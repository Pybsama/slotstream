import copy
import unittest
from vq_pilot_admission import eligible, wait_until_stable

GOOD = {'native': {'conditions': {'thermalState': 'nominal', 'lowPowerModeEnabled': False},
                   'vm': {'reclaimableBytes': 13_000_000_000}},
        'external': {'reclaimable_bytes': 13_000_000_000}}

class AdmissionChecks(unittest.TestCase):
    def test_both_observers_and_power_policy_are_required(self):
        self.assertTrue(eligible(GOOD))
        bads=[]
        for path,value in [(('native','vm','reclaimableBytes'),12_999_999_999),
                           (('external','reclaimable_bytes'),12_999_999_999),
                           (('native','conditions','thermalState'),'fair'),
                           (('native','conditions','lowPowerModeEnabled'),True),
                           (('native','vm'),None),
                           (('external','reclaimable_bytes'),True)]:
            bad=copy.deepcopy(GOOD);target=bad
            for key in path[:-1]:target=target[key]
            target[path[-1]]=value;bads.append(bad)
        for bad in bads:self.assertFalse(eligible(bad))

    def test_one_bad_observation_resets_the_whole_interval(self):
        clock=[0];events=[];bad=copy.deepcopy(GOOD);bad['native']['conditions']['thermalState']='fair'
        def sample():return bad if clock[0]==10 else GOOD
        def sleep(n):clock[0]+=n
        result=wait_until_stable(sample,now=lambda:clock[0],sleep=sleep,publish=lambda r:events.append(r),stable_seconds=15,maximum_wait=40)
        self.assertTrue(result['passed']);self.assertEqual(clock[0],30)
        self.assertEqual(result['samples'][2]['stable_seconds'],0)

    def test_missing_conditions_times_out_without_admission(self):
        clock=[0];events=[]
        with self.assertRaises(TimeoutError):
            wait_until_stable(lambda:{},now=lambda:clock[0],sleep=lambda n:clock.__setitem__(0,clock[0]+n),publish=events.append,stable_seconds=10,maximum_wait=20)
        self.assertEqual(clock[0],20);self.assertFalse(events[-1]['passed'])

    def test_slow_observer_cannot_admit_after_deadline(self):
        clock=[0];events=[]
        def sample():clock[0]+=11;return GOOD
        with self.assertRaises(TimeoutError):
            wait_until_stable(sample,now=lambda:clock[0],sleep=lambda n:clock.__setitem__(0,clock[0]+n),publish=events.append,stable_seconds=1,maximum_wait=10)
        self.assertFalse(events[-1]['passed'])

if __name__=='__main__':unittest.main()
