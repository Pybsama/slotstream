import AppKit
import CSevraSandbox
import Darwin
import Foundation
import ImageIO
import PDFKit
import Vision

// sevra-extract: the only place Sevra parses untrusted rich documents.
//
// The runtime starts one short-lived process per request and passes the file's
// bytes on stdin; this process never receives a path to the user's files. It
// applies a deny-by-default Seatbelt profile before it reads any input, so a
// parser bug cannot read other files, write outside its private temporary
// folder, open network connections or start programs. The runtime separately
// bounds time, memory and output and kills the process on any excess.
//
// Modes
//   document --kind pdf|rtf|doc|odt   text per page (PDF) or one section
//   dbmd --kind docx|xlsx|epub|html --dbmd PATH
//                                     the pinned dbmd extractor, inside this sandbox
//   render --kind pdf|image [--pages 0,4]
//                                     grayscale bitmaps for text recognition
//   ocr                               text from those bitmaps (separate profile)
//   store --dbmd PATH --root STORE [--write] -- VERB ARGS...
//                                     dbmd confined to one attached db.md store
//   selftest --profile strict|ocr --probe PATH --port N
//                                     reports which forbidden operations succeed
//
// Limits are development operating bounds recorded in
// db/records/design/sevra-spec/runtime-contract.md. They are safety ceilings,
// not measured optima; the runtime enforces its own copies as well.

enum Limit {
    static let input = 64 * 1024 * 1024
    static let pages = 2000
    static let text = 8 * 1024 * 1024
    static let renderPages = 20
    static let renderDimension = 1600
    static let imagePixels = 100_000_000
    static let dbmdOutput = 16 * 1024 * 1024
}

struct Failure: Error {
    var code: String
    var message: String
}

let stdoutLock = NSLock()
func emit(_ object: [String: Any]) {
    let data = (try? JSONSerialization.data(withJSONObject: object, options: [.sortedKeys])) ?? Data("{}".utf8)
    writeAll(1, data)
}
func writeAll(_ fd: Int32, _ data: Data) {
    stdoutLock.lock(); defer { stdoutLock.unlock() }
    data.withUnsafeBytes { raw in
        var offset = 0
        while offset < raw.count {
            let n = write(fd, raw.baseAddress!.advanced(by: offset), raw.count - offset)
            if n < 0 && errno == EINTR { continue }
            if n <= 0 { return }
            offset += n
        }
    }
}
func finish(_ failure: Failure) -> Never {
    emit(["error": ["code": failure.code, "message": failure.message]])
    exit(3)
}

func option(_ name: String) -> String? {
    let args = CommandLine.arguments
    guard let i = args.firstIndex(of: name), i + 1 < args.count else { return nil }
    return args[i + 1]
}

func readInput(limit: Int) throws -> Data {
    var data = Data()
    var buffer = [UInt8](repeating: 0, count: 65536)
    while true {
        let n = read(0, &buffer, buffer.count)
        if n < 0 && errno == EINTR { continue }
        guard n >= 0 else { throw Failure(code: "io", message: "Could not read the document.") }
        if n == 0 { break }
        guard data.count + n <= limit else { throw Failure(code: "too-large", message: "The document exceeds the reading limit.") }
        data.append(contentsOf: buffer.prefix(n))
    }
    return data
}

func limitResources(cpuSeconds: rlim_t) {
    var core = rlimit(rlim_cur: 0, rlim_max: 0)
    setrlimit(RLIMIT_CORE, &core)
    var cpu = rlimit(rlim_cur: cpuSeconds, rlim_max: cpuSeconds + 5)
    setrlimit(RLIMIT_CPU, &cpu)
    var files = rlimit(rlim_cur: 256 * 1024 * 1024, rlim_max: 256 * 1024 * 1024)
    setrlimit(RLIMIT_FSIZE, &files)
}

/// A private, canonical temporary folder: the only writable location. Seatbelt
/// matches physical paths, so /var is resolved to /private/var first.
func privateTemporaryFolder() throws -> String {
    var buffer = [CChar](repeating: 0, count: Int(PATH_MAX))
    guard confstr(_CS_DARWIN_USER_TEMP_DIR, &buffer, buffer.count) > 0,
          let base = realpath(String(cString: buffer), nil) else { throw Failure(code: "io", message: "No temporary folder is available.") }
    defer { free(base) }
    sweepStaleFolders(in: String(cString: base))
    var template = Array((String(cString: base) + "/sevra-extract.XXXXXXXX").utf8CString)
    guard let made = template.withUnsafeMutableBufferPointer({ mkdtemp($0.baseAddress!) }) else {
        throw Failure(code: "io", message: "Could not create a private temporary folder.")
    }
    return String(cString: made)
}

