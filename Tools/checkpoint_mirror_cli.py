#!/usr/bin/env python3
"""Exercise mirror forwarding/refusal through the CLI with tiny header fixtures.

The fixture is sufficient for CheckpointIndex's header checks, never inference.
Every supported command must fail on the missing mirror before reading tensors.
Engine entrypoints still perform real memory admission before opening headers;
--weights-free excludes those cases for small CI runners. The full acceptance
battery runs the complete set after its model-memory preflight.
"""
import argparse
import json
import os
from pathlib import Path
import struct
import subprocess
import tempfile


def fixture(directory):
    directory.mkdir()
    (directory / 'config.json').write_text('{"text_config": {}}')
    names = ['model.embed_tokens.weight', 'lm_head.weight']

    def linear(base):
        names.append(base + '.weight')

    def hyper(base, inject):
        names.append(base + '.hc_norm.weight')
        linear(base + '.input_mix_weight_down')
        linear(base + '.input_mix_weight_up')
        if inject:
            linear(base + '.block_inject_weight')

    hyper('model.hyper_connection_mixer', False)
    for layer in range(48):
        base = f'model.layers.{layer}'
        linear(base + '.mlp.gate')
        for name in ['shared_expert_gate', 'shared_expert.gate_proj',
                     'shared_expert.up_proj', 'shared_expert.down_proj']:
            linear(base + '.mlp.' + name)
        for projection in ['gate_proj', 'up_proj', 'down_proj']:
            for piece in ['weight', 'scales', 'biases']:
                names.append(f'{base}.mlp.switch_mlp.{projection}.{piece}')
        hyper(base + '.attn_hyper_connection', True)
        hyper(base + '.mlp_hyper_connection', True)
        if (layer + 1) % 4:
            for name in ['in_proj_qkv', 'in_proj_z', 'in_proj_b', 'in_proj_a', 'out_proj']:
                linear(base + '.linear_attn.' + name)
            names.extend(base + '.linear_attn.' + n for n in ['conv1d.weight', 'dt_bias', 'A_log', 'norm.weight'])
        else:
            for name in ['q_proj', 'k_proj', 'v_proj', 'o_proj', 'q_norm', 'k_norm',
                         'indexer.index_qk_proj', 'indexer.q_layernorm', 'indexer.k_layernorm']:
                linear(base + '.self_attn.' + name)
        if layer == 1:
            for name in ['key_proj', 'value_proj', 'norm_key', 'norm_query', 'norm_conv', 'conv1d']:
                linear(base + '.ple.' + name)
            for shard in range(128):
                for piece in ['weight', 'scales', 'biases']:
                    names.append(f'{base}.ple.ple_embedding.ngram_embedding.shard_{shard}.{piece}')
    header = json.dumps({name: {'dtype': 'F32', 'shape': [1], 'data_offsets': [4*i, 4*i+4]}
                         for i, name in enumerate(names)}).encode()
    (directory / 'model.safetensors').write_bytes(struct.pack('<Q', len(header)) + header + bytes(4*len(names)))


def check(binary, *, weights_free=False):
    root = Path(__file__).resolve().parent.parent
    env = {k: v for k, v in os.environ.items() if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_'))}
    rows = []
    with tempfile.TemporaryDirectory(prefix='slotstream-mirror-cli-') as temp:
        folder = Path(temp)
        model = folder / 'primary'
        missing = folder / 'missing-mirror'
        fixture(model)
        unsupported = ['doctor', 'template-check', 'mtp-parity', 'optimization-state-check',
                       'decode-overlap-check', 'draft-stream-check', 'ngram-golden']
        engine = [
            ['prefix-exact-check'],
            ['prefix-exact-check', '--plan', '--memory-gb', '10', '--mtp', 'off', '--vision', 'off'],
        ]
        supported = ([] if weights_free else engine) + [
            ['vision-parity', '--image', str(root / 'Tools/assets/vision_test/secret1.jpg'), '--out', str(folder / 'vision')],
            ['parity', '--tokens', '9707,11'], ['dequant-golden'],
            ['mtp-fixture-inputs', '--out', str(folder / 'mtp.safetensors')],
        ]
        for args, expected in [([x] + (['--tokens', '9707,11'] if x == 'ngram-golden' else []),
                                '--mirror is not supported by this command') for x in unsupported] + [
                (x, f'mirror {missing} cannot serve') for x in supported]:
            for repeated in [False, True]:
                command = [str(binary), *args, '--model', str(model)]
                if repeated:
                    command += ['--mirror', str(model)]
                command += ['--mirror', str(missing)]
                result = subprocess.run(command, env=env, capture_output=True, text=True, timeout=30)
                passed = result.returncode != 0 and expected in result.stderr
                rows.append({'command': args, 'repeated': repeated, 'passed': passed,
                             'exit': result.returncode, 'stderr': result.stderr})
                if not passed:
                    raise RuntimeError(json.dumps(rows[-1], indent=2))
        if (folder / 'vision').exists() or (folder / 'mtp.safetensors').exists():
            raise RuntimeError('failed mirror validation published diagnostic output')
    print(json.dumps({'passed': True, 'scope': 'weights-free' if weights_free else 'complete',
                      'checks': len(rows), 'results': rows}, indent=2))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary', type=Path, default=os.environ.get('SLOTSTREAM_TEST_BINARY', '.build/release/slotstream'))
    parser.add_argument('--weights-free', action='store_true',
                        help='exclude Engine entrypoints that require real model-memory admission')
    args = parser.parse_args()
    check(args.binary.resolve(), weights_free=args.weights_free)
