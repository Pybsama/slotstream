#!/usr/bin/env python3
"""Actual Home CLI, official dbmd, owner IPC and MCP in disposable Homes."""
import argparse
import concurrent.futures
import hashlib
import json
import os
from pathlib import Path
import select
import subprocess
import tempfile
import time


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--bin-dir', type=Path, required=True)
    parser.add_argument('--dbmd', type=Path, default=Path.home() / '.dbmd/bin/dbmd')
    args = parser.parse_args()
    cli = str((args.bin_dir / 'slotstream-home').resolve())
    checks = str((args.bin_dir / 'slotstream-mac-checks').resolve())
    env = dict(os.environ, SLOTSTREAM_DBMD=str(args.dbmd))
    env.pop('SLOTSTREAM_HOME', None)
    with tempfile.TemporaryDirectory(prefix='slotstream-data-check-') as scratch:
        root = Path(scratch).resolve()
        registry = root / 'registry'
        base = [cli, '--registry', str(registry), '--json']
        def run(*words, ok=True):
            result = subprocess.run(base + list(map(str, words)), text=True, capture_output=True, env=env, timeout=35)
            assert (result.returncode == 0) == ok, (words, result.returncode, result.stdout, result.stderr)
            if not ok:
                return result.stderr
            return json.loads(result.stdout)
        def write(home, path, title, body, fields=()):
            bodyfile = root / 'body.txt'; bodyfile.write_text(body)
            command = [str(args.dbmd), 'write', path, '--dir', str(home / 'db'), '--type', 'project-note', '--summary', title, '--body-file', str(bodyfile), '--fm', 'title=' + title, '--json']
            for field in fields:
                command += ['--fm', field]
            result = subprocess.run(command, text=True, capture_output=True, env=env, check=True)
            return json.loads(result.stdout)['written']
        a, b = root / 'Personal', root / 'Research'
        run('homes', 'create', a)
        run('homes', 'create', b)
        state = run('homes', 'list')
        assert len(state['homes']) == 2 and all('id' in entry for entry in state['homes'])
        run('homes', 'use', a)
        path_bin = root / 'bin'; path_bin.mkdir()
        (path_bin / 'slotstream-home').symlink_to(cli)
        via_path = subprocess.run(['slotstream-home', 'mcp-config', '--home', str(a), '--registry', str(registry)],
                                  cwd=root, env=dict(env, PATH=str(path_bin) + os.pathsep + env['PATH']),
                                  text=True, capture_output=True, check=True, timeout=15)
        assert json.loads(via_path.stdout)['mcpServers']['slotstream-home']['command'] == cli
        print('PASS: PATH invocation resolves the real executable for portable MCP configuration')
        one = write(a, 'records/notes/alpha.md', 'Alpha plan', 'A literal [square] token. Workshop on Friday.', ['status=open', 'project=pilot'])
        two = write(a, 'records/notes/beta.md', 'Beta plan', 'Related to [[' + one.removesuffix('.md') + ']].', ['status=closed', 'project=pilot'])
        write(a, 'records/notes/gamma.md', 'Gamma plan', 'Other work.', ['status=open', 'project=other'])
        write(b, 'records/notes/research.md', 'Research only', 'OTHER-HOME-CANARY')
        saved = {str(p.relative_to(a)): hashlib.sha256(p.read_bytes()).hexdigest() for p in a.rglob('*.md')}
        page = run('data', 'list', '--sort', 'title', '--limit', 1)
        assert page['total'] == 3 and page['records'][0]['title'] == 'Alpha plan' and page['nextOffset'] == 1, page
        following = run('data', 'list', '--sort', 'title', '--limit', 1, '--offset', 1, '--revision', page['revision'])
        assert following['records'][0]['title'] == 'Beta plan'
        assert run('data', 'list', '--where', 'status=open', '--where', 'project=pilot')['total'] == 1
        assert run('data', 'search', '[SQUARE]')['records'][0]['path'] == one
        detail = run('data', 'show', one)
        assert detail['records'][0]['sha256'] and any('beta' in p for p in detail['backlinks'])
        assert run('data', 'list', '--section', 'conversations')['records'][0]['title'] == 'Home'
        assert run('data', 'schema')['json']
        run('data', 'list', '--section', 'sources')
        run('data', 'log')
        assert saved == {str(p.relative_to(a)): hashlib.sha256(p.read_bytes()).hexdigest() for p in a.rglob('*.md')}, 'Reads changed persistent data'
        print('PASS: filtering, literal search, sorting, complete pagination, schema, backlinks and byte-preserving offline reads')
        write(a, 'records/notes/delta.md', 'Delta plan', 'Changed query')
        assert 'changed while paging' in run('data', 'list', '--sort', 'title', '--limit', 1, '--offset', 1, '--revision', page['revision'], ok=False)
        run('data', 'list', '--limit', 0, ok=False)
        run('data', 'show', '../Research/db/DB.md', ok=False)
        run('data', 'show', '.sevra/session-capability', ok=False)
        run('data', 'list', '--dbmd', root / 'missing-dbmd', ok=False)
        (a / 'db/records/escape.md').symlink_to(b / 'db/DB.md')
        run('data', 'show', 'records/escape.md', ok=False)
        (a / 'db/records/escape.md').unlink()
        missing = root / 'Missing'
        run('data', 'list', '--home', missing, ok=False)
        assert not missing.exists()
        assert run('data', 'search', 'OTHER-HOME-CANARY')['total'] == 0
        assert run('data', 'search', 'OTHER-HOME-CANARY', '--home', b)['total'] == 1
        print('PASS: stale pages, bounds, traversal, symlinks, missing Homes and cross-Home isolation')
        # Real concurrent registry writes must merge rather than lose a Home.
        extra = [root / f'H{i}' for i in range(4)]
        with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
            list(pool.map(lambda p: run('homes', 'create', p), extra))
        assert len(run('homes', 'list')['homes']) == 6
        run('homes', 'use', a)
        print('PASS: concurrent Home registration and stable explicit selection')

        class MCP:
            def __init__(self, home, allow=False):
                self.process = subprocess.Popen(base + ['serve', '--home', str(home)] + (['--allow-ask'] if allow else []), stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
                self.next_id = 0
                result = self.rpc('initialize', {'protocolVersion': '2025-06-18', 'capabilities': {}, 'clientInfo': {'name': 'home-integration-check', 'version': '1'}})
                assert result['result']['protocolVersion'] == '2025-06-18'
                self.notify('notifications/initialized')
            def notify(self, method):
                self.process.stdin.write((json.dumps({'jsonrpc':'2.0','method':method})+'\n').encode()); self.process.stdin.flush()
            def rpc(self, method, params=None):
                self.next_id += 1
                self.process.stdin.write((json.dumps({'jsonrpc':'2.0','id':self.next_id,'method':method,'params':params or {}})+'\n').encode()); self.process.stdin.flush()
                if not select.select([self.process.stdout], [], [], 25)[0]:
                    self.process.kill(); self.process.wait(); raise AssertionError('MCP response timed out: ' + self.process.stderr.read().decode())
                response = json.loads(self.process.stdout.readline())
                assert response['id'] == self.next_id and response['jsonrpc'] == '2.0'
                return response
            def tool(self, name, arguments=None):
                return self.rpc('tools/call', {'name':name,'arguments':arguments or {}})
            def close(self):
                self.process.stdin.close()
                try: self.process.wait(timeout=15)
                except subprocess.TimeoutExpired: self.process.kill(); self.process.wait(); raise
                assert self.process.returncode == 0, self.process.stderr.read().decode()
        server = MCP(a)
        try:
            tools = server.rpc('tools/list')['result']['tools']
            assert 'ask' not in [t['name'] for t in tools]
            run('homes', 'use', b)
            result = json.loads(server.tool('data_list')['result']['content'][0]['text'])
            assert result['total'] == 4 and result['homePath'].endswith('/Personal')
            assert server.tool('data_show', {'path':'../escape.md'})['result']['isError']
            assert server.tool('data_list', {'unknown':True})['error']['code'] == -32602
            assert server.tool('data_list', {'limit':False})['result']['isError']
            assert server.tool('ask', {'prompt':'wrong', 'nonce':'x'})['error']['code'] == -32602
            assert server.rpc('unknown')['error']['code'] == -32601
            assert not server.rpc('ping').get('error')
        finally: server.close()
        print('PASS: real MCP initialization, discovery, calls, error handling, read-only scope and session Home binding')

        live = root / 'Live'
        owner = subprocess.Popen([checks, '--home-owner-fixture', str(live)], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, env=env)
        server = None
        try:
            assert select.select([owner.stdout], [], [], 25)[0], 'Owner startup timed out'
            ready = owner.stdout.readline().decode().strip()
            assert ready.startswith('READY '), ready
            private_id = ready.split()[1]
            first = run('data', 'list', '--section', 'conversations', '--home', live)
            assert first['total'] == 1
            assert 'PRIVATE-DATA-BROWSER-CANARY' not in json.dumps(run('data', 'show', 'records/state/home.md', '--home', live))
            run('status', '--home', live, '--thread', private_id, ok=False)
            answer = run('ask', 'When is the workshop?', '--home', live, '--nonce', 'integration-ask')
            assert answer['thread']['messages'][-1]['text'] == 'The workshop is on Friday.'
            again = run('ask', 'When is the workshop?', '--home', live, '--nonce', 'integration-ask')
            assert again['thread']['run']['id'] == answer['thread']['run']['id']
            server = MCP(live, allow=True)
            assert 'ask' in [t['name'] for t in server.rpc('tools/list')['result']['tools']]
            value = json.loads(server.tool('run_status')['result']['content'][0]['text'])
            assert value['thread']['run']['id'] == answer['thread']['run']['id']
            assert server.tool('run_status', {'thread':private_id})['result']['isError']
            assert json.loads(server.tool('data_list', {'section':'conversations'})['result']['content'][0]['text'])['total'] == 1
            submitted = json.loads(server.tool('ask', {'prompt':'Propose a workshop document.', 'nonce':'mcp-review'})['result']['content'][0]['text'])
            assert submitted['runID']
            for _ in range(100):
                state = json.loads(server.tool('run_status')['result']['content'][0]['text'])
                if state['thread']['run']['state'] in ('needsYou', 'failed'): break
                time.sleep(0.05)
            assert state['thread']['run']['state'] == 'needsYou', state
            assert not (live / 'artifacts/workshop.md').exists(), 'MCP bypassed native review'
            assert server.tool('approve', {})['error']['code'] == -32602
        finally:
            if server: server.close()
            owner.stdin.write(b'quit\n'); owner.stdin.flush()
            try: owner.wait(timeout=20)
            except subprocess.TimeoutExpired: owner.kill(); owner.wait(); raise
            assert owner.returncode == 0, owner.stderr.read().decode()
        assert run('data', 'list', '--section', 'conversations', '--home', live)['total'] == 1
        run('ask', 'App is closed', '--home', live, ok=False)
        print('PASS: live owner attachment, CLI ask and nonce reconciliation, MCP observations, Incognito exclusion and offline reopen')
    print('HOME INTEGRATION CHECKS PASS')


if __name__ == '__main__':
    main()
