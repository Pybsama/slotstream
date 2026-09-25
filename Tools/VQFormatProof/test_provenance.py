"""Real-fixture checks must fail before native/oracle comparisons can run."""
import json
import pathlib
import shutil
import sys
import tempfile
from test_proof import real_fixtures

passed = []
with tempfile.TemporaryDirectory(prefix='vq-provenance-') as temp:
    root = pathlib.Path(temp)
    def reject(label, directory):
        try: real_fixtures(directory)
        except (ValueError, KeyError, OSError): passed.append(label)
        else: raise RuntimeError('accepted ' + label)
    reject('missing_directory', root / 'missing')
    reject('empty_directory', root)
    fixtures = root / 'fixtures'
    shutil.copytree(pathlib.Path(sys.argv[1]), fixtures)
    real_fixtures(fixtures)
    code = fixtures / 'protected_gate/codes.bin'; original = code.read_bytes()
    code.write_bytes(bytes([original[0] ^ 1]) + original[1:]); reject('changed_payload', fixtures)
    code.write_bytes(original)
    provenance = fixtures / 'protected_gate/source.json'; original = provenance.read_bytes()
    for label, key, value in [('revision', 'revision', '0'*40), ('module', 'module', 'wrong.module'),
                              ('model', 'model', 'wrong/model')]:
        source = json.loads(original); source[key] = value; provenance.write_text(json.dumps(source))
        reject('wrong_' + label, fixtures); provenance.write_bytes(original)
    geom = fixtures / 'protected_gate/geometry.json'; original = geom.read_bytes()
    source = json.loads(original); source['rows'] = 1; geom.write_text(json.dumps(source))
    reject('changed_geometry', fixtures); geom.write_bytes(original)
    shutil.rmtree(fixtures / 'ple'); reject('missing_real_module', fixtures)
print(json.dumps({'malformed_rejected': passed}, indent=2))
