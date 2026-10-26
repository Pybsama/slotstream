import AppKit
import SwiftUI
import SlotstreamRuntime

@MainActor final class DataBrowserModel: ObservableObject {
    @Published var section = "records"
    @Published var search = ""
    @Published var type = ""
    @Published var filter = ""
    @Published var sort = "updated"
    @Published var page: HomeDataResult?
    @Published var detail: HomeDataResult?
    @Published var selected: String?
    @Published var error: String?
    @Published var loading = false
    @Published var loadingDetail = false
    @Published var offset = 0
    @Published var types: [String] = []
    private var generation = 0
    private var detailGeneration = 0
    let runtime: SlotstreamRuntime?
    init(runtime: SlotstreamRuntime?) { self.runtime = runtime }
    var queryID: String { [section, search, type, filter, sort].joined(separator: "\u{0}") }
    func refresh(offset: Int = 0) async {
        generation += 1; let ticket = generation
        loading = true; error = nil
        defer { if ticket == generation { loading = false } }
        do {
            guard let runtime else { throw AppRuntimeError.unavailable("Open this Home before browsing its data.") }
            let query = HomeDataRequest(operation: section == "schemas" ? "schema" : section == "log" ? "log" : "list",
                section: HomeDataSection(rawValue: section) ?? .records, type: type.isEmpty ? nil : type,
                search: search, filters: filter.isEmpty ? [] : [filter], sort: sort, offset: offset,
                revision: offset == 0 ? nil : page?.revision)
            let result = try await runtime.data(query)
            guard ticket == generation else { return }
            page = result; self.offset = offset
            if type.isEmpty { types = result.types }
            if let selected, !result.records.contains(where: { $0.path == selected }) { clearDetail() }
        } catch {
            guard ticket == generation else { return }
            self.error = error.localizedDescription; page = nil; clearDetail()
        }
    }
    func select(_ path: String) async {
        detailGeneration += 1; let ticket = detailGeneration
        selected = path; detail = nil; loadingDetail = true; error = nil
        defer { if ticket == detailGeneration { loadingDetail = false } }
        do {
            guard let runtime else { return }
            let normalized = path.hasSuffix(".md") ? path : path + ".md"
            let value = try await runtime.data(HomeDataRequest(operation: "show", path: normalized))
            guard ticket == detailGeneration else { return }
            detail = value
        } catch { if ticket == detailGeneration { self.error = error.localizedDescription } }
    }
    func clearDetail() { detailGeneration += 1; selected = nil; detail = nil; loadingDetail = false }
}

