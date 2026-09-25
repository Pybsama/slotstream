// Isolated qualification tool. This is not a production model loader.
import Foundation
import Metal

struct ProofError: Error, CustomStringConvertible {
    let description: String
    init(_ message: String) { description = message }
}

struct Geometry: Decodable {
    let rows: Int
    let input: Int
    let dimension: Int
    let groupSize: Int
    let codebookSize: Int
    let storage: String
    let output: String

    func validate() throws {
        // Proof bounds are checked before products, file allocation or GPU use.
        guard (1...64).contains(rows), (1...4096).contains(input),
              [2, 4, 8].contains(dimension), [32, 64].contains(groupSize),
              [256, 16384].contains(codebookSize),
              input % groupSize == 0, groupSize % dimension == 0,
              ["u8", "packed32"].contains(storage),
              storage != "u8" || codebookSize == 256,
              ["f16", "bf16"].contains(output)
        else { throw ProofError("unsupported proof geometry") }
    }
    var bits: Int { codebookSize == 256 ? 8 : 14 }
    var subVectors: Int { input / dimension }
    var groups: Int { input / groupSize }
    var codeRowBytes: Int {
        storage == "u8" ? subVectors : ((subVectors + 31) / 32) * bits * 4
    }
    var codeBytes: Int { rows * codeRowBytes }
    var bookBytes: Int { codebookSize * dimension * 2 }
    var scaleBytes: Int { rows * groups * 2 }
    var outputBytes: Int { rows * input * 2 }
}

func readBounded(_ url: URL, maximum: Int, exact: Bool = true) throws -> Data {
    let handle = try FileHandle(forReadingFrom: url)
    defer { try? handle.close() }
    let data = try handle.read(upToCount: maximum + 1) ?? Data()
    guard data.count <= maximum, !exact || data.count == maximum else {
        throw ProofError("unexpected length: \(url.lastPathComponent)")
    }
    return data
}

struct Fixture {
    let geometry: Geometry
    let codes: [UInt8]
    let book: [UInt8]
    let scales: [UInt8]

    init(directory: URL) throws {
        geometry = try JSONDecoder().decode(Geometry.self, from:
            readBounded(directory.appendingPathComponent("geometry.json"), maximum: 4096, exact: false))
        try geometry.validate()
        codes = Array(try readBounded(directory.appendingPathComponent("codes.bin"), maximum: geometry.codeBytes))
        book = Array(try readBounded(directory.appendingPathComponent("codebook.bin"), maximum: geometry.bookBytes))
        scales = Array(try readBounded(directory.appendingPathComponent("scales.bin"), maximum: geometry.scaleBytes))
        for buffer in [book, scales] {
            for offset in stride(from: 0, to: buffer.count, by: 2) {
                guard Float16(bitPattern: Self.word16(buffer, offset)).isFinite else {
                    throw ProofError("non-finite codebook or scale")
                }
            }
        }
    }

    static func word16(_ data: [UInt8], _ offset: Int) -> UInt16 {
        UInt16(data[offset]) | (UInt16(data[offset + 1]) << 8)
    }
    static func word32(_ data: [UInt8], _ offset: Int) -> UInt32 {
        UInt32(word16(data, offset)) | (UInt32(word16(data, offset + 2)) << 16)
    }
    func code(row: Int, sub: Int) -> Int {
        let start = row * geometry.codeRowBytes
        if geometry.storage == "u8" { return Int(codes[start + sub]) }
        let bit = sub * geometry.bits
        let offset = start + (bit / 32) * 4
        let shift = bit % 32
        var value = Self.word32(codes, offset) >> shift
        if shift + geometry.bits > 32 {
            value |= Self.word32(codes, offset + 4) << (32 - shift)
        }
        return Int(value & UInt32(geometry.codebookSize - 1))
    }
}

func decodeCPU(_ fixture: Fixture) throws -> [UInt16] {
    let g = fixture.geometry
    var output = [UInt16](repeating: 0, count: g.rows * g.input)
    for row in 0..<g.rows {
        for sub in 0..<g.subVectors {
            let code = fixture.code(row: row, sub: sub)
            guard code < g.codebookSize else { throw ProofError("codebook index outside range") }
            for coordinate in 0..<g.dimension {
                let column = sub * g.dimension + coordinate
                let value = Float(Float16(bitPattern: Fixture.word16(fixture.book, (code * g.dimension + coordinate) * 2)))
                let scale = Float(Float16(bitPattern: Fixture.word16(fixture.scales, (row * g.groups + column / g.groupSize) * 2)))
                let product = Float16(value * scale)
                guard product.isFinite else { throw ProofError("decoded product exceeds binary16 range") }
                if g.output == "f16" { output[row * g.input + column] = product.bitPattern }
                else {
                    let word = Float(product).bitPattern
                    output[row * g.input + column] = UInt16(truncatingIfNeeded:
                        (word &+ 0x7fff &+ ((word >> 16) & 1)) >> 16)
                }
            }
        }
    }
    return output
}

