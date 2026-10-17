#ifndef SLOTSTREAM_SANDBOX_H
#define SLOTSTREAM_SANDBOX_H

/// Applies a Seatbelt profile to the calling process. The profile cannot be
/// removed afterwards and is inherited by any child the process starts.
/// Returns 0 on success; on failure `message` receives a bounded description.
int slotstream_sandbox_apply(const char *profile, char *message, unsigned long capacity);

/// Returns 1 when the named Mach service is reachable from this process.
/// Used only by the helper's self-test to prove the profile denies it.
int slotstream_can_look_up(const char *service);

#endif
