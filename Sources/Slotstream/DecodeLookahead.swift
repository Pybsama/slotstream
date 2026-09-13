import Foundation

/// The qualified decode lookahead: router-reuse expert prefetch with slot
/// adoption, FP32 copies of the router weights, and a GPU barrier every four
/// layers whose forecasts ride the next routing readback. It needs the draft
/// head and turns on with it wherever the expert cache still reaches the draft
/// head's activation floor.
///
/// Evidence: the held-out B1 cohort ran this exact configuration against the
/// shipped path at a 20 GB target with two drafts: 1.114 decode throughput
/// (bootstrap 1.105 to 1.122), outputs identical in every pair. The attribution
/// sweep apportions it: prefetch 1.090, router cache 1.021, barrier 1.022.
/// Scope: one M5 Pro, text decode with the draft head, caches of about 76 to 88
/// experts per layer. Revision: a clean paired loss at a cache size it runs at.
/// db/records/decisions/decode-lookahead-default-with-the-draft-head.md
public enum DecodeLookahead {
    /// FP32 copies of the 49 router projections (48 layers and the draft head),
    /// 512 x 2560 values each, kept beside the BF16 originals.
    public static let routerCacheBytes = 49 * 512 * 2560 * MemoryLayout<Float32>.size
    /// The prefetch scheduler's staging reserve; its 32 in-flight records fit inside.
    public static let stagingReserveBytes = ExpertPrefetchConfiguration.defaultReserveBytes
    /// The whole incremental charge, taken from the expert pool before it is sized.
    public static let reserveBytes = stagingReserveBytes + routerCacheBytes
    /// Layers between GPU barriers in the qualified configuration.
    public static let barrierLayers = 4
    /// Slots a victim scan keeps free beyond pins and speculative reservations;
    /// the speculative reservation refuses at the same margin.
    package static let victimMarginSlots = 256

    /// The barrier period one pass actually uses. A deferred barrier keeps
    /// `period + 1` layers of pins alive. A pass whose routed experts could not
    /// all stay pinned that long with the victim margin to spare (a long pool
    /// pass, or a pool the governor shrank) drains at every layer instead, which
    /// is the original path and computes the same values.
    package static func barrierPeriod(requested: Int, rows: Int, topK: Int, experts: Int,
                                      slots: Int, reservedSlots: Int) -> Int {
        guard requested > 1 else { return 1 }
        let pinnedPerLayer = min(max(1, experts), max(1, rows) * max(1, topK))
        let held = (requested + 1) * pinnedPerLayer + max(0, reservedSlots)
        return slots - held > victimMarginSlots ? requested : 1
    }
}

/// How a memory plan treats the decode lookahead.
public enum DecodeLookaheadPlanning: Sendable, Equatable {
    /// The default: on with the draft head when the cache still reaches the
    /// activation floor after the head's charge; its bytes come out of the pool.
    case automatic
    /// Never enabled or charged.
    case off
    /// An experimental environment configuration: its reservation is charged
    /// and the qualified default stays off.
    case reserved(bytes: Int)
    /// Re-planning a loaded engine: keep its decision and its charge.
    case retained(enabled: Bool, bytes: Int)

    /// `automatic` unless the environment names a prefetch switch or an explicit
    /// reserve. `SLOTSTREAM_OPT_EXPERT_PREFETCH=0` turns the default off; `=1`
    /// selects the experimental configuration its tuning variables describe.
    public static func environment(_ env: [String: String] = ProcessInfo.processInfo.environment) -> Self {
        guard ExpertPrefetchConfiguration.explicitlyConfigured(env) else { return .automatic }
        let bytes = ExpertPrefetchConfiguration.plannedReserveBytes(env)
        return bytes > 0 ? .reserved(bytes: bytes) : .off
    }
}

extension ExpertPrefetchConfiguration {
    /// Exactly the configuration the B1 cohort ran ("combined" in the decode
    /// serialization attribution configs). A T0 check parses that environment and
    /// requires equality, so the default cannot drift from what was measured.
    package static var qualifiedDecode: Self {
        var c = Self()
        c.enabled = true
        c.policy = .router
        c.strides = [2]
        c.windowLayers = 2
        c.topPerLayer = 24
        c.issueCapPerTarget = 32
        c.threshold = 0.062
        c.capRecords = 32
        c.lanes = 16
        c.adoption = .slot
        c.slotCap = 64
        c.device = .gpu
        c.memoLayers = 0
        c.readShape = .piece
        c.reserveBytes = defaultReserveBytes
        return c
    }

    /// True when the environment selects an experimental lookahead instead of
    /// the qualified default: either prefetch switch, or an explicit reserve
    /// (the capacity control). Tuning variables alone do not change the default.
    package static func explicitlyConfigured(_ env: [String: String] = ProcessInfo.processInfo.environment) -> Bool {
        env["SLOTSTREAM_OPT_EXPERT_PREFETCH"] != nil || env["SLOTSTREAM_OPT_EXPERT_PREFETCH_SHADOW"] != nil
            || env["SLOTSTREAM_EXPERT_LOOKAHEAD_RESERVE_MIB"] != nil
    }
}
