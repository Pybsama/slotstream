import CryptoKit
import Foundation

/// The checkpoint's shipped tap correction as a pinned sidecar of the model
/// mirror: not a Slotpack object, so the embedded manifest and every existing
/// pull are untouched. `pull` fetches it after the weights when it is absent
/// or does not match, verifies size and digest, and writes it atomically. A
/// checkpoint without it runs the boundary forecast, so any failure here is
/// reported and never fails a pull.
public enum TapCorrectionSidecar {
    public struct File: Sendable {
        public let path: String
        public let size: Int
        public let sha256: String
        /// The mirror commit that carries the file; the digest pins the bytes.
        public let revision: String
    }

    public enum Status: Equatable, Sendable {
        case absent
        case present
        case mismatched(String)
    }

    /// The rank-128 attention-tap correction the held-out confirmations of
    /// 2026-09-15 measured (1.031 over the plain tap, 1.111 over the previous
    /// default), 35.25 MiB of FP16 factors for the pinned checkpoint.
    public static let attention = File(path: RouterTapCorrection.shippedRelativePath, size: 37_540_708,
                                       sha256: RouterTapCorrection.shippedSHA256,
                                       revision: "8c1f9c34e4567e83d46cebe1af432e8eba4f3ea8")
    public static let files = [attention]
    static let base = "https://huggingface.co/carloslfu/Qwen3.8-Flash-Next-MLX-4bit-Slotpack/resolve/"

    public static func url(_ file: File) -> URL {
        URL(string: base + file.revision + "/" + file.path)!
    }

    public static func status(modelDir: URL, file: File = attention) -> Status {
        let path = modelDir.appendingPathComponent(file.path).path
        guard let data = FileManager.default.contents(atPath: path) else { return .absent }
        guard data.count == file.size else { return .mismatched("size \(data.count), pinned \(file.size)") }
        let digest = SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
        return digest == file.sha256 ? .present : .mismatched("digest \(digest.prefix(16)), pinned \(file.sha256.prefix(16))")
    }

    /// Fetch and verify the sidecar when it is absent or wrong. Returns true
    /// when the file is present and exact afterwards.
    @discardableResult
    public static func ensure(modelDir: URL, file: File = attention, cancellation: PullCancellation = PullCancellation(),
                              log: (String) -> Void) -> Bool {
        switch status(modelDir: modelDir, file: file) {
        case .present:
            log("\(file.path): present, \(file.size) bytes, digest verified")
            return true
        case .mismatched(let why):
            log("\(file.path): \(why); fetching the pinned file")
        case .absent:
            log("\(file.path): fetching \(file.size) bytes (the corrected decode forecast; optional)")
        }
        do {
            let http = DownloadHTTP(cancellation: cancellation)
            defer { http.close() }
            let data = try http.fetch(url(file), size: file.size)
            let digest = SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
            guard digest == file.sha256 else {
                throw SlotstreamError.pull("\(file.path) digest \(digest.prefix(16)) does not match the pinned \(file.sha256.prefix(16))")
            }
            let final = modelDir.appendingPathComponent(file.path)
            let fm = FileManager.default
            try fm.createDirectory(at: final.deletingLastPathComponent(), withIntermediateDirectories: true)
            let temp = final.appendingPathExtension("part")
            try data.write(to: temp, options: .atomic)
            if fm.fileExists(atPath: final.path) { try fm.removeItem(at: final) }
            try fm.moveItem(at: temp, to: final)
            log("\(file.path): \(file.size) bytes, digest verified")
            return true
        } catch {
            log("\(file.path): not fetched (\(error)); the boundary forecast runs until it is")
            return false
        }
    }
}
