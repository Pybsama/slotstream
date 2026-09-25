"""Independent binary16 oracle and native CPU/Metal regression driver."""
import argparse
import json
import pathlib
import random
import struct
import subprocess
import tempfile

if not __debug__:
    raise RuntimeError('Verification requires Python assertions; do not use -O')


def half(value):
    return struct.pack('<e', value)


def expected(directory):
    g = json.loads((directory / 'geometry.json').read_text())
    codes = (directory / 'codes.bin').read_bytes()
    book = [v[0] for v in struct.iter_unpack('<e', (directory / 'codebook.bin').read_bytes())]
    scales = [v[0] for v in struct.iter_unpack('<e', (directory / 'scales.bin').read_bytes())]
    count, bits = g['input'] // g['dimension'], (g['codebookSize'] - 1).bit_length()
    row_bytes = count if g['storage'] == 'u8' else ((count + 31) // 32) * bits * 4
    out = bytearray()
    for row in range(g['rows']):
        blob = codes[row * row_bytes:(row + 1) * row_bytes]
        # Arbitrary-precision whole-row extraction intentionally differs from
        # the native decoder's 32-bit word/cross-word extraction.
        integer = int.from_bytes(blob, 'little')
        for column in range(g['input']):
            sub = column // g['dimension']
            code = blob[sub] if g['storage'] == 'u8' else (integer >> (sub * bits)) & ((1 << bits) - 1)
            value = book[code * g['dimension'] + column % g['dimension']]
            scale = scales[row * (g['input'] // g['groupSize']) + column // g['groupSize']]
            rounded = half(value * scale)
            if g['output'] == 'bf16':
                f32 = struct.unpack('<I', struct.pack('<f', struct.unpack('<e', rounded)[0]))[0]
                rounded = struct.pack('<H', ((f32 + 0x7fff + ((f32 >> 16) & 1)) >> 16) & 0xffff)
            out += rounded
    return bytes(out)


def synthetic(directory, dimension, k, group, width, storage, output, rows=3, special=False):
    directory.mkdir()
    g = dict(rows=rows, input=width, dimension=dimension, groupSize=group,
             codebookSize=k, storage=storage, output=output)
    (directory / 'geometry.json').write_text(json.dumps(g))
    rng = random.Random(817 + dimension + width)
    values = [((i % 257) - 128) / 64 for i in range(k * dimension)]
    if special:
        values[:16] = [-0.0, 0.0, 2**-24, -2**-24, 2**-14, 1.0, 1.0009765625,
                       -1.0009765625, 65504.0, -65504.0, 0.333251953125,
                       -0.333251953125, 2**-15, 2**-16, 1.00390625, 1.01171875]
    (directory / 'codebook.bin').write_bytes(b''.join(half(x) for x in values))
    (directory / 'scales.bin').write_bytes(b''.join(half(x) for x in
        ([1.0] * (rows * width // group) if special else
         [(-1.0, 0.0, 0.125, 1.25)[i % 4] for i in range(rows * width // group)])))
    code_data, nsub, bits = bytearray(), width // dimension, (k - 1).bit_length()
    for row in range(rows):
        indices = [(i % 8) if special else rng.randrange(k) for i in range(nsub)]
        if not special:
            indices[0], indices[-1] = 0, k - 1
        if storage == 'u8': code_data += bytes(indices)
        else:
            words = ((nsub + 31) // 32) * bits
            integer = sum(code << (i * bits) for i, code in enumerate(indices))
            # Fill all padded tail fields with the maximum code. Consuming
            # padding as an extra vector would corrupt the next row/output.
            for i in range(nsub, ((nsub + 31) // 32) * 32): integer |= (k - 1) << (i * bits)
            code_data += integer.to_bytes(words * 4, 'little')
    (directory / 'codes.bin').write_bytes(code_data)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('binary', type=pathlib.Path)
    parser.add_argument('--real', type=pathlib.Path)
    parser.add_argument('--mode', choices=['cpu', 'metal', 'both'], default='both')
    args = parser.parse_args()
    modes = ['cpu', 'metal'] if args.mode == 'both' else [args.mode]
    results, rejected = [], []
    with tempfile.TemporaryDirectory(prefix='slotstream-vq-proof-') as temp:
        root = pathlib.Path(temp)
        cases = [
            ('u8_d2', 2, 256, 64, 2560, 'u8', 'f16'),
            ('packed8_d4', 4, 256, 64, 640, 'packed32', 'f16'),
            ('packed14_d8', 8, 16384, 64, 2560, 'packed32', 'f16'),
            ('packed14_tail', 8, 16384, 64, 640, 'packed32', 'f16'),
            ('ple_d8', 8, 256, 32, 160, 'u8', 'bf16'),
            ('half_edges', 2, 256, 32, 32, 'u8', 'f16'),
            ('bfloat_edges', 2, 256, 32, 32, 'u8', 'bf16'),
        ]
        for label, *params in cases:
            synthetic(root / label, *params, special=label.endswith('edges'))
        synthetic(root / 'maximum_tile', 8, 16384, 64, 4096, 'packed32', 'f16', rows=64)
        synthetic(root / 'one_row', 8, 16384, 64, 640, 'packed32', 'f16', rows=1)
        fixtures = [root / item[0] for item in cases]
        fixtures += [root / 'maximum_tile', root / 'one_row']
        if args.real:
            fixtures += sorted(p.parent for p in args.real.glob('*/geometry.json'))
        for fixture in fixtures:
            oracle = expected(fixture)
            for mode in modes:
                run = subprocess.run([str(args.binary), str(fixture), mode], capture_output=True)
                assert run.returncode == 0, f'{fixture.name}/{mode}: {run.stderr.decode()}'
                assert len(run.stdout) == len(oracle), (fixture.name, mode, 'output length')
                differences = sum(a != b for a, b in zip(struct.iter_unpack('<H', run.stdout), struct.iter_unpack('<H', oracle)))
                assert differences == 0, f'{fixture.name}/{mode}: {differences} differing words'
                results.append({'fixture': fixture.name, 'mode': mode, 'values': len(oracle) // 2, 'differing_bits': 0})
        base = root / 'u8_d2'
        for name, key, value in [('zero_rows', 'rows', 0), ('too_many_rows', 'rows', 65),
                                 ('huge_input', 'input', 2**63 - 1), ('bad_dim', 'dimension', 3),
                                 ('bad_group', 'groupSize', 63), ('bad_k', 'codebookSize', 255),
                                 ('u8_large_k', 'codebookSize', 16384), ('bad_storage', 'storage', 'u16'),
                                 ('bad_output', 'output', 'f32')]:
            dest = root / name; dest.mkdir()
            for f in base.iterdir(): (dest / f.name).write_bytes(f.read_bytes())
            geom = json.loads((dest / 'geometry.json').read_text()); geom[key] = value
            (dest / 'geometry.json').write_text(json.dumps(geom))
            for mode in modes:
                run = subprocess.run([str(args.binary), str(dest), mode], capture_output=True)
                assert run.returncode != 0 and not run.stdout, f'{name}/{mode} accepted'
                rejected.append(name + '/' + mode)
        for name, file, content in [('short_codes', 'codes.bin', b'\0'), ('extra_scales', 'scales.bin', (base / 'scales.bin').read_bytes() + b'\0\0'),
                                    ('nan_book', 'codebook.bin', b'\0\x7e' + (base / 'codebook.bin').read_bytes()[2:]),
                                    ('inf_scale', 'scales.bin', b'\0\x7c' + (base / 'scales.bin').read_bytes()[2:])]:
            dest = root / name; dest.mkdir()
            for f in base.iterdir(): (dest / f.name).write_bytes(f.read_bytes())
            (dest / file).write_bytes(content)
            for mode in modes:
                run = subprocess.run([str(args.binary), str(dest), mode], capture_output=True)
                assert run.returncode != 0 and not run.stdout, f'{name}/{mode} accepted'
                rejected.append(name + '/' + mode)
    print(json.dumps({'passed': results, 'malformed_rejected': rejected, 'model_support_claimed': False}, indent=2))


if __name__ == '__main__': main()
