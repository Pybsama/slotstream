import Foundation
import MLX

extension Generator {
    /// The target sampler makes every output decision. Draft guesses only
    /// select which target rows can share a pass. Rejected recurrent and KV
    /// state is rolled back through the same checked path as MTP.
    func dflashDecode(draft: DFlashDraft, state: Qwen4ExpModel.State, logits: MLXArray,
        params: SampleParams, eosIds: Set<Int>, shouldContinue: () -> Bool, contextLimit: Int,
        checkAllocation: (Int, Int, String) throws -> Void, onToken: (Int) -> Bool,
        out: inout [Int], generated: inout Set<Int>, reason: inout String,
        consumed: inout [Int], stats: inout GenStats) throws {
        state.invalidateMTP()
        let context = DFlashDraft.Context()
        model.accumulatingDraftPrefill = false
        if let features = model.draftPrefillFeatures ?? model.draftFeatures, features.end == state.tokenCount {
            draft.append(features.rows, endingAt: features.end, to: context)
        }
        model.draftPrefillFeatures = nil
        var policy = AdaptiveSpeculationPolicy(maximumDepth: 7)
        let environment = ProcessInfo.processInfo.environment
        let useVerifyBudget = model.cfg.isFast
            ? environment["SLOTSTREAM_DFLASH_VERIFY_BUDGET"] != "0"
            : model.pool.expertStore.isQ2 && environment["SLOTSTREAM_Q2_VERIFY_BUDGET"] != "0"
        // Q2 keeps the bounded fit across ordinary engine requests and labels
        // the already evaluated bonus prediction, matching Splash's useful
        // batch selection for the explicit engineering candidate. Qualification
        // belongs to each declared complete-request protocol, including failed
        // comparisons at other cache sizes. Fast keeps its separately
        // measured request-local policy. Engine.dropPrefixCache clears the fit at
        // privacy/ownership transitions. Explicit 0/1 values are ablation
        // controls, not user-facing performance modes. See the prepared
        // execution measurement before changing either operating default.
        let q2Calibration = model.pool.expertStore.isQ2
        let reuseCalibration = environment["SLOTSTREAM_DFLASH_PERSISTENT_CALIBRATION"]
            .map { $0 == "1" } ?? q2Calibration
        let observeBonus = environment["SLOTSTREAM_DFLASH_BONUS_CALIBRATION"]
            .map { $0 == "1" } ?? q2Calibration
        var verifyBudget: DFlashVerifyBudget? = useVerifyBudget
            ? (reuseCalibration ? dflashVerifyCalibration ?? .init() : .init()) : nil
        stats.dflashCalibrationCyclesBefore = verifyBudget?.cycleCount
        defer {
            stats.dflashCalibrationCyclesAfter = verifyBudget?.cycleCount
            if reuseCalibration { dflashVerifyCalibration = verifyBudget }
        }
        guard params.maxTokens > 0, shouldContinue() else { reason = "stop"; return }
        let first = sample(logits, params: params, generated: generated)
        if eosIds.contains(first) { reason = "stop"; return }
        out.append(first); generated.insert(first)
        guard onToken(first) else { reason = "stop"; return }
        var pending: Int? = first
        while let token = pending, out.count < params.maxTokens {
            guard shouldContinue() else { reason = "stop"; break }
            let action = policy.action(contextTokens: state.tokenCount)
            let requestedDepth: Int
            if verifyBudget != nil, context.end == state.tokenCount { requestedDepth = 7 }
            else if case .draft(let depth) = action, context.end == state.tokenCount { requestedDepth = depth }
            else { requestedDepth = 0 }
            let depth = min(requestedDepth, params.maxTokens - out.count,
                max(0, contextLimit - state.tokenCount - 1))
            if depth == 0 {
                if action == .plain {
                    model.capturesDraftFeatures = false
                    stats.adaptiveDisabledAtOutput = stats.adaptiveDisabledAtOutput ?? out.count
                }
                try checkAllocation(state.tokenCount + 1, 1_300_000, "plain target decode")
                let started = RuntimeClock.now()
                model.lookahead?.beginPass(phase: .mainPlain, tokens: [token], features: [])
                let next = try model.lastLogitsChecked([token], state: state)
                eval(next)
                model.lookahead?.endPass()
                consumed.append(token)
                stats.decodeForwardPasses += 1; stats.decodeModelTokens += 1
                let sampled = sample(next, params: params, generated: generated)
                policy.observePlain(seconds: RuntimeClock.seconds(since: started), contextTokens: state.tokenCount)
                stats.adaptivePlainTokens += 1
                if action != .plain, let features = model.draftFeatures, features.end == state.tokenCount {
                    draft.append(features.rows, endingAt: features.end, to: context)
                }
                if eosIds.contains(sampled) { reason = "stop"; break }
                out.append(sampled); generated.insert(sampled)
                guard onToken(sampled) else { reason = "stop"; break }
                pending = sampled
                continue
            }
            let pipelinesBefore = q2Calibration ? NativeProjectionSchedule.pipelineCount : 0
            let started = RuntimeClock.now(), emittedBefore = out.count
            try checkAllocation(state.tokenCount, 64_000_000, "DFlash proposal workspace")
            let draftStart = RuntimeClock.now()
            let guesses = try draft.propose(anchor: token, depth: depth, target: model, context: context,
                captureConfidence: verifyBudget != nil)
            let chosen = verifyBudget.map { $0.depth(confidence: draft.proposalConfidence) } ?? guesses.count
            let proposals = Array(guesses.prefix(chosen))
            stats.draftSeconds += RuntimeClock.seconds(since: draftStart)
            stats.draftedTokens += proposals.count
            guard shouldContinue() else { reason = "stop"; break }
            let checkpoint = state.checkpoint(), input = [token] + proposals
            try checkAllocation(state.tokenCount + input.count,
                ContextWorkspace.prefillBytes(pass: input.count, context: state.tokenCount + input.count), "DFlash target verification")
            state.setRecording(true)
            let verifyStart = RuntimeClock.now()
            model.lookahead?.beginPass(phase: .mainVerify, tokens: input, features: [])
            let result = try model.allLogitsWithMultiChecked(input, state: state)
            eval(result.logits)
            stats.verifySeconds += RuntimeClock.seconds(since: verifyStart)
            stats.verifyPasses += 1; stats.decodeForwardPasses += 1; stats.decodeModelTokens += input.count
            let captured = model.draftFeatures
            var accepted = 0
            var bonusAccepted: Bool?
            pending = nil
            for position in 0...proposals.count {
                guard out.count < params.maxTokens else { break }
                guard shouldContinue() else { reason = "stop"; break }
                let sampled = sample(result.logits[0..., position..<(position + 1), 0...], params: params, generated: generated)
                if eosIds.contains(sampled) { reason = "stop"; break }
                if observeBonus, position == proposals.count, position < guesses.count {
                    bonusAccepted = sampled == guesses[position]
                }
                out.append(sampled); generated.insert(sampled)
                guard onToken(sampled) else { reason = "stop"; break }
                if position < proposals.count, sampled == proposals[position] { accepted += 1 }
                else { pending = sampled; break }
            }
            let reconcileStart = RuntimeClock.now()
            let kept = [token] + Array(proposals.prefix(accepted))
            try state.rollbackChecked(keeping: kept.count, of: input, from: checkpoint, ngramWindow: model.cfg.ngramSize - 1)
            model.lookahead?.passReconciled(kept: kept.count)
            model.lookahead?.endPass()
            consumed.append(contentsOf: kept)
            if let captured {
                draft.append(captured.rows[0..., 0..<kept.count, 0...], endingAt: state.tokenCount, to: context)
            }
            stats.reconciliationSeconds += RuntimeClock.seconds(since: reconcileStart)
            stats.acceptedDrafts += accepted; stats.adaptiveDraftDepths.append(proposals.count)
            let labelsValid = pending != nil && shouldContinue()
            if bonusAccepted != nil && labelsValid {
                stats.dflashBonusObservations = (stats.dflashBonusObservations ?? 0) + 1
            }
            let preparedPipelines = q2Calibration
                && NativeProjectionSchedule.pipelineCount > pipelinesBefore
            if preparedPipelines {
                stats.dflashPreparationCycles = (stats.dflashPreparationCycles ?? 0) + 1
            }
            verifyBudget?.observe(confidence: draft.proposalConfidence, verified: proposals.count,
                accepted: accepted, seconds: RuntimeClock.seconds(since: started),
                labelsValid: labelsValid, bonusAccepted: bonusAccepted)
            // The confidence/cost controller already selects the useful
            // prefix, including an anchor-only target pass. A second controller
            // permanently halving its proposal horizon confounds its cost fit
            // and prevents its scheduled exploration from recovering.
            if verifyBudget == nil {
                policy.observeDraft(seconds: RuntimeClock.seconds(since: started), emitted: out.count - emittedBefore,
                    drafted: proposals.count, accepted: accepted)
            }
        }
    }
}