struct DataBrowser: View {
    @ObservedObject var model: AppModel
    @StateObject private var browser: DataBrowserModel
    @State private var integrations = false
    init(model: AppModel, browser: DataBrowserModel? = nil) {
        self.model = model
        _browser = StateObject(wrappedValue: browser ?? DataBrowserModel(runtime: model.runtime))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header.padding(20)
            Divider()
            controls.padding(.horizontal, 20).padding(.vertical, 12)
            if let error = browser.error {
                HStack(alignment: .top) {
                    Image(systemName: "exclamationmark.triangle")
                    Text(error).textSelection(.enabled)
                    Spacer()
                    Button("Refresh") { Task { await browser.refresh() } }
                }.font(.callout).padding(12).background(Color.orange.opacity(0.08))
            }
            Divider()
            if ["schemas", "log"].contains(browser.section) {
                ScrollView {
                    if let json = browser.page?.json {
                        if browser.section == "schemas" { SchemaBrowser(json: json) }
                        else { DatabaseLogBrowser(json: json) }
                    } else if browser.loading { ProgressView().padding(24) }
                }
            } else {
                GeometryReader { geometry in
                    if geometry.size.width >= 700 {
                        HSplitView {
                            recordList.frame(minWidth: 220, idealWidth: 280, maxWidth: 380)
                            recordDetail.frame(minWidth: 330)
                        }
                    } else if browser.selected != nil {
                        VStack(alignment: .leading, spacing: 0) {
                            Button { browser.clearDetail() } label: { Label("Back to results", systemImage: "chevron.left") }.padding(12)
                            recordDetail
                        }
                    } else { recordList }
                }
            }
        }
        .task(id: browser.queryID) {
            if !browser.search.isEmpty || !browser.filter.isEmpty { try? await Task.sleep(nanoseconds: 250_000_000) }
            guard !Task.isCancelled else { return }
            await browser.refresh()
        }
        .sheet(isPresented: $integrations) { HomeConnections(home: model.homeURL) }
        .background(Color(nsColor: .windowBackgroundColor))
        .accessibilityIdentifier("home-data-browser")
    }
    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Data").font(.title2.bold())
                Spacer()
                if browser.loading { ProgressView().controlSize(.small) }
                Button { Task { await browser.refresh() } } label: { Image(systemName: "arrow.clockwise") }.help("Refresh saved data").accessibilityLabel("Refresh data")
                Button("Connections…") { integrations = true }.accessibilityIdentifier("data-connections")
            }
            Text(model.homeURL.lastPathComponent).font(.headline)
            Text(model.homeURL.path).font(.caption).foregroundStyle(.secondary).textSelection(.enabled)
            HStack {
                Text("Inspect saved data in this Home.").font(.callout).foregroundStyle(.secondary)
                Spacer()
                Button("Memory") { model.panel = "Knowledge" }.help("Manage what Slotstream may remember")
                Button("Journal") { model.panel = "Journal" }
            }
        }
    }
    private var controls: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Picker("Collection", selection: $browser.section) {
                    ForEach(HomeDataSection.allCases, id: \.self) { Text($0.title).tag($0.rawValue) }
                    Text("Schemas").tag("schemas")
                    Text("Database log").tag("log")
                }.frame(maxWidth: 240).accessibilityIdentifier("data-section")
                Spacer()
                if let page = browser.page, !["schemas", "log"].contains(browser.section) { Text("\(page.total) records").font(.caption).foregroundStyle(.secondary) }
            }.onChange(of: browser.section) { _, _ in browser.type = ""; browser.search = ""; browser.filter = ""; browser.clearDetail() }
            if !["schemas", "log"].contains(browser.section) {
                TextField("Search this collection", text: $browser.search).textFieldStyle(.roundedBorder).accessibilityIdentifier("data-search")
                HStack {
                    Picker("Type", selection: $browser.type) {
                        Text("All types").tag("")
                        ForEach(browser.types, id: \.self) { Text($0).tag($0) }
                    }.help("Filter by an exact record type")
                    TextField("Field=value", text: $browser.filter).textFieldStyle(.roundedBorder).help("Filter by a structured field, for example status=open")
                    Picker("Sort", selection: $browser.sort) { Text("Updated").tag("updated"); Text("Title").tag("title"); Text("Path").tag("path") }.frame(width: 155)
                }
            }
            if browser.section == "advanced" {
                Text("App state and unsent drafts are read-only here. Use the conversation, Memory or Journal controls to change them.").font(.caption).foregroundStyle(.secondary)
            }
        }
    }
    private var recordList: some View {
        VStack(spacing: 0) {
            if let page = browser.page, !page.records.isEmpty {
                List(selection: Binding(get: { browser.selected }, set: { path in if let path { Task { await browser.select(path) } } })) {
                    ForEach(page.records) { record in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(record.title).font(.body.weight(.medium)).lineLimit(2)
                            if !record.summary.isEmpty && record.summary != record.title { Text(record.summary).font(.callout).foregroundStyle(.secondary).lineLimit(2) }
                            Text(record.type).font(.caption).foregroundStyle(.secondary)
                        }.padding(.vertical, 5).tag(record.path)
                    }
                }.listStyle(.inset).accessibilityLabel("Data records")
                HStack {
                    Button("Previous") { Task { await browser.refresh(offset: max(0, browser.offset - 50)) } }.disabled(browser.offset == 0 || browser.loading)
                    Spacer()
                    Text("\(browser.offset + 1)–\(browser.offset + page.records.count) of \(page.total)").font(.caption).monospacedDigit()
                    Spacer()
                    Button("Next") { if let next = page.nextOffset { Task { await browser.refresh(offset: next) } } }.disabled(page.nextOffset == nil || browser.loading)
                }.padding(12)
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "tray").font(.largeTitle).foregroundStyle(.secondary)
                    Text(browser.loading ? "Loading saved data…" : browser.search.isEmpty && browser.filter.isEmpty ? "No records in this collection" : "No matching records").font(.headline)
                    Text("Choose another collection or adjust the filters.").font(.callout).foregroundStyle(.secondary)
                }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
            }
        }
    }
    @ViewBuilder private var recordDetail: some View {
        if browser.loadingDetail { ProgressView("Opening record…").frame(maxWidth: .infinity, maxHeight: .infinity) }
        else if let record = browser.detail?.records.first {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text(record.title).font(.title2.bold()).textSelection(.enabled)
                    Text(record.path).font(.caption.monospaced()).foregroundStyle(.secondary).textSelection(.enabled)
                    if record.path.hasPrefix("records/threads/") {
                        Button("Open conversation") { model.navigate(URL(fileURLWithPath: record.path).deletingPathExtension().lastPathComponent) }
                    }
                    DisclosureGroup("Fields") {
                        Grid(alignment: .topLeading, horizontalSpacing: 16, verticalSpacing: 8) {
                            ForEach(record.fields.keys.sorted(), id: \.self) { key in
                                GridRow { Text(key).foregroundStyle(.secondary); Text(record.fields[key] ?? "").textSelection(.enabled).frame(maxWidth: .infinity, alignment: .leading) }
                            }
                        }.font(.callout).padding(.top, 8)
                    }
                    Divider()
                    Text("Content").font(.headline)
                    Text(pretty(record.body ?? "")).font(.system(.body, design: record.type.hasPrefix("sevra-") ? .monospaced : .default)).textSelection(.enabled).frame(maxWidth: .infinity, alignment: .leading)
                    links("Links", paths: record.links)
                    links("Linked from", paths: browser.detail?.backlinks ?? [])
                    if let hash = record.sha256 { DisclosureGroup("File fingerprint") { Text(hash).font(.caption.monospaced()).textSelection(.enabled) } }
                    HStack {
                        Button("Copy path") { NSPasteboard.general.clearContents(); NSPasteboard.general.setString(record.path, forType: .string) }
                        Button("Reveal in Finder") { NSWorkspace.shared.activateFileViewerSelecting([model.homeURL.appendingPathComponent("db/" + record.path)]) }
                    }
                }.padding(20)
            }.accessibilityIdentifier("data-record-detail")
        } else {
            VStack(spacing: 10) { Image(systemName: "doc.text.magnifyingglass").font(.largeTitle).foregroundStyle(.secondary); Text("Select a record").font(.headline); Text("Inspect its content, fields and connections.").foregroundStyle(.secondary) }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    @ViewBuilder private func links(_ title: String, paths: [String]) -> some View {
        if !paths.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text(title).font(.headline)
                ForEach(Array(Set(paths)).sorted(), id: \.self) { path in Button(path) { Task { await browser.select(path) } }.buttonStyle(.link).multilineTextAlignment(.leading) }
            }
        }
    }
    private func pretty(_ text: String) -> String {
        guard let value = try? JSONSerialization.jsonObject(with: Data(text.utf8), options: [.fragmentsAllowed]),
              let bytes = try? JSONSerialization.data(withJSONObject: value, options: [.prettyPrinted, .sortedKeys, .fragmentsAllowed, .withoutEscapingSlashes]) else { return text }
        return String(decoding: bytes, as: UTF8.self)
    }
}

