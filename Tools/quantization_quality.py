#!/usr/bin/env python3
"""Compare bounded full-vocabulary logits on identical teacher-forced contexts.

This is a pilot scorer, not a qualification verdict. It never loads a model,
executes a grader or relaxes the same-artifact equality benchmark. Inputs are
immutable manifests plus row-major little-endian float32 logit files. Reference,
baseline and candidate run sequentially in separate model processes elsewhere.
"""
import argparse
import array
import hashlib
import json
import math
import os
from pathlib import Path
import re
import statistics
import stat
import sys
from quantization_inventory import unique_json

VOCABULARY = 248_320
MAX_BYTES = 2_000_000_000  # per artifact, including every case's logits
IDENTITY_FIELDS = ('checkpoint', 'checkpoint_revision', 'tokenizer_sha256', 'template_sha256')


def metrics(reference, other):
    if len(reference) != len(other) or len(reference) < 2:
        raise ValueError('logits must cover the same complete vocabulary')
    if any(not math.isfinite(x) for row in (reference, other) for x in row):
        raise ValueError('non-finite logit')
    rmax, omax = max(reference), max(other)
    # Shift first: subtracting two huge absolute log normalizers can erase a
    # real KL difference even though softmax itself is shift invariant.
    rexp = [math.exp(x - rmax) for x in reference]
    rsum = math.fsum(rexp)
    rz = math.log(rsum)
    oz = math.log(math.fsum(math.exp(x - omax) for x in other))
    kl = math.fsum(p / rsum * (((r - rmax) - rz) - ((o - omax) - oz))
                   for p, r, o in zip(rexp, reference, other))
    if not math.isfinite(kl) or kl < -1e-12:
        raise ValueError('invalid full-vocabulary KL')
    return {'kl_reference_to_other': max(0, kl),
            'top1_agrees': reference.index(rmax) == other.index(omax)}


def stamp(stat):
    return stat.st_dev, stat.st_ino, stat.st_size, stat.st_mtime_ns, stat.st_ctime_ns


class Logits:
    def __init__(self, path):
        if path.stat().st_size > 4_000_000:
            raise ValueError('logit manifest exceeds its bound')
        with path.open('rb') as handle:
            raw = handle.read(4_000_001)
        if len(raw) > 4_000_000:
            raise ValueError('logit manifest grew while reading')
        self.manifest_sha256 = hashlib.sha256(raw).hexdigest()
        self.data = unique_json(raw)
        self.files = {}
        try:
            d = self.data
            if d.get('schema') != 1 or d.get('vocabulary') != VOCABULARY or d.get('format') != 'f32le':
                raise ValueError('unsupported logit manifest')
            if d.get('scope') not in ('pilot', 'held-out'):
                raise ValueError('evaluation split must be explicit')
            identity = d['artifact']
            if not re.fullmatch('[0-9a-f]{40}', identity.get('checkpoint_revision', '')):
                raise ValueError('immutable original checkpoint revision is required')
            for field in (*IDENTITY_FIELDS, 'pack_sha256', 'runtime_sha256', 'arithmetic'):
                if not isinstance(identity.get(field), str) or not identity[field]:
                    raise ValueError('missing artifact identity')
                if field.endswith('_sha256') and not re.fullmatch('[0-9a-f]{64}', identity[field]):
                    raise ValueError('invalid artifact digest')
            if not isinstance(d.get('cases'), list) or not 1 <= len(d['cases']) <= 64:
                raise ValueError('bounded, nonempty cases required')
            self.cases = {}
            total = 0
            for case in d['cases']:
                key = case['id']
                if not isinstance(key, str) or not re.fullmatch('[a-zA-Z0-9_-]{1,64}', key) or key in self.cases:
                    raise ValueError('case IDs must be unique and bounded')
                if not isinstance(case.get('family'), str) or not case['family']:
                    raise ValueError('case family is required')
                tokens, positions = case['tokens'], case['positions']
                if (not isinstance(tokens, list) or not 1 <= len(tokens) <= 262144
                        or any(type(x) is not int or not 0 <= x < VOCABULARY for x in tokens)
                        or not isinstance(positions, list) or not 1 <= len(positions) <= 2048
                        or any(type(x) is not int or not 0 <= x < len(tokens) for x in positions)
                        or positions != sorted(set(positions))):
                    raise ValueError('invalid teacher-forced token contexts or logit positions')
                # A row is the next-token distribution after tokens[:position+1].
                count = len(positions) * VOCABULARY * 4
                total += count
                if total > MAX_BYTES:
                    raise ValueError('reference-logit storage budget exceeded')
                filename = case['file']
                if not isinstance(filename, str) or not re.fullmatch('[a-zA-Z0-9_-]+\\.f32', filename):
                    raise ValueError('logit file must be a plain artifact filename')
                handle = os.fdopen(os.open(path.parent / filename, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK), 'rb')
                self.files[key] = handle
                observed = os.fstat(handle.fileno())
                before = stamp(observed)
                if not stat.S_ISREG(observed.st_mode) or before[2] != count:
                    raise ValueError('full-vocabulary logit file size mismatch')
                hasher, remaining = hashlib.sha256(), count
                while remaining:
                    chunk = handle.read(min(remaining, 65536))
                    if not chunk:
                        raise ValueError('logit file truncated while hashing')
                    hasher.update(chunk); remaining -= len(chunk)
                digest = hasher.hexdigest()
                if digest != case['sha256'] or stamp(os.fstat(handle.fileno())) != before:
                    raise ValueError('logit file digest mismatch or concurrent change')
                handle.seek(0)
                self.cases[key] = dict(case, stamp=before)
        except BaseException:
            self.close()
            raise

    def row(self, key):
        values = array.array('f')
        values.frombytes(self.files[key].read(VOCABULARY * 4))
        if len(values) != VOCABULARY:
            raise ValueError('truncated logit row')
        if sys.byteorder != 'little':
            values.byteswap()
        return values

    def verify_unchanged(self):
        for key, handle in self.files.items():
            if stamp(os.fstat(handle.fileno())) != self.cases[key]['stamp']:
                raise ValueError('logits changed during scoring')

    def close(self):
        for handle in self.files.values():
            handle.close()


