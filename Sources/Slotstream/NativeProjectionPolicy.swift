import Foundation
import IOKit
import Metal

/// Projection geometry policy from Splash's LinearGguf.cpp. Core metadata is
/// read once, never a power or scheduling setting. Missing metadata uses its
/// conservative 32-core estimate; this is a dispatch choice, not a speed claim.
package enum NativeProjectionPolicy {
    package static let device: (cores: Int, apple10: Bool) = {
        guard let metal = MTLCreateSystemDefaultDevice() else { return (32, false) }
        func count(_ entry: io_registry_entry_t) -> Int? {
            guard entry != 0,
                  let value = IORegistryEntryCreateCFProperty(entry, "gpu-core-count" as CFString,
                    kCFAllocatorDefault, 0)?.takeRetainedValue() as? NSNumber,
                  (1...4096).contains(value.intValue) else { return nil }
            return value.intValue
        }
        var entry = IOServiceGetMatchingService(kIOMainPortDefault, IORegistryEntryIDMatching(metal.registryID))
        var cores: Int?
        for _ in 0..<4 where entry != 0 {
            if let value = count(entry) { cores = value; break }
            var parent: io_registry_entry_t = 0
            _ = IORegistryEntryGetParentEntry(entry, kIOServicePlane, &parent)
            IOObjectRelease(entry); entry = parent
        }
        if entry != 0 { IOObjectRelease(entry) }
        if cores == nil {
            let fallback = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOAccelerator"))
            cores = count(fallback)
            if fallback != 0 { IOObjectRelease(fallback) }
        }
        let apple10: Bool
        if #available(macOS 26.0, *) { apple10 = metal.supportsFamily(.apple10) }
        else { apple10 = false }
        return (cores ?? 32, apple10)
    }()

    /// Splash's one-lane unsplit staged policy. Sixteen-row MPP tiles can
    /// compute the same live rows with less scheduling cost on Apple10.
    /// Count scales and metadata in the stored bits; Q4_K is exactly 4.5 and
    /// therefore stays on eight rows. Bounds in the input tensor mask padding.
    package static func stagedTileRows(batch: Int, parts: Int, format: Q2GGUFFormat) -> Int {
        device.apple10 && (1...8).contains(batch) && parts == 1
            && format.bytes * 16 < format.block * 9 ? 16 : 8
    }

    package static func splits(rows: Int, columns: Int, cores: Int, register: Bool, apple10: Bool) -> Int {
        let tiers = register ? [(4, 256, 8), (32, 1024, 8), (3, 512, 16)]
            : apple10 ? [(6, 512, 8)] : [(4, 256, 8), (32, 1024, 8)]
        var count = 1
        while (columns / 32).isMultiple(of: count * 2), tiers.contains(where: {
            count < $0.2 && rows / 64 * count < $0.0 * max(1, cores) && columns / (2 * count) >= $0.1
        }) { count *= 2 }
        return count
    }

    package static func useRegister(rows: Int, columns: Int, batch: Int, format: Q2GGUFFormat) -> Bool {
        guard device.apple10, (1...8).contains(batch),
              columns.isMultiple(of: format == .q80 || format == .q40 || format == .q50 || format == .iq4nl ? 64 : 256)
        else { return false }
        return (format.nominalBits >= 4 ? 2 : 4) * (rows / 64) < 3 * device.cores
    }
}
