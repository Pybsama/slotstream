#!/usr/bin/env python3
"""Exercise Launch.request's actual body against tiny local HTTP responses."""
import json
from pathlib import Path
import subprocess
import tempfile
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import unittest

ROOT = Path(__file__).resolve().parent.parent


class Peer(BaseHTTPRequestHandler):
    def log_message(self, *args):
        pass

    def do_GET(self):
        if self.path == "/redirect":
            self.send_response(302)
            self.send_header("Location", "/fast")
            self.send_header("Content-Length", "0")
            self.end_headers()
            return
        if self.path == "/idle":
            time.sleep(2)
        body = b"response"
        self.send_response(200)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        try:
            for byte in body:
                self.wfile.write(bytes([byte]))
                self.wfile.flush()
                if self.path == "/slow":
                    time.sleep(0.3)
        except (BrokenPipeError, ConnectionResetError):
            pass


class RequestDeadlines(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temporary = tempfile.TemporaryDirectory(prefix="slotstream-launch-request-")
        cls.addClassCleanup(cls.temporary.cleanup)
        cls.directory = Path(cls.temporary.name)
        source = (ROOT / "Sources/slotstream-cli/LaunchCommand.swift").read_text()
        start = source.index("    static func request(")
        end = source.index("    static func compareVersions(", start)
        # The method body stays byte-identical to the production CLI. Neither
        # ArgumentParser nor a running model is needed for this HTTP boundary.
        method = source[start:end]
        harness = "import Foundation\nstruct Launch {\n" + method + "}\n" + r'''
let start = Date()
let answer = Launch.request("GET", CommandLine.arguments[1],
                            timeout: Double(CommandLine.arguments[2])!, direct: true)
var report: [String: Any] = ["elapsed": Date().timeIntervalSince(start),
                           "status": NSNull(), "body": ""]
if let answer {
    report["status"] = answer.status
    report["body"] = String(decoding: answer.body, as: UTF8.self)
}
let data = try JSONSerialization.data(withJSONObject: report, options: [.sortedKeys])
print(String(decoding: data, as: UTF8.self))
'''
        swift = cls.directory / "main.swift"
        swift.write_text(harness)
        cls.binary = cls.directory / "request"
        subprocess.run(["swiftc", str(swift), "-o", str(cls.binary)], check=True)
        cls.server = ThreadingHTTPServer(("127.0.0.1", 0), Peer)
        cls.server.daemon_threads = True
        cls.thread = threading.Thread(target=cls.server.serve_forever, daemon=True)
        cls.thread.start()
        cls.addClassCleanup(cls.server.server_close)
        cls.addClassCleanup(cls.server.shutdown)

    def request(self, path):
        url = f"http://127.0.0.1:{self.server.server_port}{path}"
        result = subprocess.run([str(self.binary), url, "0.8"],
                                capture_output=True, text=True, check=True, timeout=6)
        return json.loads(result.stdout)

    def test_fast_response_remains_complete(self):
        answer = self.request("/fast")
        self.assertEqual((answer["status"], answer["body"]), (200, "response"))

    def test_redirect_remains_supported(self):
        answer = self.request("/redirect")
        self.assertEqual((answer["status"], answer["body"]), (200, "response"))

    def test_slow_progress_cannot_extend_the_total_deadline(self):
        answer = self.request("/slow")
        self.assertIsNone(answer["status"], answer)
        self.assertLess(answer["elapsed"], 1.8, answer)

    def test_idle_peer_returns_no_answer(self):
        answer = self.request("/idle")
        self.assertIsNone(answer["status"], answer)
        self.assertLess(answer["elapsed"], 1.8, answer)


if __name__ == "__main__":
    unittest.main(verbosity=2)
