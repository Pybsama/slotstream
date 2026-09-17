import MLX
import Slotstream

extension Diagnostics {
    /// The verify-pass controls on synthetic tensors: row-invariant matmuls,
    /// the split verify attention at short context, and the exact mode's
    /// attention, indexer selection and quantized products at every size where
    /// the backend changes kernels, reproduce one-row arithmetic.
    public static func verifyPassRows() -> CheckReport {
        MLX.Memory.cacheLimit = 256 << 20
        var c = CheckBuilder("verify-pass-rows")
        for result in VerifyPassSelfCheck.matmulRows() { c.expect("row-invariant matmul: " + result.name, result.passed) }
        for result in VerifyPassSelfCheck.splitRows() { c.expect("split verify attention: " + result.name, result.passed) }
        let exact = VerifyPassSelfCheck.exactRows()
        for result in exact.results { c.expect("exact verify attention: " + result.name, result.passed) }
        for keys in exact.splitCompared.keys.sorted() {
            c.measure("split_rows_differing_at_\(keys)_keys_of_\(exact.splitCompared[keys] ?? 0)",
                Double(exact.splitDiffering[keys] ?? 0))
        }
        let indexer = VerifyPassSelfCheck.indexerRows()
        for result in indexer.results { c.expect("exact indexer selection: " + result.name, result.passed) }
        c.measure("whole_pass_selection_rows_differing_with_ties", Double(indexer.batchedDiffering))
        c.measure("whole_pass_selection_rows_compared_with_ties", Double(indexer.compared))
        c.measure("whole_pass_indexer_score_rows_differing", Double(indexer.scoresDiffering))
        let quantized = VerifyPassSelfCheck.quantizedRows()
        for result in quantized.results { c.expect("quantized matmul: " + result.name, result.passed) }
        c.measure("quantized_6_to_8_row_products_differing", Double(quantized.wideDiffering))
        c.measure("quantized_6_to_8_row_products_compared", Double(quantized.wideCompared))
        for (name, value) in VerifyPassSelfCheck.stockDeviation() { c.measure(name, value) }
        return c.report()
    }

    /// The verify-pass controls themselves: what the deployment family sets,
    /// what each environment override resolves to, and which mode and pass
    /// shapes the resulting controls select. Called from `runtime-check`,
    /// where the rest of the control resolution is checked; it lives here so
    /// the verify-pass assertions stay with the verify-pass diagnostics.
    static func verifyPassControls(_ c: inout CheckBuilder) throws {
        let candidate = InferenceOptimizations.integrationCandidate
        c.expect("combined candidate splits the speculative verify attention", candidate.verifySplitAttention == true)
        var noSplit = candidate; noSplit.verifySplitAttention = nil
        c.equal("explicit zero disables only SLOTSTREAM_OPT_VERIFY_SPLIT",
            try InferenceOptimizations.resolving(environment: ["SLOTSTREAM_OPT_VERIFY_SPLIT": "0"], defaults: candidate), noSplit)
        c.equal("explicit one restores only SLOTSTREAM_OPT_VERIFY_SPLIT",
            try InferenceOptimizations.resolving(environment: ["SLOTSTREAM_OPT_VERIFY_SPLIT": "1"], defaults: noSplit), candidate)
        var anyContext = candidate; anyContext.verifySplitMinContext = 0
        c.equal("the verify split threshold override leaves the family intact",
            try InferenceOptimizations.resolving(environment: ["SLOTSTREAM_OPT_VERIFY_SPLIT_CONTEXT": "0"], defaults: candidate), anyContext)
        // Verify-pass controls are optional, so control sets saved before them decode unchanged.
        let reference = InferenceOptimizations()
        c.expect("reference leaves the verify-pass controls unset",
            reference.verifySplitAttention == nil && reference.verifySplitMinContext == nil
                && reference.rowInvariantProjection == nil)
        c.equal("explicit verify split threshold is read", try InferenceOptimizations.resolving(
            environment: ["SLOTSTREAM_OPT_VERIFY_SPLIT_CONTEXT": "0"], defaults: reference).verifySplitMinContext, 0)
        for bad in ["-1", "x", "1.5", ""] {
            var rejected = false
            do {
                _ = try InferenceOptimizations.resolving(environment: ["SLOTSTREAM_OPT_VERIFY_SPLIT_CONTEXT": bad], defaults: reference)
            } catch { rejected = true }
            c.expect("verify split threshold rejects \(bad.isEmpty ? "an empty value" : bad)", rejected)
        }
        c.expect("explicit one enables row-invariant projections", try InferenceOptimizations.resolving(
            environment: ["SLOTSTREAM_OPT_ROW_INVARIANT": "1"], defaults: reference).rowInvariantProjection == true)
        var invariant = reference; invariant.rowInvariantProjection = true
        c.equal("explicit zero returns row-invariant projections to unset", try InferenceOptimizations.resolving(
            environment: ["SLOTSTREAM_OPT_ROW_INVARIANT": "0"], defaults: invariant), reference)
        c.expect("row-invariant projections stay off unless selected", !RowInvariantMatmul.enabled)
        // The verify-pass attention policy: which mode the controls select and
        // which passes it engages for.
        typealias MRA = MultiRowAttention
        c.expect("verify split engages from 6,144 keys by default", MRA.defaultMinContext == 6144)
        c.expect("exact mode promises passes of up to five rows", MRA.exactMaxRows == 5)
        c.expect("no split control selects the stock verify attention",
            MRA.mode(splitAttention: nil, rowInvariant: nil) == .stock && MRA.mode(splitAttention: nil, rowInvariant: true) == .stock)
        c.expect("the split control alone selects the split", MRA.mode(splitAttention: true, rowInvariant: nil) == .split)
        c.expect("the split with row-invariant projections selects the exact mode",
            MRA.mode(splitAttention: true, rowInvariant: true) == .exact)
        c.expect("stock never engages", !MRA.engages(mode: .stock, rows: 3, context: 1 << 20, minContext: 0))
        c.expect("the split engages for three to eight rows from its threshold",
            MRA.engages(mode: .split, rows: 3, context: 6144, minContext: 6144)
                && MRA.engages(mode: .split, rows: 8, context: 6144, minContext: 6144)
                && !MRA.engages(mode: .split, rows: 2, context: 1 << 20, minContext: 0)
                && !MRA.engages(mode: .split, rows: 9, context: 1 << 20, minContext: 0)
                && !MRA.engages(mode: .split, rows: 3, context: 6143, minContext: 6144))
        c.expect("the exact mode engages from two rows, never for one",
            MRA.engages(mode: .exact, rows: 2, context: 1, minContext: 0)
                && !MRA.engages(mode: .exact, rows: 1, context: 1 << 20, minContext: 0)
                && !MRA.engages(mode: .exact, rows: 9, context: 1 << 20, minContext: 0))
    }
}
