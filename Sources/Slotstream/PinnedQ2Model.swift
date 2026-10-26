import Foundation

/// Exact upstream GSQ-RCO checkpoint, separate from the original MLX target.
/// Metadata and draft components have their own pinned download sources.
public enum PinnedQ2Model {
    public static let name = "qwen3.8-flash-next:gsq-q2"
    public static let directoryName = "qwen38-flash-next-gsq-q2"
    public static let repository = "ISTA-DASLab/Qwen3.8-Flash-Next-GSQ-RCO-GGUF"
    public static let revision = "ed59f92082b1e93c0e96d60a8b11aab089b52f09"
    public static let files: [PinnedModel.File] = [
        .init(path: "Qwen3.8-Flash-Next-GSQ-RCO-Q2_0-00001-of-00002.gguf", size: 37_623_740_192,
            sha256: "69820c02ec7d0b45ef2ebb19d6620299db749fe2aded7f39f93c6b88b199b720"),
        .init(path: "Qwen3.8-Flash-Next-GSQ-RCO-Q2_0-00002-of-00002.gguf", size: 28_800_138_432,
            sha256: "316b46f3a2dbd68c900f43136ab9449f9dcc3725dfd8c794847c204bc161e113"),
    ]
    static let metadataFiles = PinnedModel.files.filter {
        ["config.json", "tokenizer.json", "tokenizer_config.json", "chat_template.jinja",
         "generation_config.json", "LICENSE"].contains($0.path)
    }
    static let deployment = try! WeightDeployment(repository: repository, revision: revision, files: files,
        rawBases: ["https://huggingface.co/" + repository + "/resolve/" + revision])
    static let metadataDeployment = try! WeightDeployment(repository: PinnedModel.repo,
        revision: PinnedModel.revision, files: metadataFiles,
        rawBases: ["https://huggingface.co/" + PinnedModel.repo + "/resolve/" + PinnedModel.revision])
}
