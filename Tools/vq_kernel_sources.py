#!/usr/bin/env python3
"""Extract reviewed Metal constants from a pinned runtime without importing it.

This intentionally is not a Python evaluator. Only literal strings, previously
extracted strings, concatenation and literal string replacement are supported.
The resulting kernels are research inputs, never a model admission mechanism.
"""
import argparse
import ast
import hashlib
import json
from pathlib import Path

RUNTIME_SHA256 = '1685ec90feb24e421c379ae4e3594f659478905d2c1393617990d84d3f514ee8'
SOURCES = {
    'd2u8': ('_SRC_FUSED_D2_U32', '97dbcc6ef673170ec6f11665cc396685ebd750e5eaaecd1deffdbe85764ccf15'),
    'd2packed': ('_SRC_FUSED_PACKED_D2_WALK', 'ef88c3dce0ba7bcc849bf55955e6ebd15f83a4c08157e7f11d7be7e15c8ae04f'),
    'd4packed': ('_SRC_FUSED_PACKED_D4_WALK', '95d26045fe9d92801ff58fcad4a50370257bdb41657beef2aa50b9613c6b2205'),
    'd8scalar': ('_SRC_FUSED_PACKED_D8_WALK', '0fae9dfadbcfb9250767ed356270fc1e9297ce45cc2b52c91fae0d86c009f7a3'),
    'd8simd': ('_SRC_FUSED_PACKED_D8_SIMD_DEVX_SS', '762b40e4dc8d88e0d4ee2d780aa7c956b534f7605a642f3426c730d67482d8c7'),
    'segmentedPrefill': ('_SRC_GEMMSEG2', '32c733877cb52558856c12ab59fce3a2658896dc3c25c6f70f806bdc8167d68f'),
}


def literal_strings(text):
    if len(text.encode()) > 1_000_000:
        raise ValueError('runtime source exceeds the reviewed bound')
    values = {}

    def value(node):
        if isinstance(node, ast.Constant) and type(node.value) is str:
            if len(node.value) > 500_000:
                raise ValueError('literal exceeds bound')
            return node.value
        if isinstance(node, ast.Name) and node.id in values:
            return values[node.id]
        if isinstance(node, ast.BinOp) and isinstance(node.op, ast.Add):
            result = value(node.left) + value(node.right)
        elif (isinstance(node, ast.Call) and isinstance(node.func, ast.Attribute)
              and node.func.attr == 'replace' and len(node.args) == 2 and not node.keywords):
            base, old, new = value(node.func.value), value(node.args[0]), value(node.args[1])
            # Price the replacement before constructing it. An empty search
            # string can otherwise expand a small input quadratically.
            if len(base) + base.count(old) * (len(new) - len(old)) > 500_000:
                raise ValueError('replacement exceeds bound')
            result = base.replace(old, new)
        else:
            raise ValueError('not a supported string expression')
        if len(result) > 500_000:
            raise ValueError('extracted string exceeds bound')
        return result

    for node in ast.parse(text).body:
        if not (isinstance(node, ast.Assign) and len(node.targets) == 1
                and isinstance(node.targets[0], ast.Name)):
            continue
        name = node.targets[0].id
        try:
            values[name] = value(node.value)
        except ValueError:
            # Never keep a previous assignment when a later unsupported
            # expression changes that name. Expected digests still decide.
            values.pop(name, None)
    return values


def extract(path):
    with path.open('rb') as handle:
        data = handle.read(1_000_001)
    if hashlib.sha256(data).hexdigest() != RUNTIME_SHA256:
        raise ValueError('runtime does not match the reviewed Flash Next VQ revision')
    values = literal_strings(data.decode())
    result = {}
    for key, (name, digest) in SOURCES.items():
        source = values.get(name, '')
        if hashlib.sha256(source.encode()).hexdigest() != digest:
            raise ValueError('reviewed Metal source identity mismatch: ' + name)
        result[key] = source
    return result


def swift_source(sources):
    header = '''// Extracted from VQLab's Apache-2.0 licensed vq_switch.py, also bundled
// in Flash Next VQ model.py (SHA-256 recorded by Tools/vq_kernel_sources.py).
// Upstream: noahzelezny/VQLab, 97b4380c60f5faf55bdc777102d042468c4644ca.
// See THIRD_PARTY_NOTICES.md and Licenses/VQLab-Apache-2.0.txt.
// Modified packaging only: reviewed string constants are embedded in Swift.
// No upstream Python is imported or executed. Regenerate with the tool above.
enum VQKernelSources {
'''
    for key, source in sources.items():
        if '#"""' in source or '"""#' in source:
            raise ValueError('source contains a Swift literal delimiter')
        header += '    static let ' + key + ' = #"""\n' + source + '\n"""#\n'
    return header + '}\n'


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--runtime', required=True, type=Path)
    parser.add_argument('--swift-out', type=Path)
    args = parser.parse_args()
    sources = extract(args.runtime)
    if args.swift_out:
        args.swift_out.write_text(swift_source(sources))
    print(json.dumps({key: hashlib.sha256(value.encode()).hexdigest()
                      for key, value in sources.items()}, indent=2))
