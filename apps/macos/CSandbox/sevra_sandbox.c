#include "sevra_sandbox.h"
#include <string.h>
#include <servers/bootstrap.h>
#include <mach/mach.h>

// macOS still enforces profiles applied through this interface. It is marked
// deprecated because Apple wants apps to use App Sandbox entitlements; a
// helper that parses untrusted documents needs a narrower, process-specific
// profile than the app's own, so it applies one here, before any parsing.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#include <sandbox.h>

int sevra_sandbox_apply(const char *profile, char *message, unsigned long capacity) {
    char *error = NULL;
    int result = sandbox_init(profile, 0, &error);
    if (result != 0 && message != NULL && capacity > 0) {
        strncpy(message, error != NULL ? error : "sandbox_init failed", capacity - 1);
        message[capacity - 1] = 0;
    }
    if (error != NULL) sandbox_free_error(error);
    return result;
}
#pragma clang diagnostic pop

int sevra_can_look_up(const char *service) {
    mach_port_t port = MACH_PORT_NULL;
    kern_return_t result = bootstrap_look_up(bootstrap_port, service, &port);
    if (result == KERN_SUCCESS && port != MACH_PORT_NULL) {
        mach_port_deallocate(mach_task_self(), port);
        return 1;
    }
    return 0;
}