func entryName(_ entry: UnsafeMutablePointer<dirent>) -> String {
    withUnsafePointer(to: &entry.pointee.d_name) { $0.withMemoryRebound(to: CChar.self, capacity: Int(MAXNAMLEN) + 1) { String(cString: $0) } }
}

/// Removes work folders of helpers that were stopped before they could clean
/// up. A helper never runs for more than a few minutes, so anything older
/// than fifteen minutes is abandoned. Runs before the sandbox is entered.
func sweepStaleFolders(in base: String) {
    guard let dir = opendir(base) else { return }
    let cutoff = time(nil) - 15 * 60
    var stale: [String] = []
    while let entry = readdir(dir), stale.count < 64 {
        let name = entryName(entry)
        guard name.hasPrefix("sevra-extract.") else { continue }
        var info = stat()
        guard lstat(base + "/" + name, &info) == 0, info.st_mode & S_IFMT == S_IFDIR, info.st_uid == getuid(), info.st_mtimespec.tv_sec < cutoff else { continue }
        stale.append(base + "/" + name)
    }
    closedir(dir)
    stale.forEach { removeFolder($0) }
}

/// Removes a private work folder and everything in it, never following links.
func removeFolder(_ path: String, depth: Int = 0) {
    guard depth < 16 else { return }
    let fd = open(path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC)
    if fd >= 0 {
        var children: [(name: String, folder: Bool)] = []
        if let dir = fdopendir(fd) {
            while let entry = readdir(dir) {
                let name = entryName(entry)
                if name != "." && name != ".." { children.append((name, Int32(entry.pointee.d_type) == DT_DIR)) }
            }
            closedir(dir)
        } else { close(fd) }
        for child in children {
            if child.folder { removeFolder(path + "/" + child.name, depth: depth + 1) } else { unlink(path + "/" + child.name) }
        }
    }
    rmdir(path)
}

func quoted(_ path: String) -> String {
    "\"" + path.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\"") + "\""
}

enum Profile: String { case strict, ocr }

/// Deny by default. Reads are limited to the OS, this helper and the private
/// folder; writes to the private folder. No network, no other process except
/// an explicitly named extractor, no services beyond logging and fonts. The
/// OCR profile adds only what Vision's text recognizer needs to reach the GPU
/// and Neural Engine. It receives decoded pixels, never a document.
func profile(_ kind: Profile, temporary: String, extraExec: String? = nil, store: String? = nil, storeWritable: Bool = false) -> String {
    let executable = URL(fileURLWithPath: CommandLine.arguments[0]).resolvingSymlinksInPath().path
    let own = realpath(executable, nil).map { value -> String in defer { free(value) }; return String(cString: value) } ?? executable
    let ownFolder = (own as NSString).deletingLastPathComponent
    var ancestors: [String] = []
    var cursor = temporary
    while cursor != "/" && !cursor.isEmpty {
        cursor = (cursor as NSString).deletingLastPathComponent
        ancestors.append(cursor)
    }
    var rules = """
    (version 1)
    (deny default)
    (allow signal (target self))
    (allow sysctl-read)
    (allow file-read-metadata)
    (allow file-read* (subpath "/System") (subpath "/usr/lib") (subpath "/usr/share") (subpath "/Library/Fonts")
        (literal "/dev/urandom") (literal "/dev/random") (literal "/dev/null") (literal "/private/etc/localtime")
        (subpath "/private/var/db/timezone") (literal \(quoted(own))) (literal \(quoted(ownFolder))))
    (allow file-read* file-write* (subpath \(quoted(temporary))))
    (allow file-write-data (literal "/dev/null"))
    (allow mach-lookup (global-name "com.apple.logd") (global-name "com.apple.diagnosticd") (global-name "com.apple.fonts")
        (global-name "com.apple.system.opendirectoryd.libinfo"))
    (allow ipc-posix-shm-read-data ipc-posix-shm-read-metadata)

    """
    if let extraExec {
        // dbmd canonicalizes its working folder, which reads each folder above
        // it. Only the dbmd modes get that; the document parsers do not.
        rules += "(allow process-fork)\n(allow file-read* process-exec (literal \(quoted(extraExec))))\n"
        rules += "(allow file-read-data \(ancestors.map { "(literal \(quoted($0)))" }.joined(separator: " ")))\n"
    }
    if let store {
        // One attached db.md store, never its parents or siblings.
        rules += "(allow file-read* (subpath \(quoted(store))))\n"
        if storeWritable { rules += "(allow file-write* (subpath \(quoted(store))))\n" }
        var parent = store
        var parents: [String] = []
        while parent != "/" && !parent.isEmpty { parent = (parent as NSString).deletingLastPathComponent; parents.append(parent) }
        rules += "(allow file-read-data \(parents.map { "(literal \(quoted($0)))" }.joined(separator: " ")))\n"
    }
    if kind == .ocr {
        rules += """
        (allow iokit-get-properties)
        (allow iokit-open-user-client (iokit-user-client-class "AGXDeviceUserClient") (iokit-user-client-class "IOSurfaceRootUserClient")
            (iokit-user-client-class "IOSurfaceAcceleratorClient") (iokit-user-client-class "H1xANELoadBalancerDirectPathClient"))
        (allow mach-lookup (global-name "com.apple.MTLCompilerService") (global-name "com.apple.appleneuralengine"))

        """
    }
    return rules
}

