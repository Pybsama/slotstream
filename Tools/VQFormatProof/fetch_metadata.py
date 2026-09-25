from pathlib import Path
from datetime import datetime,timezone
import hashlib,json,urllib.request,sys
if len(sys.argv) != 2: raise SystemExit('usage: fetch_metadata.py <data-directory>')
ROOT=Path(sys.argv[1]).resolve()
ROOT.mkdir(parents=True,exist_ok=True)
REVISION='8684640a3956b01c47f5d47f9b999e2ab8b985f1'
MODEL='TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw'
def fetch(url,cap):
 req=urllib.request.Request(url,headers={'User-Agent':'Slotstream-contribution-format-audit'})
 with urllib.request.urlopen(req,timeout=40) as r:
  raw=r.read(cap+1)
  if len(raw)>cap: raise RuntimeError('metadata response exceeded bound')
 return raw
meta=fetch('https://huggingface.co/api/models/'+MODEL+'/revision/'+REVISION+'?blobs=true',4_000_000)
info=json.loads(meta);revision=info['sha'];
if revision != REVISION: raise RuntimeError('checkpoint revision mismatch')
(ROOT/'candidate-hf-metadata.json').write_bytes(meta)
small=ROOT/'candidate';small.mkdir(exist_ok=True)
allowed=['README.md','config.json','model.py','model.safetensors.index.json','LICENSE','LICENSE.txt']
files={x['rfilename']:x for x in info['siblings']};receipts=[]
for name in allowed:
 if name not in files:continue
 url='https://huggingface.co/'+MODEL+'/resolve/'+revision+'/'+name
 raw=fetch(url,2_000_000);(small/name).write_bytes(raw)
 receipts.append({'path':name,'url':url,'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest()})
weights=[x for x in info['siblings'] if x['rfilename'].endswith('.safetensors')]
receipt={'model':MODEL,'revision':revision,'checked_at':datetime.now(timezone.utc).isoformat(),'metadata_only':True,'gated':info.get('gated'),'private':info.get('private'),'weight_files':len(weights),'listed_weight_bytes':sum(x.get('size',0) for x in weights),'listed_weights':[{'name':x['rfilename'],'bytes':x.get('size'),'lfs':x.get('lfs')} for x in weights],'downloaded':receipts}
(ROOT/'candidate-receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
config=json.loads((small/'config.json').read_text());q=config.get('quantization',{})
print(json.dumps({'revision':revision,'weight_files':len(weights),'listed_weight_bytes':receipt['listed_weight_bytes'],'metadata_bytes_downloaded':len(meta)+sum(x['bytes'] for x in receipts),'files':[x['path'] for x in receipts],'model_file':config.get('model_file'),'config_keys':list(config),'root_quantization':{k:q.get(k) for k in ['bits','group_size','mode']}},indent=2))
