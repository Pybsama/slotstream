import Foundation
import Markdown

/// One citation grammar for saved documents and the native renderer. Labels
/// identify host-owned excerpts, never a URL supplied by the model. Page
/// annotations remain model text; they do not change the underlying evidence.
public enum CitationReferences {
    public struct Reference {
        public let id: String
        public let range: NSRange
    }
    private static let marker = try! NSRegularExpression(pattern: #"\[S[0-9]+(?:\s*,?\s*(?:pages?|pp?\.)\s*[0-9]+(?:\s*[-–]\s*[0-9]+)?)?(?:\s*[,;]\s*S[0-9]+(?:\s*,?\s*(?:pages?|pp?\.)\s*[0-9]+(?:\s*[-–]\s*[0-9]+)?)?)*\]"#)
    private static let identifier = try! NSRegularExpression(pattern: #"\bS[0-9]+\b"#)
    // Match bounded candidates first. Malformed model text must not make the
    // richer optional-page grammar backtrack across an entire large message.
    private static let candidate = try! NSRegularExpression(pattern: #"\[S[^\[\]\r\n]{0,254}\]"#)
    public static func inText(_ text: String) -> [Reference] {
        let ns = text as NSString
        return candidate.matches(in: text, range: NSRange(location: 0, length: ns.length)).compactMap { candidate in
            guard let match = marker.firstMatch(in: text, options: [.anchored], range: candidate.range), match.range == candidate.range else { return nil as NSTextCheckingResult? }
            return match
        }.flatMap { marker in
            let ids = identifier.matches(in: text, range: marker.range)
            return ids.map { Reference(id: ns.substring(with: $0.range), range: ids.count == 1 ? marker.range : $0.range) }
        }
    }
    public static func inMarkdown(_ source: String) -> Set<String> {
        var ids = Set<String>()
        func visit(_ node: any Markup, depth: Int) {
            guard depth <= 32 else { return }
            if node is CodeBlock || node is InlineCode || node is Markdown.Link || node is Markdown.Image || node is HTMLBlock || node is InlineHTML { return }
            if let text = node as? Markdown.Text { ids.formUnion(inText(text.string).map(\.id)) }
            for child in node.children { visit(child, depth: depth + 1) }
        }
        visit(Document(parsing: source, options: [.disableSmartOpts]), depth: 0)
        return ids
    }
}

public enum StructuredReply {
    /// Syntax validation only. Preserve numeric spelling, key order and string
    /// bytes; never repair or reserialize values and call them validated facts.
    public static func isJSONContainer(_ text: String) -> Bool {
        guard text.utf8.count <= 262_144, let first = text.first(where: { !$0.isWhitespace }), first == "{" || first == "[",
              let value = try? JSONSerialization.jsonObject(with: Data(text.utf8)) else { return false }
        return value is [String: Any] || value is [Any]
    }
    private static let fence = try! NSRegularExpression(pattern: #"\A(`{3,}|~{3,})json[ \t]*\r?\n([\s\S]*?)\r?\n\1\z"#, options: [.caseInsensitive])
    /// A reply consisting entirely of a valid JSON code block is stored as
    /// raw JSON, so Copy Message and exports are immediately machine-readable.
    /// Prose, partial JSON and other code blocks are left byte-for-byte intact.
    public static func finalized(_ source: String) -> String {
        guard source.utf8.count <= 262_144 else { return source }
        let text = source.trimmingCharacters(in: .whitespacesAndNewlines), ns = text as NSString
        guard let match = fence.firstMatch(in: text, range: NSRange(location: 0, length: ns.length)) else { return source }
        let payload = ns.substring(with: match.range(at: 2))
        return isJSONContainer(payload) ? payload : source
    }
}
