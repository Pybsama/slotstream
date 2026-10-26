import Foundation
import SlotstreamRuntime

/// Real db.md writes, including recovery after documents and the index land.
/// Table output and user text must remain data even when they contain links.
func literalStorageChecks(root: URL, dbmd: URL) throws {
    let literal = #"{"sample_rows":[["A","paid","12.50"],["B","paid","54.84"]],"text":"[[not a link]] and [label](missing.md)","slash":"\\[","unicode":"café 🐦"}"#
    for stop in ["none", "documents", "record"] {
        let home = root.appendingPathComponent("literal-json-" + stop)
        var store: HomeStore? = try HomeStore(root: home, dbmd: dbmd)
        var state = HomeState()
        try store!.save(state)
        state.revision += 1
        state.threads[0].title = "[[literal title]]"
        state.threads[0].draft = literal
        state.threads[0].messages = [Message(role: "user", text: literal)]
        var interrupted = false
        store!.fault = { stage in
            if stage == stop { throw AppRuntimeError.unavailable("injected interruption") }
        }
        do { try store!.save(state) }
        catch {
            guard error.localizedDescription == "injected interruption" else { throw error }
            interrupted = true
        }
        try require(interrupted == (stop != "none"), "literal JSON reaches the intended save stage")
        store = nil
        let reopened = try HomeStore(root: home, dbmd: dbmd)
        let restored = try reopened.load()
        try require(restored.threads[0].title == state.threads[0].title
                    && restored.threads[0].draft == literal
                    && restored.threads[0].messages.map(\.id) == state.threads[0].messages.map(\.id)
                    && restored.threads[0].messages.map(\.text) == [literal],
                    "literal brackets, escapes and Unicode survive save and recovery exactly")
        try reopened.save(restored)
        try require(!FileManager.default.fileExists(atPath: home.appendingPathComponent(".sevra/recovery.json").path), "literal JSON recovery completes")
    }
    print("PASS: literal JSON table results, Markdown-looking text, Unicode and exact interrupted-save recovery through real dbmd")
}