func enterSandbox(_ kind: Profile, temporary: String, extraExec: String? = nil, store: String? = nil, storeWritable: Bool = false) throws {
    guard chdir(store ?? temporary) == 0 else { throw Failure(code: "io", message: "Could not enter the working folder.") }
    setenv("TMPDIR", temporary + "/", 1)
    setenv("HOME", temporary, 1)
    var message = [CChar](repeating: 0, count: 512)
    guard sevra_sandbox_apply(profile(kind, temporary: temporary, extraExec: extraExec, store: store, storeWritable: storeWritable), &message, UInt(message.count)) == 0 else {
        throw Failure(code: "sandbox", message: "The document reader could not isolate itself: " + String(cString: message))
    }
}

func normalized(_ text: String) -> String {
    text.replacingOccurrences(of: "\r\n", with: "\n").replacingOccurrences(of: "\r", with: "\n").replacingOccurrences(of: "\u{0}", with: "")
}

// MARK: document

func pdfDocument(_ data: Data) throws -> PDFDocument {
    guard let document = PDFDocument(data: data) else { throw Failure(code: "unreadable", message: "This PDF could not be read. It may be damaged.") }
    if document.isLocked && !document.unlock(withPassword: "") {
        throw Failure(code: "encrypted", message: "This PDF is password-protected. Open it in Preview and export an unlocked copy to read it here.")
    }
    guard document.pageCount <= Limit.pages else { throw Failure(code: "too-many-pages", message: "This PDF has more than \(Limit.pages) pages.") }
    return document
}

func extractDocument(kind: String, data: Data) throws -> [String: Any] {
    switch kind {
    case "pdf":
        let document = try pdfDocument(data)
        var pages: [String] = [], textless: [Int] = [], total = 0
        for index in 0..<document.pageCount {
            let text = autoreleasepool { normalized(document.page(at: index)?.string ?? "") }
            total += text.utf8.count
            guard total <= Limit.text else { throw Failure(code: "text-limit", message: "This PDF contains more text than Sevra reads from one file.") }
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { textless.append(index) }
            pages.append(text)
        }
        return ["format": "pdf", "pages": pages, "textless": textless]
    case "rtf", "doc", "odt":
        let type: NSAttributedString.DocumentType = kind == "rtf" ? .rtf : kind == "doc" ? .docFormat : .openDocument
        let text: String
        do { text = try NSAttributedString(data: data, options: [.documentType: type], documentAttributes: nil).string }
        catch { throw Failure(code: "unreadable", message: "This document could not be read. It may be damaged or use an unsupported format.") }
        guard text.utf8.count <= Limit.text else { throw Failure(code: "text-limit", message: "This document contains more text than Sevra reads from one file.") }
        return ["format": kind, "pages": [normalized(text)], "textless": []]
    default:
        throw Failure(code: "unsupported", message: "This document type is not supported.")
    }
}

// MARK: dbmd

