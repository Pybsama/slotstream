import ArgumentParser
import Foundation
import MLX
import Slotstream

/// Replays trained target activations at fixed widths. The traced arm forces
/// evaluation at each named boundary and is deliberately separate from timing
/// the normal graph. Neither arm is a completed-request speed claim.
struct Q2ProfileCheck: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "q2-profile",
        abstract: "Attribute native Q2 target work on a bounded fixed-token replay")
    @Option var fixture: String
    @Option var output: String
    @Option var memoryGB: Double = 10
    @Option var rounds: Int = 3

    func run() throws {
        guard (10...20).contains(memoryGB), (1...5).contains(rounds),
              !FileManager.default.fileExists(atPath: output) else {
            throw ValidationError("Use a fresh receipt, 10–20 GB and one to five rounds")
        }
        let inputURL = URL(fileURLWithPath: fixture)
        guard let size = try inputURL.resourceValues(forKeys: [.fileSizeKey]).fileSize,
              (1..<10_000_000).contains(size) else { throw ValidationError("Fixture exceeds 10 MB") }
        let data = try Data(contentsOf: inputURL)
        guard data.count < 10_000_000,
              let input = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let prefix = input["prompt_ids"] as? [Int],
              let continuation = input["output_ids"] as? [Int],
              (1...512).contains(prefix.count), continuation.count >= 8,
              (prefix + Array(continuation.prefix(8))).allSatisfy({ (0..<248_320).contains($0) }) else {
            throw ValidationError("Use a bounded production run receipt with prompt and output IDs")
        }
        let machine = Machine.current()
        guard (machine.availableGB ?? 0) >= memoryGB + 3 else {
            throw ModelError("Q2 profile needs its target plus 3 GB reclaimable")
        }
        let plan = try Planner.plan(resources: .q2, expertsPerLayer: nil, poolGB: nil, memoryGB: memoryGB,
            ramGB: machine.ramGB, workingSetGB: machine.workingSetGB, availableGB: machine.availableGB,
            mtp: .off, mtpAvailable: false, vision: .off, visionAvailable: false,
            maxContextTokens: 8192, qualification: false, decodeLookahead: .off, mtpExperts: .automatic)
        let sem = DispatchSemaphore(value: 0)
        var outcome: Result<Void, Error> = .success(())
        Task {
            do {
                let engine = try await Engine(modelDir: ModelLocator.resolve(PinnedQ2Model.name), plan: plan)
                func checkMemory() throws {
                    guard ProcessMemory.peakResidentGB <= memoryGB,
                          (ProcessMemory.vmActivity()?.reclaimableBytes ?? 0) > 1_000_000_000 else {
                        throw ModelError("Profile exceeded its physical memory ceiling or headroom")
                    }
                }
                try checkMemory()
                let model = engine.model, state = model.makeState()
                eval(try model.lastLogitsChecked(prefix, state: state))
                let checkpoint = state.checkpoint()
                var rows: [[String: Any]] = []
                defer { model.contextNumericsObserver = nil; model.gdnPhaseProfile = nil; model.capturesDraftFeatures = false }
                for width in [1, 2, 4, 8] {
                    let ids = Array(continuation.prefix(width))
                    model.capturesDraftFeatures = width > 1
                    var reference: MLXArray?
                    // Both paths warm once. Alternate their order thereafter.
                    for round in 0...rounds {
                        for traced in (round.isMultiple(of: 2) ? [false, true] : [true, false]) {
                            try state.restoreChecked(checkpoint)
                            state.setRecording(width > 1)
                            model.pool.resetStats()
                            var phases: [[String: Any]] = []
                            let gdn = traced ? GDNPhaseProfile() : nil
                            model.gdnPhaseProfile = gdn
                            var previous = RuntimeClock.now()
                            if traced {
                                model.contextNumericsObserver = { layer, name, value in
                                    let entered = RuntimeClock.now()
                                    eval(value)
                                    let ended = RuntimeClock.now()
                                    phases.append(["layer": layer, "phase": name,
                                        "dtype": String(describing: value.dtype),
                                        "host_seconds": Double(entered - previous) / 1e9,
                                        "eval_seconds": Double(ended - entered) / 1e9])
                                    previous = ended
                                }
                            } else { model.contextNumericsObserver = nil }
                            let before = ProcessMemory.vmActivity()
                            let started = RuntimeClock.now()
                            previous = started
                            let logits = width == 1
                                ? try model.lastLogitsChecked(ids, state: state)
                                : try model.allLogitsWithMultiChecked(ids, state: state).logits
                            eval(logits)
                            let elapsed = RuntimeClock.seconds(since: started)
                            let trailing = RuntimeClock.seconds(since: previous)
                            model.contextNumericsObserver = nil
                            model.gdnPhaseProfile = nil
                            let after = ProcessMemory.vmActivity()
                            if reference == nil { reference = logits }
                            let difference = abs(logits.asType(.float32) - reference!.asType(.float32))
                            let row: [String: Any] = ["width": width, "round": round, "traced": traced,
                                "seconds": elapsed, "started_uptime_ns": started, "ended_uptime_ns": started + UInt64(elapsed * 1e9), "trailing_seconds": trailing, "phases": phases,
                                "gdn": (gdn?.samples ?? []).map { sample in
                                    ["layer": Double(sample.layer), "input": sample.inputWait,
                                     "preparation": sample.preparation, "recurrence": sample.recurrence,
                                     "finish": sample.finish]
                                },
                                "max_logit_difference": difference.max().item(Float.self),
                                "argmax_equal": (argMax(logits, axis: -1) .== argMax(reference!, axis: -1)).all().item(Bool.self),
                                "io_seconds": model.pool.ioSeconds,
                                "peak_gb": ProcessMemory.peakResidentGB,
                                "swapins_delta": (after?.swapins ?? 0) - (before?.swapins ?? 0),
                                "swapouts_delta": (after?.swapouts ?? 0) - (before?.swapouts ?? 0)]
                            try checkMemory()
                            rows.append(row)
                            let receipt: [String: Any] = ["plan": plan.json(), "prompt_ids": prefix,
                                "continuation_ids": Array(continuation.prefix(8)), "runs": rows,
                                "scope": "Fixed-forward replay, not generation. Traced boundaries serialize evaluation. Round zero is warmup."]
                            try JSONSerialization.data(withJSONObject: receipt, options: [.prettyPrinted, .sortedKeys])
                                .write(to: URL(fileURLWithPath: output), options: .atomic)
                            print("width \(width), round \(round), traced \(traced): \(elapsed) seconds")
                        }
                    }
                }
            } catch { outcome = .failure(error) }
            sem.signal()
        }
        sem.wait()
        try outcome.get()
    }
}
