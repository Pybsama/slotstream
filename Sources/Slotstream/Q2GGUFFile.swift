import Foundation
import CryptoKit

/// The finite set of formats in the pinned GSQ-RCO deployment. This is not a
/// general GGUF model loader: architecture, geometry and file identity are
/// checked independently before the model can allocate an expert arena.
package enum Q2GGUFFormat: UInt32, CaseIterable {
    case f32 = 0, f16 = 1, q40 = 2, q50 = 6, q80 = 8
    case q3k = 11, q4k = 12, q5k = 13, q6k = 14, iq4nl = 20, iq4xs = 23, bf16 = 30, q20 = 42
    package var block: Int {
        switch self { case .f32, .f16, .bf16: return 1
        case .q20: return 64
        case .q3k, .q4k, .q5k, .q6k, .iq4xs: return 256
        default: return 32 }
    }
    package var bytes: Int {
        switch self { case .f32: return 4; case .f16, .bf16: return 2
        case .q40, .iq4nl, .q20: return 18; case .q50: return 22; case .q80: return 34
        case .q3k: return 110; case .q4k: return 144; case .q5k: return 176
        case .q6k: return 210; case .iq4xs: return 136 }
    }
    /// Nominal payload bits, excluding each block's scales and metadata.
    package var nominalBits: Int {
        switch self {
        case .f32: return 32
        case .f16, .bf16: return 16
        case .q20: return 2
        case .q3k: return 3
        case .q40, .q4k, .iq4nl, .iq4xs: return 4
        case .q50, .q5k: return 5
        case .q6k: return 6
        case .q80: return 8
        }
    }
    var decoder: String {
        switch self { case .q40: return "GgufEmbedQ40"; case .q50: return "GgufEmbedQ50"
        case .q80: return "GgufEmbedQ80"; case .q3k: return "GgufEmbedQ3K"
        case .q4k: return "GgufEmbedQ4K"; case .q5k: return "GgufEmbedQ5K"
        case .q6k: return "GgufEmbedQ6K"; case .iq4nl: return "GgufEmbedIQ4NL"
        case .iq4xs: return "GgufEmbedIQ4XS"; case .q20: return "GgufEmbedQ20"
        case .f32: return "SlotstreamGGUFF32"; case .f16: return "SlotstreamGGUFF16"
        case .bf16: return "SlotstreamGGUFBF16" }
    }
}

package struct Q2GGUFTensor {
    let name: String
    let shape: [Int]
    let format: Q2GGUFFormat
    let offset: Int
    unowned let file: Q2GGUFFile
    var columns: Int { shape.last! }
    var rows: Int { shape.dropLast().reduce(1, *) }
    var rowBytes: Int { columns / format.block * format.bytes }
    var byteCount: Int { rows * rowBytes }
    func read(offset relative: Int = 0, count: Int? = nil) throws -> Data {
        let n = count ?? byteCount
        let absolute = try ExactRead.tensorOffset(base: offset, length: byteCount, offset: relative, count: n)
        return try file.read(at: absolute, count: n)
    }
}

