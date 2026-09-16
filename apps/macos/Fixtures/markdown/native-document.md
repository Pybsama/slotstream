# A good place to think

Sevra keeps the conversation **readable**, the next action clear, and your files local. This is a UI test document, not a model response or product claim.

## A short plan

1. Read the notes and check the evidence.
2. Make the proposed change easy to inspect.
   - Preserve the original files.
   - Ask before saving the reviewed result.
3. Return to the conversation without losing your place.

> Good tools leave you in control. The interface should make that visible.

## A native table

| Task | Owner | Status |
| :--- | :--- | :--- |
| Keyboard navigation | Maya | Ready to check |
| Appearance review | Leo | Light and Dark |
| Source inspection | You | Review first |

## Code you can copy

The source stays exact, including indentation, Unicode and trailing newlines.

```swift
struct Briefing {
    let title = "Café, 中文, שלום 👩🏽‍💻"
    let localOnly = true

    func describe() -> String {
        return "Ready to review"
    }
}
```

A deliberate [link to Apple](https://developer.apple.com/design/human-interface-guidelines/) opens a destination review first. No page or image loads just because it appears in a reply.

![A remote image, shown as a link](https://example.com/no-background-download.png)

## Evidence and literal content

An unknown citation [S99] stays ordinary text. `file:///private` and [unsafe schemes](javascript:alert) do not grant access.

<script>Raw HTML stays literal. It does not execute.</script>

### Still yours

Use **Copy Markdown**, **Export Markdown**, native Find, or normal text selection. An unfinished streaming span like **this remains readable.
