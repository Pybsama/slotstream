"""Independent recomputation from raw stats, not the benchmark's derived rates."""
import hashlib,itertools,json,math,statistics,sys
from pathlib import Path
root=Path(sys.argv[1])
load=lambda name:json.loads((root/name).read_text())
protocol=load('protocol.json');result=load('result.json');rows=load('runs.json');triplets=load('triplets.json');summary=load('summary.json')
identities=load('model-identities-before.json')
assert identities==load('model-identities-after.json')
comparable=[{name:{k:v for k,v in details.items() if k!='mtime_ns'} for name,details in identity.items()} for identity in identities.values()]
assert len(comparable)==2 and comparable[0]==comparable[1]
draft=load('draft-payload-sha256.json')
assert draft['external']==draft['internal'] and len(draft['external'])==64
auxiliary=load('auxiliary-payloads-before.json')
assert auxiliary==load('auxiliary-payloads-after.json')
assert auxiliary['external']==auxiliary['internal']
assert result['passed'] is True
assert len(rows)==84 and len(triplets)==24 and len(summary)==4
assert len({r['name'] for r in rows})==84
assert set(map(tuple,protocol['round_order']))==set(itertools.permutations(['external','internal','both']))
assert result['binary_sha256']==protocol['binary_sha256'] and result['head']==protocol['head']
payloads={}
metrics={}
peaks=[]
for row in rows:
 p=load(row['name']+'/stats.json');s=p['stats'];payloads[row['name']]=p
 assert (root/row['name']/'stdout.txt').read_text().rstrip('\n')==p['text'].rstrip('\n')
 assert row['exit']==0 and s['decodeTokens']==128 and s['reusedPrefixTokens']==0
 assert len(p['output_ids'])==128
 assert not any(s.get(k) for k in ['runtimeError','requestFailure','memoryPressureCancelled'])
 timing=load(row['name']+'/process-timing.json')
 assert timing['started_ns']<timing['first_output_ns']<=timing['exited_ns']
 assert math.isclose((timing['exited_ns']-timing['started_ns'])/1e9,row['process_wall_s'],rel_tol=1e-12)
 v={'ttft_s':s['firstTokenSeconds'],'first_text_s':s['firstTextSeconds'],'request_s':s['requestSeconds'],
    'process_wall_s':row['process_wall_s'],'process_first_text_s':(timing['first_output_ns']-timing['started_ns'])/1e9,'prefill_tps':s['prefillTokens']/s['prefillSeconds'],
    'decode_tps':s['decodeTokens']/s['decodeSeconds']}
 assert all(math.isfinite(x) and x>0 for x in v.values())
 assert v['ttft_s']<=v['request_s'] and v['first_text_s']<=v['request_s']
 assert v['request_s']<=v['process_wall_s']+.1
 for k in v:assert math.isclose(v[k],row['metrics'][k],rel_tol=1e-12)
 metrics[row['name']]=v
 profile=next(x for x in protocol['profiles'] if x['name']==row['profile'])
 assert p['effective_mtp']==(profile['mtp']=='on')
 if p['effective_mtp']: assert s['draftedTokens']>0
 peak=max(s['sampledFootprint']['peakBytes'],s['lifetimeRSSPeakBytes'],s['physicalFootprintEndBytes'],s['lifetimePhysicalFootprintPeakBytes'])
 assert peak<=profile['memory_gb']*1e9
 peaks.append(peak)
 assert s['sampledFootprint']['samples']>0 and s['sampledFootprint']['intervalMilliseconds']==20
 if row['arm']=='both':assert len(s['mirrorBytes'])==2 and all(x>0 for x in s['mirrorBytes'])
 else:assert not s['mirrorBytes']
 if not row['warmup']:
  assert row['eligible']
  assert all(row['vm_before'][k]==row['vm_after'][k] for k in ['swapins','swapouts'])
  assert all(s[k]['thermalState']=='nominal' and s[k]['lowPowerModeEnabled'] is False for k in ['generatorSystemBefore','generatorSystemAfter'])
for profile in protocol['profiles']:
 expected=None
 for round_number in range(7):
  selected=[r for r in rows if r['profile']==profile['name'] and r['round']==round_number]
  assert len(selected)==3
  assert [r['arm'] for r in selected]==(protocol['warmup_order'] if round_number==0 else protocol['round_order'][round_number-1])
  payload=[payloads[r['name']] for r in selected]
  for k in ['prompt_ids','output_ids','text','effective_pool_slots','effective_prefill_chunk','effective_mtp','optimizations']:
   assert payload[0][k]==payload[1][k]==payload[2][k]
  current={k:payload[0][k] for k in ['prompt_ids','output_ids','text','effective_pool_slots','effective_prefill_chunk','effective_mtp','optimizations']}
  if expected is not None:assert expected==current
  expected=current
 group=[r for r in rows if r['profile']==profile['name'] and not r['warmup']]
 published=next(x for x in summary if x['profile']==profile['name'])
 assert published['eligible_rounds']==6 and not published['excluded_rounds']
 for arm in ['external','internal','both']:
  for key in v:
   median=statistics.median(metrics[r['name']][key] for r in group if r['arm']==arm)
   assert math.isclose(median,published['arm_medians'][arm][key],rel_tol=1e-12)
 for key in v:
  gains=[]
  for n in range(1,7):
   arms={r['arm']:metrics[r['name']][key] for r in group if r['round']==n}
   best=(max if key.endswith('_tps') else min)(arms['external'],arms['internal'])
   gain=arms['both']/best-1 if key.endswith('_tps') else 1-arms['both']/best
   gains.append(gain)
   recorded=next(t for t in triplets if t['profile']==profile['name'] and t['round']==n)
   assert math.isclose(gain,recorded['benefit_vs_best_single'][key],rel_tol=1e-12,abs_tol=1e-12)
  p=published['best_single_comparison'][key]
  assert math.isclose(statistics.median(gains),p['median_benefit'],rel_tol=1e-12,abs_tol=1e-12)
  assert min(gains)==p['minimum_benefit'] and max(gains)==p['maximum_benefit']
  assert sum(x>0 for x in gains)==p['positive_rounds']
topology=load('disk-topology.json')
assert not set(topology['external']['physical_disks']) & set(topology['internal']['physical_disks'])
receipt={'passed':True,'runs':len(rows),'measured_runs':72,'measured_triplets':24,'warmups':12,
         'process_peak_bytes':max(peaks),'source_commit':result['head'],'binary_sha256':result['binary_sha256'],
         'all_run_swap_unchanged':all(all(r['vm_before'][k]==r['vm_after'][k] for k in ['swapins','swapouts']) for r in rows)}
(root/'independent-audit.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
