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
}
