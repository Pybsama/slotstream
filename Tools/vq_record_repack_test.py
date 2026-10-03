import hashlib
from pathlib import Path
import tempfile
import unittest
from vq_record_repack import ALIGNMENT, align, exact, header, write_layer, verify_layer

class RepackChecks(unittest.TestCase):
    def test_transposition_preserves_source_piece_order_and_zero_padding(self):
        rows=3;pieces=[5,2,7,3,4,6]
        tensors=[bytes((p*31+i)%256 for i in range(rows*n)) for p,n in enumerate(pieces)]
        hashes=[hashlib.sha256(x).hexdigest() for x in tensors]
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)/'records.safetensors'
            write_layer(path,rows=rows,pieces=pieces,stride=64,
                        read_piece=lambda p,r:tensors[p][r*pieces[p]:(r+1)*pieces[p]])
            self.assertEqual(verify_layer(path,rows=rows,pieces=pieces,stride=64,source_hashes=hashes),hashes)
            data=path.read_bytes();self.assertEqual(len(data),ALIGNMENT+rows*64)
            for r in range(rows):
                expected=b''.join(t[r*n:(r+1)*n] for t,n in zip(tensors,pieces))
                self.assertEqual(data[ALIGNMENT+r*64:ALIGNMENT+(r+1)*64],expected+b'\0'*(64-sum(pieces)))
            for position in (ALIGNMENT,ALIGNMENT+sum(pieces),10):
                altered=bytearray(data);altered[position]^=1;path.write_bytes(altered)
                with self.assertRaises(ValueError):verify_layer(path,rows=rows,pieces=pieces,stride=64,source_hashes=hashes)
            path.write_bytes(data[:-1])
            with self.assertRaises(ValueError):verify_layer(path,rows=rows,pieces=pieces,stride=64,source_hashes=hashes)

    def test_failed_build_never_creates_a_completion_manifest(self):
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)/'records.safetensors'
            with self.assertRaises(ValueError):write_layer(path,rows=3,pieces=[4]*6,stride=64,read_piece=lambda p,r:b'bad')
            self.assertFalse((Path(tmp)/'manifest.json').exists())
            with self.assertRaises(FileExistsError):write_layer(path,rows=3,pieces=[4]*6,stride=64,read_piece=lambda p,r:b'good')

    def test_invalid_extents_are_refused(self):
        for value in (0,-1,True,1.5):
            with self.assertRaises(ValueError):align(value)
        for rows,stride in [(0,16),(513,16),(True,16),(1,0),(1,3_000_001)]:
            with self.assertRaises(ValueError):header(rows,stride)
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)/'x'
            with self.assertRaises(ValueError):write_layer(path,rows=1,pieces=[7]*6,stride=16,read_piece=lambda p,r:b'')
            self.assertFalse(path.exists())

if __name__=='__main__':unittest.main()
