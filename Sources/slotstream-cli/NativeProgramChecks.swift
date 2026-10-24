import ArgumentParser
import CNativeSchedule
import Cmlx
import Metal
import MLX

func checkNativeProgramBoundaries() throws {
    func require(_ condition: Bool, _ label: String) throws {
        guard condition else { throw ValidationError("Native program boundary: \(label)") }
    }
    guard let device = MTLCreateSystemDefaultDevice() else { throw ValidationError("Missing Metal device") }
    let source = """
    #include <metal_stdlib>
    using namespace metal;
    kernel void copy_value(device const bfloat* x [[buffer(0)]], device float* y [[buffer(1)]]) { y[0]=float(x[0]); }
    kernel void add_values(device const bfloat* x [[buffer(0)]], device float* y [[buffer(1)]], constant int* v [[buffer(2)]]) { y[0]=float(x[0])+v[0]+v[7]; }
    """
    let library = try device.makeLibrary(source: source, options: nil)
    let pipeline = try device.makeComputePipelineState(function: library.makeFunction(name: "copy_value")!)
    let pointer = Unmanaged.passUnretained(pipeline as AnyObject).toOpaque()
    let specs: [Int32] = [1, 1, 1, 1, 1, 0, 2, 1, 1, 1, 1, 1]
    try require(ss_program_new(1, [99, 1, 1, 1, 1, 0, 2, 1, 1, 1, 1, 1], 2) == nil, "unknown dtype admitted")
    try require(ss_program_new(1, [1, 1, 0, 1, 1, 0, 2, 1, 1, 1, 1, 1], 2) == nil, "empty extent admitted")
    try require(ss_program_new(1, specs, 17) == nil, "buffer capacity exceeded")
    guard let capacity = ss_program_new(1, specs, 2) else { throw ValidationError("Missing capacity fixture") }
    defer { ss_program_free(capacity) }
    for _ in 0..<12 {
        try require(ss_program_add(capacity, pointer, [0, 1], 2, 2, [1, 1, 1], [1, 1, 1], nil, 0) == 0, "bounded step rejected")
    }
    try require(ss_program_add(capacity, pointer, [0, 1], 2, 2, [1, 1, 1], [1, 1, 1], nil, 0) != 0, "step capacity exceeded")
    guard let p = ss_program_new(1, specs, 2) else { throw ValidationError("Missing program") }
    var owns = true
    defer { if owns { ss_program_free(p) } }
    try require(ss_program_seal(p) != 0, "empty plan sealed")
    try require(ss_program_add(p, pointer, [0, 1], 2, 1, [1, 1, 1], [1, 1, 1], nil, 0) != 0, "input write admitted")
    try require(ss_program_add(p, pointer, [0, 2], 2, 2, [1, 1, 1], [1, 1, 1], nil, 0) != 0, "out-of-bounds binding admitted")
    try require(ss_program_add(p, pointer, [0, 1], 2, 2, [1, 1, 1], [2048, 1, 1], nil, 0) != 0, "oversized launch admitted")
    try require(ss_program_add(p, pointer, [0, 1], 2, 2, [1, 1, 1], [1, 1, 1], nil, 1) != 0, "missing constants admitted")
    try require(ss_program_add(p, pointer, [0, 1], 2, 2, [1, 1, 1], [1, 1, 1], nil, -1) != 0, "negative constant count admitted")
    try require(ss_program_add(p, pointer, [0, 1], 2, 2, [1, 1, 1], [1, 1, 1], Array(repeating: 0, count: 9), 9) != 0, "constant capacity exceeded")
    try require(ss_program_add(p, pointer, [0, 1], 2, 2, [1, 1, 1], [1, 1, 1], nil, 0) == 0, "valid plan rejected")
    try require(ss_program_seal(p) == 0, "valid plan did not seal")
    try require(ss_program_add(p, pointer, [0, 1], 2, 2, [1, 1, 1], [1, 1, 1], nil, 0) != 0, "sealed plan mutated")
    for bad in [MLXArray([Float(3)]), MLXArray([Float(3), 4]).asType(.bfloat16)] {
        var output: UnsafeMutableRawPointer?
        try require(ss_program_apply(p, [bad.ctx.ctx], 1, StreamOrDevice.gpu.ctx.ctx, &output, 1) != 0
            && output == nil, "invalid input escaped before dispatch")
    }
    let x = MLXArray([Float(3)]).asType(.bfloat16), y = MLXArray([Float(7)]).asType(.bfloat16)
    var invalid: UnsafeMutableRawPointer?
    try require(ss_program_apply(p, [x.ctx.ctx], 1, StreamOrDevice.cpu.ctx.ctx, &invalid, 1) != 0
        && invalid == nil, "CPU stream admitted")
    var a: UnsafeMutableRawPointer?, b: UnsafeMutableRawPointer?
    try require(ss_program_apply(p, [x.ctx.ctx], 1, StreamOrDevice.gpu.ctx.ctx, &a, 1) == 0, "first invocation failed")
    let first = MLXArray(mlx_array(ctx: a!))
    try require(ss_program_apply(p, [y.ctx.ctx], 1, StreamOrDevice.gpu.ctx.ctx, &b, 1) == 0, "second invocation failed")
    let second = MLXArray(mlx_array(ctx: b!))
    ss_program_free(p); owns = false
    try require(first.item(Float.self) == 3 && second.item(Float.self) == 7, "plan/input lifetime or independent outputs changed")
    guard let uninitialized = ss_program_new(1, specs, 2) else { throw ValidationError("Missing program") }
    defer { ss_program_free(uninitialized) }
    try require(ss_program_add(uninitialized, pointer, [1, 1], 2, 2, [1, 1, 1], [1, 1, 1], nil, 0) == 0, "invalid-read fixture did not construct")
    try require(ss_program_seal(uninitialized) != 0, "uninitialized read admitted")
    let parameterPipeline = try device.makeComputePipelineState(function: library.makeFunction(name: "add_values")!)
    let parameterPointer = Unmanaged.passUnretained(parameterPipeline as AnyObject).toOpaque()
    var parameterOutputs: [MLXArray] = []
    for value in [Int32(5), 9] {
        guard let plan = ss_program_new(1, specs, 2) else { throw ValidationError("Missing parameter plan") }
        defer { ss_program_free(plan) }
        var values: [Int32] = [value, 0, 0, 0, 0, 0, 0, 2]
        try require(ss_program_add(plan, parameterPointer, [0, 1], 2, 2, [1, 1, 1], [1, 1, 1], values, 8) == 0, "bounded parameters rejected")
        values[0] = 99
        try require(ss_program_seal(plan) == 0, "parameter plan did not seal")
        var output: UnsafeMutableRawPointer?
        try require(ss_program_apply(plan, [x.ctx.ctx], 1, StreamOrDevice.gpu.ctx.ctx, &output, 1) == 0, "parameter invocation failed")
        parameterOutputs.append(MLXArray(mlx_array(ctx: output!)))
    }
    try require(parameterOutputs.map { $0.item(Float.self) } == [10, 14], "shared pipeline constants or their lifetime changed")
    let ephemeralParameters = (0..<5).map { "device const bfloat* x\($0) [[buffer(\($0))]]" }
        + ["device float* y [[buffer(5)]]"]
    let ephemeralSource = "#include <metal_stdlib>\nusing namespace metal;\nkernel void ephemeral("
        + ephemeralParameters.joined(separator: ",") + "){y[0]="
        + (0..<5).map { "float(x\($0)[0])" }.joined(separator: "+") + ";}"
    let ephemeralLibrary = try device.makeLibrary(source: ephemeralSource, options: nil)
    let ephemeralPipeline = try device.makeComputePipelineState(function: ephemeralLibrary.makeFunction(name: "ephemeral")!)
    let ephemeralPointer = Unmanaged.passUnretained(ephemeralPipeline as AnyObject).toOpaque()
    let ephemeralSpecs = (0..<6).flatMap { i -> [Int32] in [i < 5 ? 1 : 2, 1, 1, 1, 1, i == 5 ? 1 : 0] }
    guard let ephemeral = ss_program_new(5, ephemeralSpecs, 6) else { throw ValidationError("Missing ephemeral fixture") }
    var ownsEphemeral = true
    defer { if ownsEphemeral { ss_program_free(ephemeral) } }
    try require(ss_program_add(ephemeral, ephemeralPointer, [0,1,2,3,4,5], 6, 32, [1,1,1], [1,1,1], nil, 0) == 0
        && ss_program_seal(ephemeral) == 0, "ephemeral plan rejected")
    let ephemeralOutputs = try [0,10].map { offset -> MLXArray in
        let inputs = (1...5).map { MLXArray([Float($0+offset)]).asType(.bfloat16) }
        var output: UnsafeMutableRawPointer?
        // The raw pointer array does not retain these fresh MLX wrappers.
        // Keep them alive until the native primitive owns its copied arrays.
        let status = withExtendedLifetime(inputs) {
            ss_program_apply(ephemeral, inputs.map { $0.ctx.ctx }, 5, StreamOrDevice.gpu.ctx.ctx, &output, 1)
        }
        try require(status == 0, "ephemeral invocation failed")
        return MLXArray(mlx_array(ctx: output!))
    }
    ss_program_free(ephemeral); ownsEphemeral = false
    try require(ephemeralOutputs.map { $0.item(Float.self) } == [15,65], "ephemeral inputs or independent output lifetime changed")
    print("Native program: geometry, write ownership, initialization, stream, sealing and output lifetime PASS")
}
