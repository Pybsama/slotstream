---
type: native-spec
meta-type: operational
id: 01m2gb6wethn2y9seydk6z1tsk
created: 2026-09-14T16:15:09.786189+00:00
updated: 2026-09-17T07:31:17.040332+00:00
summary: Sevra native product specification entry point
---
# Sevra native product specifications

Contract baseline: native-product-2026-09-14-r2. Status: implementation in progress.

Sevra shares Markdown/text specifications, schemas and declarative test fixtures across platforms. Each platform implements its own deeply integrated UI, application runtime, memory, tools, permissions and inference integration. Independently chosen upstream libraries remain allowed. Sharing a specification does not require sharing application code.

The Mac application is Swift-owned: SwiftUI and AppKit/TextKit compose the UI; a Swift runtime owns Home state, inference scheduling, tools, approvals and recovery; the existing Slotstream library runs in process through MLX/Metal; the official dbmd executable performs deterministic store mutations. Desktop requires no web server or account. Windows and Linux implementation are outside this work.

The initial product loop is a composer-led Home stream with explicit work threads, Shared/Thread-only/Incognito memory modes, needs-you decisions and serial local generation. Private Workspace Brief reads a user-attached folder through bounded typed tools, returns verifiable citations, and asks for exact-content approval before creating a Markdown artifact. It is a starter workflow, not the whole product. Since September 17 a thread can also read documents and scans, stage file and knowledge base changes for review, and publish reviewed skills and offline mini-apps.

Cloud development, paid sync and remote inference remain deferred until users ask. The existing Slotstream CLI, public Swift package and serving APIs remain independent. The existing sevra compatibility CLI is not replaced by the internal sevra-local test consumer.

[[records/design/sevra-spec/mac-platform]] records the baseline and current limits. [[records/design/sevra-spec/runtime-contract]] defines the runtime contract, including sources, reviewed changes, knowledge bases, skills and mini-apps. [[records/design/sevra-spec/ui-contract]] defines native UI requirements. [[records/design/sevra-spec/implementation-status]] keeps evidence and outstanding qualification visible.
