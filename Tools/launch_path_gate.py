#!/usr/bin/env python3
"""Check the launcher's production PATH lookup with tiny executable fixtures.

Compiles only Launch.find, directly from the CLI source, with Foundation. No
model, installed coding agent, server or SwiftPM build is needed. Empty PATH
components must search the current directory, in their original position.
"""
import json
from pathlib import Path
import subprocess
import tempfile


ROOT = Path(__file__).resolve().parents[1]


def main():
    launch = (ROOT / 'Sources/slotstream-cli/LaunchCommand.swift').read_text()
    start = launch.index('    static func find(')
    end = launch.index('    static func codexVersion(', start)
    lookup = launch[start:end]
    entry = r'''
let found = Launch.find(CommandLine.arguments[1], path: CommandLine.arguments[2])
if let found { print(found) } else { exit(1) }
'''
    results = []
    with tempfile.TemporaryDirectory(prefix='slotstream-launch-path-') as folder:
        root = Path(folder)
        source = root / 'main.swift'
        source.write_text('import Foundation\nenum Launch {\n' + lookup + '}\n' + entry)
        binary = root / 'probe'
        subprocess.run(['xcrun', 'swiftc', '-swift-version', '5', str(source), '-o', str(binary)], check=True)
        for name in ['work', 'first', 'last', 'missing']:
            (root / name).mkdir()
        for name in ['work', 'first', 'last']:
            fixture = root / name / 'fixture-agent'
            fixture.write_text('#!/bin/sh\nexit 0\n')
            fixture.chmod(0o755)
        blocked = root / 'work' / 'blocked-agent'
        blocked.write_text('#!/bin/sh\nexit 0\n')
        blocked.chmod(0o644)
        for name in ['elsewhere-agent', 'blocked-agent', 'directory-agent']:
            fixture = root / 'first' / name
            fixture.write_text('#!/bin/sh\nexit 0\n')
            fixture.chmod(0o755)
        (root / 'work' / 'directory-agent').mkdir()
        (root / 'work' / 'linked-agent').symlink_to(root / 'first' / 'fixture-agent')

        # Literal expected paths pin discovery and search order independently
        # of the Swift implementation. No fixture executable is run.
        cases = [
            ('empty PATH', 'fixture-agent', '', './fixture-agent'),
            ('leading empty component', 'fixture-agent', ':../first', './fixture-agent'),
            ('trailing empty component', 'fixture-agent', '../missing:', './fixture-agent'),
            ('interior empty component', 'fixture-agent', '../missing::../last', './fixture-agent'),
            ('repeated empty components', 'fixture-agent', '::', './fixture-agent'),
            ('earlier directory wins', 'fixture-agent', '../first:', '../first/fixture-agent'),
            ('later directory wins when current directory misses', 'elsewhere-agent', '::../first', '../first/elsewhere-agent'),
            ('explicit current directory', 'fixture-agent', '.:../last', './fixture-agent'),
            ('absolute directory', 'fixture-agent', str(root / 'first'), str(root / 'first' / 'fixture-agent')),
            ('relative directories retain order', 'fixture-agent', '../first:../last', '../first/fixture-agent'),
            ('missing executable', 'absent-agent', ':../missing', None),
            ('nonexecutable file is skipped', 'blocked-agent', ':../missing', None),
            ('lookup continues past a nonexecutable file', 'blocked-agent', ':../first', '../first/blocked-agent'),
            ('directory is not an executable', 'directory-agent', ':../missing', None),
            ('lookup continues past a directory', 'directory-agent', ':../first', '../first/directory-agent'),
            ('executable symlink is accepted', 'linked-agent', ':../missing', './linked-agent'),
            ('explicit symlink directory', 'linked-agent', '.', './linked-agent'),
        ]
        for label, name, path, expected in cases:
            run = subprocess.run([str(binary), name, path], cwd=root / 'work',
                                 capture_output=True, text=True, timeout=10)
            got = run.stdout.rstrip('\n') if run.returncode == 0 else None
            passed = got == expected and run.returncode == (0 if expected else 1) and not run.stderr
            results.append(dict(case=label, passed=passed, found=got, expected=expected, exit=run.returncode))
    print(json.dumps(results, indent=2))
    raise SystemExit(0 if all(row['passed'] for row in results) else 1)


if __name__ == '__main__':
    main()
