import AppKit
import SwiftUI

/// Keep help on the actual AppKit hit target. SwiftUI's Menu/Label wrappers can
/// expose the label while dropping the help attached outside their frame.
struct NativeIconButton: NSViewRepresentable {
    var symbol: String
    var title: String
    var help: String
    var prominent = false
    var action: () -> Void
    @Environment(\.isEnabled) private var isEnabled

    func makeCoordinator() -> Coordinator { Coordinator(action) }
    func makeNSView(context: Context) -> NSButton {
        let button = NSButton(image: NSImage(), target: context.coordinator, action: #selector(Coordinator.invoke))
        button.bezelStyle = .inline; button.isBordered = false
        button.imagePosition = .imageOnly
        return button
    }
    func updateNSView(_ button: NSButton, context: Context) {
        context.coordinator.action = action
        button.image = NSImage(systemSymbolName: symbol, accessibilityDescription: nil)
        button.contentTintColor = prominent ? .labelColor : .secondaryLabelColor
        if button.toolTip != help { button.toolTip = help; button.setAccessibilityHelp(help) }
        button.setAccessibilityLabel(title); button.isEnabled = isEnabled
    }
    final class Coordinator: NSObject {
        var action: () -> Void
        init(_ action: @escaping () -> Void) { self.action = action }
        @objc func invoke() { action() }
    }
}

struct NativeMenuAction {
    var title: String
    var checked: Bool = false
    var enabled: Bool = true
    var action: () -> Void = {}
}

struct NativeIconMenu: NSViewRepresentable {
    var symbol: String
    var title: String
    var help: String
    var items: [NativeMenuAction]
    @Environment(\.isEnabled) private var isEnabled

    func makeCoordinator() -> Coordinator { Coordinator() }
    func makeNSView(context: Context) -> NSPopUpButton {
        let button = NSPopUpButton(frame: .zero, pullsDown: true)
        button.bezelStyle = .inline; button.isBordered = false
        button.imagePosition = .imageOnly
        (button.cell as? NSPopUpButtonCell)?.arrowPosition = .noArrow
        button.menu = NSMenu(); button.menu?.autoenablesItems = false
        button.menu?.delegate = context.coordinator
        button.menu?.addItem(withTitle: "", action: nil, keyEquivalent: "")
        return button
    }
    func updateNSView(_ button: NSPopUpButton, context: Context) {
        context.coordinator.items = items
        button.menu?.items.first?.image = NSImage(systemSymbolName: symbol, accessibilityDescription: nil)
        button.contentTintColor = .secondaryLabelColor
        if button.toolTip != help { button.toolTip = help; button.setAccessibilityHelp(help) }
        button.setAccessibilityLabel(title); button.isEnabled = isEnabled
    }
    final class Coordinator: NSObject, NSMenuDelegate {
        var items: [NativeMenuAction] = []
        func menuNeedsUpdate(_ menu: NSMenu) {
            // Resolve current actions at open, then keep that menu stable while
            // the conversation continues streaming behind it.
            while menu.items.count > 1 { menu.removeItem(at: 1) }
            for entry in items {
                let item = NSMenuItem(title: entry.title, action: #selector(invoke(_:)), keyEquivalent: "")
                item.target = self; item.isEnabled = entry.enabled
                item.state = entry.checked ? .on : .off
                item.representedObject = entry
                menu.addItem(item)
            }
        }
        @objc func invoke(_ sender: NSMenuItem) { (sender.representedObject as? NativeMenuAction)?.action() }
    }
}