func runDbmd(kind: String, data: Data, dbmd: String, temporary: String) throws -> [String: Any] {
    let input = temporary + "/input." + kind
    let fd = open(input, O_WRONLY | O_CREAT | O_EXCL | O_NOFOLLOW | O_CLOEXEC, 0o600)
    guard fd >= 0 else { throw Failure(code: "io", message: "Could not stage the document.") }
    let wrote = data.withUnsafeBytes { raw -> Bool in
        var offset = 0
        while offset < raw.count {
            let n = write(fd, raw.baseAddress!.advanced(by: offset), raw.count - offset)
            if n < 0 && errno == EINTR { continue }
            if n <= 0 { return false }
            offset += n
        }
        return true
    }
    close(fd)
    guard wrote else { throw Failure(code: "io", message: "Could not stage the document.") }
    var output: [Int32] = [0, 0]
    guard pipe(&output) == 0 else { throw Failure(code: "io", message: "Could not start the extractor.") }
    var actions: posix_spawn_file_actions_t?
    posix_spawn_file_actions_init(&actions)
    defer { posix_spawn_file_actions_destroy(&actions) }
    posix_spawn_file_actions_addopen(&actions, 0, "/dev/null", O_RDONLY, 0)
    posix_spawn_file_actions_adddup2(&actions, output[1], 1)
    posix_spawn_file_actions_adddup2(&actions, output[1], 2)
    posix_spawn_file_actions_addclose(&actions, output[0])
    let argv: [UnsafeMutablePointer<CChar>?] = [strdup(dbmd), strdup("extract"), strdup("--json"), strdup(input), nil]
    let env: [UnsafeMutablePointer<CChar>?] = [strdup("PATH=/usr/bin:/bin"), strdup("LANG=en_US.UTF-8"), strdup("HOME=" + temporary), strdup("TMPDIR=" + temporary + "/"), nil]
    defer { argv.forEach { free($0) }; env.forEach { free($0) } }
    var pid: pid_t = 0
    let spawned = posix_spawn(&pid, dbmd, &actions, nil, argv, env)
    close(output[1])
    guard spawned == 0 else { close(output[0]); throw Failure(code: "unavailable", message: "The document extractor could not start (\(spawned)).") }
    var result = Data(), buffer = [UInt8](repeating: 0, count: 65536), overflow = false
    while true {
        let n = read(output[0], &buffer, buffer.count)
        if n < 0 && errno == EINTR { continue }
        if n <= 0 { break }
        if result.count + n > Limit.dbmdOutput { overflow = true; kill(pid, SIGKILL); break }
        result.append(contentsOf: buffer.prefix(n))
    }
    close(output[0])
    var status: Int32 = 0
    while waitpid(pid, &status, 0) < 0 && errno == EINTR {}
    unlink(input)
    guard !overflow else { throw Failure(code: "text-limit", message: "This document contains more text than Sevra reads from one file.") }
    let object = try? JSONSerialization.jsonObject(with: result) as? [String: Any]
    if let error = object?["error"] as? [String: Any] {
        let code = error["code"] as? String ?? ""
        if code == "DOCUMENT_ENCRYPTED" { throw Failure(code: "encrypted", message: "This document is password-protected. Export an unlocked copy to read it here.") }
        throw Failure(code: "unreadable", message: "This document could not be read. It may be damaged or use an unsupported format.")
    }
    guard (status & 0x7f) == 0, (status >> 8) & 0xff == 0, let text = object?["text"] as? String else {
        throw Failure(code: "unreadable", message: "This document could not be read. It may be damaged or use an unsupported format.")
    }
    guard text.utf8.count <= Limit.text else { throw Failure(code: "text-limit", message: "This document contains more text than Sevra reads from one file.") }
    return ["format": kind, "pages": [normalized(text)], "textless": []]
}

// MARK: render

struct Frame {
    var width: Int
    var height: Int
    var pixels: Data
    var encoded: Data {
        var header = Data("SVRF".utf8)
        for value in [UInt32(width).bigEndian, UInt32(height).bigEndian] { withUnsafeBytes(of: value) { header.append(contentsOf: $0) } }
        return header + pixels
    }
}

