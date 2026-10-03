import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Fixed on-manifold component comparison. No main-model generation,
    /// speculative commit, pack admission or throughput claim is involved.
    public static func quantizationDraft(baseline: URL, fixture: URL, output: URL,
                                         referenceArithmetic: Bool) throws -> Data {
        guard !ProcessInfo.processInfo.environment.keys.contains(where: {
            $0.hasPrefix("SLOTSTREAM_") || $0.hasPrefix("SS_DEBUG") || $0.hasPrefix("VQ_") || $0.hasPrefix("VQLAB_")
        }) else { throw ModelError("draft research refuses ambient runtime overrides") }
        guard !FileManager.default.fileExists(atPath: output.path) else {
            throw ModelError("draft research output must be a new directory")
        }
        try ModelProcessGuard.acquire()
        guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 13_000_000_000 else {
            throw ModelError("draft research requires 13 GB real reclaimable memory")
        }
        MLX.Memory.memoryLimit = 3_500_000_000
        MLX.Memory.cacheLimit = 128_000_000
        let fixtureSHA = "75061cdf20bf1221448ef07e5a07442bd0f26a101bfc788b78717a93feb8c032"
        let owner = try VQTensorFile(url: fixture, identity: .init(fileBytes: 2_253_521,
            headerBytes: 713, headerSHA256: "1c61cf5ec5d7a53bc51bf957c178ad1cabef9607e9549abc4d8a1d0868c45da4",
            fileSHA256: fixtureSHA))
        let widths = ["embedded": 2560, "hidden": 10240, "embedded2": 2560, "hidden2": 10240,
                      "out1": 2560, "multi1": 10240, "out2": 2560, "multi2": 10240]
        guard Set(owner.tensors.keys) == Set(widths.keys) else { throw ModelError("draft fixture coverage changed") }
        var fx: [String: MLXArray] = [:]
        for (name, width) in widths {
            let ref = owner.tensors[name]!, rows = name.hasSuffix("2") ? 1 : 43
            guard ref.shape == [1, rows, width], ref.dtype == "BF16", ref.byteCount == 2 * rows * width else {
                throw ModelError("draft fixture shape or dtype changed")
            }
            let data = try owner.read(name, offset: 0, count: ref.byteCount)
            fx[name] = MLXArray(data, ref.shape, dtype: .bfloat16)
        }
        try FileManager.default.createDirectory(at: output, withIntermediateDirectories: false)
        let weights = try VQDraftWeights.load(baseline: baseline)
        let head = MTPHead(weights, referenceArithmetic: referenceArithmetic)
        let cfg = weights.config
        let rope = Rope(dim: cfg.rotaryDim, base: cfg.ropeTheta, pinnedVQReference: referenceArithmetic)
        let state = MTPState()
        var stage = 0, written = 0
        var trace: [[String: Any]] = [], traceError: Error?
        func dump(_ name: String, _ value: MLXArray) {
            guard traceError == nil else { return }
            do {
                eval(value)
                guard value.dtype == .bfloat16, all(isFinite(value)).item(Bool.self),
                      value.nbytes <= 12_000_000 - written,
                      let memory = ProcessMemory.vmActivity(), memory.reclaimableBytes >= 3_000_000_000,
                      ProcessMemory.peakResidentBytes() <= 10_000_000_000 else {
                    throw ModelError("draft trace exceeded its finite BF16 or resource bound")
                }
                let raw = value.asData(access: .copy).data, file = "s\(stage)_\(name).bin"
                try raw.write(to: output.appendingPathComponent(file), options: .withoutOverwriting)
                written += raw.count
                trace.append(["stage": stage, "name": name, "shape": value.shape, "dtype": "BF16",
                              "bytes": raw.count, "file": file,
                              "sha256": SHA256.hash(data: raw).map { String(format: "%02x", $0) }.joined()])
            } catch { traceError = error }
        }
        head.debugSink = dump
        let a = try head.callAsFunctionChecked(embedded: fx["embedded"]!, hiddenMulti: fx["hidden"]!, rope: rope, state: state)
        eval(a.sample, a.multi); dump("out", a.sample); dump("multi", a.multi)
        guard state.offset == 43, state.isAligned(withConsumedTokens: 44) else { throw ModelError("draft prefill state is misaligned") }
        stage = 1
        let b = try head.callAsFunctionChecked(embedded: fx["embedded2"]!, hiddenMulti: fx["hidden2"]!, rope: rope, state: state)
        eval(b.sample, b.multi); dump("out", b.sample); dump("multi", b.multi)
        if let traceError { throw traceError }
        guard state.offset == 44, state.isAligned(withConsumedTokens: 45) else { throw ModelError("draft decode state is misaligned") }
        try owner.verifyUnchanged()
        var comparisons: [[String: Any]] = [], passed = true
        for (name, value) in [("out1", a.sample), ("multi1", a.multi), ("out2", b.sample), ("multi2", b.multi)] {
            let ref = fx[name]!, delta = abs(ref.asType(.float32) - value.asType(.float32)).max().item(Float.self)
            let scale = abs(ref.asType(.float32)).max().item(Float.self), relative = delta / max(scale, 1e-6)
            let finite = all(isFinite(value)).item(Bool.self), ok = finite && relative < 2e-2
            passed = passed && ok
            comparisons.append(["name": name, "max_abs": delta, "relative_max": relative, "finite": finite,
                "passed": ok, "exact": ref.asData(access: .copy).data == value.asData(access: .copy).data])
        }
        let receipt: [String: Any] = ["schema": 1, "passed": passed, "qualification": "unproven",
            "scope": "Fixed original-four-bit draft component on independently frozen composite inputs only",
            "fixture_sha256": fixtureSHA, "draft_sha256": VQDraftWeights.fileSHA256,
            "config_sha256": VQDraftWeights.configSHA256, "draft_bits": 4, "draft_group_size": 64,
            "arithmetic": referenceArithmetic ? "explicit-python-reference" : "deployed",
            "payload_bytes": weights.totalBytes, "largest_load_copy_bytes": VQDraftWeights.largestLoadCopyBytes,
            "relative_tolerance": 0.02, "cache_offsets": [43, 44], "comparisons": comparisons,
            "trace": trace, "trace_bytes": written, "peak_process_bytes": ProcessMemory.peakResidentBytes()]
        let raw = try JSONSerialization.data(withJSONObject: receipt, options: [.prettyPrinted, .sortedKeys])
        try raw.write(to: output.appendingPathComponent("receipt.json"), options: .withoutOverwriting)
        guard passed else { throw ModelError("draft component parity failed at the unchanged two-percent bound") }
        return raw
    }
}
