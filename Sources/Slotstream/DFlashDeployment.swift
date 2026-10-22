import Foundation

/// Pinned acceleration component. Stored separately from target shards so the
/// target loader cannot accidentally interpret draft tensors as target weights.
public enum DFlashDeployment {
    public static let revision = "51ef7b6923ad6c14cb1bb41c37a9041446496ab6"
    public static let files: [PinnedModel.File] = [
        .init(path: "LICENSE", size: 11343, sha256: "50cbab8a892c5f2993b8c7351a99182507472def3b1374558308605d99b86b32"),
        .init(path: "README.md", size: 5173, sha256: "d42aa1b008d20479a6fd3d5df2846d304d5c18a96e8191427bb819d3d30f3b2a"),
        .init(path: "config.json", size: 1291, sha256: "86d2e8e57e7c70bb867240708d00c0535ae9ed3c828dbdcb21584471c7bbce59"),
        .init(path: "model.safetensors", size: 1052513456, sha256: "d1f16c0ff85afbe6166fabfae998af3ec16fa11da87da4391b5e0e0a7c796a4d"),
    ]
    static let deployment = try! WeightDeployment(repository: "incoai/Qwen3.6-35B-A3B-DFlash2", revision: revision,
        files: files, rawBases: ["https://huggingface.co/incoai/Qwen3.6-35B-A3B-DFlash2/resolve/" + revision])
    public static func directory(for target: URL) -> URL { target.appendingPathComponent("dflash", isDirectory: true) }
    public static func store(for target: URL) -> WeightStore {
        WeightStore(modelDirectory: directory(for: target), deployment: deployment)
    }
}

/// Exact upstream Smart draft, kept separate from the Fast deployment.
/// The explicit native comparison uses these original published bytes.
package enum SmartDFlashDeployment {
    package static let revision = "a22a1744e85c17364dcc54a6a420af7135d4c7f6"
    package static let files: [PinnedModel.File] = [
        .init(path: "README.md", size: 5402, sha256: "296dfce04d501f313f4223a4ab2378f198ecb860e3b24a4689e66aff651f0477"),
        .init(path: "config.json", size: 1236, sha256: "2409575986f9ea24d455343eb469c0e6940def5edab1d1be503bb8eb4cc3b1b9"),
        .init(path: "model.safetensors", size: 1206140008, sha256: "d6723f2a359eaf33ec0c95f22ae8edda896774020c552296a85e1913b4d3186f"),
    ]
    static let deployment = try! WeightDeployment(repository: "incoai/Qwen3.8-Flash-Next-DFlash2",
        revision: revision, files: files,
        rawBases: ["https://huggingface.co/incoai/Qwen3.8-Flash-Next-DFlash2/resolve/" + revision])
    package static func store(for target: URL) -> WeightStore {
        WeightStore(modelDirectory: DFlashDeployment.directory(for: target), deployment: deployment)
    }
}

public extension ModelPack {
    var usesDFlash: Bool { id == PinnedFastModel.name || id == PinnedQ2Model.name }
    var draftFiles: [PinnedModel.File] { id == PinnedQ2Model.name ? SmartDFlashDeployment.files : DFlashDeployment.files }
    var installationBytes: Int64 { totalBytes + (usesDFlash ? draftFiles.reduce(0) { $0 + $1.size } : 0)
        + (id == PinnedQ2Model.name ? PinnedQ2Model.metadataDeployment.totalBytes : 0) }
    func installationStores(at directory: URL) -> [WeightStore] {
        [WeightStore(modelDirectory: directory, pack: self)]
            + (id == PinnedQ2Model.name ? [WeightStore(modelDirectory: directory, deployment: PinnedQ2Model.metadataDeployment)] : [])
            + (usesDFlash ? [id == PinnedQ2Model.name ? SmartDFlashDeployment.store(for: directory) : DFlashDeployment.store(for: directory)] : [])
    }
    func installationFiles(at directory: URL) -> [URL] {
        (files + (id == PinnedQ2Model.name ? PinnedQ2Model.metadataFiles : [])).map { directory.appendingPathComponent($0.path) } + (usesDFlash
            ? draftFiles.map { DFlashDeployment.directory(for: directory).appendingPathComponent($0.path) } : [])
    }
    func installationStatus(at directory: URL, shouldContinue: @escaping () -> Bool = { true }) throws -> WeightStatus {
        let states = try installationStores(at: directory).map { try $0.status(shouldContinue: shouldContinue) }
        if states.allSatisfy({ $0.isReady }) { return .ready }
        let remaining = states.reduce(Int64(0)) { $0 + $1.bytesToFetch }
        let free = WeightStore.freeDiskBytes(near: directory)
        let corrupt = states.enumerated().flatMap { index, status -> [String] in
            if case .corrupt(let paths, _, _) = status {
                let isDraft = usesDFlash && index == states.count - 1
                return paths.map { (isDraft ? "dflash/" : "") + $0 }
            }
            return []
        }
        if !corrupt.isEmpty { return .corrupt(paths: corrupt, repairBytes: remaining, freeDiskBytes: free) }
        return .incomplete(remainingBytes: remaining, freeDiskBytes: free)
    }
}
