#include "AdaptiveReplacement.h"
#include "model/SlotRecycler.hpp"
#include <memory>
#include <stdexcept>
#include <string>

// SlotRecycler itself is unmodified Apache-2.0 Splash code. This adapter
// translates Slotstream's independently owned physical slots and longer-lived
// pins. It has no file, model, GPU or thread ownership.
namespace {
thread_local std::string replacement_error;
struct Replacement {
  splash::model::SlotRecycler order;
  std::vector<uint8_t> occupied;
  uint64_t load = 1;
  explicit Replacement(int count) : order(uint32_t(count)), occupied(count, 0) {}
};
Replacement& get(void *ptr) {
  if (!ptr) throw std::invalid_argument("Missing adaptive replacement policy");
  return *static_cast<Replacement *>(ptr);
}
void check_slot(const Replacement& r, int slot) {
  if (slot < 0 || uint32_t(slot) >= r.order.size())
    throw std::invalid_argument("Adaptive replacement slot is out of range");
}
}
extern "C" {
const char *ss_recycler_error() { return replacement_error.c_str(); }
void *ss_recycler_new(const uint64_t *keys, int count) {
  try {
    if (!keys || count < 1 || count > 65536) throw std::invalid_argument("Invalid replacement capacity");
    auto result = std::make_unique<Replacement>(count);
    // Empty placeholders preserve physical slot indices while seeding the
    // unmodified recycler, then become free. Real expert keys use two UInt32s
    // with a nonnegative, bounded layer, so cannot collide with placeholders.
    for (int i = 0; i < count; ++i) {
      uint64_t key = keys[i] == UINT64_MAX ? UINT64_MAX - i : keys[i];
      if ((keys[i] != UINT64_MAX && (key >> 32) >= 0x80000000ull) || result->order.find(key))
        throw std::invalid_argument("Invalid or duplicate replacement seed");
      if (result->order.claim(key, result->load, true) != uint32_t(i))
        throw std::logic_error("Replacement seed changed physical slots");
      result->occupied[i] = keys[i] != UINT64_MAX;
    }
    for (int i = count; i-- > 0;) if (keys[i] == UINT64_MAX) result->order.free(i);
    return result.release();
  } catch (const std::exception& e) { replacement_error = e.what(); return nullptr; }
}
void ss_recycler_delete(void *ptr) { delete static_cast<Replacement *>(ptr); }
int ss_recycler_begin(void *ptr, const int32_t *pinned, int count) {
  try {
    auto& r = get(ptr);
    if (count < 0 || uint32_t(count) > r.order.size() || (count && !pinned) || r.load == UINT64_MAX)
      throw std::invalid_argument("Invalid replacement pin set or load generation");
    for (int i = 0; i < count; ++i) {
      check_slot(r, pinned[i]);
      if (!r.occupied[pinned[i]]) throw std::invalid_argument("Cannot pin an empty replacement slot");
    }
    ++r.load;
    // A scan touch pins without promoting or moving any list entry.
    for (int i = 0; i < count; ++i) r.order.touch(pinned[i], r.load, true);
    return 0;
  } catch (const std::exception& e) { replacement_error = e.what(); return 1; }
}
int ss_recycler_touch(void *ptr, int slot, bool scan) {
  try {
    auto& r = get(ptr); check_slot(r, slot);
    if (!r.occupied[slot]) throw std::invalid_argument("Cannot touch an empty replacement slot");
    r.order.touch(slot, r.load, scan); return 0;
  }
  catch (const std::exception& e) { replacement_error = e.what(); return 1; }
}
int ss_recycler_claim(void *ptr, uint64_t key, bool scan) {
  try {
    auto& r = get(ptr);
    if ((key >> 32) >= 0x80000000ull || r.order.find(key)) throw std::invalid_argument("Invalid or already resident key");
    auto slot = r.order.claim(key, r.load, scan); r.occupied[slot] = 1; return int(slot);
  } catch (const std::exception& e) { replacement_error = e.what(); return -1; }
}
uint64_t ss_recycler_ghost_hits(void *ptr) { return ptr ? static_cast<Replacement *>(ptr)->order.ghostHits() : 0; }
}
