import AppKit
import SwiftUI
import SevraPresentation

enum Appearance: String, CaseIterable { case system = "System", light = "Light", dark = "Dark" }

@MainActor final class TextSession {
    struct Position { var selection = NSRange(location: 0, length: 0); var origin = NSPoint.zero; var followsLatest = false }
    var positions: [String: Position] = [:]
    var composers: [String: NSScrollView] = [:]
    weak var conversation: DocumentTextView?
    weak var artifact: DocumentTextView?
    weak var composer: ComposerTextView?
    weak var returnFocus: NSView?
    var pendingDocumentFocus = false
    var pendingLatestDocumentID: String?
    var pendingLatestFocus = true
    private var returnRole = "composer"
    func rememberFocus() {
        returnFocus = NSApp.keyWindow?.firstResponder as? NSView
        if returnFocus is ComposerTextView { returnRole = "composer" }
        else if returnFocus === conversation { returnRole = "conversation" }
        else if returnFocus === artifact { returnRole = "artifact" }
    }
    func restoreFocus() {
        let fallback: NSView? = returnRole == "conversation" ? conversation : returnRole == "artifact" ? artifact ?? conversation : composer
        let target = returnFocus?.window != nil ? returnFocus : fallback
        if let target { target.window?.makeFirstResponder(target) }
    }
    func focusComposer() { if let composer { composer.window?.makeFirstResponder(composer) } }
    func focusDocument() { if let conversation, let window = conversation.window { window.makeFirstResponder(conversation) } else { pendingDocumentFocus = true } }
    private var composerOrder: [String] = []
    func retainComposer(_ scroll: NSScrollView, id: String) {
        composers[id] = scroll; composerOrder.removeAll { $0 == id }; composerOrder.append(id)
        while composerOrder.count > 12 { composers.removeValue(forKey: composerOrder.removeFirst()) }
    }
    func discard(_ id: String) { composers.removeValue(forKey: id); positions = positions.filter { !$0.key.contains(id) } }
}

