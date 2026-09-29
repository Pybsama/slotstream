import Foundation
import Metal

struct ProjectionInput {
    let fixture: Fixture
    let batch: Int
    let data: Data
    let values: [Float]

    init(fixture: Fixture, batch: Int, inputURL: URL) throws {
        guard (1...128).contains(batch), fixture.geometry.output == "f16" else {
            throw ProofError("projection requires batch 1...128 and F16 expert weights")
        }
        self.fixture = fixture
        self.batch = batch
        data = try readBounded(inputURL, maximum: batch * fixture.geometry.input * 2)
        let bytes = Array(data)
        values = stride(from: 0, to: bytes.count, by: 2).map {
            Float(Float16(bitPattern: Fixture.word16(bytes, $0)))
        }
        guard values.allSatisfy({ $0.isFinite }) else { throw ProofError("non-finite projection input") }
        // Check each selected decoded product before any Metal allocation.
        // This scan does not construct a decoded weight matrix.
        let g = fixture.geometry
        for row in 0..<g.rows {
            for column in 0..<g.input {
                guard projectionWeight(fixture, row: row, column: column).isFinite else {
                    throw ProofError("decoded product exceeds binary16 range")
                }
            }
        }
    }
}

private func projectionWeight(_ fixture: Fixture, row: Int, column: Int) -> Float {
    let g = fixture.geometry
    let code = fixture.code(row: row, sub: column / g.dimension)
    let a = Float(Float16(bitPattern: Fixture.word16(fixture.book,
                  (code * g.dimension + column % g.dimension) * 2)))
    let b = Float(Float16(bitPattern: Fixture.word16(fixture.scales,
                  (row * g.groups + column / g.groupSize) * 2)))
    return Float(Float16(a * b))
}

func projectCPU(_ input: ProjectionInput) throws -> [Float] {
    let g = input.fixture.geometry
    var output = [Float](repeating: 0, count: input.batch * g.rows)
    for token in 0..<input.batch {
        for row in 0..<g.rows {
            var total = 0.0
            for column in 0..<g.input {
                total += Double(input.values[token * g.input + column]) *
                         Double(projectionWeight(input.fixture, row: row, column: column))
            }
            let value = Float(total)
            guard value.isFinite else { throw ProofError("non-finite projection output") }
            output[token * g.rows + row] = value
        }
    }
    return output
}

private let projectionMetalSource = """
#include <metal_stdlib>
using namespace metal;
kernel void vq_sampled_projection(device const uchar* codes [[buffer(0)]],
                                  device const half* book [[buffer(1)]],
                                  device const half* scales [[buffer(2)]],
                                  device const half* x [[buffer(3)]],
                                  device float* output [[buffer(4)]],
                                  constant uint* dims [[buffer(5)]],
                                  uint index [[thread_position_in_grid]]) {
    const uint rows = dims[0], width = dims[1], d = dims[2], group = dims[3];
    const uint stride = dims[4], bits = dims[5], packed = dims[6], batch = dims[7];
    if (index >= batch * rows) return;
    const uint token = index / rows, row = index % rows;
    const device uchar* source = codes + row * stride;
    float total = 0.0f;
    for (uint column = 0; column < width; ++column) {
        const uint sub = column / d;
        uint code;
        if (packed) {
            const device uint* words = reinterpret_cast<const device uint*>(source);
            const uint bit = sub * bits, at = bit / 32, shift = bit % 32;
            code = words[at] >> shift;
            if (shift + bits > 32) code |= words[at + 1] << (32 - shift);
            code &= (1u << bits) - 1u;
        } else code = source[sub];
        const half weight = half(float(book[code * d + column % d]) *
                                 float(scales[row * (width / group) + column / group]));
        total = fma(float(x[token * width + column]), float(weight), total);
    }
    output[index] = total;
}
"""

// Isolated numerical candidate for one 64-row tile of the fixed F16 expert.
// The historical kernel above stays byte-identical as the control mode.
private let projectionUnroundedSerialMetalSource = """
#include <metal_stdlib>
using namespace metal;
kernel void vq_unrounded_serial_projection(device const uchar* codes [[buffer(0)]],
                                  device const half* book [[buffer(1)]],
                                  device const half* scales [[buffer(2)]],
                                  device const half* x [[buffer(3)]],
                                  device float* output [[buffer(4)]],
                                  constant uint* dims [[buffer(5)]],
                                  uint index [[thread_position_in_grid]]) {
    const uint rows = dims[0], width = dims[1], d = dims[2], group = dims[3];
    const uint stride = dims[4], bits = dims[5], packed = dims[6], batch = dims[7];
    if (index >= batch * rows) return;
    const uint token = index / rows, row = index % rows;
    const device uchar* source = codes + row * stride;
    float total = 0.0f;
    for (uint column = 0; column < width; ++column) {
        const uint sub = column / d;
        uint code;
        if (packed) {
            const device uint* words = reinterpret_cast<const device uint*>(source);
            const uint bit = sub * bits, at = bit / 32, shift = bit % 32;
            code = words[at] >> shift;
            if (shift + bits > 32) code |= words[at + 1] << (32 - shift);
            code &= (1u << bits) - 1u;
        } else code = source[sub];
        const float weight = float(book[code * d + column % d]) *
                                 float(scales[row * (width / group) + column / group]);
        total = fma(float(x[token * width + column]), float(weight), total);
    }
    output[index] = total;
}
"""

