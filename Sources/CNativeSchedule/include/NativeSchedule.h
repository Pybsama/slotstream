#pragma once
#include <stdbool.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
void *ss_schedule_plan(void *gather, void *gate_up, void *down, void *scatter,
                       int hidden, int intermediate, bool affine,
                       void *repack, bool mixed_shared);
void ss_schedule_plan_free(void *plan);
// Array contexts follow the pinned mlx-c ownership contract. The returned
// output is an owned mlx_array context; all input contexts remain borrowed.
// grouped_output retains tile rows for a direct ordered mixture; otherwise
// the result is scattered into the original route order.
int ss_schedule_prepare(void *plan, void *input, void *const *weights, int count,
                        const int32_t *order, int rows, const int32_t *inverse,
                        int routes, const int32_t *slots, const int32_t *live,
                        const int32_t *staged_slots, int staged_count, bool awaiting_reads, bool grouped_output,
                        void *prerequisite, void *const *forecast, void *stream_context, void **output, void **job);
// Materialized MLX storage, shared by bounded read-ahead tickets and the GPU.
void *ss_schedule_forecast_array(int records, int piece_bytes, void **base);
// On success the job owns context until its last GPU reader completes.
int ss_schedule_stage_forecast(void *job, int index, int source, void *context, void (*release)(void *));
void *ss_schedule_stage_base(void *job, int piece);
int ss_schedule_stage_mark(void *job, const int32_t *indices, int count);
void ss_schedule_publish(void *job, bool success);
void ss_schedule_job_free(void *job);
void ss_schedule_event_stats(uint64_t *created, uint64_t *reused, uint64_t *cached);
const char *ss_schedule_error(void);
#ifdef __cplusplus
}
#endif
