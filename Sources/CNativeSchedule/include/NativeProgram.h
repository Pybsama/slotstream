#pragma once
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
// Each buffer has six integers: dtype (1 BF16, 2 FP32, 3 U8, 4 I32),
// rank, three dimensions (unused dimensions are 1), exported-output flag.
void *ss_program_new(int inputs, const int32_t *specs, int buffers);
int ss_program_add(void *program, void *pipeline, const int32_t *bindings,
                   int count, uint32_t writes, const int32_t *grid,
                   const int32_t *group, const int32_t *constants,
                   int constant_count);
int ss_program_seal(void *program);
int ss_program_apply(void *program, void *const *inputs, int count,
                     void *stream, void **outputs, int output_count);
void ss_program_free(void *program);
const char *ss_program_error(void);
#ifdef __cplusplus
}
#endif
