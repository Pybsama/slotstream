#!/usr/bin/env python3
"""Weight-free checks of the prospective experiment's scoring gates."""
import contextlib
import io
import json
from pathlib import Path
import tempfile
from unittest.mock import patch

import ready_overlap_probe as probe


for changed in ['none', 'paging_one', 'paging_two', 'tokens', 'pool', 'aa', 'tiny']:
    def invoke(binary, arguments, out, name, env, required):
        round_id, arm = name.split('-', 1)
        candidate = arm == 'ready_direct'
        seconds = (9.8 if changed == 'tiny' else 9) if candidate else 10
        if changed == 'aa' and arm == 'reference_repeat':
            seconds = 12
        paging = candidate and ((changed == 'paging_one' and round_id == 'r0')
            or (changed == 'paging_two' and round_id in ['r0', 'r1']))
        return [{'kind': 'model_cell',
            'output_ids': [1, 3] if changed == 'tokens' and candidate else [1, 2],
            'prompt_ids': [4], 'plan': {'decode_lookahead': True, 'pool_slots': 641 if changed == 'pool' and candidate else 640},
            'stats': {'decodeSeconds': seconds, 'requestSeconds': seconds + 1,
                'decodeTokens': 2, 'prefillTokens': 1, 'decodeForwardPasses': 1,
                'prefillRecords': 2, 'decodeRecords': 3, 'expertPrefetch': {'mode': 'on'}},
            'ready_ticket_prelaunch_records': 1, 'overlap_direct_batches': 1,
            'swapins_delta': int(paging), 'swapouts_delta': 0,
            'thermal_before': 'nominal', 'thermal_after': 'nominal', 'normal_power': True}]
    with tempfile.TemporaryDirectory() as directory:
        with patch.object(probe, 'ready_invoke', invoke), patch.object(probe, 'host_conditions', lambda: {'fixture': True}):
            with contextlib.redirect_stdout(io.StringIO()):
                probe.run(Path(directory), Path(__file__))
        result = json.loads((Path(directory) / 'summary.json').read_text())['comparisons']['ready_direct']
        assert result['passes_screen'] == (changed in ['none', 'paging_one']), (changed, result)
        print(f'PASS {changed}: eligible={result["eligible_pairs"]}, screen={result["passes_screen"]}')
