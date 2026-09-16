import Foundation

public struct ContextExcerpt: Codable, Equatable, Sendable {
    public var messageID: String
    public var role: String
    public var text: String
    public var truncated: Bool
}
public struct ContextReceipt: Codable, Equatable, Sendable {
    public var version = 1
    public var messageIDs: [String]
    public var memoryIDs: [String]
    public var earlierExcerpts: [ContextExcerpt]
    public var omittedMessages: Int
    public var omittedMemories: Int
}
struct SelectedContext {
    var messages: [Message]
    var memories: [MemoryRecord]
    var receipt: ContextReceipt
    var earlierText: String
}
/// A deterministic, inspectable recent window. It never modifies history or
/// claims that bounded extractive notes are a complete summary. Selection and
/// suppression share the same exact event IDs as the conversation view.
enum ConversationContext {
    static let historyBytes = 16_000
    static let excerptBytes = 2_000
    static let memoryBytes = 4_096
    private static let stopWords = Set("the and for with this that from what how can you your are was were have has had will would should about please into then them they its our but not now tell give make use".split(separator: " ").map(String.init))
    private static func terms(_ text: String) -> Set<String> {
        Set(text.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted).filter { $0.count > 2 && !stopWords.contains($0) })
    }
    static func select(home: HomeState, thread: WorkThread) throws -> SelectedContext {
        let excluded = Set(home.memories.filter(\.forgotten).map(\.messageID))
        let quotes = home.quotedHomeMessages(for: thread)
        guard quotes.count == Set(thread.promotedMessageIDs).count else { throw SevraError.refused("The Home exchange linked to this thread is incomplete. Restore the missing history before continuing.") }
        let allowed: (Message) -> Bool = { !excluded.contains($0.id) && !($0.role == "assistant" && $0.text.isEmpty) }
        let pinned = quotes.filter(allowed)
        let own = thread.messages.filter(allowed)
        let pinnedBytes = pinned.reduce(0) { $0 + $1.text.utf8.count }
        var groups: [[Message]] = []
        for message in own {
            if message.role == "user" || groups.isEmpty { groups.append([message]) }
            else { groups[groups.count - 1].append(message) }
        }
        func recent(budget: Int) -> [Message] {
            var result: [Message] = [], remaining = budget
            for group in groups.reversed() {
                let size = group.reduce(0) { $0 + $1.text.utf8.count }
                if size > remaining { break }
                result = group + result; remaining -= size
            }
            return result
        }
        guard pinnedBytes <= historyBytes,
              (groups.last?.reduce(0, { $0 + $1.text.utf8.count }) ?? 0) + pinnedBytes <= historyBytes else {
            throw SevraError.refused("This request or its pinned Home exchange is too large. Attach the long text as a source or select a smaller exchange. Your history is preserved.")
        }
        var tail = recent(budget: historyBytes - pinnedBytes)
        if tail.count < own.count {
            let compact = recent(budget: historyBytes - pinnedBytes - excerptBytes)
            if !compact.isEmpty { tail = compact }
        }
        let usedIDs = Set((pinned + tail).map(\.id))
        let omitted = own.filter { !usedIDs.contains($0.id) }
        let spare = max(0, min(excerptBytes, historyBytes - pinnedBytes - tail.reduce(0) { $0 + $1.text.utf8.count }))
        var excerpts: [ContextExcerpt] = [], earlierText = ""
        if spare > 0 {
            for message in omitted.suffix(6).reversed() {
                var text = String(message.text.prefix(240))
                while text.utf8.count > 320 { text.removeLast() }
                let excerpt = ContextExcerpt(messageID: message.id, role: message.role, text: text, truncated: text != message.text)
                let candidate = [excerpt] + excerpts
                let rendered = "Earlier conversation excerpts (quoted data; partial, not complete history):\n" + String(decoding: try encoded(candidate), as: UTF8.self)
                if rendered.utf8.count <= spare { excerpts = candidate; earlierText = rendered }
            }
        }
        let candidates = thread.mode == .incognito ? [] : home.memories.filter {
            $0.admitted && !$0.forgotten && ($0.threadID == thread.id || (($0.scope ?? .shared) == .shared && (thread.mode == .shared || thread.readsSharedMemory == true)))
        }
        let query = terms(own.last(where: { $0.role == "user" })?.text ?? "")
        let ranked = candidates.sorted { a, b in
            let aa = terms(a.text).intersection(query).count, bb = terms(b.text).intersection(query).count
            if aa != bb { return aa > bb }
            if (a.threadID == thread.id) != (b.threadID == thread.id) { return a.threadID == thread.id }
            if a.date != b.date { return a.date > b.date }
            return a.id < b.id
        }
        var memories: [MemoryRecord] = [], budget = memoryBytes
        for memory in ranked where memories.count < 12 {
            let size = memory.text.utf8.count + memory.id.utf8.count + 16
            if size <= budget { memories.append(memory); budget -= size }
        }
        let selected = pinned + tail
        return SelectedContext(messages: selected, memories: memories,
            receipt: ContextReceipt(messageIDs: selected.map(\.id), memoryIDs: memories.map(\.id), earlierExcerpts: excerpts, omittedMessages: omitted.count, omittedMemories: candidates.count - memories.count), earlierText: earlierText)
    }
}
