import AppKit
import Markdown

public struct DocumentSection: Equatable, Sendable {
    public var id: String
    public var speaker: String?
    public var source: String
    public var citationIDs: Set<String>
    public init(id: String, speaker: String? = nil, source: String, citationIDs: Set<String> = []) {
        self.id = id; self.speaker = speaker; self.source = source; self.citationIDs = citationIDs
    }
}
public struct DocumentStyle: Equatable, Sendable {
    public var size: Double
    public var dark: Bool
    public var highContrast: Bool
    public var sourceMode: Bool
    public init(size: Double = 16, dark: Bool = false, highContrast: Bool = false, sourceMode: Bool = false) {
        self.size = size; self.dark = dark; self.highContrast = highContrast; self.sourceMode = sourceMode
    }
    var ink: NSColor { dark ? NSColor(srgbRed: 241/255, green: 240/255, blue: 233/255, alpha: 1) : NSColor(srgbRed: 20/255, green: 20/255, blue: 20/255, alpha: 1) }
    var secondary: NSColor { highContrast ? ink : dark ? NSColor(srgbRed: 184/255, green: 182/255, blue: 170/255, alpha: 1) : NSColor(srgbRed: 99/255, green: 97/255, blue: 91/255, alpha: 1) }
    var link: NSColor { dark ? NSColor(srgbRed: 157/255, green: 189/255, blue: 1, alpha: 1) : NSColor(srgbRed: 53/255, green: 94/255, blue: 170/255, alpha: 1) }
    public var linkColor: NSColor { link }
    var well: NSColor { dark ? NSColor(white: 0.15, alpha: 1) : NSColor(srgbRed: 235/255, green: 233/255, blue: 226/255, alpha: 1) }
    func font(_ size: Double? = nil, bold: Bool = false, mono: Bool = false, italic: Bool = false) -> NSFont {
        let points = size ?? self.size
        var f = mono ? NSFont.monospacedSystemFont(ofSize: points, weight: bold ? .semibold : .regular) : NSFont(name: "Inter-Regular", size: points) ?? .systemFont(ofSize: points)
        var traits: NSFontDescriptor.SymbolicTraits = []
        if bold { traits.insert(.bold) }; if italic { traits.insert(.italic) }
        if !traits.isEmpty, let converted = NSFont(descriptor: f.fontDescriptor.withSymbolicTraits(traits), size: points) { f = converted }
        return f
    }
}
public struct DocumentRegion {
    public enum Kind { case heading, code, table, paragraph }
    public var kind: Kind
    public var sectionID: String
    public var display: NSRange
    /// UTF-8 bytes, directly corresponding to the parser's source coordinates.
    public var source: Range<Int>
    public var title: String
    public var copyText: String?
}
public struct RenderedDocument {
    public var text: NSAttributedString
    public var regions: [DocumentRegion]
    public var notices: [String]
    public var parsedSections: Int
}

