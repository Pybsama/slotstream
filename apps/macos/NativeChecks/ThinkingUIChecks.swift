import AppKit
import SwiftUI
import CoreText
import Combine
import Vision
@testable import SevraMac
import SevraRuntime
import SevraPresentation

/// Offscreen check of the thinking controls in the production Mac views.
///
/// The real `ContentView` and `AppModel` run over the scripted engine in a
/// scratch Home. Controls are found by their rendered labels with on-device
/// text recognition and clicked with synthesized mouse events, so the check
/// exercises what a person sees and presses: the Think longer switch, Send,
/// the live clock, Answer now, the working-notes disclosure, the receipt line
/// and the typical-time hint, in light and dark appearance. Snapshots go to
/// `SEVRA_UI_OUT`. The window lives far outside every display, the process
/// never activates, and no user Home is touched. Run it with
/// `Tools/check_sevra_thinking_ui.sh`.
@main struct ThinkingUIChecks {
    @MainActor static func main() async throws {
        setvbuf(stdout, nil, _IOLBF, 0)
        _ = NSApplication.shared
        NSApp.setActivationPolicy(.prohibited)
        let env = ProcessInfo.processInfo.environment
        let out = URL(fileURLWithPath: env["SEVRA_UI_OUT"] ?? FileManager.default.temporaryDirectory.appendingPathComponent("sevra-ui-probe").path)
        try FileManager.default.createDirectory(at: out, withIntermediateDirectories: true)
        let fonts = URL(fileURLWithPath: env["SEVRA_FONTS"] ?? "apps/macos/Resources/Fonts")
        for name in ["Inter", "Poppins-Medium"] {
            CTFontManagerRegisterFontsForURL(fonts.appendingPathComponent(name + ".ttf") as CFURL, .process, nil)
        }
        let home = out.appendingPathComponent("home")
        try? FileManager.default.removeItem(at: home)
        let dbmd = URL(fileURLWithPath: env["SEVRA_DBMD"] ?? NSHomeDirectory() + "/.dbmd/bin/dbmd")
        let words = ["The", "user", "asks", "when", "a", "train", "arrives.", "Departure", "is", "9:40", "and", "the", "trip", "takes", "2", "hours", "35", "minutes.", "Adding", "the", "hours", "first", "gives", "11:40,", "then", "35", "minutes", "more", "gives", "12:15.", "I", "should", "also", "check", "whether", "the", "duration", "crosses", "noon,", "which", "it", "does,", "so", "the", "answer", "stays", "in", "the", "same", "day."]
        let trace = (0..<8).flatMap { _ in words }.joined(separator: " ")
        let engine = ScriptedInference(turns: [EngineTurn(text: "The train arrives at **12:15**. Two hours after 9:40 is 11:40, and 35 minutes more is 12:15.")],
                                       delayNanoseconds: 40_000_000, thinkingTraces: [trace])
        let runtime = try SevraRuntime(homeURL: home, dbmd: dbmd, inference: engine)
        let model = AppModel()
        model.runtime = runtime
        // The same forwarding the app's start() installs, so composer edits re-render the view.
        let forwarding = [model.composer.objectWillChange.sink { [weak model] _ in model?.objectWillChange.send() },
                          model.journalComposer.objectWillChange.sink { [weak model] _ in model?.objectWillChange.send() }]
        defer { withExtendedLifetime(forwarding) {} }
        await model.refresh()
        try await model.composer.open("home")
        try await model.journalComposer.open("journal")
        let poll = Task { while !Task.isCancelled { await model.refresh(); try? await Task.sleep(nanoseconds: 100_000_000) } }
        defer { poll.cancel() }

        let size = NSSize(width: 1120, height: 760)
        let window = NSWindow(contentRect: NSRect(origin: .zero, size: size), styleMask: [.borderless], backing: .buffered, defer: false)
        window.appearance = NSAppearance(named: .aqua)
        let host = NSHostingView(rootView: ContentView(model: model))
        window.contentView = host
        // SwiftUI controls only take clicks from a window the window server knows,
        // so the window is ordered in far outside every display. The process never
        // activates, owns no Dock icon and nothing is drawn on a screen.
        window.setFrameOrigin(NSPoint(x: -30000, y: -30000))
        window.orderFront(nil)
        if NSScreen.screens.contains(where: { $0.frame.intersects(window.frame) }) || window.occlusionState.contains(.visible) {
            print("FAIL: the check window would be visible on a display; stopping"); window.orderOut(nil); exit(1)
        }

        var failures = 0
        func check(_ condition: @autoclosure () -> Bool, _ message: String) {
            if condition() { print("PASS: \(message)") } else { failures += 1; print("FAIL: \(message)") }
        }
        func settle(_ seconds: Double = 12, _ what: String, _ predicate: () -> Bool) async throws {
            let deadline = Date().addingTimeInterval(seconds)
            while Date() < deadline {
                host.layoutSubtreeIfNeeded()
                if predicate() { return }
                try await Task.sleep(nanoseconds: 20_000_000)
            }
            throw NSError(domain: "ThinkingUIChecks", code: 1, userInfo: [NSLocalizedDescriptionKey: "Timed out waiting for " + what])
        }
        func pause(_ seconds: Double) async throws {
            let deadline = Date().addingTimeInterval(seconds)
            while Date() < deadline { host.layoutSubtreeIfNeeded(); try await Task.sleep(nanoseconds: 20_000_000) }
        }
        func render() -> NSBitmapImageRep {
            host.layoutSubtreeIfNeeded(); host.displayIfNeeded()
            let bounds = host.bounds
            let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(bounds.width) * 2, pixelsHigh: Int(bounds.height) * 2, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
            rep.size = bounds.size
            host.cacheDisplay(in: bounds, to: rep)
            return rep
        }
        func snapshot(_ name: String) throws -> NSBitmapImageRep {
            let rep = render()
            let url = out.appendingPathComponent(name + ".png")
            try rep.representation(using: .png, properties: [:])!.write(to: url)
            print("SNAPSHOT: \(url.path)")
            return rep
        }
        struct Line { let text: String; let candidate: VNRecognizedText; let box: CGRect }
        func read(_ rep: NSBitmapImageRep) throws -> [Line] {
            guard let image = rep.cgImage else { return [] }
            let request = VNRecognizeTextRequest()
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = false
            try VNImageRequestHandler(cgImage: image, options: [:]).perform([request])
            return (request.results ?? []).compactMap { observation in
                guard let top = observation.topCandidates(1).first else { return nil }
                return Line(text: top.string, candidate: top, box: observation.boundingBox)
            }
        }
        /// Window-coordinate rectangle of a visible label, or nil when it is not on screen.
        func labelRect(_ label: String, in lines: [Line]) -> NSRect? {
            for line in lines {
                guard let range = line.text.range(of: label, options: .caseInsensitive) else { continue }
                let box = ((try? line.candidate.boundingBox(for: range)) ?? nil)?.boundingBox ?? line.box
                return NSRect(x: box.minX * size.width, y: box.minY * size.height, width: box.width * size.width, height: box.height * size.height)
            }
            return nil
        }
        func locate(_ label: String, in lines: [Line]) -> NSPoint? {
            labelRect(label, in: lines).map { NSPoint(x: $0.midX, y: $0.midY) }
        }
        /// A macOS disclosure opens from its chevron, which sits just before the label.
        func clickDisclosure(_ label: String) async throws -> Bool {
            guard let rect = labelRect(label, in: try read(render())) else { print("  label not visible: \(label)"); return false }
            let point = NSPoint(x: rect.minX - 9, y: rect.midY)
            print("  click chevron of \(label) at (\(Int(point.x)), \(Int(point.y)))")
            try await click(point)
            return true
        }
        func visible(_ label: String, _ lines: [Line]) -> Bool { locate(label, in: lines) != nil }
        func click(_ point: NSPoint) async throws {
            let time = ProcessInfo.processInfo.systemUptime
            guard let down = NSEvent.mouseEvent(with: .leftMouseDown, location: point, modifierFlags: [], timestamp: time, windowNumber: window.windowNumber, context: nil, eventNumber: 1, clickCount: 1, pressure: 1),
                  let up = NSEvent.mouseEvent(with: .leftMouseUp, location: point, modifierFlags: [], timestamp: time + 0.06, windowNumber: window.windowNumber, context: nil, eventNumber: 2, clickCount: 1, pressure: 0) else { return }
            window.sendEvent(down)
            try await pause(0.06)
            window.sendEvent(up)
        }
        /// Renders, finds the label a person would click, and clicks it.
        func clickLabel(_ label: String) async throws -> Bool {
            guard let point = locate(label, in: try read(render())) else { print("  label not visible: \(label)"); return false }
            print("  click \(label) at (\(Int(point.x)), \(Int(point.y)))")
            try await click(point)
            return true
        }
        func textView(_ view: NSView) -> NSTextView? {
            if let text = view as? NSTextView, text.accessibilityIdentifier() == "message-composer" { return text }
            for child in view.subviews { if let found = textView(child) { return found } }
            return nil
        }

        // 1. Home: the switch is present and off, with the plain local hint.
        try await settle(12, "the Home screen") { model.snapshot != nil && model.selectedID == "home" && model.composer.ready }
        try await pause(0.8)
        var lines = try read(try snapshot("01-home-idle"))
        check(visible("Think longer", lines), "Home composer shows the Think longer switch")
        check(visible("Local on this Mac", lines), "Home hint stays plain while thinking is off")

        // 2. A new thread starts with thinking off.
        model.newThread()
        try await settle(12, "a new thread") { model.selectedID != "home" && model.thread != nil && model.composer.ready }
        try await pause(0.8)
        lines = try read(try snapshot("02-thread-thinking-off"))
        check(!model.thinkingEnabled && visible("Think longer", lines), "a new thread starts with Think longer off")

        // 3. Clicking the switch turns thinking on for this thread and changes the hint.
        let clicked1 = try await clickLabel("Think longer"); check(clicked1, "Think longer is clickable")
        try await settle(6, "thinking to turn on") { model.thinkingEnabled }
        try await pause(0.6)
        lines = try read(try snapshot("03-thread-thinking-on"))
        check(model.thread?.thinking == true, "the thread remembers the switch")
        check(visible("Thinks before answering", lines), "the hint explains the switch while it is on")

        // 4. Typing into the real composer and clicking Send starts a visible thought.
        guard let composer = textView(host) else { print("FAIL: composer text view not found"); exit(1) }
        window.makeFirstResponder(composer)
        composer.insertText("A train leaves at 9:40 and the trip takes 2 hours 35 minutes. When does it arrive?", replacementRange: composer.selectedRange())
        try await settle(6, "the draft to be sendable") { model.composer.canSend }
        try await pause(0.4)
        let clicked2 = try await clickLabel("Send"); check(clicked2, "Send is clickable")
        try await settle(20, "a live thought") { (model.liveThinking?.active ?? false) && (model.liveThinking?.text.count ?? 0) > 120 }
        try await pause(0.3)
        check(model.thread?.run?.status.hasPrefix("Thinking… ") == true, "run status shows Thinking with a clock: \(model.thread?.run?.status ?? "")")
        lines = try read(render())
        check(visible("Thinking", lines) && visible("Answer now", lines), "Thinking status and Answer now are visible while the thought runs")
        let clicked3 = try await clickDisclosure("Working notes"); check(clicked3, "Working notes can be opened while the thought runs")
        try await pause(0.6)
        lines = try read(try snapshot("04-thinking-live"))
        check(visible("Not saved or remembered", lines) && visible("Departure is 9:40", lines), "opened working notes show the streaming thought and its privacy line")

        // 5. Answer now ends the thought; the answer and the receipt appear.
        let clicked4 = try await clickLabel("Answer now"); check(clicked4, "Answer now is clickable")
        try await settle(30, "the run to finish") { model.thread?.run?.state.terminal == true }
        try await pause(0.8)
        let receipt = model.thread?.run?.thinking
        check(receipt?.ending == .answerNow, "the run records an Answer now receipt: \(receipt?.line ?? "none")")
        check(model.thread?.run?.state == .completed && (model.snapshot?.home.conversationMessages(for: model.thread!).last?.text.contains("12:15") ?? false), "the answer arrived after Answer now")
        lines = try read(try snapshot("05-answered-receipt"))
        check(visible("then answered when you asked", lines), "the receipt line is shown under the run")
        check(visible("Working notes", lines) && !visible("Answer now", lines), "working notes stay readable and Answer now is gone")
        check(visible("Recently about", lines), "the composer hint now quotes a typical thinking time")

        // 6. Dark appearance renders the same state.
        window.appearance = NSAppearance(named: .darkAqua)
        try await pause(0.8)
        _ = try snapshot("06-answered-receipt-dark")
        window.appearance = NSAppearance(named: .aqua)
        try await pause(0.4)

        // 7. The switch turns off again from the same control.
        let clicked5 = try await clickLabel("Think longer"); check(clicked5, "Think longer is clickable again")
        try await settle(6, "thinking to turn off") { !model.thinkingEnabled }
        try await pause(0.6)
        lines = try read(render())
        check(model.thread?.thinking != true && visible("Local on this Mac", lines), "clicking again turns thinking off and restores the plain hint (thinking=\(String(describing: model.thread?.thinking)))")

        window.orderOut(nil)
        window.contentView = nil
        print(failures == 0 ? "PASS: thinking controls render and respond in the production Mac views" : "FAIL: \(failures) checks failed")
        exit(failures == 0 ? 0 : 1)
    }
}
