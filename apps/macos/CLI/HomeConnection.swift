import Foundation
import SlotstreamRuntime
import Slotstream

/// Bind once. A registry selection change cannot redirect an in-flight command
/// or a running MCP session to another Home.
struct HomeConnection {
    let home: URL
    let dbmd: URL
    func request(_ request: LocalRequest, allowOffline: Bool = true) async throws -> LocalReply {
        do { return try LocalClient(home: home).request(request) }
        catch {
            guard allowOffline else { throw AppRuntimeError.unavailable("Open this Home in Slotstream to use AI: \(home.path). \(error.localizedDescription)") }
            // No model is created for data access. The brief owner also verifies
            // integrity and serializes with a simultaneous app open.
            let store: HomeStore
            do { store = try HomeStore(root: home, dbmd: dbmd) }
            catch AppRuntimeError.ownerBusy { return try LocalClient(home: home).request(request) }
            let state = try store.load()
            if request.operation == "data", let query = request.dataQuery {
                return LocalReply(homeID: state.id, data: try store.data(query, threadTitles: Dictionary(uniqueKeysWithValues: state.threads.map { ($0.id, $0.title) })))
            }
            if request.operation == "status" {
                guard var thread = state.threads.first(where: { $0.id == request.threadID && $0.mode != .incognito }) else { throw AppRuntimeError.refused("This thread is not available.") }
                thread.messages = Array(thread.messages.filter { $0.runID == thread.run?.id }.suffix(2))
                thread.pastRuns = nil; thread.draft = ""
                return LocalReply(homeID: state.id, thread: thread)
            }
            throw AppRuntimeError.refused("This operation requires the Home to be open in the app.")
        }
    }
    func data(_ query: HomeDataRequest) async throws -> HomeDataResult {
        var request = LocalRequest(operation: "data"); request.dataQuery = query
        guard let data = try await self.request(request).data else { throw AppRuntimeError.unavailable("The Home owner does not support data browsing. Reopen it in the updated app.") }
        return data
    }
}