/// Used on a serial worker. Completed sections are reused when a response streams;
/// only changed sections are reparsed, including reference-definition reconciliation.
public final class MarkdownDocumentRenderer {
    private struct Cache { var section: DocumentSection; var style: DocumentStyle; var document: RenderedDocument }
    private var cache: [String: Cache] = [:]
    public init() {}
    public func render(_ sections: [DocumentSection], style: DocumentStyle) -> RenderedDocument {
        let result = NSMutableAttributedString(string: "")
        var regions: [DocumentRegion] = [], notices: [String] = [], parsed = 0
        let keep = Set(sections.map(\.id)); cache = cache.filter { keep.contains($0.key) }
        for section in sections {
            let rendered: RenderedDocument
            if let hit = cache[section.id], hit.section == section, hit.style == style { rendered = hit.document }
            else {
                rendered = SectionRenderer(section: section, style: style).render()
                cache[section.id] = Cache(section: section, style: style, document: rendered); parsed += 1
            }
            let offset = result.length
            result.append(rendered.text)
            regions += rendered.regions.map { var r = $0; r.display.location += offset; return r }
            notices += rendered.notices
        }
        return RenderedDocument(text: result, regions: regions, notices: Array(Set(notices)).sorted(), parsedSections: parsed)
    }
    public func clear() { cache.removeAll() }
    public static func codeCopyURL(sectionID: String, sourceOffset: Int) -> URL? {
        var url = URLComponents(); url.scheme = "sevra-copy"; url.host = "code"; url.path = "/" + sectionID + "/" + String(sourceOffset); return url.url
    }
    public static func externalURL(_ destination: String) -> URL? {
        guard let u = URL(string: destination), ["https", "http"].contains(u.scheme?.lowercased() ?? ""),
              u.host?.isEmpty == false, u.user == nil, u.password == nil else { return nil }
        return u
    }
}
private final class SectionRenderer {
    let section: DocumentSection, style: DocumentStyle
    let output = NSMutableAttributedString(string: "")
    var regions: [DocumentRegion] = [], notices: [String] = []
    let bytes: [UInt8]
    var lineOffsets = [0]
    var visited = 0
    init(section: DocumentSection, style: DocumentStyle) {
        self.section = section; self.style = style; bytes = Array(section.source.utf8)
        for (i, b) in bytes.enumerated() where b == 10 { lineOffsets.append(i + 1) }
    }
    func render() -> RenderedDocument {
        if let speaker = section.speaker {
            let p = paragraph(); p.lineSpacing = 0; p.paragraphSpacing = 6; p.paragraphSpacingBefore = 0
            output.append(NSAttributedString(string: speaker + "\n", attributes: [.font: NSFont.systemFont(ofSize: 13, weight: .semibold), .foregroundColor: style.secondary, .paragraphStyle: p]))
        }
        if bytes.count > 262144 {
            notices.append("A large message is shown as source. Copy or export Markdown to keep the complete text.")
            // The paginated document host limits loaded messages; source mode does not discard bytes.
            append(section.source, attributes: attributes(mono: true))
        } else if style.sourceMode { append(section.source, attributes: attributes(mono: true)) }
        else {
            let document = Document(parsing: section.source, options: [.disableSmartOpts])
            for node in document.children { block(node, depth: 0, indent: 0) }
        }
        // Separate turns without adding another full body-text line and its
        // paragraph spacing. The source and copy/export text remain unchanged.
        let gap = NSMutableParagraphStyle()
        gap.minimumLineHeight = 12; gap.maximumLineHeight = 12
        append("\n", attributes: [.font: NSFont.systemFont(ofSize: 1), .paragraphStyle: gap])
        return RenderedDocument(text: output, regions: regions, notices: notices, parsedSections: 1)
    }
    func sourceRange(_ node: any Markup) -> Range<Int> {
        guard let r = node.range else { return 0..<0 }
        func offset(_ location: SourceLocation) -> Int {
            guard location.line > 0, location.line <= lineOffsets.count else { return bytes.count }
            return min(bytes.count, lineOffsets[location.line - 1] + max(0, location.column - 1))
        }
        let start = offset(r.lowerBound), end = offset(r.upperBound)
        return start..<max(start, end)
    }
    func raw(_ node: any Markup) -> String { String(decoding: bytes[sourceRange(node)], as: UTF8.self) }
    func paragraph(indent: Double = 0) -> NSMutableParagraphStyle {
        let p = NSMutableParagraphStyle(); p.lineSpacing = max(3, style.size * 0.24); p.paragraphSpacing = 10
        p.headIndent = indent; p.firstLineHeadIndent = indent
        return p
    }
    func attributes(bold: Bool = false, italic: Bool = false, mono: Bool = false) -> [NSAttributedString.Key: Any] {
        [.font: style.font(bold: bold, mono: mono, italic: italic), .foregroundColor: style.ink, .paragraphStyle: paragraph()]
    }
    func append(_ string: String, attributes: [NSAttributedString.Key: Any]) { output.append(NSAttributedString(string: string, attributes: attributes)) }
    func bounded(_ node: any Markup, depth: Int) -> Bool {
        visited += 1
        if depth > 32 || visited > 20000 {
            notices.append("Complex Markdown is shown as readable source."); append(raw(node) + "\n", attributes: attributes(mono: true)); return false
        }
        return true
    }
    func block(_ node: any Markup, depth: Int, indent: Double) {
        guard bounded(node, depth: depth) else { return }
        let start = output.length
        var kind = DocumentRegion.Kind.paragraph, title = "", code: String?
        if let h = node as? Heading {
            let scale = style.size / 16
            let sizes: [Double] = [24,20,18,16,16,16]
            var a = attributes(bold: true); a[.font] = style.font(sizes[min(5,max(0,h.level-1))] * scale, bold: true)
            let p = paragraph(indent: indent); p.paragraphSpacingBefore = 14; p.paragraphSpacing = 10; a[.paragraphStyle] = p
            for c in h.children { inline(c, attributes: a, depth: depth + 1) }; append("\n", attributes: a)
            kind = .heading; title = h.plainText
        } else if let p = node as? Paragraph {
            var a = attributes(); a[.paragraphStyle] = paragraph(indent: indent)
            for c in p.children { inline(c, attributes: a, depth: depth + 1) }; append("\n", attributes: a)
        } else if let c = node as? CodeBlock {
            code = c.code; kind = .code; title = c.language?.isEmpty == false ? c.language! : "Code"
            var a = attributes(mono: true)
            let p = paragraph(indent: indent + 12); p.lineSpacing = 3; p.paragraphSpacing = 0
            a[.paragraphStyle] = p; a[.backgroundColor] = style.well
            let label: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 13, weight: .medium), .foregroundColor: style.secondary, .paragraphStyle: paragraph(indent: indent + 12)]
            append(title + "   ", attributes: label)
            var action = label; action[.link] = MarkdownDocumentRenderer.codeCopyURL(sectionID: section.id, sourceOffset: sourceRange(c).lowerBound); action[.foregroundColor] = style.link
            append("Copy code", attributes: action); append("\n", attributes: label)
            let bodyStart = output.length
            append(c.code.hasSuffix("\n") ? c.code : c.code + "\n", attributes: a)
            highlight(NSRange(location: bodyStart, length: output.length - bodyStart))
            append("\n", attributes: a)
        } else if let t = node as? Markdown.Table {
            kind = .table; title = "Table: " + String(t.head.children.map { ($0 as? Markdown.Table.Cell)?.plainText ?? "" }.joined(separator: ", ").prefix(160))
            if t.maxColumnCount > 20 || t.body.childCount > 200 {
                notices.append("A large table is shown as source. Copy Markdown preserves every cell."); append(raw(t) + "\n", attributes: attributes(mono: true))
            } else { table(t, depth: depth + 1) }
        } else if let list = node as? OrderedList {
            for (index, child) in list.children.enumerated() { listItem(child, prefix: "\(Int(list.startIndex) + index).", depth: depth + 1, indent: indent) }
        } else if node is UnorderedList {
            for child in node.children { listItem(child, prefix: "•", depth: depth + 1, indent: indent) }
        } else if node is BlockQuote {
            let begin = output.length
            for child in node.children { block(child, depth: depth + 1, indent: indent + 20) }
            output.addAttribute(.foregroundColor, value: style.secondary, range: NSRange(location: begin, length: output.length - begin))
        } else if node is ThematicBreak {
            append("────────────────\n", attributes: [.font: style.font(), .foregroundColor: style.secondary, .paragraphStyle: paragraph()])
        } else if let html = node as? HTMLBlock { append(html.rawHTML + "\n", attributes: attributes(mono: true)) }
        else if node.childCount > 0 { for child in node.children { block(child, depth: depth + 1, indent: indent) } }
        else { append(raw(node) + "\n", attributes: attributes()) }
        if output.length > start { regions.append(DocumentRegion(kind: kind, sectionID: section.id, display: NSRange(location: start, length: output.length - start), source: sourceRange(node), title: title, copyText: code)) }
    }
    func listItem(_ node: any Markup, prefix: String, depth: Int, indent: Double) {
        guard bounded(node, depth: depth) else { return }
        var prefix = prefix
        if let item = node as? ListItem, let checkbox = item.checkbox { prefix = checkbox == .checked ? "☑" : "☐" }
        let start = output.length
        for (index, child) in node.children.enumerated() {
            if index == 0, let p = child as? Paragraph {
                var a = attributes(); let paragraph = paragraph(indent: indent + 22); paragraph.firstLineHeadIndent = indent
                paragraph.tabStops = [NSTextTab(textAlignment: .left, location: indent + 22)]; a[.paragraphStyle] = paragraph
                append(prefix + "\t", attributes: a)
                for c in p.children { inline(c, attributes: a, depth: depth + 1) }; append("\n", attributes: a)
            } else { block(child, depth: depth + 1, indent: indent + 22) }
        }
        regions.append(DocumentRegion(kind: .paragraph, sectionID: section.id, display: NSRange(location: start, length: output.length - start), source: sourceRange(node), title: "", copyText: nil))
    }
    func inline(_ node: any Markup, attributes a: [NSAttributedString.Key: Any], depth: Int) {
        guard bounded(node, depth: depth) else { return }
        if let t = node as? Markdown.Text { appendCitations(t.string, attributes: a) }
        else if let c = node as? InlineCode { var b = a; b[.font] = style.font(mono: true); b[.backgroundColor] = style.well; append(c.code, attributes: b) }
        else if node is SoftBreak { append(" ", attributes: a) }
        else if node is LineBreak { append("\u{2028}", attributes: a) }
        else if let html = node as? InlineHTML { append(html.rawHTML, attributes: a) }
        else if let image = node as? Markdown.Image {
            var b = a
            if let destination = image.source, let url = MarkdownDocumentRenderer.externalURL(destination) { b[.link] = url; b[.foregroundColor] = style.link; b[.underlineStyle] = NSUnderlineStyle.single.rawValue }
            append("[Image: " + (image.plainText.isEmpty ? "not loaded" : image.plainText) + "]", attributes: b)
        } else {
            var b = a
            if node is Strong || node is Emphasis {
                let old = a[.font] as? NSFont ?? style.font()
                var traits = old.fontDescriptor.symbolicTraits
                traits.insert(node is Strong ? .bold : .italic)
                b[.font] = NSFont(descriptor: old.fontDescriptor.withSymbolicTraits(traits), size: old.pointSize) ?? old
            }
            if node is Strikethrough { b[.strikethroughStyle] = NSUnderlineStyle.single.rawValue }
            if let link = node as? Markdown.Link, let destination = link.destination, let url = MarkdownDocumentRenderer.externalURL(destination) {
                b[.link] = url; b[.foregroundColor] = style.link; b[.underlineStyle] = NSUnderlineStyle.single.rawValue; b[.toolTip] = destination
            }
            if node.childCount == 0 { append(raw(node), attributes: b) }
            else { for child in node.children { inline(child, attributes: b, depth: depth + 1) } }
        }
    }
    func appendCitations(_ text: String, attributes a: [NSAttributedString.Key: Any]) {
        let start = output.length; append(text, attributes: a)
        guard let expression = try? NSRegularExpression(pattern: #"\[(S[0-9]+)\]"#) else { return }
        let ns = text as NSString
        for match in expression.matches(in: text, range: NSRange(location: 0, length: ns.length)) {
            let id = ns.substring(with: match.range(at: 1)); guard section.citationIDs.contains(id) else { continue }
            var url = URLComponents(); url.scheme = "sevra-citation"; url.host = "evidence"; url.path = "/" + section.id + "/" + id
            if let target = url.url { output.addAttributes([.link: target, .foregroundColor: style.link, .underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: start + match.range.location, length: match.range.length)) }
        }
    }
    func table(_ table: Markdown.Table, depth: Int) {
        let native = NSTextTable(); native.numberOfColumns = max(1, table.maxColumnCount); native.layoutAlgorithm = .automaticLayoutAlgorithm
        native.collapsesBorders = true; native.setValue(100, type: .percentageValueType, for: .width)
        let rows = [Array(table.head.children)] + table.body.children.map { Array($0.children) }
        for (row, cells) in rows.enumerated() {
            for (column, cell) in cells.enumerated() {
                let box = NSTextTableBlock(table: native, startingRow: row, rowSpan: 1, startingColumn: column, columnSpan: 1)
                box.setWidth(8, type: .absoluteValueType, for: .padding)
                box.setWidth(style.highContrast ? 1 : 0.5, type: .absoluteValueType, for: .border)
                box.setBorderColor(style.secondary.withAlphaComponent(style.highContrast ? 1 : 0.3))
                box.backgroundColor = row == 0 ? style.well : nil
                let p = paragraph(); p.paragraphSpacing = 0; p.textBlocks = [box]
                if column < table.columnAlignments.count { switch table.columnAlignments[column] { case .center: p.alignment = .center; case .right: p.alignment = .right; default: break } }
                var a = attributes(bold: row == 0); a[.paragraphStyle] = p
                for c in cell.children { inline(c, attributes: a, depth: depth + 1) }; append("\n", attributes: a)
            }
        }
        append("\n", attributes: attributes())
    }
    func highlight(_ range: NSRange) {
        guard range.length <= 65536 else { return }
        let text = (output.string as NSString).substring(with: range)
        let patterns: [(String, NSColor)] = [
            (#"\b(func|let|var|if|else|return|class|struct|enum|import|public|private|async|await|try|throw|def|from|for|in|while|const|function|export|true|false|nil|null)\b"#, style.link),
            (#"\b[0-9]+(?:\.[0-9]+)?\b"#, style.dark ? NSColor(srgbRed: 0.87, green: 0.75, blue: 0.5, alpha: 1) : NSColor(srgbRed: 0.5, green: 0.33, blue: 0, alpha: 1)),
            (#"\"(?:[^\"\\]|\\.)*\"|'(?:[^'\\]|\\.)*'"#, style.dark ? NSColor(srgbRed: 0.61, green: 0.80, blue: 0.66, alpha: 1) : NSColor(srgbRed: 0.18, green: 0.40, blue: 0.27, alpha: 1)),
            (#"(?m)//[^\n]*|^\s*#[^\n]*"#, style.secondary)
        ]
        for (pattern, color) in patterns {
            guard let re = try? NSRegularExpression(pattern: pattern) else { continue }
            for match in re.matches(in: text, range: NSRange(location: 0, length: (text as NSString).length)) { output.addAttribute(.foregroundColor, value: color, range: NSRange(location: range.location + match.range.location, length: match.range.length)) }
        }
    }
}