private let metalSource = """
#include <metal_stdlib>
using namespace metal;
kernel void vq_proof(device const uchar* codes [[buffer(0)]],
                     device const half* book [[buffer(1)]],
                     device const half* scales [[buffer(2)]],
                     device ushort* output [[buffer(3)]],
                     constant uint* dims [[buffer(4)]],
                     uint index [[thread_position_in_grid]]) {
    const uint rows = dims[0], width = dims[1], d = dims[2], group = dims[3];
    if (index >= rows * width) return;
    const uint row = index / width, column = index % width, sub = column / d;
    const uint stride = dims[4], bits = dims[5], packed = dims[6], bf16 = dims[7];
    const device uchar* source = codes + row * stride;
    uint code;
    if (packed) {
        const device uint* words = reinterpret_cast<const device uint*>(source);
        const uint bit = sub * bits, at = bit / 32, shift = bit % 32;
        code = words[at] >> shift;
        if (shift + bits > 32) code |= words[at + 1] << (32 - shift);
        code &= (1u << bits) - 1u;
    } else code = source[sub];
    const float a = float(book[code * d + column % d]);
    const float b = float(scales[row * (width / group) + column / group]);
    const half product = half(a * b);
    if (bf16) {
        const uint word = as_type<uint>(float(product));
        output[index] = ushort((word + 0x7fffu + ((word >> 16) & 1u)) >> 16);
    } else output[index] = as_type<ushort>(product);
}
"""

func decodeMetal(_ fixture: Fixture) throws -> [UInt16] {
    let g = fixture.geometry
    guard let device = MTLCreateSystemDefaultDevice(), let queue = device.makeCommandQueue() else {
        throw ProofError("Metal device unavailable")
    }
    let options = MTLCompileOptions()
    if #available(macOS 15.0, *) { options.mathMode = .safe }
    else { options.fastMathEnabled = false }
    let library = try device.makeLibrary(source: metalSource, options: options)
    guard let function = library.makeFunction(name: "vq_proof") else { throw ProofError("Metal function unavailable") }
    let pipeline = try device.makeComputePipelineState(function: function)
    func buffer(_ bytes: [UInt8]) throws -> MTLBuffer {
        let made = bytes.withUnsafeBytes { device.makeBuffer(bytes: $0.baseAddress!, length: $0.count, options: .storageModeShared) }
        guard let made else { throw ProofError("Metal allocation failed") }
        return made
    }
    let inputs = try [buffer(fixture.codes), buffer(fixture.book), buffer(fixture.scales)]
    guard let output = device.makeBuffer(length: g.outputBytes, options: .storageModeShared),
          let command = queue.makeCommandBuffer(), let encoder = command.makeComputeCommandEncoder() else {
        throw ProofError("Metal command allocation failed")
    }
    // Sentinel makes uninitialized/unwritten output detectable by the oracle.
    memset(output.contents(), 0xa5, g.outputBytes)
    var dimensions = [UInt32(g.rows), UInt32(g.input), UInt32(g.dimension), UInt32(g.groupSize),
                      UInt32(g.codeRowBytes), UInt32(g.bits), g.storage == "packed32" ? 1 : 0,
                      g.output == "bf16" ? 1 : 0]
    encoder.setComputePipelineState(pipeline)
    for (index, input) in inputs.enumerated() { encoder.setBuffer(input, offset: 0, index: index) }
    encoder.setBuffer(output, offset: 0, index: 3)
    encoder.setBytes(&dimensions, length: dimensions.count * MemoryLayout<UInt32>.size, index: 4)
    let threads = min(256, pipeline.maxTotalThreadsPerThreadgroup)
    encoder.dispatchThreads(MTLSize(width: g.rows * g.input, height: 1, depth: 1),
                            threadsPerThreadgroup: MTLSize(width: threads, height: 1, depth: 1))
    encoder.endEncoding()
    command.commit()
    command.waitUntilCompleted()
    guard command.status == .completed else { throw command.error ?? ProofError("Metal command failed") }
    let values = Array(UnsafeBufferPointer(start: output.contents().assumingMemoryBound(to: UInt16.self), count: g.rows * g.input))
    let exponent: UInt16 = g.output == "f16" ? 0x7c00 : 0x7f80
    guard values.allSatisfy({ $0 & exponent != exponent }) else { throw ProofError("non-finite decoded output") }
    return values
}
