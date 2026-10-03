#!/usr/bin/env python3
"""Frozen bounded allocator-cache reuse comparison; never promotes a pack."""
import argparse
from pathlib import Path
from vq_kernel_pair_pilot import run

PROTOCOL_SHA = '3636759194b031abdfec5e084eb86de40b3b1fc093cd8ac38b5194ec84243246'

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('before', 'after', 'research-root', 'out'):
        parser.add_argument('--' + name, type=Path, required=True)
    run(parser.parse_args(), protocol_file='allocator-pair-v1.json', protocol_sha=PROTOCOL_SHA)
