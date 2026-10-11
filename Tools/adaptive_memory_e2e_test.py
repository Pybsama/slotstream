#!/usr/bin/env python3
"""Readiness deadlines and unchanged adaptive assertions, without a model."""
import argparse
import contextlib
import io
import json
import sys
from pathlib import Path
import tempfile
import unittest
from unittest.mock import Mock, mock_open, patch

import adaptive_memory_e2e as fixture


class Clock:
    def __init__(self):
        self.now = 0.0

    def monotonic(self):
        return self.now

    def sleep(self, seconds):
        self.now += seconds


class StartupChecks(unittest.TestCase):
    def run_wait(self, timeout, ready_after, *, stalled=False):
        clock = Clock()
        process = Mock()
        process.poll.return_value = None
        plan = {'memory_limit_gb': 10}

        def request(*args, **kwargs):
            self.assertLessEqual(kwargs['timeout'], 1)
            self.assertLessEqual(kwargs['deadline'], timeout)
            if stalled:
                clock.sleep(kwargs['timeout'])
                raise TimeoutError('accepted connection did not answer')
            if clock.now < ready_after:
                raise ConnectionRefusedError()
            return {'models': [{'details': {'memory_plan': plan}}]}

        with patch.object(fixture.time, 'monotonic', clock.monotonic), \
             patch.object(fixture.time, 'sleep', clock.sleep), \
             patch.object(fixture, 'exchange', side_effect=request):
            try:
                fixture.wait_for_startup(process, 12345, timeout)
            except TimeoutError:
                self.assertAlmostEqual(clock.now, timeout)
                raise

    def test_shorter_override_still_times_out(self):
        with self.assertRaisesRegex(TimeoutError, '45 seconds'):
            self.run_wait(45, 55)

    def test_accepted_but_unresponsive_connections_stay_bounded(self):
        with self.assertRaisesRegex(TimeoutError, '2.5 seconds'):
            self.run_wait(2.5, 100, stalled=True)

    def test_child_exit_fails_immediately(self):
        process = Mock()
        process.poll.return_value = 7
        with patch.object(fixture, 'exchange') as request:
            with self.assertRaisesRegex(RuntimeError, 'exit 7'):
                fixture.wait_for_startup(process, 12345, 180)
            request.assert_not_called()

    def test_invalid_timeouts(self):
        for value in ('0', '-1', 'nan', 'inf', '-inf', 'invalid'):
            with self.subTest(value=value), self.assertRaises(argparse.ArgumentTypeError):
                fixture.positive_seconds(value)
        self.assertEqual(fixture.positive_seconds('2.5'), 2.5)

    def test_slow_http_chunks_do_not_reset_probe_deadline(self):
        clock = Clock()
        connection = Mock()
        connection.__enter__ = Mock(return_value=connection)
        connection.__exit__ = Mock(return_value=False)

        def receive(_size):
            if clock.now >= .2:
                raise AssertionError('HTTP deadline did not expire')
            clock.sleep(.04)
            return b'partial response'

        connection.recv.side_effect = receive
        with patch.object(fixture.time, 'monotonic', clock.monotonic), \
             patch.object(fixture.socket, 'create_connection', return_value=connection):
            with self.assertRaisesRegex(TimeoutError, 'HTTP request timed out'):
                fixture.exchange(12345, 'GET', '/api/ps', timeout=1, deadline=.1)
        self.assertEqual(connection.recv.call_count, 3)
        self.assertLess(clock.now, .15)

    def test_normal_http_calls_keep_30_second_socket_timeout(self):
        connection = Mock()
        connection.__enter__ = Mock(return_value=connection)
        connection.__exit__ = Mock(return_value=False)
        connection.recv.side_effect = [b'HTTP/1.1 200 OK\r\n\r\n{"ok": true}', b'']
        with patch.object(fixture.socket, 'create_connection', return_value=connection) as connect:
            self.assertEqual(fixture.exchange(12345, 'GET', '/status'), {'ok': True})
        self.assertEqual(connect.call_args.kwargs['timeout'], 30)
        self.assertTrue(all(call.args == (30,) for call in connection.settimeout.call_args_list))

    def run_fixture(self, *, timeout=None, plan_change=None, completion_stalled=False):
        clock = Clock()
        process = Mock()
        process.poll.return_value = None
        plan = {'memory_limit_gb': 10, 'target_gb': 10, 'pool_slots': 833,
                'memory_ledger': {'expected_peak_bytes': 9_000_000_000},
                'max_prefill_wait_minutes': 17}
        plan.update(plan_change or {})
        vm = 'Mach Virtual Memory Statistics: (page size of 4096 bytes)\nPages free: 4000000.\nPages purgeable: 0.\nFile-backed pages: 0.\n'

        def request(_port, _method, path, body=None, **kwargs):
            if path == '/api/ps':
                if clock.now < 55:
                    raise ConnectionRefusedError()
                return {'models': [{'details': {'memory_plan': plan}}]}
            if path == '/slotstream/status':
                return {'memory_limit_gb': 10, 'memory_target_gb': 10}
            self.assertEqual(path, '/v1/chat/completions')
            self.assertEqual(body['max_tokens'], 12)
            self.assertEqual(kwargs, {'timeout': 120, 'deadline': clock.now + 120})
            if completion_stalled:
                clock.sleep(kwargs['timeout'])
                raise TimeoutError('completion timed out')
            return {'choices': [{'message': {'content': 'The Nile.'}}]}

        def launch(*args, **kwargs):
            kwargs['stdout'].write('elastic: on\n')
            kwargs['stdout'].flush()
            return process

        probe = Mock()
        probe.__enter__ = Mock(return_value=probe)
        probe.__exit__ = Mock(return_value=False)
        probe.getsockname.return_value = ('127.0.0.1', 12345)
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            binary = root/'binary'
            binary.write_bytes(b'fixture')
            argv = ['adaptive_memory_e2e.py', '--binary', str(binary), '--out', str(root/'result')]
            if timeout is not None:
                argv += ['--startup-timeout-seconds', str(timeout)]
            with patch.object(sys, 'argv', argv), \
                 patch('adaptive_memory_e2e.open', mock_open()), \
                 patch.object(fixture.socket, 'socket', return_value=probe), \
                 patch.object(fixture.time, 'monotonic', clock.monotonic), \
                 patch.object(fixture.time, 'sleep', clock.sleep), \
                 patch.object(fixture.fcntl, 'flock'), \
                 patch.object(fixture.subprocess, 'check_output', return_value=vm), \
                 patch.object(fixture.subprocess, 'Popen', side_effect=launch) as popen, \
                 patch.object(fixture, 'exchange', side_effect=request), \
                 contextlib.redirect_stdout(io.StringIO()):
                code = fixture.main()
            report = json.loads((root/'result/report.json').read_text())
        process.terminate.assert_called_once()
        process.wait.assert_called_once_with(timeout=15)
        self.assertTrue(report['server_reaped'])
        command = popen.call_args.args[0]
        self.assertEqual(command[command.index('--memory-limit-gb')+1], '10')
        self.assertEqual(command[command.index('--max-prefill-wait')+1], '17')
        return code, report

    def test_default_fixture_checks_settings_after_slow_startup(self):
        code, report = self.run_fixture()
        self.assertEqual(code, 0)
        self.assertEqual(report['startup_timeout_seconds'], 180)
        self.assertEqual(report['completion_timeout_seconds'], 120)
        self.assertGreaterEqual(report['startup_seconds'], 55)
        self.assertLess(report['startup_seconds'], 56)
        self.assertGreater(len(report['observations']), 2)
        self.assertIn('completion_seconds', report)

    def test_timeout_cleans_up_child_without_skipping_to_functional_checks(self):
        code, report = self.run_fixture(timeout=45)
        self.assertEqual(code, 1)
        self.assertIn('startup timed out', report['error'])
        self.assertEqual(report['observations'], [])

    def test_completion_timeout_still_fails_and_cleans_up(self):
        code, report = self.run_fixture(completion_stalled=True)
        self.assertEqual(code, 1)
        self.assertEqual(report['error'], 'completion timed out')
        self.assertEqual(report['completion_seconds'], 120)
        self.assertFalse(report['passed'])

    def test_lost_memory_or_prefill_settings_still_fail(self):
        for change in ({'memory_limit_gb': 11}, {'target_gb': 11},
                       {'memory_ledger': {'expected_peak_bytes': 11_000_000_000}},
                       {'max_prefill_wait_minutes': 30}):
            with self.subTest(change=change):
                code, report = self.run_fixture(plan_change=change)
                self.assertEqual(code, 1)
                self.assertFalse(report['passed'])


if __name__ == '__main__':
    unittest.main()
