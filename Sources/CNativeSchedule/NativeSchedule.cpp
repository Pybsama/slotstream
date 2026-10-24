#include "NativeSchedule.h"
#include "mlx/primitives.h"
#include "mlx/backend/metal/device.h"
#include "mlx/backend/metal/event.h"
#include <algorithm>
#include <optional>
#include <mutex>
#include <atomic>
#include <limits>
#include <functional>

// This extension links the same MLX implementation used by mlx-swift. Header
// and mlx-c context layouts are pinned to Package.swift, not inferred at run
// time. No second allocator, command queue or inference runtime is created.
using namespace mlx::core;
namespace {
thread_local std::string last_error;
struct Plan {
  NS::SharedPtr<MTL::ComputePipelineState> gather, gate_up, down, scatter;
  NS::SharedPtr<MTL::ComputePipelineState> repack;
  int hidden, intermediate;
  bool affine, mixed_shared;
  Plan(void *g, void *u, void *d, void *s, int h, int m, bool a, void *rp, bool mixed)
      : gather(NS::RetainPtr(static_cast<MTL::ComputePipelineState *>(g))),
        gate_up(NS::RetainPtr(static_cast<MTL::ComputePipelineState *>(u))),
        down(NS::RetainPtr(static_cast<MTL::ComputePipelineState *>(d))),
        scatter(NS::RetainPtr(static_cast<MTL::ComputePipelineState *>(s))),
        hidden(h), intermediate(m), affine(a), mixed_shared(mixed) {
    if (rp) repack = NS::RetainPtr(static_cast<MTL::ComputePipelineState *>(rp));
  }
};
// Reuse host-ready events only after both the host ticket and the submitted
// GPU command release their lease. Values only increase; an older publication
// can never accidentally release a newer command. The cache retains at most
// 64 events, independent of the number of layers, requests or model weights.
struct ReadyEvent {
  Event event;
  uint64_t next = 0;
  explicit ReadyEvent(Stream stream) : event(stream) {}
};
struct ReadyEvents {
  std::mutex mutex;
  std::vector<std::shared_ptr<ReadyEvent>> idle;
  uint64_t created = 0, reused = 0;
  std::shared_ptr<ReadyEvent> take(Stream stream) {
    std::lock_guard guard(mutex);
    for (auto& candidate : idle) {
      if (candidate.use_count() == 1 && candidate->event.stream() == stream &&
          !candidate->event.load_error() && candidate->next < std::numeric_limits<uint64_t>::max()) {
        ++candidate->next; ++reused;
        return candidate;
      }
    }
    auto candidate = std::make_shared<ReadyEvent>(stream);
    candidate->next = 1; ++created;
    if (idle.size() < 64) idle.push_back(candidate);
    return candidate;
  }
};
ReadyEvents& ready_events() { static ReadyEvents pool; return pool; }
struct Job {
  std::shared_ptr<ReadyEvent> lease;
  array ready;
  std::vector<array> raw;
  std::optional<array> mask;
  std::optional<array> sources;
  int forecast_records = 0;
  struct Release {
    void *context;
    void (*release)(void *);
  };
  std::vector<Release> forecast_owners;
  int staged = 0;
  std::atomic<bool> published{false};
  explicit Job(Stream stream, bool awaiting_reads) : ready({uint32_t(0), uint32_t(0)}, uint32) {
    if (awaiting_reads) lease = ready_events().take(stream);
  }
  void prepare_staging(int count, int piece_bytes) {
    staged = count; ready.data<uint32_t>()[1] = count;
    if (!count) return;
    // Host-owned materialized inputs; the event gates every GPU read.
    for (int i = 0; i < 3; ++i)
      raw.emplace_back(allocator::malloc(size_t(count) * piece_bytes), Shape{count, piece_bytes}, uint8);
    mask.emplace(allocator::malloc(size_t(count) * sizeof(int32_t)), Shape{count}, int32);
    std::fill_n(mask->data<int32_t>(), count, 0);
    sources.emplace(allocator::malloc(size_t(count) * sizeof(int32_t)), Shape{count}, int32);
    std::fill_n(sources->data<int32_t>(), count, 0);
  }
  void publish(bool success) {
    if (published.load(std::memory_order_acquire)) return;
    ready.data<uint32_t>()[0] = success ? 1 : 2;
    if (lease) lease->event.cast<metal::EventImpl>().signal(lease->next);
    published.store(true, std::memory_order_release);
  }
  ~Job() {
    publish(false);
    for (auto& owner : forecast_owners) owner.release(owner.context);
  }
};
class ExpertSchedule final : public Primitive {
  std::shared_ptr<Plan> plan_;
  std::shared_ptr<Job> job_;
  int rows_, routes_, count_;
  bool grouped_output_;
 public:
  ExpertSchedule(Stream s, std::shared_ptr<Plan> plan, std::shared_ptr<Job> job,
                 int rows, int routes, int count, bool grouped_output)
      : Primitive(s), plan_(std::move(plan)), job_(std::move(job)),
        rows_(rows), routes_(routes), count_(count), grouped_output_(grouped_output) {}
  const char *name() const override { return "SlotstreamExpertSchedule"; }
  void eval_cpu(const std::vector<array>&, std::vector<array>&) override {
    throw std::runtime_error("Native expert schedule requires a GPU stream");
  }
  void eval_gpu(const std::vector<array>& in, std::vector<array>& out) override {
    auto scoped_pool = metal::new_scoped_memory_pool();
    auto& p = *plan_;
    // MLX owns scratch and output allocations and their complete GPU lifetime.
    // Its bounded allocator cache can reuse them without registering new
    // Metal views of multi-GB expert buffers or retaining a second buffer pool.
    array grouped({rows_, p.hidden}, bfloat16, nullptr, {});
    array activated({rows_, p.intermediate}, bfloat16, nullptr, {});
    array projected({rows_, p.hidden}, bfloat16, nullptr, {});
    for (auto *a : {&grouped, &activated, &out[0]})
      a->set_data(allocator::malloc(a->nbytes()));
    if (grouped_output_) projected = out[0];
    else projected.set_data(allocator::malloc(projected.nbytes()));
    auto& enc = metal::get_command_encoder(stream());
    // An all-hit call can stay lazy in the surrounding MLX graph. If the
    // host already published the bytes, no event wait or encoder split is
    // needed. The acquire observes the host writes before dispatch encoding.
    if (job_->lease) {
      if (!job_->published.load(std::memory_order_acquire))
        enc.wait_event(job_->lease->event, job_->lease->next);
      // A primitive may be released before Metal completes. Keep its event
      // lease until completion as well, without an extra buffer or CPU join.
      enc.get_command_buffer()->addCompletedHandler([lease = job_->lease](MTL::CommandBuffer*) { (void)lease; });
    } else if (!job_->published.load(std::memory_order_acquire)) {
      throw std::logic_error("All-hit expert schedule was not published");
    }
    const int order = count_ + 1, inverse = order + 1;
    const int slots = order + 2, live = order + 3, ready = order + 4;
    if (job_->staged) {
      const int raw = ready + 1, mask = raw + 3, destinations = mask + 1;
      const int forecast = destinations + 1, sources = forecast + 3;
      // Keep ticket leases beyond primitive/array release, through the last
      // GPU reader. Their arena positions cannot be reused before completion.
      enc.get_command_buffer()->addCompletedHandler([job = job_](MTL::CommandBuffer*) { (void)job; });
      enc.set_compute_pipeline_state(p.repack.get());
      for (int piece = 0; piece < 3; ++piece) {
        enc.set_input_array(in[raw + piece], piece);
        // Preserve MLX write tracking for every pinned destination. No raw
        // binding bypasses its ownership or command-buffer accounting.
        auto destination = in[1 + piece];
        enc.set_output_array(destination, 3 + piece);
        enc.set_input_array(in[forecast + piece], 9 + piece);
      }
      enc.set_input_array(in[destinations], 6);
      enc.set_input_array(in[mask], 7); enc.set_input_array(in[ready], 8);
      enc.set_input_array(in[sources], 12);
      enc.dispatch_threads(MTL::Size(p.hidden * p.intermediate / 64, 4, 3), MTL::Size(256, 1, 1));
    }
    auto reorder = [&](MTL::ComputePipelineState *kernel, const array& x,
                       const array& indices, array& y, uint32_t n) {
      enc.set_compute_pipeline_state(kernel);
      enc.set_input_array(x, 0); enc.set_input_array(indices, 1);
      enc.set_output_array(y, 2); enc.set_bytes(n, 3);
      enc.set_input_array(in[ready], 4);
      enc.dispatch_threadgroups(MTL::Size((n + 255) / 256, 1, 1), MTL::Size(256, 1, 1));
    };
    auto project = [&](MTL::ComputePipelineState *kernel, const array& x,
                       array& y, int piece, bool fused, int width) {
      int w = 1 + (p.affine ? piece * 3 : piece);
      int s = p.affine ? w + 1 : w, b = p.affine ? w + 2 : w;
      int u = fused ? (p.affine ? 4 : 2) : w;
      enc.set_compute_pipeline_state(kernel);
      enc.set_input_array(x, 0);
      const int inputs[] = {w, s, b, u, fused && p.affine ? 5 : s,
                            fused && p.affine ? 6 : b, slots, live};
      for (int i = 0; i < 8; ++i) enc.set_input_array(in[inputs[i]], i + 1);
      enc.set_output_array(y, 9); enc.set_input_array(in[ready], 10);
      if (p.mixed_shared) {
        for(int i=0;i<4;++i) enc.set_input_array(in[4+i],11+i);
        uint32_t tile=rows_/8-1; enc.set_bytes(tile,15);
      }
      enc.dispatch_threadgroups(MTL::Size(width / (fused ? 32 : 64), rows_ / 8, 1), MTL::Size(64, 1, 1));
    };
    reorder(p.gather.get(), in[0], in[order], grouped, rows_ * p.hidden);
    project(p.gate_up.get(), grouped, activated, 0, true, p.intermediate);
    project(p.down.get(), activated, projected, 2, false, p.hidden);
    if (!grouped_output_)
      reorder(p.scatter.get(), projected, in[inverse], out[0], routes_ * p.hidden);
    if (grouped_output_) enc.add_temporaries({grouped, activated});
    else enc.add_temporaries({grouped, activated, projected});
  }
};
}
extern "C" {
void ss_schedule_event_stats(uint64_t *created, uint64_t *reused, uint64_t *cached) {
  auto& pool = ready_events(); std::lock_guard guard(pool.mutex);
  if (created) *created = pool.created;
  if (reused) *reused = pool.reused;
  if (cached) *cached = pool.idle.size();
}
const char *ss_schedule_error() { return last_error.c_str(); }
void *ss_schedule_plan(void *g, void *u, void *d, void *s, int h, int m, bool a, void *rp, bool mixed) {
  try {
    if (!g || !u || !d || !s || h < 64 || m < 64 || h % 64 || m % 64)
      throw std::invalid_argument("Invalid native schedule plan");
    if (mixed && (a || h != 2560 || m != 640)) throw std::invalid_argument("Invalid mixed expert geometry");
    if (a && rp) throw std::invalid_argument("Affine schedule cannot use Q2 repack");
    return new std::shared_ptr<Plan>(std::make_shared<Plan>(g, u, d, s, h, m, a, rp, mixed));
  } catch (const std::exception& e) { last_error = e.what(); return nullptr; }
}
void ss_schedule_plan_free(void *p) { delete static_cast<std::shared_ptr<Plan> *>(p); }
int ss_schedule_prepare(void *p, void *x, void *const *weights, int count,
                        const int32_t *order, int rows, const int32_t *inverse,
                        int routes, const int32_t *slots, const int32_t *live,
                        const int32_t *staged_slots, int staged_count, bool awaiting_reads, bool grouped_output,
                        void *prerequisite, void *const *forecast, void *stream_context, void **output, void **job) {
  try {
    if (!p || !x || !output || !job || !weights || !order || !inverse || !slots || !live || !stream_context)
      throw std::invalid_argument("Missing native schedule argument");
    auto plan = *static_cast<std::shared_ptr<Plan> *>(p);
    if (count != (plan->affine ? 9 : plan->mixed_shared ? 7 : 3) || routes < 1 || routes > 256 ||
        rows < 8 || rows > routes * 8 + (plan->mixed_shared ? 8 : 0) || rows % 8)
      throw std::invalid_argument("Invalid native schedule geometry");
    if (plan->mixed_shared && (!grouped_output || rows < 16))
      throw std::invalid_argument("Mixed shared schedule needs grouped output");
    if (staged_count < 0 || staged_count > 80 || (staged_count &&
        (!staged_slots || !awaiting_reads || plan->affine || !plan->repack)))
      throw std::invalid_argument("Invalid native staging geometry");
    if (uint64_t(staged_count) * 3 * plan->hidden * plan->intermediate / 64 * 18 > 110592000)
      throw std::invalid_argument("Native staging exceeds its charged byte ceiling");
    // The stream adapter follows pinned mlx-c/private/stream.h, preserving
    // both device and index rather than manufacturing a GPU stream index.
    auto stream = *static_cast<Stream *>(stream_context);
    if (stream.device != Device::gpu)
      throw std::invalid_argument("Native expert schedule requires the current GPU stream");
    auto work = std::make_shared<Job>(stream, awaiting_reads);
    std::vector<array> inputs{*static_cast<array *>(x)};
    if (inputs[0].dtype() != bfloat16 || !inputs[0].flags().row_contiguous)
      throw std::invalid_argument("Invalid native schedule activation");
    for (int i = 0; i < count; ++i) {
      if (!weights[i]) throw std::invalid_argument("Missing native expert weight");
      inputs.push_back(*static_cast<array *>(weights[i]));
    }
    if (plan->mixed_shared) {
      if(inputs[7].dtype()!=uint32 || inputs[7].size()!=10 || !inputs[7].flags().row_contiguous)
        throw std::invalid_argument("Invalid shared expert metadata");
      auto *meta=inputs[7].data<uint32_t>();
      if(meta[9]<1 || meta[9]>8 || inputs[0].size()!=size_t(meta[9])*plan->hidden || live[rows/8-1]!=int(meta[9]))
        throw std::invalid_argument("Invalid shared expert row extent");
      for(int i=0;i<rows;++i) if(order[i]<0 || order[i]>=int(meta[9]))
        throw std::invalid_argument("Invalid mixed gather row");
      for(int i=0;i<routes;++i) if(inverse[i]<0 || inverse[i]>=rows-8)
        throw std::invalid_argument("Invalid mixed inverse row");
      for(int i=0;i<rows/8-1;++i) if(slots[i]<0 || slots[i]>=inputs[1].shape(0) || live[i]<1 || live[i]>8)
        throw std::invalid_argument("Invalid mixed routed tile");
      for(int piece=0;piece<3;++piece){
        uint32_t p0=0,p1=0,mb=0,mg=0;
        switch(meta[piece*3]){
          case 2:p0=16;mb=2;mg=1;break;
          case 6:p0=16;p1=4;mb=2;mg=1;break;
          case 8:p0=32;mb=2;mg=1;break;
          case 11:p0=8;p1=4;mb=16;mg=8;break;
          case 12:p0=16;mb=16;mg=8;break;
          case 13:p0=16;p1=4;mb=16;mg=8;break;
          case 14:p0=16;p1=8;mb=20;mg=8;break;
          case 20:p0=16;mb=2;mg=1;break;
          case 23:p0=16;mb=8;mg=8;break;
          case 42:p0=8;mb=2;mg=2;break;
          default:throw std::invalid_argument("Unsupported shared expert format");
        }
        uint64_t n=piece==2?plan->hidden:plan->intermediate,k=piece==2?plan->intermediate:plan->hidden,g=k/32;
        uint64_t first=n*g*p0,second=n*g*p1,total=first+second+n*(g/mg)*mb;
        auto& weight=inputs[4+piece];
        if(g%mg || meta[piece*3+1]!=first || meta[piece*3+2]!=first+second || weight.dtype()!=uint8 || !weight.flags().row_contiguous || weight.nbytes()!=total)
          throw std::invalid_argument("Invalid shared expert prepared extent");
      }
    }
    for (int i = 0; i < staged_count; ++i) {
      if (staged_slots[i] < 0 || staged_slots[i] >= inputs[1].shape(0))
        throw std::invalid_argument("Staged expert destination is out of bounds");
      for (int j = 0; j < i; ++j) if (staged_slots[j] == staged_slots[i])
        throw std::invalid_argument("Duplicate staged expert destination");
      if (std::find(slots, slots + rows / 8 - (plan->mixed_shared ? 1 : 0), staged_slots[i]) == slots + rows / 8 - (plan->mixed_shared ? 1 : 0))
        throw std::invalid_argument("Staged destination is not a routed expert");
    }
    inputs.emplace_back(order, Shape{rows});
    inputs.emplace_back(inverse, Shape{routes});
    inputs.emplace_back(slots, Shape{rows / 8});
    inputs.emplace_back(live, Shape{rows / 8});
    inputs.push_back(work->ready);
    work->prepare_staging(staged_count, plan->hidden * plan->intermediate / 64 * 18);
    if (staged_count) {
      inputs.insert(inputs.end(), work->raw.begin(), work->raw.end());
      inputs.push_back(*work->mask); inputs.emplace_back(staged_slots, Shape{staged_count});
      for (int piece = 0; piece < 3; ++piece) {
        if (forecast) {
          if (!forecast[piece]) throw std::invalid_argument("Missing forecast arena piece");
          auto& a = *static_cast<array *>(forecast[piece]);
          if (a.dtype() != uint8 || a.ndim() != 2 || a.shape(0) != 64 ||
              a.shape(1) != plan->hidden * plan->intermediate / 64 * 18 || !a.flags().row_contiguous)
            throw std::invalid_argument("Invalid forecast arena geometry");
          inputs.push_back(a); work->forecast_records = a.shape(0);
        } else inputs.push_back(work->raw[piece]);
      }
      inputs.push_back(*work->sources);
    }
    // The shared expert is an ordering dependency, not another expert weight.
    // Its projection commands precede the host-ready wait in the same MLX
    // evaluation. This removes a separate async-evaluation submission while
    // retaining useful overlap with host demand reads.
    if (prerequisite) inputs.push_back(*static_cast<array *>(prerequisite));
    auto primitive = std::make_shared<ExpertSchedule>(stream, plan, work, rows, routes, count, grouped_output);
    auto value = std::make_unique<array>(Shape{grouped_output ? rows : routes, plan->hidden}, bfloat16, primitive, std::move(inputs));
    auto ticket = std::make_unique<std::shared_ptr<Job>>(work);
    *output = value.release(); *job = ticket.release(); return 0;
  } catch (const std::exception& e) { last_error = e.what(); return 1; }
}
void ss_schedule_publish(void *j, bool success) {
  (*static_cast<std::shared_ptr<Job> *>(j))->publish(success);
}
void *ss_schedule_forecast_array(int records, int piece_bytes, void **base) {
  try {
    if (!base || records != 64 || piece_bytes < 1 || uint64_t(records) * piece_bytes > 134217728 / 3)
      throw std::invalid_argument("Forecast arena exceeds its reservation");
    auto value = std::make_unique<array>(allocator::malloc(size_t(records) * piece_bytes),
                                       Shape{records, piece_bytes}, uint8);
    *base = value->data<uint8_t>();
    return value.release();
  } catch (const std::exception& e) { last_error = e.what(); return nullptr; }
}
int ss_schedule_stage_forecast(void *j, int index, int source, void *context, void (*release)(void *)) {
  try {
    if (!j || !context || !release) throw std::invalid_argument("Missing forecast lease");
    auto& work = **static_cast<std::shared_ptr<Job> *>(j);
    if (work.published.load(std::memory_order_acquire) || index < 0 || index >= work.staged ||
        source < 0 || source >= work.forecast_records || work.mask->data<int32_t>()[index] != 0)
      throw std::invalid_argument("Invalid forecast staging publication");
    work.forecast_owners.push_back({context, release});
    work.sources->data<int32_t>()[index] = source;
    work.mask->data<int32_t>()[index] = 2;
    return 0;
  } catch (const std::exception& e) { last_error = e.what(); return 1; }
}
void *ss_schedule_stage_base(void *j, int piece) {
  if (!j || piece < 0 || piece >= 3) return nullptr;
  auto& work = **static_cast<std::shared_ptr<Job> *>(j);
  if (!work.staged || work.published.load(std::memory_order_acquire)) return nullptr;
  return work.raw[piece].data<uint8_t>();
}
int ss_schedule_stage_mark(void *j, const int32_t *indices, int count) {
  try {
    if (!j || !indices || count < 1 || count > 80) throw std::invalid_argument("Invalid staging publication");
    auto& work = **static_cast<std::shared_ptr<Job> *>(j);
    if (!work.staged || work.published.load(std::memory_order_acquire)) throw std::invalid_argument("Staging already released");
    for (int i = 0; i < count; ++i)
      if (indices[i] < 0 || indices[i] >= work.staged) throw std::invalid_argument("Staged index is out of bounds");
    for (int i = 0; i < count; ++i) work.mask->data<int32_t>()[indices[i]] = 1;
    return 0;
  } catch (const std::exception& e) { last_error = e.what(); return 1; }
}
void ss_schedule_job_free(void *j) { delete static_cast<std::shared_ptr<Job> *>(j); }
}