struct DatabaseLogBrowser: View {
    let json: String
    private var entries: [[String: Any]] { (try? JSONSerialization.jsonObject(with: Data(json.utf8))) as? [[String: Any]] ?? [] }
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Database log").font(.title2.bold())
            Text("Recent maintenance entries for this Home. Conversation events are in Activity.").foregroundStyle(.secondary)
            if entries.isEmpty { Text("No maintenance entries yet.") }
            ForEach(Array(entries.enumerated()), id: \.offset) { _, entry in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(entry["kind"] as? String ?? "Entry").font(.headline)
                        Spacer()
                        Text(entry["timestamp"] as? String ?? "").font(.caption).foregroundStyle(.secondary)
                    }
                    Text(entry["object"] as? String ?? "").font(.caption.monospaced()).foregroundStyle(.secondary)
                    Text(entry["note"] as? String ?? "").textSelection(.enabled)
                }
                Divider()
            }
        }.padding(20).frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SchemaBrowser: View {
    let json: String
    private var schemas: [String: Any] { ((try? JSONSerialization.jsonObject(with: Data(json.utf8))) as? [String: Any])?["types"] as? [String: Any] ?? [:] }
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Declared record types").font(.title2.bold())
            Text("Schemas describe fields and validation rules. Records may also use types without a declared schema.").foregroundStyle(.secondary)
            if schemas.isEmpty { Text("This Home has no declared type schemas.") }
            ForEach(schemas.keys.sorted(), id: \.self) { name in
                VStack(alignment: .leading, spacing: 10) {
                    Text(name).font(.headline)
                    let fields = (schemas[name] as? [String: Any])?["fields"] as? [[String: Any]] ?? []
                    if fields.isEmpty { Text("No required fields declared.").font(.callout).foregroundStyle(.secondary) }
                    ForEach(Array(fields.enumerated()), id: \.offset) { _, field in
                        HStack(alignment: .top) {
                            Text(field["name"] as? String ?? "").font(.system(.body, design: .monospaced))
                            Spacer()
                            Text((field["enum"] as? [String])?.joined(separator: ", ") ?? field["shape"] as? String ?? "value").foregroundStyle(.secondary)
                            if field["required"] as? Bool == true { Text("Required").font(.caption) }
                        }
                    }
                }
                Divider()
            }
        }.padding(20).frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct HomeConnections: View {
    let home: URL
    @Environment(\.dismiss) private var dismiss
    @State private var message: String?
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack { Text("Connect to this Home").font(.title2.bold()); Spacer(); Button("Done") { dismiss() } }
            Text(home.path).font(.caption).foregroundStyle(.secondary).textSelection(.enabled)
            Text("Command line").font(.headline)
            Text("Browse saved data from any folder. Ask uses the model and review controls in the open app.")
            Text("slotstream-home data list\nslotstream-home ask \"What should I work on next?\"").font(.system(.callout, design: .monospaced)).textSelection(.enabled)
            Button("Install command line tool") { action { try HomeIntegration.installCLI().path } }
            Text("Installs in ~/.local/bin. If your shell cannot find it, add that directory to PATH.").font(.caption).foregroundStyle(.secondary)
            Divider()
            Text("Agent skill").font(.headline)
            Text("Teach an agent how to choose a Home, query records and use the app's review flow.")
            HStack {
                Button("Install for Codex") { action { try HomeIntegration.installSkill(for: "codex").path } }
                Button("Install for Claude Code") { action { try HomeIntegration.installSkill(for: "claude").path } }
            }
            Divider()
            Text("MCP server").font(.headline)
            Text("Connect an MCP client to this Home. The server reads saved data and does not load a model. Each connection stays bound to this Home.")
            Text("slotstream-home serve --home \"\(home.path)\"").font(.system(.callout, design: .monospaced)).textSelection(.enabled)
            Button("Copy MCP configuration") {
                action {
                    let text = try HomeIntegration.mcpConfiguration(home: home, executable: Bundle.main.bundleURL.appendingPathComponent("Contents/Helpers/slotstream-home"))
                    NSPasteboard.general.clearContents(); NSPasteboard.general.setString(text, forType: .string)
                    return "Copied configuration for this Home."
                }
            }
            Text("Read-only by default. Add --allow-ask to expose AI submissions and run controls; proposed changes still require review in the app.").font(.caption).foregroundStyle(.secondary)
            if let message { Text(message).font(.callout).textSelection(.enabled).accessibilityLabel(message) }
        }.padding(24).frame(width: 560).background(Color(nsColor: .windowBackgroundColor))
    }
    private func action(_ operation: () throws -> String) {
        do { message = try operation() } catch { message = error.localizedDescription }
    }
}