struct Transcript: NSViewRepresentable {
    let documentID: String
    var sections: [DocumentSection]
    var fontSize: CGFloat = 16
    var sourceMode = false
    var label = "Conversation"
    var horizontalInset: CGFloat = 16
    var session: TextSession
    var onLink: (URL) -> Void = { _ in }
    var onNotice: (String) -> Void = { _ in }
    var onOutline: ([DocumentRegion]) -> Void = { _ in }
    var onScrollAwayFromLatest: (Bool) -> Void = { _ in }
    /// Opens a response's details at a place in this document.
    var onDetails: (URL, NSRect, NSView) -> Void = { _, _, _ in }
    @Environment(\.colorScheme) private var scheme
    @Environment(\.colorSchemeContrast) private var contrast
    func makeCoordinator() -> Coordinator { Coordinator() }
    func makeNSView(context: Context) -> NSScrollView {
        let scroll = TranscriptScrollView(); scroll.hasVerticalScroller = true; scroll.drawsBackground = false
        // NSTextTable is not supported by TextKit 2. Use its native compatible
        // document engine deliberately, with bounded history pages and regression tests.
        let view = DocumentTextView(frame: .zero)
        view.isEditable = false; view.isSelectable = true; view.drawsBackground = false
        view.isRichText = true; view.importsGraphics = false
        view.usesFindBar = true; view.isIncrementalSearchingEnabled = true
        view.isAutomaticLinkDetectionEnabled = false
        if #available(macOS 15, *) { view.writingToolsBehavior = .none }
        view.isHorizontallyResizable = false; view.isVerticallyResizable = true
        view.autoresizingMask = [.width]; view.textContainer?.widthTracksTextView = true
        view.textContainerInset = NSSize(width: horizontalInset, height: 16)
        view.textContainer?.lineFragmentPadding = 0
        view.delegate = context.coordinator; view.focusRingType = .exterior
        view.setAccessibilityCustomRotors([
            NSAccessibilityCustomRotor(rotorType: .heading, itemSearchDelegate: view),
            NSAccessibilityCustomRotor(rotorType: .table, itemSearchDelegate: view),
            NSAccessibilityCustomRotor(label: "Code blocks", itemSearchDelegate: view)
        ])
        view.setAccessibilityIdentifier(label == "Conversation" ? "conversation-document" : "artifact-document")
        scroll.documentView = view; context.coordinator.view = view
        context.coordinator.observeViewport(scroll, view: view)
        return scroll
    }
    func updateNSView(_ scroll: NSScrollView, context: Context) {
        guard let view = scroll.documentView as? DocumentTextView else { return }
        let c = context.coordinator
        c.session = session; c.onLink = onLink
        c.onScrollAwayFromLatest = onScrollAwayFromLatest
        let details = onDetails
        c.onDetails = details
        view.onDetails = { [weak view] url, rect in if let view { details(url, rect, view) } }
        view.setAccessibilityLabel(label)
        view.onOversizeCopy = onNotice
        if label == "Conversation" { session.conversation = view } else { session.artifact = view }
        let style = DocumentStyle(size: fontSize, dark: scheme == .dark, highContrast: contrast == .increased, sourceMode: sourceMode)
        // Every link carries its own look: text links are colored and
        // underlined by the renderer, while a reply's details line stays quiet.
        view.linkTextAttributes = [.cursor: NSCursor.pointingHand]
        guard c.sections != sections || c.style != style || c.id != documentID else { return }
        if c.id != documentID {
            if !c.id.isEmpty { session.positions[c.id] = view.savedPosition }
            c.restore = session.positions[documentID] ?? TextSession.Position(followsLatest: label == "Conversation" && documentID.hasSuffix(":latest"))
            c.id = documentID
            c.lastAway = nil
        }
        c.sections = sections; c.style = style; c.generation += 1
        let generation = c.generation, input = sections, renderer = c.renderer
        c.pending?.cancel()
        let work = DispatchWorkItem { [weak c, weak scroll, weak view] in
            guard let c, !Thread.current.isCancelled else { return }
            let document = renderer.render(input, style: style)
            DispatchQueue.main.async {
                guard generation == c.generation, let scroll, let view, let storage = view.textStorage else { return }
                let selected = view.selectedRange(), origin = scroll.contentView.bounds.origin
                let follow = c.restore?.followsLatest ?? (selected.length == 0 && view.isNearLatest)
                let before = storage.string as NSString, after = document.text.string as NSString
                var prefix = 0
                if c.restore == nil && c.appliedStyle == style {
                    while prefix < min(before.length, after.length), before.character(at: prefix) == after.character(at: prefix) { prefix += 1 }
                    if prefix > 0 { prefix = after.paragraphRange(for: NSRange(location: min(prefix - 1, max(0, after.length - 1)), length: 0)).location }
                    // Earlier reference definitions can change attributes without changing text.
                    if prefix > 0 && !storage.attributedSubstring(from: NSRange(location: 0, length: prefix)).isEqual(to: document.text.attributedSubstring(from: NSRange(location: 0, length: prefix))) { prefix = 0 }
                }
                storage.beginEditing()
                storage.replaceCharacters(in: NSRange(location: prefix, length: before.length - prefix), with: document.text.attributedSubstring(from: NSRange(location: prefix, length: after.length - prefix)))
                storage.endEditing()
                view.sections = input; view.regions = document.regions
                onOutline(document.regions.filter { $0.kind != .paragraph })
                let position = c.restore ?? TextSession.Position(selection: selected, origin: origin)
                let location = min(position.selection.location, storage.length)
                view.setSelectedRange(NSRange(location: location, length: min(position.selection.length, storage.length - location)))
                view.layoutManager?.ensureLayout(for: view.textContainer!)
                // A page change renders asynchronously. Honor an explicit
                // Latest request only after that exact destination is laid out.
                let jumpLatest = session.pendingLatestDocumentID == documentID
                if jumpLatest { session.pendingLatestDocumentID = nil }
                if jumpLatest { view.jumpToLatest(focus: session.pendingLatestFocus) }
                else if follow { view.scrollToEndOfDocument(nil) }
                else { scroll.contentView.scroll(to: position.origin) }
                scroll.reflectScrolledClipView(scroll.contentView)
                c.restore = nil; c.appliedStyle = style
                c.publishViewport()
                if label == "Conversation", session.pendingDocumentFocus { session.pendingDocumentFocus = false; view.window?.makeFirstResponder(view) }
                c.notice = document.notices.joined(separator: " ")
                onNotice(c.notice)
            }
        }
        c.pending = work; c.queue.async(execute: work)
    }
    static func dismantleNSView(_ scroll: NSScrollView, coordinator: Coordinator) {
        coordinator.generation += 1; coordinator.pending?.cancel()
        coordinator.stopObservingViewport()
        if let view = scroll.documentView as? DocumentTextView, !coordinator.id.isEmpty {
            coordinator.session?.positions[coordinator.id] = view.savedPosition
        }
    }
    final class Coordinator: NSObject, NSTextViewDelegate {
        weak var view: DocumentTextView?
        var session: TextSession?
        var sections: [DocumentSection] = []
        var style: DocumentStyle?, appliedStyle: DocumentStyle?
        var id = "", notice = ""
        var generation = 0
        var restore: TextSession.Position?
        let queue = DispatchQueue(label: "Sevra.Markdown", qos: .userInitiated)
        let renderer = MarkdownDocumentRenderer()
        var pending: DispatchWorkItem?
        var onLink: (URL) -> Void = { _ in }
        var onScrollAwayFromLatest: (Bool) -> Void = { _ in }
        var onDetails: (URL, NSRect, NSView) -> Void = { _, _, _ in }
        var lastAway: Bool?
        private var viewportObservers: [NSObjectProtocol] = []
        func observeViewport(_ scroll: NSScrollView, view: DocumentTextView) {
            scroll.contentView.postsBoundsChangedNotifications = true
            scroll.contentView.postsFrameChangedNotifications = true
            view.postsFrameChangedNotifications = true
            for (name, object) in [(NSView.boundsDidChangeNotification, scroll.contentView),
                                   (NSView.frameDidChangeNotification, scroll.contentView),
                                   (NSView.frameDidChangeNotification, view)] {
                viewportObservers.append(NotificationCenter.default.addObserver(forName: name, object: object, queue: .main) { [weak self] _ in self?.publishViewport() })
            }
        }
        func stopObservingViewport() {
            viewportObservers.forEach(NotificationCenter.default.removeObserver)
            viewportObservers.removeAll()
        }
        func publishViewport() {
            // Defer past layout/SwiftUI updates and read the latest geometry,
            // rather than publishing intermediate text-replacement positions.
            let currentID = id, currentGeneration = generation
            DispatchQueue.main.async { [weak self] in
                guard let self, self.id == currentID, self.generation == currentGeneration,
                      let view = self.view, view.window != nil else { return }
                let away = !view.isNearLatest
                guard self.lastAway != away else { return }
                self.lastAway = away; self.onScrollAwayFromLatest(away)
            }
        }
        deinit { viewportObservers.forEach(NotificationCenter.default.removeObserver) }
        func textView(_ textView: NSTextView, clickedOnLink link: Any, at charIndex: Int) -> Bool {
            if let url = link as? URL {
                if url.scheme == "sevra-copy", let view = textView as? DocumentTextView {
                    // Only a generated link at this exact code region can copy it.
                    if let region = view.regions.first(where: { $0.kind == .code && NSLocationInRange(charIndex, $0.display) }),
                       url == MarkdownDocumentRenderer.codeCopyURL(sectionID: region.sectionID, sourceOffset: region.source.lowerBound), let code = region.copyText { view.put(code); view.onOversizeCopy("Code copied.") }
                } else if ResponseDetailsLink.target(url) != nil {
                    onDetails(url, (textView as? DocumentTextView)?.linkRect(at: charIndex) ?? .zero, textView)
                } else { session?.rememberFocus(); onLink(url) }
            }; return true
        }
    }
}

