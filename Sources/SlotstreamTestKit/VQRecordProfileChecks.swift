import Foundation
import Slotstream
import SlotstreamDiagnostics

extension Catalogue {
    static func vqRecordProfile() throws -> CheckReport {
        var c = CheckBuilder("vq-record-profile")
        guard let url = Bundle.module.url(forResource: "vq-record-profile-v1", withExtension: "json") else {
            throw ModelError("missing VQ record fixture")
        }
        let data = try Data(contentsOf: url)
        let profile = try VQRecordProfile.load(data, alignment: 1)
        c.equal("exact pinned revision", profile.revision, "8684640a3956b01c47f5d47f9b999e2ab8b985f1")
        let expected = [2_611_200, 2_611_200] + Array(repeating: 1_280_000, count: 25)
            + Array(repeating: 1_382_400, count: 7) + [1_280_000, 1_382_400]
            + Array(repeating: 1_280_000, count: 11) + [1_382_400]
        c.equal("48 exact ordered record sizes", profile.recordBytesByLayer, expected)
        c.equal("maximum payload", profile.slotPayloadBytes, 2_611_200)
        c.equal("one expert across 48 layers", profile.recordBytesByLayer.reduce(0, +), 65_024_000)
        c.equal("all expert payload", profile.allExpertPayloadBytes, 33_292_288_000)
        c.equal("shared books", profile.codebookBytes, 19_535_872)
        c.equal("unpadded stride", profile.slotStrideBytes, 2_611_200)
        let ledger = try profile.ledger(slotCount: 640)
        c.equal("640-slot pool", ledger.poolAllocatedBytes, 1_671_168_000)
        c.equal("layer 2 actual bytes", ledger.actualRecordBytesByLayer[2], 1_280_000)
        c.equal("layer 2 charged stride", ledger.slotStrideBytes, 2_611_200)
        c.equal("ledger shared books", ledger.sharedCodebookBytes, 19_535_872)
        c.equal("ledger all expert payload", ledger.allExpertPayloadBytes, 33_292_288_000)
        c.equal("ledger requested slots", ledger.slotCount, 640)
        let aligned = try VQRecordProfile.load(data, alignment: 4096)
        c.equal("4096-aligned slot stride", aligned.slotStrideBytes, 2_613_248)
        c.equal("4096-aligned 640-slot pool", try aligned.ledger(slotCount: 640).poolAllocatedBytes, 1_672_478_720)
        c.equal("alignment does not change payload", aligned.slotPayloadBytes, 2_611_200)
        c.equal("legacy affine-4 record bytes", Geometry.recordBytes, 2_764_800.0)
        c.equal("legacy affine-4 640-slot GB", Geometry.gb(640), 1.769472)
        c.equal("legacy affine-4 floor slots", Geometry.slotsForPoolGB(1.769472), 640)

        func rejects(_ label: String, reason: String, _ change: (inout [String: Any]) -> Void) throws {
            var object = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            let original = try JSONSerialization.data(withJSONObject: object, options: [.sortedKeys])
            change(&object)
            let altered = try JSONSerialization.data(withJSONObject: object, options: [.sortedKeys])
            c.expect("\(label) changes the manifest", altered != original)
            do {
                _ = try VQRecordProfile.load(altered, alignment: 1)
                c.expect(label, false, "altered manifest was accepted")
            } catch let error as ModelError {
                c.expect(label, error.description.contains(reason), error.description)
            } catch {
                c.expect(label, false, "unexpected rejection: \(error)")
            }
        }
        try rejects("unsupported revision", reason: "unsupported VQ schema, model, or revision") { $0["revision"] = "unapproved" }
        try rejects("changed source receipt", reason: "source hashes differ") { object in
            var source = object["source"] as! [String: Any]
            source["indexSHA256"] = String(repeating: "0", count: 64)
            object["source"] = source
        }
        try rejects("orphan tensor", reason: "tensor set contains") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            tensors[0]["name"] = "orphan.codebook"
            object["tensors"] = tensors
        }
        try rejects("wrong tensor bytes", reason: "declared byte count mismatch") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            tensors[0]["byteCount"] = 1025
            object["tensors"] = tensors
        }
        try rejects("wrong expert dimension", reason: "unexpected shape or dtype") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            let index = tensors.firstIndex { ($0["name"] as! String).hasSuffix(".codes") }!
            var shape = tensors[index]["shape"] as! [Int]
            shape[0] = 511
            tensors[index]["shape"] = shape
            object["tensors"] = tensors
        }
        try rejects("wrong codes dtype", reason: "unexpected shape or dtype") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            let index = tensors.firstIndex { ($0["name"] as! String).hasSuffix(".codes") && $0["dtype"] as? String == "U8" }!
            tensors[index]["dtype"] = "U32"
            object["tensors"] = tensors
        }
        for suffix in [".vq_scales", ".codebook"] {
            try rejects("missing \(suffix)", reason: "144 modules and 432 tensors") { object in
                var tensors = object["tensors"] as! [[String: Any]]
                tensors.remove(at: tensors.firstIndex { ($0["name"] as! String).hasSuffix(suffix) }!)
                object["tensors"] = tensors
            }
        }
        try rejects("duplicate tensor", reason: "duplicate module or tensor name") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            tensors[1] = tensors[0]
            object["tensors"] = tensors
        }
        try rejects("orphan VQ scale", reason: "tensor set contains") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            let index = tensors.firstIndex { ($0["name"] as! String).hasSuffix(".vq_scales") }!
            tensors[index]["name"] = "model.layers.0.mlp.switch_mlp.orphan.vq_scales"
            object["tensors"] = tensors
        }
        try rejects("affine weight under VQ module", reason: "tensor set contains") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            let index = tensors.firstIndex { ($0["name"] as! String).hasSuffix(".codes") }!
            tensors[index]["name"] = "model.layers.0.mlp.switch_mlp.down_proj.weight"
            object["tensors"] = tensors
        }
        try rejects("changed config receipt", reason: "source hashes differ") { object in
            var source = object["source"] as! [String: Any]
            source["configSHA256"] = String(repeating: "0", count: 64)
            object["source"] = source
        }
        try rejects("duplicate header hash", reason: "139 unique files and hashes") { object in
            var source = object["source"] as! [String: Any]
            var headers = source["headers"] as! [[String: Any]]
            headers[1]["sha256"] = headers[0]["sha256"]
            source["headers"] = headers
            object["source"] = source
        }
        try rejects("changed header hash with unchanged receipt label", reason: "frozen manifest fingerprint") { object in
            var source = object["source"] as! [String: Any]
            var headers = source["headers"] as! [[String: Any]]
            headers[0]["sha256"] = String(repeating: "f", count: 64)
            source["headers"] = headers
            object["source"] = source
        }
        try rejects("changed header file with unchanged receipt label", reason: "frozen manifest fingerprint") { object in
            var source = object["source"] as! [String: Any]
            var headers = source["headers"] as! [[String: Any]]
            headers[0]["file"] = "forged-header.safetensors"
            source["headers"] = headers
            object["source"] = source
        }
        try rejects("self-consistent cross-layer tuple swap", reason: "frozen manifest fingerprint") { object in
            let first = "model.layers.0.mlp.switch_mlp.gate_proj"
            let second = "model.layers.2.mlp.switch_mlp.gate_proj"
            var modules = object["modules"] as! [[String: Any]]
            let firstModule = modules.firstIndex { $0["name"] as? String == first }!
            let secondModule = modules.firstIndex { $0["name"] as? String == second }!
            for field in ["dim", "k", "group"] {
                let value = modules[firstModule][field]
                modules[firstModule][field] = modules[secondModule][field]
                modules[secondModule][field] = value
            }
            object["modules"] = modules
            var tensors = object["tensors"] as! [[String: Any]]
            for suffix in [".codes", ".vq_scales", ".codebook"] {
                let firstTensor = tensors.firstIndex { $0["name"] as? String == first + suffix }!
                let secondTensor = tensors.firstIndex { $0["name"] as? String == second + suffix }!
                for field in ["shape", "dtype", "byteCount"] {
                    let value = tensors[firstTensor][field]
                    tensors[firstTensor][field] = tensors[secondTensor][field]
                    tensors[secondTensor][field] = value
                }
            }
            object["tensors"] = tensors
        }
        try rejects("alternate expert geometry", reason: "alternate expert geometry") { object in
            var modules = object["modules"] as! [[String: Any]]
            modules[0]["input"] = 641
            object["modules"] = modules
        }
        for field in ["dim", "group"] {
            try rejects("alternate \(field)", reason: "alternate expert geometry") { object in
                var modules = object["modules"] as! [[String: Any]]
                modules[0][field] = 3
                object["modules"] = modules
            }
        }
        try rejects("unsupported codebook K", reason: "unsupported codebook tuple") { object in
            var modules = object["modules"] as! [[String: Any]]
            modules[0]["k"] = 1024
            object["modules"] = modules
        }
        try rejects("noncanonical layer spelling", reason: "noncanonical module") { object in
            var modules = object["modules"] as! [[String: Any]]
            let original = modules[0]["name"] as! String
            let renamed = original.replacingOccurrences(of: "model.layers.0.", with: "model.layers.00.")
            modules[0]["name"] = renamed
            object["modules"] = modules
            var tensors = object["tensors"] as! [[String: Any]]
            for index in tensors.indices where (tensors[index]["name"] as! String).hasPrefix(original + ".") {
                let name = tensors[index]["name"] as! String
                tensors[index]["name"] = renamed + name.dropFirst(original.count)
            }
            object["tensors"] = tensors
        }
        try rejects("mixed affine suffix", reason: "tensor set contains") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            let old = tensors[2]["name"] as! String
            tensors[2]["name"] = old.replacingOccurrences(of: ".vq_scales", with: ".scales")
            object["tensors"] = tensors
        }
        try rejects("oversized tensor shape", reason: "unexpected shape or dtype") { object in
            var tensors = object["tensors"] as! [[String: Any]]
            tensors[0]["shape"] = [Int.max, Int.max]
            object["tensors"] = tensors
        }
        for count in [-1, 24_577, Int.max] {
            do { _ = try profile.ledger(slotCount: count); c.expect("reject slot count \(count)", false) }
            catch { c.expect("reject slot count \(count)", true) }
        }
        for alignment in [0, 3, Int.max] {
            do { _ = try VQRecordProfile.load(data, alignment: alignment); c.expect("reject alignment \(alignment)", false) }
            catch { c.expect("reject alignment \(alignment)", true) }
        }
        let wide = try VQRecordProfile.load(data, alignment: 1 << 62)
        c.equal("large power-of-two alignment is valid", wide.slotStrideBytes, 1 << 62)
        do {
            _ = try wide.ledger(slotCount: 640)
            c.expect("large aligned pool multiplication overflows", false, "overflowing pool was accepted")
        } catch let error as ModelError {
            c.expect("large aligned pool multiplication overflows",
                error.description.contains("slot pool: byte multiplication overflow"), error.description)
        } catch {
            c.expect("large aligned pool multiplication overflows", false, "unexpected error: \(error)")
        }
        return c.report()
    }
}