func projectMetal(_ input: ProjectionInput) throws -> ([Float], Int) {
    try projectMetalKernel(input, source: projectionMetalSource,
                           functionName: "vq_sampled_projection")
}

func projectMetalUnroundedSerial(_ input: ProjectionInput) throws -> ([Float], Int) {
    let g = input.fixture.geometry
    // The 640-row expert is supplied as ten disjoint 64-row fixtures. This
    // candidate intentionally accepts only the first-tile geometry.
    guard g.rows == 64, g.input == 2560, g.dimension == 8, g.groupSize == 64,
          g.codebookSize == 16384, g.storage == "packed32", g.output == "f16" else {
        throw ProofError("unsupported unrounded-serial proof geometry")
    }
    return try projectMetalKernel(input, source: projectionUnroundedSerialMetalSource,
                                  functionName: "vq_unrounded_serial_projection")
}

private func projectMetalKernel(_ input: ProjectionInput, source: String,
                                functionName: String) throws -> ([Float], Int) {
    let g = input.fixture.geometry
    guard let device = MTLCreateSystemDefaultDevice(), let queue = device.makeCommandQueue() else {
        throw ProofError("Metal device unavailable")
    }
    let options = MTLCompileOptions()
    if #available(macOS 15.0, *) { options.mathMode = .safe }
    else { options.fastMathEnabled = false }
    let library = try device.makeLibrary(source: source, options: options)
    guard let function = library.makeFunction(name: functionName) else {
        throw ProofError("Metal projection function unavailable")
    }
    let pipeline = try device.makeComputePipelineState(function: function)
    func buffer(_ bytes: [UInt8]) throws -> MTLBuffer {
        let made = bytes.withUnsafeBytes {
            device.makeBuffer(bytes: $0.baseAddress!, length: $0.count, options: .storageModeShared)
        }
        guard let made else { throw ProofError("Metal projection allocation failed") }
        return made
    }
    let inputs = try [buffer(input.fixture.codes), buffer(input.fixture.book),
                      buffer(input.fixture.scales), buffer(Array(input.data))]
    let count = input.batch * g.rows
    guard let output = device.makeBuffer(length: count * 4, options: .storageModeShared),
          let command = queue.makeCommandBuffer(), let encoder = command.makeComputeCommandEncoder() else {
        throw ProofError("Metal projection command allocation failed")
    }
    // A quiet-NaN sentinel cannot pass the finite-output check if a lane is unwritten.
    let words = output.contents().assumingMemoryBound(to: UInt32.self)
    for i in 0..<count { words[i] = 0x7fc000a5 }
    var dimensions = [UInt32(g.rows), UInt32(g.input), UInt32(g.dimension), UInt32(g.groupSize),
                      UInt32(g.codeRowBytes), UInt32(g.bits), g.storage == "packed32" ? 1 : 0,
                      UInt32(input.batch)]
    encoder.setComputePipelineState(pipeline)
    for (index, buffer) in inputs.enumerated() { encoder.setBuffer(buffer, offset: 0, index: index) }
    encoder.setBuffer(output, offset: 0, index: 4)
    encoder.setBytes(&dimensions, length: dimensions.count * MemoryLayout<UInt32>.size, index: 5)
    let threads = min(256, pipeline.maxTotalThreadsPerThreadgroup)
    encoder.dispatchThreads(MTLSize(width: count, height: 1, depth: 1),
                            threadsPerThreadgroup: MTLSize(width: threads, height: 1, depth: 1))
    encoder.endEncoding()
    command.commit()
    command.waitUntilCompleted()
    guard command.status == .completed else { throw command.error ?? ProofError("Metal projection failed") }
    let values = Array(UnsafeBufferPointer(start: output.contents().assumingMemoryBound(to: Float.self), count: count))
    guard values.allSatisfy({ $0.isFinite }) else { throw ProofError("non-finite or unwritten projection output") }
    return (values, inputs.reduce(output.length) { $0 + $1.length })
}
