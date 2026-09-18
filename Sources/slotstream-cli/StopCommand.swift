import ArgumentParser
import Foundation
import Slotstream

/// `slotstream stop`: stop the server on a port, the one `slotstream launch`
/// started in the background or one running in a Terminal window.
struct Stop: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "stop",
        abstract: "Stop the Slotstream server on a port",
        discussion: """
            Asks the server on the port for its process and stops it. Requests it is answering \
            end at once. Prompt caches already written to disk stay for the next server.
            """)

    @Option(help: "The port the server listens on.")
    var port: UInt16 = 11434

    func run() throws {
        let port = Int(self.port)
        let home = ModelLocator.home.path
        let statePath = CodingToolLaunch.BackgroundServer.statePath(home: home, port: port)
        let started = Launch.startedServer(home: home, port: port)
        do {
            guard let answer = Launch.request("GET", "http://127.0.0.1:\(port)/slotstream/status", direct: true) else {
                // A server launch is still starting does not answer yet, and
                // is stopped all the same.
                if let started, ProcessIdentity.of(started.pid) == started.process {
                    try Launch.stopServer(pid: started.pid, port: port)
                    print("Stopped the Slotstream server that was starting on port \(port).")
                } else {
                    print("No Slotstream server is running on port \(port).")
                }
                try? FileManager.default.removeItem(atPath: statePath)
                return
            }
            guard answer.status == 200,
                  let json = (try? JSONSerialization.jsonObject(with: answer.body)) as? [String: Any],
                  let status = CodingToolLaunch.ServerStatus.from(json) else {
                if case .answered = try Launch.probe(port: port) {
                    throw CodingToolLaunch.Failure("the Slotstream server on port \(port) is older than `slotstream stop`. "
                        + "Stop it with Control-C in its window.")
                }
                throw CodingToolLaunch.Failure("the server on port \(port) is not Slotstream, so nothing was stopped")
            }
            let ours = started?.answers(status, running: ProcessIdentity.of(status.pid)) ?? false
            try Launch.stopServer(pid: status.pid, port: port)
            let cut = status.activeRequests == 0 ? ""
                : " The \(status.activeRequests) request\(status.activeRequests == 1 ? "" : "s") it was answering ended."
            print("Stopped the Slotstream server on port \(port).\(cut)")
            if ours { try? FileManager.default.removeItem(atPath: statePath) }
        } catch let failure as CodingToolLaunch.Failure {
            Launch.say("slotstream stop: \(failure.message)")
            throw ExitCode.failure
        }
    }
}
