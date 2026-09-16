import AppKit
import SwiftUI
import SevraPresentation

@MainActor private final class ScrollFixture: ObservableObject {
    @Published var id = "first:latest"
    @Published var text = (1...120).map { "Paragraph \($0): a synthetic reading position." }.joined(separator: "\n\n")
    @Published var fontSize = 16.0
    let session = TextSession()
    var away = false
}

private struct FixtureView: View {
    @ObservedObject var fixture: ScrollFixture
    var body: some View {
        Transcript(documentID: fixture.id, sections: [DocumentSection(id: "message", source: fixture.text)],
                   fontSize: fixture.fontSize, session: fixture.session,
                   onScrollAwayFromLatest: { fixture.away = $0 })
    }
}

@main private struct ScrollChecks {
    @MainActor static func main() async throws {
        _ = NSApplication.shared
        NSApp.setActivationPolicy(.prohibited)
        let fixture = ScrollFixture()
        // An offscreen component test. It never activates or drives a user's app.
        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 540, height: 400), styleMask: [.borderless], backing: .buffered, defer: false)
        window.contentView = NSHostingView(rootView: FixtureView(fixture: fixture))
        func settle(_ predicate: () -> Bool) async throws {
            for _ in 0..<200 {
                window.contentView?.layoutSubtreeIfNeeded()
                if predicate() { return }
                try await Task.sleep(nanoseconds: 10_000_000)
            }
            throw NSError(domain: "ScrollChecks", code: 1, userInfo: [NSLocalizedDescriptionKey: "Timed out waiting for native render/viewport"])
        }
        func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
            guard condition() else { fputs("FAIL: \(message)\n", stderr); exit(1) }
            print("PASS: \(message)")
        }
        try await settle { fixture.session.conversation?.string.contains("Paragraph 120") == true && fixture.session.conversation?.isNearLatest == true }
        let view = fixture.session.conversation!, scroll = view.enclosingScrollView!
        expect(!fixture.away, "first opening of a long conversation starts at latest without an extra control")

        fixture.text += "\n\nStreaming tail one."
        try await settle { view.string.contains("Streaming tail one.") && view.isNearLatest }
        expect(!fixture.away, "new text follows while already at the end")

        scroll.contentView.scroll(to: NSPoint(x: 0, y: 300)); scroll.reflectScrolledClipView(scroll.contentView)
        try await settle { fixture.away }
        let readingOrigin = scroll.contentView.bounds.origin.y
        fixture.text += "\n\n" + String(repeating: "Streaming while reading above.\n\n", count: 20)
        try await settle { view.string.contains("Streaming while reading above.") }
        expect(abs(scroll.contentView.bounds.origin.y - readingOrigin) < 1 && fixture.away, "streaming preserves the reader's position and offers Latest")

        view.setSelectedRange(NSRange(location: 12, length: 7))
        view.jumpToLatest(focus: false)
        try await settle { !fixture.away && view.isNearLatest }
        expect(view.selectedRange().length == 0, "explicit Latest clears selection and resumes following")
        fixture.text += "\n\nAfter resuming."
        try await settle { view.string.contains("After resuming.") && view.isNearLatest }
        expect(!fixture.away, "later text keeps following after Latest")

        let selectionOrigin = scroll.contentView.bounds.origin.y
        view.setSelectedRange(NSRange(location: (view.string as NSString).length - 20, length: 7))
        fixture.text += "\n\n" + String(repeating: "New output while selecting text.\n\n", count: 12)
        try await settle { view.string.contains("New output while selecting text.") && fixture.away }
        expect(abs(scroll.contentView.bounds.origin.y - selectionOrigin) < 1 && view.selectedRange().length == 7,
               "selecting text prevents streaming from moving the document")
        view.jumpToLatest(focus: false)
        try await settle { !fixture.away }

        window.setContentSize(NSSize(width: 440, height: 300))
        window.contentView?.layoutSubtreeIfNeeded()
        try await Task.sleep(nanoseconds: 100_000_000)
        expect(view.isNearLatest && !fixture.away, "window resizing preserves following at latest")

        fixture.fontSize = 22
        try await settle { view.font?.pointSize == 22 || (view.textStorage?.attribute(.font, at: 0, effectiveRange: nil) as? NSFont)?.pointSize == 22 }
        expect(view.isNearLatest, "text-size reflow keeps a reader at latest")

        fixture.id = "first:earlier"
        fixture.text = "Earlier page.\n\n" + String(repeating: "Previous message.\n\n", count: 80)
        try await settle { view.string.hasPrefix("Earlier page.") && fixture.away }
        expect(!view.isNearLatest, "an earlier page opens at its beginning")

        fixture.session.pendingLatestDocumentID = "first:latest"
        fixture.session.pendingLatestFocus = false
        fixture.id = "first:latest"
        fixture.text = "Latest page.\n\n" + String(repeating: "Newest message.\n\n", count: 90)
        try await settle { view.string.hasPrefix("Latest page.") && view.isNearLatest && !fixture.away }
        expect(fixture.session.pendingLatestDocumentID == nil, "earlier-page Latest is consumed only after destination layout")

        scroll.contentView.scroll(to: NSPoint(x: 0, y: 450)); scroll.reflectScrolledClipView(scroll.contentView)
        try await settle { fixture.away }
        let saved = scroll.contentView.bounds.origin.y
        fixture.id = "second:latest"; fixture.text = "A short conversation."
        try await settle { view.string == "A short conversation.\n\n" || view.string.trimmingCharacters(in: .whitespacesAndNewlines) == "A short conversation." }
        try await settle { !fixture.away }
        expect(view.isNearLatest, "short conversations need no jump control")
        fixture.id = "first:latest"; fixture.text = "Latest page.\n\n" + String(repeating: "Newest message.\n\n", count: 90)
        try await settle { view.string.hasPrefix("Latest page.") && fixture.away }
        expect(abs(scroll.contentView.bounds.origin.y - saved) < 1, "returning to a thread restores its reading position")
        window.contentView = nil
        print("PASS: production native transcript scroll lifecycle")
    }
}
