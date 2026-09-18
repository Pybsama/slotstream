#ifndef SEVRA_SANDBOX_H
#define SEVRA_SANDBOX_H

/// Applies a Seatbelt profile to the calling process. The profile cannot be
/// removed afterwards and is inherited by any child the process starts.
/// Returns 0 on success; on failure `message` receives a bounded description.
int sevra_sandbox_apply(const char *profile, char *message, unsigned long capacity);

/// Returns 1 when the named Mach service is reachable from this process.
/// Used only by the helper's self-test to prove the profile denies it.
int sevra_can_look_up(const char *service);

#endif
