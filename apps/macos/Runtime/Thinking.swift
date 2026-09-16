import Foundation
import CryptoKit

/// Optional reasoning before an answer. Off unless a person turns it on for a
/// thread; never joined to a tool turn until that combination is measured.
/// Bounded by a token budget, and a person can end it early with Answer now.
/// The trace is working state: never persisted, never admitted to memory and
/// never treated as evidence. Only this receipt is recorded with the run.
public struct ThinkingRequest: Sendable, Equatable {
    public var level: String
    public var budgetTokens: Int
    public var replyTokens: Int
    public var seed: UInt64
    public init(level: String, budgetTokens: Int, replyTokens: Int, seed: UInt64) {
        self.level = level; self.budgetTokens = budgetTokens; self.replyTokens = replyTokens; self.seed = seed
    }
}

public enum ThinkingPolicy {
    /// The template's brief-thinking instruction. The model's own default is
    /// `xhigh`, which this app never leaves implicit.
    public static let level = "low"
    /// A ceiling, not a typical length: simple asks close after a few dozen
    /// tokens. At the engine's measured 10 to 16 decode tokens per second this
    /// is about a minute; the app's bounded 10 GB development plan observed
    /// about 4 tokens per second, so about three minutes at worst, with Answer
    /// now always available. A development operating bound, not an optimum.
    public static let budgetTokens = 768
    public static let replyTokens = 1024
    /// The model's documented budget closure. The thought block is closed and
    /// the answer begins from whatever was reasoned so far.
    public static let closure = "\n\nConsidering the limited time by the user, I have to give the solution based on the thinking directly now.\n"
    public static let closeTag = "</think>"
    public static func request(seed: UInt64) -> ThinkingRequest {
        ThinkingRequest(level: level, budgetTokens: budgetTokens, replyTokens: replyTokens, seed: seed)
    }
    /// A stable per-run sampling seed, so a retried run reasons the same way.
    public static func seed(_ text: String) -> UInt64 {
        let digest = Array(SHA256.hash(data: Data(text.utf8)))
        let value = digest.prefix(8).reduce(UInt64(0)) { ($0 << 8) | UInt64($1) }
        return value == 0 ? 1 : value
    }
    /// "0:42" for a live counter.
    public static func clock(_ seconds: Double) -> String {
        let total = max(0, Int(seconds.rounded(.down)))
        return String(format: "%d:%02d", total / 60, total % 60)
    }
    /// "42 s" or "1 min 5 s" for prose.
    public static func describe(_ seconds: Double) -> String {
        let total = max(0, Int(seconds.rounded()))
        if total < 60 { return "\(total) s" }
        return total % 60 == 0 ? "\(total / 60) min" : "\(total / 60) min \(total % 60) s"
    }
}

public struct ThinkingReceipt: Codable, Sendable, Equatable {
    public enum Ending: String, Codable, Sendable { case closed, budget, answerNow, stopped, offForTools }
    public var level: String
    public var budgetTokens: Int
    public var tokens: Int
    public var seconds: Double
    public var ending: Ending
    public init(level: String, budgetTokens: Int, tokens: Int, seconds: Double, ending: Ending) {
        self.level = level; self.budgetTokens = budgetTokens; self.tokens = tokens; self.seconds = seconds; self.ending = ending
    }
    public static let offForTools = ThinkingReceipt(level: ThinkingPolicy.level, budgetTokens: 0, tokens: 0, seconds: 0, ending: .offForTools)
    /// One plain line for the run status area.
    public var line: String {
        let time = ThinkingPolicy.describe(seconds)
        switch ending {
        case .closed: return "Thought for \(time) before answering."
        case .budget: return "Thought for \(time), up to its limit, then answered."
        case .answerNow: return "Thought for \(time), then answered when you asked."
        case .stopped: return "Thinking stopped after \(time)."
        case .offForTools: return "Thinking is off while a source is attached."
        }
    }
}

/// Answer now: a thread-safe signal read between thinking tokens, outside the
/// blocked inference executor. It ends the thought, never the run.
public final class ThinkingControl: @unchecked Sendable {
    private let lock = NSLock()
    private var requested = false
    public init() {}
    public var answerRequested: Bool { lock.lock(); defer { lock.unlock() }; return requested }
    public func requestAnswer() { lock.lock(); requested = true; lock.unlock() }
}

/// What a viewer may observe about the current thought: bounded text, elapsed
/// time and whether it is still running. Memory only.
public struct ThinkingObservation: Sendable, Equatable {
    public var threadID: String
    public var runID: String
    public var text: String
    public var seconds: Double
    public var active: Bool
    public init(threadID: String, runID: String, text: String, seconds: Double, active: Bool) {
        self.threadID = threadID; self.runID = runID; self.text = text; self.seconds = seconds; self.active = active
    }
}
