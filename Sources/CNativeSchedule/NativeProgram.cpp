#include "NativeProgram.h"
#include "mlx/primitives.h"
#include "mlx/backend/metal/device.h"

using namespace mlx::core;
namespace {
thread_local std::string program_error;
struct Buffer { Shape shape; Dtype dtype; bool exported; };
struct Step {
  NS::SharedPtr<MTL::ComputePipelineState> pipeline;
  std::vector<int32_t> bindings;
  std::vector<int32_t> constants;
  uint32_t writes;
  MTL::Size grid, group;
};
// Bounded prepared sections. Keep 16 buffers / 12 steps as finite ceilings
// for the qualified projection, shared-expert and hyper-connection plans;
// arguments retain no model weights between invocations.
struct Program {
  int inputs;
  bool sealed = false;
  std::vector<Buffer> buffers;
  std::vector<Step> steps;
};
class PreparedProgram final : public Primitive {
  std::shared_ptr<Program> program_;
 public:
  PreparedProgram(Stream stream, std::shared_ptr<Program> program)
      : Primitive(stream), program_(std::move(program)) {}
  const char *name() const override { return "SlotstreamPreparedProgram"; }
  void eval_cpu(const std::vector<array>&, std::vector<array>&) override {
    throw std::runtime_error("Prepared program requires a GPU stream");
  }
  void eval_gpu(const std::vector<array>& inputs, std::vector<array>& outputs) override {
    auto scoped_pool = metal::new_scoped_memory_pool();
    auto& p = *program_;
    auto& enc = metal::get_command_encoder(stream());
    std::vector<array> buffers = inputs, scratch;
    for (const auto& input : inputs)
      if (!input.flags().row_contiguous) throw std::invalid_argument("Prepared program input must be contiguous");
    int output = 0;
    for (size_t i = p.inputs; i < p.buffers.size(); ++i) {
      const auto& spec = p.buffers[i];
      if (spec.exported) {
        auto& a = outputs.at(output++); a.set_data(allocator::malloc(a.nbytes())); buffers.push_back(a);
      } else {
        array a(spec.shape, spec.dtype, nullptr, {}); a.set_data(allocator::malloc(a.nbytes()));
        buffers.push_back(a); scratch.push_back(a);
      }
    }
    for (const auto& step : p.steps) {
      enc.set_compute_pipeline_state(step.pipeline.get());
      for (size_t i = 0; i < step.bindings.size(); ++i) {
        auto& a = buffers.at(step.bindings[i]);
        if (step.writes & (1u << i)) enc.set_output_array(a, int(i));
        else enc.set_input_array(a, int(i));
      }
      if (!step.constants.empty())
        enc.set_vector_bytes(step.constants, int(step.bindings.size()));
      enc.dispatch_threads(step.grid, step.group);
    }
    enc.add_temporaries(std::move(scratch));
  }
};
}
extern "C" {
const char *ss_program_error() { return program_error.c_str(); }
void *ss_program_new(int inputs, const int32_t *specs, int buffers) {
  try {
    if (!specs || inputs < 1 || buffers <= inputs || buffers > 16) throw std::invalid_argument("Invalid program buffer count");
    auto p = std::make_shared<Program>(); p->inputs = inputs;
    const Dtype types[] = {bfloat16, float32, uint8, int32};
    for (int i = 0; i < buffers; ++i) {
      auto s = specs + i * 6;
      if (s[0] < 1 || s[0] > 4 || s[1] < 1 || s[1] > 3 || (i < inputs && s[5])) throw std::invalid_argument("Invalid program buffer");
      Shape shape;
      size_t elements = 1;
      for (int j = 0; j < s[1]; ++j) {
        if (s[j + 2] < 1 || elements > (size_t(1) << 32) / s[j + 2]) throw std::invalid_argument("Invalid program buffer extent");
        shape.push_back(s[j + 2]); elements *= s[j + 2];
      }
      p->buffers.push_back({shape, types[s[0] - 1], s[5] != 0});
    }
    return new std::shared_ptr<Program>(p);
  } catch (const std::exception& e) { program_error = e.what(); return nullptr; }
}
int ss_program_add(void *ptr, void *pipeline, const int32_t *bindings, int count,
                   uint32_t writes, const int32_t *grid, const int32_t *group,
                   const int32_t *constants, int constant_count) {
  try {
    if (!ptr || !pipeline || !bindings || !grid || !group || count < 1 || count > 16 || (writes >> count)) throw std::invalid_argument("Invalid program dispatch");
    if (constant_count < 0 || constant_count > 8 || (constant_count && !constants))
      throw std::invalid_argument("Invalid program constants");
    auto& p = **static_cast<std::shared_ptr<Program> *>(ptr);
    if (p.sealed || p.steps.size() >= 12) throw std::invalid_argument("Program is sealed or full");
    for (int i = 0; i < count; ++i)
      if (bindings[i] < 0 || size_t(bindings[i]) >= p.buffers.size() || ((writes & (1u << i)) && bindings[i] < p.inputs))
        throw std::invalid_argument("Invalid program binding");
    size_t threads = 1;
    for (int i = 0; i < 3; ++i) {
      if (grid[i] < 1 || group[i] < 1 || group[i] > 1024) throw std::invalid_argument("Invalid program launch");
      threads *= group[i];
    }
    auto kernel = static_cast<MTL::ComputePipelineState *>(pipeline);
    if (threads > kernel->maxTotalThreadsPerThreadgroup()) throw std::invalid_argument("Program threadgroup exceeds kernel capacity");
    std::vector<int32_t> values;
    if (constant_count) values.assign(constants, constants + constant_count);
    p.steps.push_back({NS::RetainPtr(kernel), {bindings, bindings + count}, std::move(values), writes,
                      MTL::Size(grid[0], grid[1], grid[2]), MTL::Size(group[0], group[1], group[2])});
    return 0;
  } catch (const std::exception& e) { program_error = e.what(); return 1; }
}
int ss_program_seal(void *ptr) {
  try {
    if (!ptr) throw std::invalid_argument("Missing program");
    auto& p = **static_cast<std::shared_ptr<Program> *>(ptr);
    if (p.steps.empty()) throw std::invalid_argument("Empty program");
    std::vector<bool> initialized(p.buffers.size(), false);
    std::fill_n(initialized.begin(), p.inputs, true);
    for (const auto& step : p.steps) {
      for (size_t i = 0; i < step.bindings.size(); ++i)
        if (!(step.writes & (1u << i)) && !initialized[step.bindings[i]]) throw std::invalid_argument("Program reads an uninitialized buffer");
      for (size_t i = 0; i < step.bindings.size(); ++i)
        if (step.writes & (1u << i)) initialized[step.bindings[i]] = true;
    }
    int outputs = 0;
    for (size_t i = p.inputs; i < p.buffers.size(); ++i) if (p.buffers[i].exported) {
      if (!initialized[i]) throw std::invalid_argument("Program output is uninitialized");
      outputs++;
    }
    if (!outputs) throw std::invalid_argument("Program has no output");
    p.sealed = true; return 0;
  } catch (const std::exception& e) { program_error = e.what(); return 1; }
}
int ss_program_apply(void *ptr, void *const *contexts, int count, void *stream_context,
                     void **outputs, int output_count) {
  try {
    if (!ptr || !contexts || !outputs || !stream_context) throw std::invalid_argument("Missing program arguments");
    auto p = *static_cast<std::shared_ptr<Program> *>(ptr);
    auto stream = *static_cast<Stream *>(stream_context);
    if (!p->sealed || count != p->inputs || stream.device != Device::gpu) throw std::invalid_argument("Invalid program invocation");
    std::vector<array> inputs; std::vector<Shape> shapes; std::vector<Dtype> dtypes;
    for (int i = 0; i < count; ++i) {
      if (!contexts[i]) throw std::invalid_argument("Missing program input");
      const auto& a = *static_cast<array *>(contexts[i]); const auto& spec = p->buffers[i];
      if (a.shape() != spec.shape || a.dtype() != spec.dtype) throw std::invalid_argument("Program input geometry changed");
      inputs.push_back(a);
    }
    for (size_t i = p->inputs; i < p->buffers.size(); ++i) if (p->buffers[i].exported) {
      shapes.push_back(p->buffers[i].shape); dtypes.push_back(p->buffers[i].dtype);
    }
    if (int(shapes.size()) != output_count) throw std::invalid_argument("Program output count changed");
    auto values = array::make_arrays(shapes, dtypes, std::make_shared<PreparedProgram>(stream, p), inputs);
    std::vector<std::unique_ptr<array>> owned;
    for (auto& a : values) owned.push_back(std::make_unique<array>(std::move(a)));
    for (int i = 0; i < output_count; ++i) outputs[i] = owned[i].release();
    return 0;
  } catch (const std::exception& e) { program_error = e.what(); return 1; }
}
void ss_program_free(void *ptr) { delete static_cast<std::shared_ptr<Program> *>(ptr); }
}
