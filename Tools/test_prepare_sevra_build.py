#!/usr/bin/env python3
import pathlib
import tempfile
from prepare_sevra_build import prepare

with tempfile.TemporaryDirectory() as temporary:
    root = pathlib.Path(temporary)
    for target in ['SevraMac', 'SevraRuntime', 'Slotstream', 'MLX']:
        (root / (target + '.build')).mkdir()
        (root / (target + '.build') / 'old.o').write_text('old layout')
    (root / 'Modules').mkdir()
    (root / 'Modules/SevraMac.swiftmodule').write_text('old layout')
    assert prepare(root, 'first')
    assert not (root / 'SevraMac.build').exists()
    assert not (root / 'SevraRuntime.build').exists()
    assert not (root / 'Modules/SevraMac.swiftmodule').exists()
    assert (root / 'Slotstream.build/old.o').exists()
    assert (root / 'MLX.build/old.o').exists()
    (root / 'SevraMac.build').mkdir()
    (root / 'SevraMac.build/current.o').write_text('current layout')
    assert not prepare(root, 'first')
    assert (root / 'SevraMac.build/current.o').exists()
    assert prepare(root, 'changed dependency layout')
    assert not (root / 'SevraMac.build').exists()
print('PASS: changed dependencies invalidate native objects; stable inputs and dependency caches survive')
