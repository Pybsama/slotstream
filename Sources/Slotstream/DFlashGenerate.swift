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
        var verifyBudget: DFlashVerifyBudget? = model.pool.expertStore.isQ2
            && ProcessInfo.processInfo.environment["SLOTSTREAM_Q2_VERIFY_BUDGET"] != "0" ? .init() : nil
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
                let next = try model.lastLogitsChecked([token], state: state)
                eval(next)
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
            let result = try model.allLogitsWithMultiChecked(input, state: state)
            eval(result.logits)
            stats.verifySeconds += RuntimeClock.seconds(since: verifyStart)
            stats.verifyPasses += 1; stats.decodeForwardPasses += 1; stats.decodeModelTokens += input.count
            let captured = model.draftFeatures
            var accepted = 0
            pending = nil
            for position in 0...proposals.count {
                guard out.count < params.maxTokens else { break }
                guard shouldContinue() else { reason = "stop"; break }
                let sampled = sample(result.logits[0..., position..<(position + 1), 0...], params: params, generated: generated)
                if eosIds.contains(sampled) { reason = "stop"; break }
                out.append(sampled); generated.insert(sampled)
                guard onToken(sampled) else { reason = "stop"; break }
                if position < proposals.count, sampled == proposals[position] { accepted += 1 }
                else { pending = sampled; break }
            }
            let reconcileStart = RuntimeClock.now()
            let kept = [token] + Array(proposals.prefix(accepted))
            try state.rollbackChecked(keeping: kept.count, of: input, from: checkpoint, ngramWindow: model.cfg.ngramSize - 1)
            consumed.append(contentsOf: kept)
            if let captured {
                draft.append(captured.rows[0..., 0..<kept.count, 0...], endingAt: state.tokenCount, to: context)
            }
            stats.reconciliationSeconds += RuntimeClock.seconds(since: reconcileStart)
            stats.acceptedDrafts += accepted; stats.adaptiveDraftDepths.append(proposals.count)
            verifyBudget?.observe(confidence: draft.proposalConfidence, verified: proposals.count,
                accepted: accepted, seconds: RuntimeClock.seconds(since: started),
                labelsValid: pending != nil && shouldContinue())
            // Q2's confidence/cost controller already selects the useful
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