/// Retains the descriptor inspected at open. Payloads are never mmap'd, and
/// streamed reads cannot follow a subsequently replaced pathname.
package final class Q2GGUFFile {
    let url: URL
    let fd: Int32
    private let identity: stat
    private(set) var metadata: [String: Any] = [:]
    private(set) var tensors: [String: Q2GGUFTensor] = [:]
    deinit { close(fd) }

    package init(url: URL, expectedSize: Int64? = nil, expectedSHA256: String? = nil,
         shouldContinue: () -> Bool = { true }) throws {
        self.url = url
        let handle = open(url.path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW | O_NONBLOCK)
        guard handle >= 0 else { throw ModelError("Cannot open Q2 shard: \(url.lastPathComponent)") }
        var st = stat()
        guard fstat(handle, &st) == 0, st.st_mode & S_IFMT == S_IFREG,
              st.st_size >= 24, expectedSize == nil || st.st_size == expectedSize else {
            close(handle); throw ModelError("Q2 shard size or file type changed")
        }
        fd = handle; identity = st
        _ = fcntl(fd, F_NOCACHE, 1)
        _ = fcntl(fd, F_RDAHEAD, 0)
        if let expectedSHA256 {
            var hash = SHA256(), offset = 0
            while offset < st.st_size {
                guard shouldContinue() else { throw CheckpointReadError.cancelled }
                let count = min(4 << 20, Int(st.st_size) - offset)
                hash.update(data: try read(at: offset, count: count)); offset += count
            }
            guard hash.finalize().map({ String(format: "%02x", $0) }).joined() == expectedSHA256 else {
                throw ModelError("Q2 shard failed its pinned SHA-256")
            }
            try verifyUnchanged()
        }
        // Headers are small relative to payloads. Bounded buffering avoids a
        // system call per vocabulary token without ever mapping the weights.
        let header = try read(at: 0, count: min(Int(st.st_size), 32 << 20))
        let reader = Q2GGUFHeader(header)
        guard try reader.integer(UInt32.self) == 0x46554747,
              try reader.integer(UInt32.self) == 3 else { throw ModelError("Expected GGUF v3") }
        let nt = try reader.count(maximum: 16_384), nk = try reader.count(maximum: 16_384)
        for _ in 0..<nk {
            let key = try reader.string()
            guard metadata[key] == nil else { throw ModelError("Duplicate GGUF metadata") }
            metadata[key] = try reader.value(try reader.integer(UInt32.self))
        }
        var entries: [(String, [Int], Q2GGUFFormat, Int)] = []
        var names = Set<String>()
        for _ in 0..<nt {
            let name = try reader.string(), rank = Int(try reader.integer(UInt32.self))
            guard (1...4).contains(rank), names.insert(name).inserted else { throw ModelError("Invalid GGUF tensor name or rank") }
            var shape: [Int] = []
            for _ in 0..<rank { shape.append(try reader.count(maximum: 1_000_000_000)) }
            guard let format = Q2GGUFFormat(rawValue: try reader.integer(UInt32.self)),
                  shape.allSatisfy({ $0 > 0 }), shape[0].isMultiple(of: format.block) else {
                throw ModelError("Unsupported Q2 deployment tensor format or shape")
            }
            let offset = try reader.count(maximum: Int(st.st_size))
            entries.append((name, shape.reversed(), format, offset))
        }
        let rawAlignment = metadata["general.alignment"] as? UInt64 ?? 32
        guard rawAlignment <= 4096 else { throw ModelError("Invalid GGUF alignment") }
        let alignment = Int(rawAlignment)
        guard alignment > 0, alignment <= 4096, alignment.nonzeroBitCount == 1 else { throw ModelError("Invalid GGUF alignment") }
        let start = (reader.position + alignment - 1) / alignment * alignment
        var end = start
        for (name, shape, format, offset) in entries.sorted(by: { $0.3 < $1.3 }) {
            let count = try shape.reduce(1) { try QuantizationBytes.product($0, $1) }
            let bytes = try QuantizationBytes.product(count / format.block, format.bytes)
            let at = try QuantizationBytes.sum(start, offset)
            let next = try QuantizationBytes.sum(at, bytes)
            guard offset.isMultiple(of: alignment), at >= end, next <= st.st_size else { throw ModelError("Overlapping or truncated GGUF tensor") }
            tensors[name] = Q2GGUFTensor(name: name, shape: shape, format: format, offset: at, file: self)
            end = next
        }
    }

    package func verifyUnchanged() throws {
        var current = stat()
        guard fstat(fd, &current) == 0, current.st_size == identity.st_size,
              current.st_mtimespec.tv_sec == identity.st_mtimespec.tv_sec,
              current.st_mtimespec.tv_nsec == identity.st_mtimespec.tv_nsec,
              current.st_ctimespec.tv_sec == identity.st_ctimespec.tv_sec,
              current.st_ctimespec.tv_nsec == identity.st_ctimespec.tv_nsec else { throw ModelError("Q2 shard changed during use") }
    }

    func read(at: Int, count: Int) throws -> Data {
        try verifyUnchanged()
        guard at >= 0, count >= 0, at <= identity.st_size, count <= Int(identity.st_size) - at else { throw CheckpointReadError.invalidRange }
        var bytes = Data(count: count)
        try bytes.withUnsafeMutableBytes { dst in
            var done = 0
            while done < count {
                let n = pread(fd, dst.baseAddress! + done, count - done, off_t(at + done))
                if n < 0 && errno == EINTR { continue }
                guard n > 0 else { throw ModelError("Truncated Q2 shard read") }
                done += n
            }
        }
        try verifyUnchanged()
        return bytes
    }
}

private final class Q2GGUFHeader {
    let data: Data
    var position = 0
    init(_ data: Data) { self.data = data }
    func integer<T: FixedWidthInteger>(_ type: T.Type) throws -> T {
        guard MemoryLayout<T>.size <= data.count - position else { throw ModelError("Truncated GGUF header") }
        defer { position += MemoryLayout<T>.size }
        return data.withUnsafeBytes { T(littleEndian: $0.loadUnaligned(fromByteOffset: position, as: T.self)) }
    }
    func count(maximum: Int) throws -> Int {
        let n = try integer(UInt64.self)
        guard n <= UInt64(maximum) else { throw ModelError("GGUF extent exceeds its bound") }
        return Int(n)
    }
    func string() throws -> String {
        let n = try count(maximum: data.count - position)
        guard n <= data.count - position, let s = String(data: data[position..<position+n], encoding: .utf8) else { throw ModelError("Invalid GGUF string") }
        position += n; return s
    }
    func value(_ type: UInt32) throws -> Any {
        switch type {
        case 0: return UInt64(try integer(UInt8.self)); case 1: return Int64(try integer(Int8.self))
        case 2: return UInt64(try integer(UInt16.self)); case 3: return Int64(try integer(Int16.self))
        case 4: return UInt64(try integer(UInt32.self)); case 5: return Int64(try integer(Int32.self))
        case 6: return Float(bitPattern: try integer(UInt32.self))
        case 7: return try integer(UInt8.self) != 0
        case 8: return try string()
        case 9:
            let element = try integer(UInt32.self), n = try count(maximum: 1_000_000)
            guard element != 9 else { throw ModelError("Nested GGUF arrays are unsupported") }
            var result: [Any] = []; result.reserveCapacity(min(n, 64))
            for _ in 0..<n { let v = try value(element); if n <= 64 { result.append(v) } }
            return result
        case 10: return try integer(UInt64.self); case 11: return try integer(Int64.self)
        case 12: return Double(bitPattern: try integer(UInt64.self))
        default: throw ModelError("Invalid GGUF metadata type")
        }
    }
}
