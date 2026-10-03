#!/usr/bin/env python3
"""Preallocation refusal gates for the original and authenticated research heads.

Every child is sequential. A parent-owned exclusion lock stands in for another
model without allocating one. Other refusal cases use tiny corrupt files only.
"""
import argparse
from contextlib import nullcontext
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile

from context_qualification import quiet_preflight, verification_lock


def run(options):
    binary = options.binary.resolve()
    baseline = options.baseline.resolve()
    fixture = options.fixture.resolve()
    env = {k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_', 'SS_DEBUG', 'VQ_', 'VQLAB_'))}
    rows = []
    with tempfile.TemporaryDirectory(prefix='slotstream-draft-admission-') as temp:
        root = Path(temp)
        def check(name, args, *, locked=False, expected, extra_env=None):
            before = quiet_preflight(13)
            with verification_lock() if locked else nullcontext():
                child = subprocess.run([str(binary), *args], env=env | (extra_env or {}),
                                       capture_output=True, text=True, timeout=30)
            result = dict(name=name, command=[str(binary), *args], parent_held_lock=locked,
                          exit_code=child.returncode, stdout=child.stdout, stderr=child.stderr,
                          before=before, expected=expected)
            rows.append(result)
            assert child.returncode != 0 and expected in child.stderr, result
        def research(*, base=baseline, fx=fixture, output=None):
            return ['quantization-draft-check', '--baseline', str(base), '--fixture', str(fx),
                    '--output', str(output or root/'never-created'), '--reference-arithmetic']
        check('standalone head refuses existing lock',
              ['mtp-parity', '--model', str(baseline), '--fixture', str(fixture)], locked=True,
              expected='another Slotstream model process')
        check('research head refuses existing lock', research(), locked=True,
              expected='another Slotstream model process')
        check('research rejects ambient overrides before opening files', research(),
              extra_env={'SLOTSTREAM_MODEL_LOCK_PATH':str(root/'unexpected-lock')},
              expected='refuses ambient runtime overrides')
        assert not (root/'unexpected-lock').exists()
        for kind in ('truncated', 'symlink', 'fifo'):
            fx = root/(kind+'.safetensors')
            if kind == 'truncated': fx.write_bytes(b'\0'*16)
            elif kind == 'symlink': fx.symlink_to(fixture)
            else: os.mkfifo(fx)
            check('fixture '+kind, research(fx=fx), expected='VQ tensor')
            assert not (root/'never-created').exists()
        for kind in ('corrupt', 'symlink', 'fifo'):
            base=root/kind;base.mkdir();config=base/'config.json'
            if kind=='corrupt':
                value=bytearray((baseline/'config.json').read_bytes());value[-1]^=1;config.write_bytes(value)
            elif kind=='symlink': config.symlink_to(baseline/'config.json')
            else: os.mkfifo(config)
            destination=root/(kind+'-output')
            check('configuration '+kind, research(base=base,output=destination), expected='draft configuration' if kind=='symlink' else 'separate configuration')
            assert not (destination/'receipt.json').exists()
        for kind in ('symlink', 'fifo', 'truncated'):
            base=root/('sidecar-'+kind);base.mkdir()
            (base/'config.json').write_bytes((baseline/'config.json').read_bytes())
            sidecar=base/'mtp.safetensors'
            if kind=='symlink': sidecar.symlink_to(baseline/'mtp.safetensors')
            elif kind=='fifo': os.mkfifo(sidecar)
            else: sidecar.write_bytes(b'\0'*16)
            destination=root/('sidecar-'+kind+'-output')
            check('sidecar '+kind, research(base=base,output=destination), expected='VQ tensor')
            assert not (destination/'receipt.json').exists()
    return {'schema':1,'passed':True,'cases':rows,'scope':__doc__}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    for key in ('binary','baseline','fixture','out'):parser.add_argument('--'+key,type=Path,required=True)
    args=parser.parse_args()
    args.out.mkdir(parents=True,exist_ok=False)
    try:
        receipt=run(args)
        (args.out/'receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
        print(json.dumps({'passed':True,'cases':len(receipt['cases'])}))
    except BaseException as error:
        (args.out/'failure.json').write_text(json.dumps({'passed':False,'failure':repr(error)})+'\n');raise
