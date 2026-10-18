"""Prove that small-runner checks never depend on model-memory admission."""
import contextlib
import io
import json
from pathlib import Path
import subprocess
import unittest
from unittest.mock import patch

import checkpoint_mirror_cli as gate


class MirrorCLIScope(unittest.TestCase):
    def run_gate(self, *, weights_free=False, insufficient=False, wrong_error=False,
                 successful_exit=False, publish_output=False):
        calls = []

        def child(command, **kwargs):
            calls.append(command)
            name = command[1]
            if insufficient and name == 'prefix-exact-check':
                error = 'insufficient reclaimable memory for model allocation and safety headroom'
            elif name in ['doctor', 'template-check', 'mtp-parity', 'optimization-state-check',
                          'decode-overlap-check', 'draft-stream-check']:
                error = '--mirror is not supported by this command'
            else:
                error = f'mirror {command[-1]} cannot serve'
            if publish_output and name == 'vision-parity':
                Path(command[command.index('--out') + 1]).mkdir(exist_ok=True)
            return subprocess.CompletedProcess(command, 0 if successful_exit else 1,
                                               '', 'unrelated refusal' if wrong_error else error)

        output = io.StringIO()
        with patch.object(gate.subprocess, 'run', side_effect=child), contextlib.redirect_stdout(output):
            gate.check(Path('/fake/slotstream'), weights_free=weights_free)
        return json.loads(output.getvalue()), calls

    def test_small_runner_never_launches_engine_admission(self):
        result, calls = self.run_gate(weights_free=True, insufficient=True)
        self.assertEqual(result['scope'], 'weights-free')
        self.assertEqual(result['checks'], 22)
        self.assertNotIn('prefix-exact-check', [call[1] for call in calls])

    def test_complete_gate_keeps_both_engine_paths_and_repeated_mirrors(self):
        result, calls = self.run_gate()
        self.assertEqual(result['scope'], 'complete')
        self.assertEqual(result['checks'], 26)
        engines = [call for call in calls if call[1] == 'prefix-exact-check']
        self.assertEqual(len(engines), 4)
        self.assertEqual(sum('--plan' in call for call in engines), 2)
        self.assertEqual([call.count('--mirror') for call in calls], [1, 2] * 13)

    def test_memory_refusal_is_not_mirror_forwarding_evidence(self):
        with self.assertRaisesRegex(RuntimeError, 'insufficient reclaimable memory'):
            self.run_gate(insufficient=True)

    def test_unrelated_error_cannot_pass(self):
        with self.assertRaisesRegex(RuntimeError, 'unrelated refusal'):
            self.run_gate(weights_free=True, wrong_error=True)

    def test_successful_exit_cannot_pass_even_with_expected_error(self):
        with self.assertRaises(RuntimeError):
            self.run_gate(successful_exit=True)

    def test_failed_mirror_must_not_publish_diagnostic_output(self):
        with self.assertRaisesRegex(RuntimeError, 'published diagnostic output'):
            self.run_gate(publish_output=True)


if __name__ == '__main__':
    unittest.main()