func grayContext(width: Int, height: Int) throws -> CGContext {
    guard width > 0, height > 0, width <= Limit.renderDimension, height <= Limit.renderDimension,
          let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width,
                                  space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
        throw Failure(code: "unreadable", message: "This page could not be prepared for text recognition.")
    }
    context.setFillColor(gray: 1, alpha: 1)
    context.fill(CGRect(x: 0, y: 0, width: width, height: height))
    return context
}

func frame(from context: CGContext) -> Frame {
    let bytes = context.data!.assumingMemoryBound(to: UInt8.self)
    return Frame(width: context.width, height: context.height, pixels: Data(bytes: bytes, count: context.width * context.height))
}

func render(kind: String, data: Data, pages requested: [Int]) throws -> [Frame] {
    if kind == "pdf" {
        let document = try pdfDocument(data)
        let pages = Array((requested.isEmpty ? Array(0..<document.pageCount) : requested).filter { $0 >= 0 && $0 < document.pageCount }.prefix(Limit.renderPages))
        return try pages.map { index in
            try autoreleasepool {
                guard let page = document.page(at: index) else { throw Failure(code: "unreadable", message: "A page could not be read.") }
                let bounds = page.bounds(for: .mediaBox)
                guard bounds.width > 1, bounds.height > 1 else { throw Failure(code: "unreadable", message: "A page has no printable area.") }
                // About 200 dots per inch, bounded on the longest side.
                let scale = min(Double(Limit.renderDimension) / Double(max(bounds.width, bounds.height)), 200.0 / 72.0)
                let context = try grayContext(width: Int(bounds.width * scale), height: Int(bounds.height * scale))
                context.scaleBy(x: scale, y: scale)
                context.translateBy(x: -bounds.minX, y: -bounds.minY)
                page.draw(with: .mediaBox, to: context)
                return frame(from: context)
            }
        }
    }
    guard let source = CGImageSourceCreateWithData(data as CFData, [kCGImageSourceShouldCache: false] as CFDictionary),
          CGImageSourceGetCount(source) > 0,
          let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any],
          let width = properties[kCGImagePropertyPixelWidth] as? Int, let height = properties[kCGImagePropertyPixelHeight] as? Int else {
        throw Failure(code: "unreadable", message: "This image could not be read.")
    }
    // Refuse decompression bombs before decoding anything.
    guard width > 0, height > 0, width * height <= Limit.imagePixels else { throw Failure(code: "too-large", message: "This image has more pixels than Sevra reads.") }
    let options: [CFString: Any] = [kCGImageSourceCreateThumbnailFromImageAlways: true, kCGImageSourceCreateThumbnailWithTransform: true,
                                    kCGImageSourceThumbnailMaxPixelSize: Limit.renderDimension, kCGImageSourceShouldCacheImmediately: true]
    guard let image = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary) else { throw Failure(code: "unreadable", message: "This image could not be decoded.") }
    let context = try grayContext(width: image.width, height: image.height)
    context.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
    return [frame(from: context)]
}

// MARK: ocr

func decodeFrames(_ data: Data) throws -> [Frame] {
    var frames: [Frame] = [], offset = 0
    let bytes = [UInt8](data)
    func number(_ at: Int) -> Int { Int(bytes[at]) << 24 | Int(bytes[at + 1]) << 16 | Int(bytes[at + 2]) << 8 | Int(bytes[at + 3]) }
    while offset < bytes.count {
        guard offset + 12 <= bytes.count, bytes[offset..<offset + 4].elementsEqual("SVRF".utf8), frames.count < Limit.renderPages else { throw Failure(code: "invalid", message: "Invalid page image stream.") }
        let width = number(offset + 4), height = number(offset + 8)
        guard width > 0, height > 0, width <= Limit.renderDimension, height <= Limit.renderDimension, offset + 12 + width * height <= bytes.count else { throw Failure(code: "invalid", message: "Invalid page image size.") }
        frames.append(Frame(width: width, height: height, pixels: Data(bytes[(offset + 12)..<(offset + 12 + width * height)])))
        offset += 12 + width * height
    }
    return frames
}

