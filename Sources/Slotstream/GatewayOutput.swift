import Foundation

/// Gateway parts assembled on values, before Server writes any executable frame.
public final class GatewayOutput {
    public private(set) var error: String?
    public private(set) var hasToolCall = false
    public var acceptsToolCalls: Bool { choice != .disabled && !names.isEmpty }
    private var textOpen = false
    private let names: Set<String>
    private let choice: GatewayDialect.ToolChoice

    public init(tools: [ToolDefinition], choice: GatewayDialect.ToolChoice) {
        names = Set(tools.map(\.name))
        self.choice = choice
    }

    public func consume(_ events: [ToolStreamEvent]) -> [[String: Any]] {
        var parts: [[String: Any]] = []
        for event in events {
            guard error == nil else { break }
            switch event {
            case .text(let text), .malformed(let text):
                guard !text.isEmpty else { continue }
                if !textOpen {
                    parts.append(["type": "text-start", "id": "t0"])
                    textOpen = true
                }
                parts.append(["type": "text-delta", "id": "t0", "delta": text])
            case .toolInputStart(let id, let name):
                guard validate(name, into: &parts) else { break }
                if textOpen {
                    parts.append(["type": "text-end", "id": "t0"])
                    textOpen = false
                }
                parts.append(["type": "tool-input-start", "id": id, "toolName": name])
            case .toolInputDelta(let id, let delta):
                parts.append(["type": "tool-input-delta", "id": id, "delta": delta])
            case .toolInputEnd(let id):
                parts.append(["type": "tool-input-end", "id": id])
            case .toolCall(let call):
                guard validate(call.name, into: &parts) else { break }
                hasToolCall = true
                parts.append(["type": "tool-call", "toolCallId": call.id, "toolName": call.name,
                              "input": call.inputJSON])
            }
        }
        return parts
    }

    public func finish() -> [[String: Any]] {
        guard error == nil else { return [] }
        var parts: [[String: Any]] = []
        if textOpen {
            parts.append(["type": "text-end", "id": "t0"])
            textOpen = false
        }
        if !hasToolCall, choice == .required || choice.isNamedTool {
            fail("tool_choice_unsatisfied: the model produced no tool call for toolChoice \(choice.label)", into: &parts)
        }
        return parts
    }

    private func validate(_ name: String, into parts: inout [[String: Any]]) -> Bool {
        guard acceptsToolCalls, names.contains(name) else {
            fail("model called an undeclared or disabled tool: \(name)", into: &parts)
            return false
        }
        if case .tool(let required) = choice, name != required {
            fail("model did not satisfy the named tool_choice: \(required)", into: &parts)
            return false
        }
        return true
    }

    private func fail(_ message: String, into parts: inout [[String: Any]]) {
        error = message
        parts.append(["type": "error", "error": ["message": message]])
    }
}
