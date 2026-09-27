#!/usr/bin/env python3
"""Check the actual shard parser with small, ordinary empty-tensor layouts."""
import json
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent.parent


class EmptyTensors(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temporary = tempfile.TemporaryDirectory(prefix="slotstream-empty-tensors-")
        cls.addClassCleanup(cls.temporary.cleanup)
        cls.directory = Path(cls.temporary.name)
        source = (ROOT / "Sources/Slotstream/Checkpoint.swift").read_text()
        # TensorRef and the complete method are copied from the current source,
        # not reimplemented. Initialization requiring all model tensor names is
        # outside this header-format gate; no model/tensor array is loaded.
        ref_start = source.index("public struct TensorRef {")
        ref_end = source.index("/// Immutable descriptor", ref_start)
        method_start = source.index("    private func parseHeader(")
        method_end = source.index("    /// Names every build path", method_start)
        method = source[method_start:method_end]
        error = '''public struct ModelError: Error, CustomStringConvertible {
    public let description: String
    public init(_ description: String) { self.description = description }
}
'''
        harness = "import Foundation\n" + error + source[ref_start:ref_end] + '''
final class ShardParser {
    var tensors: [String: TensorRef] = [:]
    func read(_ file: URL) throws { try parseHeader(file) }
''' + method + "}\n" + r'''
let directory = URL(fileURLWithPath: CommandLine.arguments[1])
var reports: [[String: Any]] = []
func tensor(_ shape: [Int], _ start: Int, _ end: Int) -> [String: Any] {
    ["dtype": "U8", "shape": shape, "data_offsets": [start, end]]
}
func check(_ label: String, _ header: [String: Any], _ payload: [UInt8], expected: Bool) throws {
    let json = try JSONSerialization.data(withJSONObject: header, options: [.sortedKeys])
    var size = UInt64(json.count).littleEndian
    let file = directory.appendingPathComponent("fixture.safetensors")
    try (withUnsafeBytes(of: &size) { Data($0) } + json + Data(payload)).write(to: file)
    let parser = ShardParser()
    do {
        try parser.read(file)
        let refsMatch = parser.tensors.allSatisfy { name, ref in
            let entry = header[name] as! [String: Any]
            let offsets = entry["data_offsets"] as! [Int]
            return ref.shape == entry["shape"] as! [Int] && ref.byteCount == offsets[1] - offsets[0]
        }
        reports.append(["label": label, "expected": expected, "accepted": true,
                        "refs_match": refsMatch && parser.tensors.count == header.count])
    } catch {
        reports.append(["label": label, "expected": expected, "accepted": false,
                        "reason": String(describing: error)])
    }
}
// Different legal names exercise randomized dictionary iteration, which must
// never decide whether an empty tensor is accepted at a shared start.
for i in 0..<64 {
    try check("shared-start-\(i)", ["empty_\(i)": tensor([0], 0, 0),
               "byte_\(i)": tensor([1], 0, 1)], [42], expected: true)
}
try check("middle-and-end", ["first": tensor([1], 0, 1), "middle": tensor([0, 2], 1, 1),
          "second": tensor([1], 1, 2), "end": tensor([0], 2, 2)], [10, 20], expected: true)
try check("all-empty", ["a": tensor([0], 0, 0), "b": tensor([2, 0], 0, 0)], [], expected: true)
try check("scalar", ["scalar": tensor([], 0, 1)], [42], expected: true)
try check("gap", ["byte": tensor([1], 1, 2)], [10, 20], expected: false)
try check("overlap", ["a": tensor([1], 0, 1), "b": tensor([1], 0, 1)], [10, 20], expected: false)
try check("wrong-span", ["a": tensor([0], 0, 1)], [10], expected: false)
print(String(decoding: try JSONSerialization.data(withJSONObject: reports, options: [.sortedKeys]), as: UTF8.self))
'''
        swift = cls.directory / "main.swift"
        swift.write_text(harness)
        binary = cls.directory / "parser"
        subprocess.run(["swiftc", str(swift), "-o", str(binary)], check=True)
        result = subprocess.run([str(binary), str(cls.directory)], check=True,
                                capture_output=True, text=True, timeout=15)
        cls.reports = json.loads(result.stdout)

    def test_valid_empty_layouts_are_independent_of_dictionary_order(self):
        failures = [r for r in self.reports if r["expected"] and
                    (not r["accepted"] or not r.get("refs_match"))]
        self.assertEqual(failures, [])

    def test_gaps_overlaps_and_wrong_spans_stay_rejected(self):
        failures = [r for r in self.reports if not r["expected"] and r["accepted"]]
        self.assertEqual(failures, [])


if __name__ == "__main__":
    unittest.main(verbosity=2)
