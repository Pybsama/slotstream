import CoreFoundation
import CryptoKit
import Darwin
import Foundation

/// Experimental, immutable safetensors access. The caller must authenticate
/// the supplied identities against its pinned pack manifest. This constructor
/// verifies the entire payload through the same owned descriptor later used
/// for tensor reads; a header hash alone never admits model bytes.
package final class VQTensorFile {
    package static let maximumRead = 1_000_000
    package struct Identity {
        package let fileBytes: Int
        package let headerBytes: Int
        package let headerSHA256: String
        package let fileSHA256: String
        package init(fileBytes: Int, headerBytes: Int, headerSHA256: String, fileSHA256: String) {
            self.fileBytes = fileBytes; self.headerBytes = headerBytes
            self.headerSHA256 = headerSHA256; self.fileSHA256 = fileSHA256
        }
    }
    private struct Stamp: Equatable {
        let device: dev_t, inode: ino_t, bytes: off_t
        let modifiedSeconds: Int, modifiedNanos: Int, changedSeconds: Int, changedNanos: Int
        init(_ value: stat) {
            device = value.st_dev; inode = value.st_ino; bytes = value.st_size
            modifiedSeconds = value.st_mtimespec.tv_sec; modifiedNanos = value.st_mtimespec.tv_nsec
            changedSeconds = value.st_ctimespec.tv_sec; changedNanos = value.st_ctimespec.tv_nsec
        }
    }
    private let descriptor: Int32
    private let stamp: Stamp
    package let tensors: [String: TensorRef]

    private static func hash(_ data: Data) -> String {
        SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }
    private static func status(_ fd: Int32) throws -> stat {
        var value = stat()
        guard fstat(fd, &value) == 0 else { throw ModelError("cannot inspect owned VQ tensor descriptor") }
        return value
    }
    private static func raw(_ fd: Int32, offset: Int, count: Int, shouldContinue: () -> Bool = { true }) throws -> Data {
        // Header reads may exceed a payload read, but are still bounded before
        // allocation. Every syscall is at most one megabyte.
        guard offset >= 0, count > 0, count <= 4_000_000,
              !offset.addingReportingOverflow(count).overflow else { throw CheckpointReadError.invalidRange }
        var data = Data(count: count)
        try data.withUnsafeMutableBytes { buffer in
            try ExactRead.transfer(into: buffer.baseAddress!, offset: offset, count: count, shouldContinue: shouldContinue) { destination, remaining, position in
                let got = pread(fd, destination, min(remaining, maximumRead), off_t(position))
                return .init(count: got, error: got < 0 ? errno : 0)
            }
        }
        return data
    }

    package init(url: URL, identity: Identity, shouldContinue: () -> Bool = { true }) throws {
        func validSHA(_ value: String) -> Bool {
            value.utf8.count == 64 && value.utf8.allSatisfy { (48...57).contains($0) || (97...102).contains($0) }
        }
        guard identity.fileBytes > 8, identity.fileBytes <= 200_000_000_000,
              (1...4_000_000).contains(identity.headerBytes), identity.headerBytes <= identity.fileBytes - 8,
              validSHA(identity.headerSHA256), validSHA(identity.fileSHA256) else {
            throw ModelError("invalid pinned VQ safetensors identity")
        }
        let fd = open(url.path, O_RDONLY | O_NOFOLLOW | O_NONBLOCK | O_CLOEXEC)
        guard fd >= 0 else { throw ModelError("cannot open regular VQ tensor file") }
        do {
            let initial = try Self.status(fd)
            guard initial.st_mode & S_IFMT == S_IFREG, initial.st_size == Int64(identity.fileBytes) else {
                throw ModelError("VQ tensor file kind or size differs from its pinned identity")
            }
            let prefix = try Self.raw(fd, offset: 0, count: 8, shouldContinue: shouldContinue)
            let length = prefix.withUnsafeBytes { UInt64(littleEndian: $0.loadUnaligned(as: UInt64.self)) }
            guard length == UInt64(identity.headerBytes) else { throw ModelError("VQ tensor header extent changed") }
            let header = try Self.raw(fd, offset: 8, count: identity.headerBytes, shouldContinue: shouldContinue)
            guard Self.hash(header) == identity.headerSHA256,
                  let object = try JSONSerialization.jsonObject(with: header) as? [String: Any] else {
                throw ModelError("VQ tensor header identity or JSON is invalid")
            }
            let dataStart = 8 + identity.headerBytes, dataBytes = identity.fileBytes - dataStart
            var parsed: [String: TensorRef] = [:]
            func integer(_ value: Any) throws -> Int {
                guard let n = value as? NSNumber, CFGetTypeID(n) != CFBooleanGetTypeID(),
                      !["f", "d"].contains(String(cString: n.objCType)),
                      let result = value as? Int, result >= 0 else { throw ModelError("invalid VQ tensor extent") }
                return result
            }
            for (name, value) in object where name != "__metadata__" {
                guard let value = value as? [String: Any], let dtype = value["dtype"] as? String,
                      let dimensions = value["shape"] as? [Any], let offsets = value["data_offsets"] as? [Any],
                      offsets.count == 2 else { throw ModelError("malformed VQ tensor header entry") }
                let shape = try dimensions.map(integer), range = try offsets.map(integer)
                guard range[0] <= range[1], range[1] <= dataBytes else { throw CheckpointReadError.invalidRange }
                let ref = TensorRef(file: url, dtype: dtype, shape: shape,
                    byteOffset: dataStart + range[0], byteCount: range[1] - range[0])
                guard ref.itemSize > 0 else { throw ModelError("unsupported VQ tensor dtype") }
                var bytes = ref.itemSize
                for size in shape { bytes = try QuantizationBytes.product(bytes, size) }
                guard bytes == ref.byteCount else { throw ModelError("VQ tensor bytes do not match its shape") }
                parsed[name] = ref
            }
            var cursor = dataStart
            for ref in parsed.values.sorted(by: { ($0.byteOffset, $0.byteCount) < ($1.byteOffset, $1.byteCount) }) {
                guard ref.byteOffset == cursor else { throw ModelError("VQ tensor payload has holes or overlaps") }
                cursor += ref.byteCount
            }
            guard cursor == identity.fileBytes else { throw ModelError("VQ tensors do not cover their file") }
            var digest = SHA256(), offset = 0
            while offset < identity.fileBytes {
                guard shouldContinue() else { throw CheckpointReadError.cancelled }
                let count = min(Self.maximumRead, identity.fileBytes - offset)
                digest.update(data: try Self.raw(fd, offset: offset, count: count, shouldContinue: shouldContinue)); offset += count
            }
            guard shouldContinue() else { throw CheckpointReadError.cancelled }
            guard digest.finalize().map({ String(format: "%02x", $0) }).joined() == identity.fileSHA256,
                  Stamp(try Self.status(fd)) == Stamp(initial) else {
                throw ModelError("VQ tensor payload changed or failed its complete-file digest")
            }
            descriptor = fd; stamp = Stamp(initial); tensors = parsed
        } catch {
            close(fd)
            throw error
        }
    }

    deinit { close(descriptor) }

    package func verifyUnchanged() throws {
        guard Stamp(try Self.status(descriptor)) == stamp else { throw ModelError("owned VQ tensor file changed") }
    }

    /// Retaining this object retains the verified descriptor. Partial reads,
    /// cancellation or a changed file publish no Data to the caller.
    package func read(_ name: String, offset: Int, count: Int,
                      shouldContinue: () -> Bool = { true }) throws -> Data {
        guard let ref = tensors[name], (1...Self.maximumRead).contains(count) else {
            throw CheckpointReadError.invalidRange
        }
        let absolute = try ExactRead.tensorOffset(base: ref.byteOffset, length: ref.byteCount, offset: offset, count: count)
        guard shouldContinue() else { throw CheckpointReadError.cancelled }
        try verifyUnchanged()
        let data = try Self.raw(descriptor, offset: absolute, count: count, shouldContinue: shouldContinue)
        guard shouldContinue() else { throw CheckpointReadError.cancelled }
        try verifyUnchanged()
        return data
    }
}
