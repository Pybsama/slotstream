#!/usr/bin/env python3
"""Run the production mirror diagnostic with ThreadSanitizer, without weights."""
import json
import os
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent


def main():
    diagnostic = ROOT / 'Sources/SlotstreamDiagnostics/Diagnostics+CheckpointMirror.swift'
    source = diagnostic.read_text()
    # Compile the existing diagnostic in the same module as the router. Neither
    # source needs MLX; only the package import/namespace needs this adapter.
    assert source.count('import Slotstream\n') == 1
    with tempfile.TemporaryDirectory(prefix='slotstream-mirror-thread-') as directory:
        temp = Path(directory)
        adapted = temp / diagnostic.name
        adapted.write_text(source.replace('import Slotstream\n', 'public enum Diagnostics {}\n'))
        entry = temp / 'main.swift'
        entry.write_text('''import Foundation
let report = Diagnostics.checkpointMirror()
print(String(data: try JSONEncoder().encode(report), encoding: .utf8)!)
exit(report.passed ? 0 : 1)
''')
        binary = temp / 'checkpoint-mirror-thread-check'
        subprocess.run(['xcrun', 'swiftc', '-O', '-num-threads', '1',
                        '-sanitize=thread', '-package-name', 'slotstream',
                        str(ROOT / 'Sources/Slotstream/CheckpointMirror.swift'),
                        str(ROOT / 'Sources/SlotstreamDiagnostics/CheckReport.swift'),
                        str(adapted), str(entry), '-o', str(binary)], check=True)
        env = dict(os.environ, TSAN_OPTIONS='halt_on_error=1:abort_on_error=0:exitcode=66')
        run = subprocess.run([str(binary)], env=env, capture_output=True, text=True, timeout=60)
        if run.stderr:
            print(run.stderr, end='')
        if run.returncode:
            return 1
        report = json.loads(run.stdout)
        assert report['passed'] and report['items'], report
        print(f"MIRROR THREAD GATE PASS ({len(report['items'])} assertions, ThreadSanitizer)")
        return 0


if __name__ == '__main__':
    raise SystemExit(main())
