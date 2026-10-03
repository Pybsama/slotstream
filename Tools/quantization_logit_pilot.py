#!/usr/bin/env python3
"""Freeze the owned raw-continuation pilot with the original tokenizer.

No model is loaded, no candidate file is changed, and no score is calculated.
The resulting token files are the identical inputs for sequential producers.
"""
import argparse
import hashlib
import importlib.metadata
import json
from pathlib import Path
import re

from quantization_inventory import unique_json
from vq_fused_reference import bounded


def texts(protocol):
    if protocol.get('schema') != 1 or protocol.get('scope') != 'pilot' or len(protocol.get('cases', [])) != 6:
        raise ValueError('the bounded six-case pilot is required')
    result = []
    for case in protocol['cases']:
        if not re.fullmatch('[a-z][a-z-]{0,63}', case['id']) or not case.get('family'):
            raise ValueError('invalid pilot case identity')
        if 'records' in case:
            count = case['records']
            if type(count) is not int or not 1 <= count <= 70:
                raise ValueError('record pilot exceeds its bound')
            text = case['text_prefix'] + ''.join(case['record_template'].format(
                index=i, code=i * i, shelf=i % 7) for i in range(1, count + 1)) + case['text_suffix']
        else:
            text = case['text']
        if not isinstance(text, str) or not 1 <= len(text.encode()) <= 32_000:
            raise ValueError('pilot text exceeds its bound')
        result.append((case, text))
    if len({case['id'] for case, _ in result}) != len(result):
        raise ValueError('duplicate case ID')
    return result


def prepare(protocol_path, tokenizer_path, out):
    protocol_raw = bounded(protocol_path, 100_000)
    protocol = unique_json(protocol_raw)
    examples = texts(protocol)
    if importlib.metadata.version('tokenizers') != protocol['tokenizers_version']:
        raise ValueError('pilot tokenizer version mismatch')
    raw = bounded(tokenizer_path, 32_000_000)
    if hashlib.sha256(raw).hexdigest() != protocol['tokenizer_sha256']:
        raise ValueError('use the pinned original tokenizer, not the VQ bundle tokenizer')
    from tokenizers import Tokenizer
    tokenizer = Tokenizer.from_str(raw.decode())
    cases = []
    for case, text in examples:
        tokens = tokenizer.encode(text, add_special_tokens=False).ids
        if not 1 <= len(tokens) <= 2048 or any(not 0 <= t < 248_320 for t in tokens):
            raise ValueError('tokenized pilot exceeds the producer bound')
        token_bytes = (json.dumps(tokens) + '\n').encode()
        cases.append({'id': case['id'], 'family': case['family'], 'tokens': tokens,
                      'positions': list(range(max(0, len(tokens) - 16), len(tokens))),
                      'text': text, 'text_sha256': hashlib.sha256(text.encode()).hexdigest(),
                      'file': case['id'] + '.json', 'tokens_sha256': hashlib.sha256(token_bytes).hexdigest()})
    out.mkdir(parents=True, exist_ok=False)
    for case in cases:
        (out / case['file']).write_text(json.dumps(case['tokens']) + '\n')
    receipt = {'schema': 1, 'scope': 'pilot', 'protocol_sha256': hashlib.sha256(protocol_raw).hexdigest(),
               'preprocessing': protocol['preprocessing'], 'cases': cases,
               'identity': {key: protocol[key] for key in ('checkpoint', 'checkpoint_revision',
                   'tokenizer_sha256', 'template_sha256', 'tokenizers_version', 'lineage')}}
    (out / 'inputs.json').write_text(json.dumps(receipt, indent=2, ensure_ascii=False) + '\n')
    print(json.dumps([{'id': c['id'], 'tokens': len(c['tokens']), 'positions': c['positions']} for c in cases]))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for arg in ('protocol', 'tokenizer', 'out'):
        parser.add_argument('--' + arg, type=Path, required=True)
    options = parser.parse_args()
    prepare(options.protocol, options.tokenizer, options.out)