func recognize(_ frame: Frame) throws -> String {
    guard let provider = CGDataProvider(data: frame.pixels as CFData),
          let image = CGImage(width: frame.width, height: frame.height, bitsPerComponent: 8, bitsPerPixel: 8, bytesPerRow: frame.width,
                              space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue),
                              provider: provider, decode: nil, shouldInterpolate: false, intent: .defaultIntent) else {
        throw Failure(code: "invalid", message: "Invalid page image.")
    }
    let request = VNRecognizeTextRequest()
    request.recognitionLevel = .accurate
    request.usesLanguageCorrection = true
    if #available(macOS 13.0, *) { request.automaticallyDetectsLanguage = true }
    try VNImageRequestHandler(cgImage: image, options: [:]).perform([request])
    // Reading order: top to bottom, then left to right within a line.
    let lines = (request.results ?? []).sorted {
        abs($0.boundingBox.midY - $1.boundingBox.midY) > min($0.boundingBox.height, $1.boundingBox.height) / 2
            ? $0.boundingBox.midY > $1.boundingBox.midY : $0.boundingBox.minX < $1.boundingBox.minX
    }
    return lines.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
}

/// Vision returns no text, rather than an error, when it cannot reach the
/// hardware it needs. A known phrase proves recognition works before any
/// empty result is reported as a blank page.
func canary() throws {
    let context = try grayContext(width: 480, height: 96)
    context.setFillColor(gray: 0, alpha: 1)
    let text = NSAttributedString(string: "Sevra reads 42", attributes: [.font: NSFont.systemFont(ofSize: 36), .foregroundColor: NSColor.black])
    let line = CTLineCreateWithAttributedString(text)
    context.textPosition = CGPoint(x: 16, y: 30)
    CTLineDraw(line, context)
    guard try recognize(frame(from: context)).contains("42") else {
        throw Failure(code: "ocr-unavailable", message: "Text recognition is unavailable on this Mac right now.")
    }
}

// MARK: selftest

func selftest(probe: String, port: UInt16) -> [String: Any] {
    var result: [String: Any] = [:]
    result["read_file"] = open(probe, O_RDONLY) >= 0
    result["list_folder"] = opendir((probe as NSString).deletingLastPathComponent) != nil
    result["write_file"] = open((probe as NSString).deletingLastPathComponent + "/written-by-helper", O_WRONLY | O_CREAT, 0o600) >= 0
    let socketFD = socket(AF_INET, SOCK_STREAM, 0)
    var address = sockaddr_in()
    address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    address.sin_family = sa_family_t(AF_INET)
    address.sin_port = port.bigEndian
    address.sin_addr.s_addr = inet_addr("127.0.0.1")
    result["connect_loopback"] = withUnsafePointer(to: &address) { $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { connect(socketFD, $0, socklen_t(MemoryLayout<sockaddr_in>.size)) } } == 0
    var pid: pid_t = 0
    let argv: [UnsafeMutablePointer<CChar>?] = [strdup("/bin/echo"), nil]
    result["spawn_process"] = posix_spawn(&pid, "/bin/echo", nil, nil, argv, nil) == 0
    result["window_server"] = sevra_can_look_up("com.apple.windowserver.active") == 1
    result["read_home"] = open(NSHomeDirectoryForUser(NSUserName()).map { $0 + "/.zshrc" } ?? "/Users", O_RDONLY) >= 0
    return result
}

// MARK: main