def compare(reference, baseline, candidate):
    packs = []
    try:
        for path in (reference, baseline, candidate):
            packs.append(Logits(path))
        ref, base, cand = packs
        for pack in packs[1:]:
            if any(pack.data['artifact'][k] != ref.data['artifact'][k] for k in IDENTITY_FIELDS):
                raise ValueError('checkpoint, tokenizer or template identity differs')
            if pack.data['scope'] != ref.data['scope'] or pack.cases.keys() != ref.cases.keys():
                raise ValueError('evaluation split or case coverage differs')
            for key, case in ref.cases.items():
                if any(case[k] != pack.cases[key][k] for k in ('family', 'tokens', 'positions')):
                    raise ValueError('teacher-forced contexts, positions or task family differ')
        cases = []
        for key, case in ref.cases.items():
            rows = []
            for position in case['positions']:
                target = ref.row(key)
                a, b = metrics(target, base.row(key)), metrics(target, cand.row(key))
                rows.append({'position': position, 'baseline': a, 'candidate': b,
                             'delta_kl': b['kl_reference_to_other'] - a['kl_reference_to_other']})
            cases.append({'id': key, 'family': case['family'], 'rows': rows,
                          'mean_delta_kl': statistics.mean(row['delta_kl'] for row in rows),
                          **{role: {'mean_kl': statistics.mean(row[role]['kl_reference_to_other'] for row in rows),
                                    'top1_agreement': statistics.mean(row[role]['top1_agrees'] for row in rows)}
                             for role in ('baseline', 'candidate')}})
        for pack in packs:
            pack.verify_unchanged()
        return {'schema': 1, 'scope': ref.data['scope'], 'qualification': 'unproven',
                'metric': 'full-vocabulary KL(reference || other), natural logarithms',
                'aggregation': 'equal case weight; token positions are correlated, not independent trials',
                'reference_is_quantized_proxy': True,
                'identities': {role: {'manifest_sha256': p.manifest_sha256, **p.data['artifact']}
                               for role, p in zip(('reference', 'baseline', 'candidate'), packs)},
                'mean_case_delta_kl': statistics.mean(case['mean_delta_kl'] for case in cases),
                'cases': cases}
    finally:
        for pack in packs:
            pack.close()


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    for option in ('reference', 'baseline', 'candidate', 'out'):
        p.add_argument('--' + option, type=Path, required=True)
    args = p.parse_args()
    result = compare(args.reference, args.baseline, args.candidate)
    with args.out.open('x') as output:
        json.dump(result, output, indent=2, allow_nan=False)
        output.write('\n')
