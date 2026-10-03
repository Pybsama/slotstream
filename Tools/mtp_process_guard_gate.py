#!/usr/bin/env python3
"""Exercise both draft entrypoints under an actual lock with no model weights."""
import argparse
import fcntl
import json
import os
from pathlib import Path
import subprocess
import tempfile


def check(binary):
    root=Path(__file__).resolve().parent.parent
    env={k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_','SS_DEBUG','VQ_','VQLAB_'))}
    with tempfile.TemporaryDirectory(prefix='slotstream-draft-lock-') as directory:
        folder=Path(directory)
        (folder/'config.json').write_bytes((root/'Tools/reference/config.json').read_bytes())
        # Missing or corrupt payloads must not be reached while another owner
        # holds the reservation. No real model path is passed to either child.
        (folder/'mtp.safetensors').write_bytes(b'not model weights')
        with open(f'/tmp/slotstream-model-{os.getuid()}.lock','a') as lock:
            fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
            for command in [
                ['mtp-parity','--model',str(folder),'--fixture',str(folder/'absent')],
                ['quantization-draft-check','--baseline',str(folder),'--fixture',str(folder/'absent'),
                 '--output',str(folder/'must-not-exist')],
            ]:
                result=subprocess.run([str(binary),*command],env=env,capture_output=True,text=True,timeout=15)
                if result.returncode==0 or 'another Slotstream model process is already running' not in result.stderr:
                    raise RuntimeError(json.dumps({'command':command,'code':result.returncode,
                                                    'stdout':result.stdout,'stderr':result.stderr}))
            if (folder/'must-not-exist').exists():raise RuntimeError('research command published output under contention')
    print('MTP PROCESS GUARD PASS (standalone and research)')


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--binary',type=Path,default=Path(os.environ.get('SLOTSTREAM_TEST_BINARY','.build/release/slotstream')))
    check(parser.parse_args().binary.resolve())
