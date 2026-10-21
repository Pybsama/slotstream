import Foundation
import Slotstream

extension Diagnostics {
    public static func dflashConfiguration() throws -> CheckReport {
        var c = CheckBuilder("dflash-configuration")
        let target = try ModelConfig.parse(Data("{\"text_config\":{}}".utf8), label: "Smart geometry fixture")
        let draft: [String: Any] = ["target_layer_ids": [5, 15, 25, 35, 45], "block_size": 8,
            "mask_token_id": 248077, "conv_kernel_size": 2, "conv_group_size": 16,
            "selector_rank": 256, "selector_top_k": 16]
        let config: [String: Any] = ["architectures": ["DFlash2DraftModel"],
            "hidden_size": 2560, "vocab_size": 248320, "num_target_layers": 48,
            "rms_norm_eps": 1e-6, "hidden_act": "silu", "attention_bias": false,
            "rope_parameters": ["rope_type": "default", "rope_theta": 10000],
            "layer_types": Array(repeating: "sliding_attention", count: 5),
            "num_attention_heads": 32, "num_key_value_heads": 8, "head_dim": 128,
            "num_hidden_layers": 5, "intermediate_size": 7680, "sliding_window": 2048,
            "is_causal": false, "dflash_config": draft]
        func validate(_ value: [String: Any]) throws -> [Int] {
            try DFlashDraft.validateConfiguration(JSONSerialization.data(withJSONObject: value), target: target)
        }
        c.equal("published Smart geometry is accepted before tensor allocation", try validate(config), [5, 15, 25, 35, 45])
        let wrong: [(String, Any)] = [
            ("hidden_size", 2048), ("num_target_layers", 40), ("vocab_size", 248319),
            ("rms_norm_eps", 1e-5), ("attention_bias", true), ("is_causal", true),
            ("sliding_window", 4096), ("num_hidden_layers", 6), ("hidden_act", "gelu"),
            ("rope_parameters", ["rope_type": "default", "rope_theta": 10000000]),
            ("layer_types", Array(repeating: "full_attention", count: 5))]
        for (key, value) in wrong {
            var changed = config; changed[key] = value
            do { _ = try validate(changed); c.expect("reject incompatible \(key)", false) }
            catch { c.expect("reject incompatible \(key)", true) }
        }
        var changed = config, wrongDraft = draft
        wrongDraft["target_layer_ids"] = [4, 14, 24, 34, 44]; changed["dflash_config"] = wrongDraft
        do { _ = try validate(changed); c.expect("reject plausible but untrained layer taps", false) }
        catch { c.expect("reject plausible but untrained layer taps", true) }
        for ram in [16.0, 24, 32, 48, 64] {
            let plan = try Planner.plan(resources: .smartDFlash, expertsPerLayer: nil, poolGB: nil,
                memoryGB: 10, ramGB: ram, workingSetGB: ram * 0.75, availableGB: ram,
                mtp: .off, vision: .off, maxContextTokens: 32768, simulated: true,
                qualification: false, decodeLookahead: .off, mtpExperts: .automatic)
            c.expect("bounded Smart draft plan on simulated \(ram) GB",
                plan.simulated && plan.expectedPeakGB <= 10 && !plan.mtpEnabled && !plan.decodeLookahead
                    && plan.resources.residentReserveBytes >= 1_600_000_000
                    && !plan.resources.usesBaselineSpeedEvidence)
        }
        return c.report()
    }
}
