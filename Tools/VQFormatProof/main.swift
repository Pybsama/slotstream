import Foundation
do {
    guard CommandLine.arguments.count == 3, ["cpu", "metal"].contains(CommandLine.arguments[2]) else {
        throw ProofError("usage: vq-proof <fixture-directory> cpu|metal")
    }
    let fixture = try Fixture(directory: URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true))
    let values = try CommandLine.arguments[2] == "cpu" ? decodeCPU(fixture) : decodeMetal(fixture)
    var data = Data(capacity: values.count * 2)
    for value in values {
        data.append(UInt8(truncatingIfNeeded: value))
        data.append(UInt8(truncatingIfNeeded: value >> 8))
    }
    FileHandle.standardOutput.write(data)
} catch {
    FileHandle.standardError.write(Data("\(error)\n".utf8))
    exit(1)
}