final class TranscriptScrollView: NSScrollView {
    override func setFrameSize(_ newSize: NSSize) {
        let document = documentView as? DocumentTextView
        let follow = document?.selectedRange().length == 0 && document?.isNearLatest == true
        super.setFrameSize(newSize)
        if follow, let document, let container = document.textContainer {
            document.layoutManager?.ensureLayout(for: container)
            document.scrollToEndOfDocument(nil)
        }
    }
}

final class DocumentTextView: NSTextView, NSAccessibilityCustomRotorItemSearchDelegate {
    override func cancelOperation(_ sender: Any?) {
        if enclosingScrollView?.isFindBarVisible == true {
            let item = NSMenuItem(); item.tag = Int(NSTextFinder.Action.hideFindInterface.rawValue)
            performTextFinderAction(item)
            window?.makeFirstResponder(self)
        } else { window?.cancelOperation(sender) }
    }
    var sections: [DocumentSection] = []
    var regions: [DocumentRegion] = []
    var onOversizeCopy: (String) -> Void = { _ in }
    var onDetails: ((URL, NSRect) -> Void)?
    private var menuCode: String?
    private var menuSource: String?
    private var menuLink: URL?
    private var menuDetails: (url: URL, rect: NSRect)?
    override func menu(for event: NSEvent) -> NSMenu? {
        let menu = NSMenu()
        let point = convert(event.locationInWindow, from: nil)
        let offset = characterIndexForInsertion(at: point)
        menuCode = regions.first { $0.kind == .code && NSLocationInRange(offset, $0.display) }?.copyText
        let id = regions.first { NSLocationInRange(offset, $0.display) }?.sectionID
        menuSource = sections.first { $0.id == id }?.source
        if menuSource == nil, sections.count == 1 { menuSource = sections.first?.source }
        func add(_ title: String, _ action: Selector) { let item = NSMenuItem(title: title, action: action, keyEquivalent: ""); item.target = self; menu.addItem(item) }
        if selectedRange().length > 0 { add("Copy", #selector(copy(_:))) }
        if menuCode != nil { let item = NSMenuItem(title: "Copy Code", action: #selector(copyCode), keyEquivalent: ""); item.target = self; menu.addItem(item) }
        if menuSource != nil { let item = NSMenuItem(title: "Copy Message as Markdown", action: #selector(copySource), keyEquivalent: ""); item.target = self; menu.addItem(item) }
        menuLink = offset < (textStorage?.length ?? 0) ? textStorage?.attribute(.link, at: offset, effectiveRange: nil) as? URL : nil
        if let link = menuLink, MarkdownDocumentRenderer.externalURL(link.absoluteString) != nil { add("Copy Link", #selector(copyLink)) }
        // A reply's details, from its text or from its details line.
        let details = menuLink.flatMap { ResponseDetailsLink.target($0) != nil ? $0 : nil } ?? sections.first { $0.id == id }?.details
        menuDetails = details.map { ($0, NSRect(x: point.x, y: point.y, width: 1, height: 1)) }
        if menuDetails != nil, onDetails != nil { menu.addItem(.separator()); add("Show Response Details", #selector(showDetails)) }
        menu.addItem(.separator()); add("Select All", #selector(selectAll(_:))); add("Find…", #selector(findDocument))
        return menu
    }
    func put(_ text: String) {
        guard text.utf8.count <= 4 * 1024 * 1024 else { onOversizeCopy("This selection is too large for the clipboard. Use Export Markdown to save its full source."); return }
        NSPasteboard.general.clearContents(); NSPasteboard.general.setString(text, forType: .string)
    }
    @objc func copyCode() { if let menuCode { put(menuCode) } }
    @objc func copySource() { if let menuSource { put(menuSource) } }
    @objc func copyLink() { if let menuLink { put(menuLink.absoluteString) } }
    @objc func showDetails() { if let menuDetails { onDetails?(menuDetails.url, menuDetails.rect) } }
    /// Where a link's text sits in this view, for a popover beside it.
    func linkRect(at index: Int) -> NSRect {
        guard let storage = textStorage, let manager = layoutManager, let container = textContainer, index < storage.length else { return .zero }
        var range = NSRange(location: index, length: 1)
        _ = storage.attribute(.link, at: index, longestEffectiveRange: &range, in: NSRange(location: 0, length: storage.length))
        let glyphs = manager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
        var rect = manager.boundingRect(forGlyphRange: glyphs, in: container)
        rect.origin.x += textContainerOrigin.x; rect.origin.y += textContainerOrigin.y
        return rect
    }
    @objc func findDocument() { window?.makeFirstResponder(self); let item = NSMenuItem(); item.tag = Int(NSFindPanelAction.showFindPanel.rawValue); performFindPanelAction(item) }
    override func copy(_ sender: Any?) {
        let selected = selectedRange()
        guard selected.length > 0 else { return }
        put((string as NSString).substring(with: selected))
    }
    /// A small trailing allowance keeps the affordance stable around the last
    /// few text lines and during native elastic scrolling. This is a UI
    /// tolerance in points, not a content or retention limit.
    var isNearLatest: Bool {
        guard let scroll = enclosingScrollView, scroll.contentView.bounds.height > 0 else { return true }
        return bounds.height - scroll.contentView.bounds.maxY <= 64
    }
    var savedPosition: TextSession.Position {
        TextSession.Position(selection: selectedRange(), origin: enclosingScrollView?.contentView.bounds.origin ?? .zero,
                             followsLatest: selectedRange().length == 0 && isNearLatest)
    }
    func jumpToLatest(focus: Bool = true) {
        setSelectedRange(NSRange(location: (string as NSString).length, length: 0))
        scrollToEndOfDocument(nil)
        if focus { window?.makeFirstResponder(self) }
    }
    func jump(to region: DocumentRegion) {
        // A menu can remain open while streaming changes the rendered ranges.
        guard let current = regions.first(where: { $0.sectionID == region.sectionID && $0.kind == region.kind && $0.title == region.title && $0.source == region.source }),
              current.display.location <= (string as NSString).length,
              current.display.length <= (string as NSString).length - current.display.location else { return }
        setSelectedRange(NSRange(location: current.display.location, length: 0))
        scrollRangeToVisible(current.display); window?.makeFirstResponder(self)
    }
    func rotor(_ rotor: NSAccessibilityCustomRotor, resultFor searchParameters: NSAccessibilityCustomRotor.SearchParameters) -> NSAccessibilityCustomRotor.ItemResult? {
        let kind: DocumentRegion.Kind = rotor.type == .heading ? .heading : rotor.type == .table ? .table : .code
        let candidates = regions.filter { $0.kind == kind && (searchParameters.filterString.isEmpty || $0.title.localizedCaseInsensitiveContains(searchParameters.filterString)) }
        let location = searchParameters.currentItem.flatMap { $0.targetRange.location == NSNotFound ? nil : $0.targetRange.location }
        let next = searchParameters.searchDirection == .next
        let found = next ? candidates.first { location == nil || $0.display.location > location! } : candidates.last { location == nil || $0.display.location < location! }
        guard let found else { return nil }
        let result = NSAccessibilityCustomRotor.ItemResult(targetElement: self)
        result.targetRange = found.display; result.customLabel = kind == .code ? "Code, " + found.title : found.title
        return result
    }
}

struct Composer: NSViewRepresentable {
    @Environment(\.isEnabled) private var isEnabled
    @Binding var text: String
    var documentID: String
    var session: TextSession
    var fontSize: CGFloat = 16
    var canSend: Bool
    var focusRevision: Int
    var onHeight: (CGFloat) -> Void
    var onFocus: (Bool) -> Void
    var onFiles: ([URL]) -> Void
    var send: () -> Void
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    func makeNSView(context: Context) -> NSScrollView {
        if let existing = session.composers[documentID] {
            session.retainComposer(existing, id: documentID)
            (existing.documentView as? ComposerTextView)?.delegate = context.coordinator
            return existing
        }
        let scroll = NSScrollView(); scroll.hasVerticalScroller = true; scroll.drawsBackground = false
        let view = ComposerTextView(); view.delegate = context.coordinator
        view.isRichText = false; view.drawsBackground = false
        if #available(macOS 15, *) { view.writingToolsBehavior = .none }
        view.isAutomaticQuoteSubstitutionEnabled = false; view.isAutomaticDashSubstitutionEnabled = false
        view.allowsUndo = true; view.isVerticallyResizable = true; view.isHorizontallyResizable = false
        view.autoresizingMask = [.width]; view.textContainer?.widthTracksTextView = true
        view.textContainerInset = NSSize(width: 10, height: 10)
        view.setAccessibilityLabel("Message"); view.setAccessibilityHelp("Return sends. Shift Return inserts a new line. You can type a draft while a response runs.")
        view.setAccessibilityIdentifier("message-composer")
        view.registerForDraggedTypes([.fileURL])
        scroll.documentView = view; session.retainComposer(scroll, id: documentID)
        return scroll
    }
    func updateNSView(_ scroll: NSScrollView, context: Context) {
        context.coordinator.parent = self
        guard let view = scroll.documentView as? ComposerTextView else { return }
        view.isEditable = isEnabled
        session.composer = view
        if view.string != text && !view.hasMarkedText() {
            let selection = view.selectedRange()
            view.string = text
            view.setSelectedRange(NSRange(location: min(selection.location, (text as NSString).length), length: 0))
            // A programmatic replacement (Send, retry, or choosing a competing
            // draft) changes the base text. Old undo ranges no longer apply.
            // Ordinary typing and revisiting unchanged drafts keep their Undo.
            view.undoManager?.removeAllActions()
        }
        if view.font?.pointSize != fontSize { view.font = NSFont(name: "Inter-Regular", size: fontSize) ?? .systemFont(ofSize: fontSize) }
        view.textColor = .labelColor; view.insertionPointColor = .labelColor
        view.send = canSend ? send : nil; view.onFocus = onFocus; view.onFiles = onFiles
        view.onLayout = { [weak coordinator = context.coordinator] in coordinator?.measure(view) }
        if view.appliedFocusRevision != focusRevision {
            view.requestFocus(focusRevision)
        }
        context.coordinator.measure(view)
    }
    final class Coordinator: NSObject, NSTextViewDelegate {
        var parent: Composer
        var height: CGFloat = 0
        init(_ parent: Composer) { self.parent = parent }
        func textDidChange(_ notification: Notification) {
            if let view = notification.object as? ComposerTextView { parent.text = view.string; measure(view) }
        }
        func measure(_ view: NSTextView) {
            guard let manager = view.layoutManager, let container = view.textContainer else { return }
            manager.ensureLayout(for: container)
            let next = max(52, manager.usedRect(for: container).height + 20)
            guard abs(next - height) > 1 else { return }; height = next
            DispatchQueue.main.async { self.parent.onHeight(next) }
        }
    }
}
final class ComposerTextView: NSTextView {
    var appliedFocusRevision = -1
    private var pendingFocusRevision: Int?
    func requestFocus(_ revision: Int) {
        pendingFocusRevision = revision
        DispatchQueue.main.async { [weak self] in self?.applyPendingFocus() }
    }
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        // SwiftUI may request focus before mounting a newly created composer.
        // A failed early attempt must remain pending until there is a window.
        applyPendingFocus()
    }
    private func applyPendingFocus() {
        guard let revision = pendingFocusRevision, let window,
              window.makeFirstResponder(self) else { return }
        appliedFocusRevision = revision; pendingFocusRevision = nil
    }
    var send: (() -> Void)?
    var onFocus: (Bool) -> Void = { _ in }
    var onFiles: ([URL]) -> Void = { _ in }
    var onLayout: (() -> Void)?
    override func menu(for event: NSEvent) -> NSMenu? {
        let menu = NSMenu()
        for (title, action) in [("Undo", Selector(("undo:"))), ("Redo", Selector(("redo:"))), ("Cut", #selector(cut(_:))), ("Copy", #selector(copy(_:))), ("Paste", #selector(paste(_:))), ("Select All", #selector(selectAll(_:)))] {
            let item = NSMenuItem(title: title, action: action, keyEquivalent: ""); menu.addItem(item)
        }
        return menu
    }
    override func becomeFirstResponder() -> Bool { let result = super.becomeFirstResponder(); if result { DispatchQueue.main.async { self.onFocus(true) } }; return result }
    override func resignFirstResponder() -> Bool { let result = super.resignFirstResponder(); if result { DispatchQueue.main.async { self.onFocus(false) } }; return result }
    override func setFrameSize(_ newSize: NSSize) { super.setFrameSize(newSize); onLayout?() }
    override func keyDown(with event: NSEvent) {
        if (event.keyCode == 36 || event.keyCode == 76) && !event.modifierFlags.contains(.shift) && !hasMarkedText() { send?(); return }
        super.keyDown(with: event)
    }
    private func files(_ pasteboard: NSPasteboard) -> [URL] { pasteboard.readObjects(forClasses: [NSURL.self], options: [.urlReadingFileURLsOnly: true]) as? [URL] ?? [] }
    override func draggingEntered(_ sender: any NSDraggingInfo) -> NSDragOperation { files(sender.draggingPasteboard).isEmpty ? super.draggingEntered(sender) : .copy }
    override func performDragOperation(_ sender: any NSDraggingInfo) -> Bool {
        let urls = files(sender.draggingPasteboard); if urls.isEmpty { return super.performDragOperation(sender) }; onFiles(urls); return true
    }
    override func paste(_ sender: Any?) {
        let urls = files(.general); if !urls.isEmpty { onFiles(urls) } else { super.paste(sender) }
    }
}

/// A native segmented control also remains keyboard reachable when the system
/// limits ordinary Tab navigation to text fields.
struct AppearanceControl: NSViewRepresentable {
    @Binding var value: Appearance
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    func makeNSView(context: Context) -> AppearanceSegments {
        let view = AppearanceSegments(labels: Appearance.allCases.map(\.rawValue), trackingMode: .selectOne, target: context.coordinator, action: #selector(Coordinator.changed(_:)))
        view.setAccessibilityLabel("Appearance")
        for (index, help) in ["Follow this Mac’s system appearance", "Use light appearance", "Use dark appearance"].enumerated() {
            view.setToolTip(help, forSegment: index)
        }
        return view
    }
    func updateNSView(_ view: AppearanceSegments, context: Context) { context.coordinator.parent = self; view.selectedSegment = Appearance.allCases.firstIndex(of: value) ?? 0 }
    final class Coordinator: NSObject {
        var parent: AppearanceControl
        init(_ parent: AppearanceControl) { self.parent = parent }
        @objc func changed(_ sender: NSSegmentedControl) { guard Appearance.allCases.indices.contains(sender.selectedSegment) else { return }; parent.value = Appearance.allCases[sender.selectedSegment] }
    }
}
final class AppearanceSegments: NSSegmentedControl {
    override var acceptsFirstResponder: Bool { true }
}

enum SettingsCategory: String, CaseIterable { case general = "General", model = "Model", keyboard = "Keyboard" }

struct SettingsTabs: NSViewRepresentable {
    @Binding var value: SettingsCategory
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    func makeNSView(context: Context) -> SettingsSegments {
        let view = SettingsSegments(labels: SettingsCategory.allCases.map(\.rawValue), trackingMode: .selectOne, target: context.coordinator, action: #selector(Coordinator.changed(_:)))
        view.setAccessibilityLabel("Settings category")
        view.segmentDistribution = .fillEqually
        for (index, help) in ["Appearance and Home backups", "Memory, performance, and model files", "Keyboard shortcuts"].enumerated() {
            view.setToolTip(help, forSegment: index)
        }
        return view
    }
    func updateNSView(_ view: SettingsSegments, context: Context) {
        context.coordinator.parent = self
        view.selectedSegment = SettingsCategory.allCases.firstIndex(of: value) ?? 0
    }
    final class Coordinator: NSObject {
        var parent: SettingsTabs
        init(_ parent: SettingsTabs) { self.parent = parent }
        @objc func changed(_ sender: NSSegmentedControl) {
            guard SettingsCategory.allCases.indices.contains(sender.selectedSegment) else { return }
            parent.value = SettingsCategory.allCases[sender.selectedSegment]
        }
    }
}
final class SettingsSegments: NSSegmentedControl {
    override var acceptsFirstResponder: Bool { true }
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        if let window { DispatchQueue.main.async { window.makeFirstResponder(self) } }
    }
}
