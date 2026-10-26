#pragma once
#include <stdbool.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
// Pure cache metadata. UINT64_MAX denotes an empty physical slot. The
// caller owns weight bytes, publication and all pins beyond a single load.
void *ss_recycler_new(const uint64_t *keys, int count);
void ss_recycler_delete(void *recycler);
int ss_recycler_begin(void *recycler, const int32_t *pinned, int count);
int ss_recycler_touch(void *recycler, int slot, bool scan);
int ss_recycler_claim(void *recycler, uint64_t key, bool scan);
uint64_t ss_recycler_ghost_hits(void *recycler);
const char *ss_recycler_error(void);
#ifdef __cplusplus
}
#endif
