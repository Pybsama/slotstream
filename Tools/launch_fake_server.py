"""A stand-in for `slotstream serve` that checks `slotstream launch` plumbing.

It answers the launcher's probes (`/v1/models`, `/api/version`,
`/v1/messages/count_tokens`) as Slotstream does and refuses every inference
request with a 400, recording one JSON line per request: method, path, size,
transfer encoding and user agent, plus the parsed body when a third argument
is given. Tools/coding_agents_gate.sh uses it with FAKE=1.

Usage: python3 Tools/launch_fake_server.py <port> <log> [bodies]
Standard library only.
"""
import json, sys
from http.server import ThreadingHTTPServer, BaseHTTPRequestHandler
PORT = int(sys.argv[1]); LOG = sys.argv[2]
class H(BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"
    def log_message(self, *a): pass
    def reply(self, code, payload):
        data = json.dumps(payload).encode()
        self.send_response(code); self.send_header("content-type", "application/json")
        self.send_header("content-length", str(len(data))); self.end_headers(); self.wfile.write(data)
    def record(self, raw=b""):
        with open(LOG, "a") as f:
            rec = {"method": self.command, "path": self.path, "bytes": len(raw),
                   "te": self.headers.get("transfer-encoding"), "ua": (self.headers.get("user-agent") or "")[:40]}
            if len(sys.argv) > 3 and raw:
                try: rec["body"] = json.loads(raw)
                except ValueError: pass
            f.write(json.dumps(rec) + "\n")
    def do_GET(self):
        self.record()
        if self.path == "/v1/models":
            return self.reply(200, {"object": "list", "data": [{"id": "qwen3.8-flash-next:4bit", "object": "model",
                                    "owned_by": "slotstream", "context_window": 65536}]})
        if self.path == "/api/version":
            return self.reply(200, {"version": "0.2.20"})
        self.reply(404, {"error": "not found"})
    def do_POST(self):
        raw = self.rfile.read(int(self.headers.get("content-length") or 0))
        self.record(raw)
        if self.path.startswith("/v1/messages/count_tokens"):
            return self.reply(200, {"input_tokens": 10})
        if self.path.startswith("/v1/messages"):
            return self.reply(400, {"type": "error", "error": {"type": "invalid_request_error", "message": "fake server: request recorded"}})
        self.reply(400, {"error": {"message": "fake server: request recorded", "type": "invalid_request_error", "code": None, "param": None}})
ThreadingHTTPServer(("127.0.0.1", PORT), H).serve_forever()
