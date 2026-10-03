"""Refuse evidence that swaps cache profiles, producer or numerical gates."""
import copy
import hashlib
import json
from pathlib import Path
import unittest
from vq_contiguous_expert_pilot import ARMS, PROFILE_SHAS, IDENTITY_SHA, VQ_INVENTORY, validate_receipt, validate_gate, PACKED_MANIFEST_SHA

class RecordLayoutChecks(unittest.TestCase):
    def test_receipt_cannot_swap_cache_geometry_or_producer(self):
        root=Path(__file__).resolve().parent.parent
        producer={'binary_sha256':'binary','metallib_sha256':'metal'}
        for arm,file in [('split','dense-reinvestment-cost-v1.json'),('contiguous','contiguous-record-cost-v1.json')]:
            raw=(root/'bench/quantization'/file).read_bytes()
            self.assertEqual(hashlib.sha256(raw).hexdigest(),PROFILE_SHAS[arm])
            profile=json.loads(raw);reference=profile['references'][IDENTITY_SHA];factor=3
            cache={'parallel_read_lanes':12,'total_capacity':608*factor,'reserved_bank_bytes':1194393600*factor,
                   'maximum_bank_capacity':512*factor,'minimum_bank_capacity':96*factor,'occupied_records':608*factor,
                   'dense_savings_reinvested':1,'maximum_executed_slot':512*factor-1,
                   'minimum_class_maximum_executed_slot':96*factor-1,'pinned_records':0}
            receipt={'passed':True,'mode':'validation','profile_sha256':PROFILE_SHAS[arm],'producer':producer,
                     'pack':'3.2-dense-affine4','inventory_sha256':VQ_INVENTORY,'composite_sha256':IDENTITY_SHA,
                     'verified_files':138,'overlay_verified_files':9,'resident_text':{'payload_bytes':2893477400},
                     'cache_after':cache,'peak_process_bytes':9_000_000_000,'generated':reference['generated'],
                     'observed_logit_hashes':[x['sha256'] for x in reference['logits']],
                     'record_storage':'contiguous-records-16k-v1' if arm=='contiguous' else 'split-tensor-ranges-v1',
                     'packed_manifest_sha256':PACKED_MANIFEST_SHA if arm=='contiguous' else None,
                     'packed_verified_files':48 if arm=='contiguous' else 0,
                     'packed_verified_bytes':47866183680 if arm=='contiguous' else 0,
                     'expert_file_read_policy':'buffered-v1', 'uncached_expert_files':0}
            validate_receipt(receipt,arm,profile,producer,measurement=False)
            for field,value in [('producer',{}),('profile_sha256','wrong'),('peak_process_bytes',10_000_000_001),('observed_logit_hashes',[]),('expert_file_read_policy','other'),('uncached_expert_files',8),('packed_manifest_sha256','other'),('packed_verified_bytes',1),('packed_verified_files',47),('record_storage','other')]:
                bad=copy.deepcopy(receipt);bad[field]=value
                with self.assertRaises(ValueError):validate_receipt(bad,arm,profile,producer,measurement=False)
            for field in ('reserved_bank_bytes','maximum_executed_slot','occupied_records','pinned_records'):
                bad=copy.deepcopy(receipt);bad['cache_after'][field]+=1
                with self.assertRaises(ValueError):validate_receipt(bad,arm,profile,producer,measurement=False)
            other=ARMS[1] if arm==ARMS[0] else ARMS[0]
            with self.assertRaises(ValueError):validate_receipt(receipt,other,profile,producer,measurement=False)

    def test_sparse_gate_does_not_pretend_it_filled_the_whole_cache(self):
        r={'composite_sha256':IDENTITY_SHA,'inventory_sha256':VQ_INVENTORY,'report':{'passed':True},
           'process_bound_bytes':10_000_000_000,'peak_process_bytes':9_000_000_000,
           'expert_file_read_policy':'buffered-v1','uncached_expert_files':0,
           'record_storage':'contiguous-records-16k-v1','packed_manifest_sha256':PACKED_MANIFEST_SHA,
           'packed_verified_files':48,'packed_verified_bytes':47866183680,
           'observed':{str(i):'hash' for i in range(984)},
           'resident_record_cache':{'dense_savings_reinvested':1,'total_capacity':1824,
                                   'reserved_bank_bytes':3583180800,'pinned_records':0}}
        validate_gate(r,True,'contiguous')
        with self.assertRaises(ValueError):validate_gate(r,False,'contiguous')
        r['resident_record_cache'].update(maximum_executed_slot=1535,minimum_class_maximum_executed_slot=287)
        r['observed']={str(i):'hash' for i in range(2560)}
        validate_gate(r,False,'contiguous')
        r['report']['passed']=False
        with self.assertRaises(ValueError):validate_gate(r,False,'contiguous')

if __name__=='__main__':unittest.main()
