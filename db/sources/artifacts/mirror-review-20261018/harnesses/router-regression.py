import hashlib,json,subprocess
from pathlib import Path
ROOT=Path('/Volumes/external/slotstream')
OUT=Path('/Volumes/external/review-evidence/router-regression')
OUT.mkdir(exist_ok=False)
router='Sources/Slotstream/CheckpointMirror.swift'
diag='Sources/SlotstreamDiagnostics/Diagnostics+CheckpointMirror.swift'
base='72e882d03ab97e56e01ff9f2189664b36fc3f4f2'
old=lambda path:subprocess.check_output(['git','show',base+':'+path],cwd=ROOT,text=True)
new=lambda path:(ROOT/path).read_text()
report=(ROOT/'Sources/SlotstreamDiagnostics/CheckReport.swift').read_text()
rows=[]
for name,r,d,expected in [('original-tests-original-router',old(router),old(diag),True),('new-tests-original-router',old(router),new(diag),False),('new-tests-fixed-router',new(router),new(diag),True)]:
 cell=OUT/name;cell.mkdir()
 code=report+'\npublic enum Diagnostics {}\n'+r+'\n'+d.replace('import Slotstream\n','')+'\nlet report = Diagnostics.checkpointMirror()\nprint(String(data: try JSONEncoder().encode(report), encoding: .utf8)!)\n'
 source=cell/'main.swift';source.write_text(code)
 subprocess.run(['swiftc','-swift-version','5','-package-name','slotstream',str(source),'-o',str(cell/'checks')],check=True,timeout=120,stdout=(cell/'compile.stdout').open('w'),stderr=(cell/'compile.stderr').open('w'))
 result=subprocess.run([str(cell/'checks')],check=True,capture_output=True,text=True,timeout=30)
 (cell/'report.json').write_text(result.stdout)
 value=json.loads(result.stdout)
 assert value['passed']==expected,name
 rows.append({'case':name,'expected_pass':expected,'observed_pass':value['passed'],'assertions':len(value['items']),'failures':[x for x in value['items'] if not x['passed']], 'router_sha256':hashlib.sha256(r.encode()).hexdigest()})
(OUT/'result.json').write_text(json.dumps({'passed':True,'cases':rows},indent=2)+'\n')
print(json.dumps(rows,indent=2))