let mode = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : ""
limitResources(cpuSeconds: mode == "ocr" ? 150 : 90)
signal(SIGPIPE, SIG_IGN)
var temporary = ""
do {
    temporary = try privateTemporaryFolder()
    switch mode {
    case "document":
        try enterSandbox(.strict, temporary: temporary)
        let kind = option("--kind") ?? ""
        emit(try extractDocument(kind: kind, data: readInput(limit: Limit.input)))
    case "dbmd":
        guard let dbmd = option("--dbmd"), dbmd.hasPrefix("/"), let kind = option("--kind"), ["docx", "xlsx", "epub", "html"].contains(kind) else {
            throw Failure(code: "invalid", message: "Unsupported extractor request.")
        }
        let tool = realpath(dbmd, nil).map { value -> String in defer { free(value) }; return String(cString: value) } ?? dbmd
        try enterSandbox(.strict, temporary: temporary, extraExec: tool)
        emit(try runDbmd(kind: kind, data: readInput(limit: Limit.input), dbmd: tool, temporary: temporary))
    case "render":
        try enterSandbox(.strict, temporary: temporary)
        let pages = (option("--pages") ?? "").split(separator: ",").compactMap { Int($0) }
        for frame in try render(kind: option("--kind") ?? "", data: readInput(limit: Limit.input), pages: pages) { writeAll(1, frame.encoded) }
    case "ocr":
        try enterSandbox(.ocr, temporary: temporary)
        let frames = try decodeFrames(readInput(limit: Limit.renderPages * (Limit.renderDimension * Limit.renderDimension + 12)))
        try canary()
        emit(["pages": try frames.map { frame in try autoreleasepool { try recognize(frame) } }])
    case "store":
        // dbmd for one attached knowledge base. The body of a new or changed
        // record arrives on stdin and replaces the @BODY argument.
        guard let dbmd = option("--dbmd"), dbmd.hasPrefix("/"), let requested = option("--root"), requested.hasPrefix("/"),
              let separator = CommandLine.arguments.firstIndex(of: "--") else { throw Failure(code: "invalid", message: "Unsupported knowledge request.") }
        let canonical: (String) -> String? = { path in realpath(path, nil).map { value -> String in defer { free(value) }; return String(cString: value) } }
        guard let tool = canonical(dbmd), let root = canonical(requested), root == requested else {
            throw Failure(code: "invalid", message: "The knowledge base path is not canonical.")
        }
        var info = stat()
        guard stat(root, &info) == 0, info.st_mode & S_IFMT == S_IFDIR, lstat(root + "/DB.md", &info) == 0, info.st_mode & S_IFMT == S_IFREG else {
            throw Failure(code: "invalid", message: "The attached folder is not a db.md store.")
        }
        var arguments = Array(CommandLine.arguments[(separator + 1)...])
        let allowed: Set<String> = ["search", "query", "show", "schema", "write", "body", "stats", "index"]
        guard let verb = arguments.first, allowed.contains(verb) else { throw Failure(code: "invalid", message: "This knowledge operation is not available.") }
        let writes = CommandLine.arguments.contains("--write")
        guard writes || !["write", "body", "index"].contains(verb) else { throw Failure(code: "invalid", message: "Changes are not allowed for this knowledge base.") }
        if let index = arguments.firstIndex(of: "@BODY") {
            let body = try readInput(limit: 1024 * 1024)
            let path = temporary + "/body.md"
            let fd = open(path, O_WRONLY | O_CREAT | O_EXCL | O_NOFOLLOW | O_CLOEXEC, 0o600)
            guard fd >= 0 else { throw Failure(code: "io", message: "Could not stage the record text.") }
            body.withUnsafeBytes { raw in _ = write(fd, raw.baseAddress!, raw.count) }
            close(fd)
            arguments[index] = path
        }
        try enterSandbox(.strict, temporary: temporary, extraExec: tool, store: root, storeWritable: writes)
        let argumentList: [String] = [tool] + arguments
        let environment: [String] = ["PATH=/usr/bin:/bin", "LANG=en_US.UTF-8", "HOME=\(temporary)", "TMPDIR=\(temporary)/"]
        let argv: [UnsafeMutablePointer<CChar>?] = argumentList.map { strdup($0) } + [nil]
        let env: [UnsafeMutablePointer<CChar>?] = environment.map { strdup($0) } + [nil]
        defer { argv.forEach { free($0) }; env.forEach { free($0) } }
        // The tool inherits this process's output and sandbox. The staged
        // record text is deleted as soon as the tool exits.
        var child: pid_t = 0
        guard posix_spawn(&child, tool, nil, nil, argv, env) == 0 else { throw Failure(code: "unavailable", message: "The knowledge tool could not start.") }
        var status: Int32 = 0
        while waitpid(child, &status, 0) < 0 && errno == EINTR {}
        removeFolder(temporary)
        exit((status & 0x7f) == 0 ? (status >> 8) & 0xff : 70)
    case "selftest":
        let kind = Profile(rawValue: option("--profile") ?? "") ?? .strict
        let probe = option("--probe") ?? "/etc/hosts"
        try enterSandbox(kind, temporary: temporary)
        emit(selftest(probe: probe, port: UInt16(option("--port") ?? "") ?? 9))
    default:
        throw Failure(code: "invalid", message: "Unknown mode.")
    }
    removeFolder(temporary)
    exit(0)
} catch let failure as Failure {
    if !temporary.isEmpty { removeFolder(temporary) }
    finish(failure)
} catch {
    if !temporary.isEmpty { removeFolder(temporary) }
    finish(Failure(code: "unreadable", message: "This document could not be read."))
}
