import hashlib,json,os,subprocess,sys
from pathlib import Path
ROOT=Path('/Volumes/external/slotstream')
OUT=Path('/Volumes/external/review-evidence/mirror-runtime')
OUT.mkdir(exist_ok=False)
sys.path.insert(0,str(ROOT/'Tools'))
from context_qualification import quiet_preflight
from prefill_bench import run_child
BIN=ROOT/'.build/release/slotstream'
EXTERNAL=Path('/Volumes/external/model')
INTERNAL=Path('/Volumes/internal/model')
env={k:v for k,v in os.environ.items() if not k.startswith(('SLOTSTREAM_','SS_DEBUG'))}
rows=[]
def run(name,argv,needed=13,timeout=1800):
 cell=OUT/name;cell.mkdir()
 quiet_preflight(needed)
 cmd=[str(BIN),*argv]
 (cell/'command.json').write_text(json.dumps(cmd,indent=2)+'\n')
 code=run_child(cmd,env,cell,timeout)
 rows.append({'name':name,'exit':code})
 (OUT/'runs.json').write_text(json.dumps(rows,indent=2)+'\n')
 assert code==0,name
 print('PASS',name,flush=True)
 return cell
run('prefix-exact-mirror',['prefix-exact-check','--model',str(EXTERNAL),'--mirror',str(INTERNAL)])
run('prefix-exact-mirror-plan-mtp',['prefix-exact-check','--plan','--memory-gb','12','--mtp','on','--vision','off','--model',str(EXTERNAL),'--mirror',str(INTERNAL),'--max-tokens','12'],needed=15)
combined=run('mtp-vision-mirror',['mtp-check','--memory-gb','12','--mtp','on','--vision','on',
 '--image',str(ROOT/'Tools/assets/vision_test/secret1.jpg'),'--model',str(EXTERNAL),
 '--mirror',str(INTERNAL)],needed=15)
text=(combined/'stdout.txt').read_text()+(combined/'stderr.txt').read_text()
assert 'PASS  vision speculation deterministic' in text
assert 'PASS  vision speculation ran' in text
assert 'SKIP' not in text and 'MTP CHECK PASS' in text
memory=[json.loads(line.removeprefix('MTP CHECK MEMORY ')) for line in text.splitlines() if line.startswith('MTP CHECK MEMORY ')]
assert len(memory)==1 and memory[0]['memory_validated'] is True
rows.append({'name':'mtp-vision-memory','passed':True,'receipt':memory[0]})
for arm in ['single','mirror']:
 args=['vision-parity','--model',str(EXTERNAL),'--out',str(OUT/f'vision-{arm}'/'tensors')]
 if arm=='mirror':args+=['--mirror',str(INTERNAL)]
 run('vision-'+arm,args)
for filename in ['pixels.bin','embed.bin','manifest.json']:
 a=(OUT/'vision-single'/'tensors'/filename).read_bytes()
 b=(OUT/'vision-mirror'/'tensors'/filename).read_bytes()
 assert a==b,filename
rows.append({'name':'vision-byte-equality','passed':True,'files':['pixels.bin','embed.bin','manifest.json']})
(OUT/'result.json').write_text(json.dumps({'passed':True,'checks':rows},indent=2)+'\n')
