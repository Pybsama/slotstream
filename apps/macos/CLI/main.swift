import Foundation
import SlotstreamRuntime

let semaphore = DispatchSemaphore(value: 0)
var exitStatus: Int32 = 0
Task {
    do { exitStatus = try await HomeCLI.run(Array(CommandLine.arguments.dropFirst())) }
    catch {
        if CommandLine.arguments.contains("--json"), let bytes = try? JSONSerialization.data(withJSONObject: ["error": ["message": error.localizedDescription]], options: [.sortedKeys]) {
            FileHandle.standardError.write(bytes + Data([10]))
        } else { fputs(error.localizedDescription + "\n", stderr) }
        exitStatus = 1
    }
    semaphore.signal()
}
semaphore.wait()
exit(exitStatus)
