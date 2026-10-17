#!/usr/bin/env python3
import pathlib
import tempfile
from prepare_slotstream_build import prepare

with tempfile.TemporaryDirectory() as temporary:
    root = pathlib.Path(temporary)
    for target in ['SlotstreamMac', 'SlotstreamRuntime', 'Slotstream', 'MLX']:
        (root / (target + '.build')).mkdir()
        (root / (target + '.build') / 'old.o').write_text('old layout')
    (root / 'Modules').mkdir()
    (root / 'Modules/SlotstreamMac.swiftmodule').write_text('old layout')
    assert prepare(root, 'first')
    assert not (root / 'SlotstreamMac.build').exists()
    assert not (root / 'SlotstreamRuntime.build').exists()
    assert not (root / 'Modules/SlotstreamMac.swiftmodule').exists()
    assert (root / 'Slotstream.build/old.o').exists()
    assert (root / 'MLX.build/old.o').exists()
    (root / 'SlotstreamMac.build').mkdir()
    (root / 'SlotstreamMac.build/current.o').write_text('current layout')
    assert not prepare(root, 'first')
    assert (root / 'SlotstreamMac.build/current.o').exists()
    assert prepare(root, 'changed dependency layout')
    assert not (root / 'SlotstreamMac.build').exists()
print('PASS: changed dependencies invalidate native objects; stable inputs and dependency caches survive')
