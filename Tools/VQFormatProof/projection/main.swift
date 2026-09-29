import Foundation

do {
    let args = CommandLine.arguments
    guard args.count == 5, let batch = Int(args[3]),
          ["cpu", "metal", "metal-unrounded-serial"].contains(args[4]) else {
        throw ProofError("usage: vq-projection <fixture> <input-f16.bin> <batch> cpu|metal|metal-unrounded-serial")
    }
    let fixture = try Fixture(directory: URL(fileURLWithPath: args[1], isDirectory: true))
    let input = try ProjectionInput(fixture: fixture, batch: batch, inputURL: URL(fileURLWithPath: args[2]))
    let values: [Float]
    let bytes: Int
    if args[4] == "cpu" { values = try projectCPU(input); bytes = 0 }
    else if args[4] == "metal" { (values, bytes) = try projectMetal(input) }
    else { (values, bytes) = try projectMetalUnroundedSerial(input) }
    var result = Data(capacity: values.count * 4)
    for value in values {
        let bits = value.bitPattern
        for shift in stride(from: 0, to: 32, by: 8) { result.append(UInt8(truncatingIfNeeded: bits >> shift)) }
    }
    let metadata = try JSONSerialization.data(withJSONObject: ["explicit_metal_buffer_bytes": bytes])
    FileHandle.standardError.write(metadata + Data([10]))
    FileHandle.standardOutput.write(result)
} catch {
    FileHandle.standardError.write(Data("\(error)\n".utf8))
    exit(1)
}
