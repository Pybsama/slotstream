#!/usr/bin/env python3
"""Bounded investigation of routing handoffs. No production dispatch changes.

micro: identical synthetic MoE math with host or GPU expert-to-slot lookup.
The all-hit immutable pool is an optimistic mechanism test, not inference.
Python overhead is included, so timings cannot establish a Swift speedup.

model: current native engine versus its existing resident-overlap prototype.
This tests useful overlap, not the unimplemented GPU-directory architecture.
All raw cells, paging exclusions, hashes and exact output checks are retained.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import statistics
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "Tools"))
from prefill_bench import digest, host_conditions, preflight, vm_snapshot


def write(path, value):
    with path.open("x") as f:
        json.dump(value, f, indent=2, sort_keys=True)
        f.write("\n")


def clean(before, after):
    return all(before[k] == after[k] for k in ("swapins", "swapouts"))


def micro(out, rounds, layers):
    import importlib.metadata
    import mlx.core as mx

    preflight(4)
    mx.set_cache_limit(64 << 20)
    mx.set_memory_limit(2_000_000_000)
    mx.random.seed(59)
    slots, experts, hidden, intermediate, topk = 32, 512, 2560, 640, 10
    # An immutable, known-complete resident set. Other IDs are never routed
    # in the timing workload; missing-ID handling is tested separately below.
    resident = [(i * 13 + 7) % experts for i in range(slots)]
    host_map = {expert: slot for slot, expert in enumerate(resident)}
    mapping = [host_map.get(i, -1) for i in range(experts)]
    directory = mx.array(mapping, dtype=mx.int32)
    mask = mx.array([i in host_map for i in range(experts)])
    router = mx.random.normal((experts, hidden)) / hidden**0.5
    pools = []
    for output, input_size in [(intermediate, hidden), (intermediate, hidden), (hidden, intermediate)]:
        weights = (mx.random.normal((slots, output, input_size)) / input_size**0.5).astype(mx.bfloat16)
        q = mx.quantize(weights, group_size=64, bits=4)
        mx.eval(q)
        pools.append(q)
        del weights
        mx.clear_cache()
    initial = mx.random.normal((1, 1, hidden)).astype(mx.bfloat16)
    mx.eval(initial, directory, mask, router)

    def project(x, slot_ids):
        xe = mx.expand_dims(x, (-2, -3))
        def qmm(a, pool):
            w, scales, biases = pool
            return mx.gather_qmm(a, w, scales=scales, biases=biases,
                                 rhs_indices=slot_ids, transpose=True,
                                 group_size=64, bits=4)
        gate, up = qmm(xe, pools[0]), qmm(xe, pools[1])
        value = gate * mx.sigmoid(gate) * up
        return mx.squeeze(qmm(value, pools[2]), -2)

    def run(mode, depth):
        x = initial
        routes = []
        for layer in range(depth):
            scores = mx.where(mask, x.astype(mx.float32) @ router.T, -float("inf"))
            ids = mx.argpartition(-scores, kth=topk-1, axis=-1)[..., :topk].astype(mx.int32)
            probabilities = mx.softmax(mx.take_along_axis(scores, ids, -1), axis=-1, precise=True)
            if mode == "host":
                cpu_ids = ids.reshape(-1).tolist()
                slot_ids = mx.array([host_map[i] for i in cpu_ids], dtype=mx.int32).reshape(ids.shape)
            else:
                slot_ids = directory[ids]
                if mode == "device_checked" and bool(mx.any(slot_ids < 0).item()):
                    raise AssertionError("unexpected miss in frozen all-hit workload")
            value = project(x, slot_ids)
            x = (x + (value * probabilities[..., None]).sum(-2).astype(x.dtype) * 0.03125).astype(mx.bfloat16)
            routes.append(ids)
            # Preserve the current four-layer larger barrier, independently
            # of removing the routing readback at each layer.
            if (layer + 1) % 4 == 0:
                mx.eval(x)
        mx.eval(x, routes)
        return x, routes

    modes = ["host", "device_checked", "device_all_hit"]
    # Exactness precedes timing. No missing expert is silently mapped to data.
    expected = None
    correctness = []
    for depth in [1, 4, layers]:
        for mode in modes:
            value, routes = run(mode, depth)
            payload = bytes(value.view(mx.uint8).reshape(-1).tolist())
            route_values = [r.reshape(-1).tolist() for r in routes]
            result = (hashlib.sha256(payload).hexdigest(), route_values)
            if mode == "host":
                expected = result
            ok = result == expected and bool(mx.all(mx.isfinite(value)).item())
            correctness.append({"depth": depth, "mode": mode, "exact": ok,
                                "output_sha256": result[0], "routes": route_values})
            write(out / f"correctness-{depth}-{mode}.json", correctness[-1])
            if not ok:
                raise AssertionError("exact route/output equality failed; no timings qualified")
    # Verify all 512 directory entries and all possible resident-count splits.
    assert directory.tolist() == mapping
    for count in range(topk + 1):
        absent = [i for i in range(experts) if i not in host_map]
        ids = resident[:count] + absent[:topk-count]
        looked_up = directory[mx.array(ids, dtype=mx.int32)].tolist()
        assert looked_up == [host_map.get(i, -1) for i in ids]
        assert sum(i < 0 for i in looked_up) == topk-count
    write(out / "directory-checks.json", {"all_entries": experts, "hit_miss_splits": topk+1, "passed": True})
    for mode in modes:
        run(mode, layers)
    cells = []
    for round_id in range(rounds):
        order = modes if round_id % 2 == 0 else list(reversed(modes))
        for mode in order:
            before = vm_snapshot()
            start = time.perf_counter()
            value, _ = run(mode, layers)
            elapsed = time.perf_counter() - start
            after = vm_snapshot()
            cell = {"round": round_id, "mode": mode, "seconds": elapsed,
                    "before": before, "after": after, "paging_clean": clean(before, after)}
            cells.append(cell)
            write(out / f"timing-{round_id}-{mode}.json", cell)
            print(json.dumps({k: cell[k] for k in ("round", "mode", "seconds", "paging_clean")}), flush=True)
    summary = {"mlx": importlib.metadata.version("mlx"), "device": mx.device_info(),
               "layers": layers, "rows": 1, "slots": slots, "topk": topk,
               "synthetic": True, "python_host_overhead_included": True,
               "peak_mlx_bytes": mx.get_peak_memory(), "correctness_passed": True, "comparisons": {}}
    for mode in modes[1:]:
        paired = []
        for round_id in range(rounds):
            pair = {c["mode"]: c for c in cells if c["round"] == round_id}
            if all(pair[m]["paging_clean"] for m in ["host", mode]):
                paired.append(pair["host"]["seconds"] / pair[mode]["seconds"])
        summary["comparisons"][mode] = {"eligible_pairs": len(paired), "ratios": paired,
            "median_speed_ratio": statistics.median(paired) if paired else None}
    write(out / "summary.json", summary)


def model(out, rounds):
    binary = ROOT / ".build/release/slotstream"
    identity_path = binary.parent / "build-identity.json"
    identity = json.loads(identity_path.read_text())
    if digest(binary) != identity["binary_sha256"]:
        raise RuntimeError("native executable does not match its source receipt")
    shutil.copy2(identity_path, out / "native-build-identity.json")
    # All cells use the same fixed plan and actual native code. Fresh-process
    # prefill warms the relevant experts; this is not a repeated server test.
    prompt = "Explain how a hash map works, in about 200 words."
    cells = []
    for round_id in range(rounds):
        order = ["baseline", "resident_overlap"] if round_id % 2 == 0 else ["resident_overlap", "baseline"]
        for arm in order:
            before = preflight(13)
            env = {k: v for k, v in os.environ.items() if not k.startswith("SLOTSTREAM_")}
            env["SLOTSTREAM_OPT_RESIDENT_OVERLAP"] = "1" if arm == "resident_overlap" else "0"
            path = out / f"r{round_id}-{arm}"
            command = [str(binary), "run", "--memory-gb", "10", "--mtp", "off", "--vision", "off",
                       "--max-context", "8192", "--max-tokens", "64", "--greedy", "--prompt", prompt,
                       "--stats-json", str(path.with_suffix(".stats.json"))]
            host_before = host_conditions()
            start = time.perf_counter()
            with path.with_suffix(".stdout.txt").open("x") as stdout, path.with_suffix(".stderr.txt").open("x") as stderr:
                result = subprocess.run(command, cwd=ROOT, env=env, stdout=stdout, stderr=stderr, timeout=180)
            after = vm_snapshot()
            cell = {"round": round_id, "arm": arm, "command": command,
                    "environment": {k: v for k, v in env.items() if k.startswith("SLOTSTREAM_")},
                    "exit_code": result.returncode, "elapsed_seconds": time.perf_counter()-start,
                    "before": before, "after": after, "host_before": host_before,
                    "host_after": host_conditions(), "paging_clean": clean(before, after)}
            write(path.with_suffix(".run.json"), cell)
            if result.returncode:
                raise RuntimeError(f"native run failed: {path}")
            d = json.loads(path.with_suffix(".stats.json").read_text())
            cell["stats"] = d
            cells.append(cell)
            s = d["stats"]
            print(json.dumps({"round": round_id, "arm": arm, "decode_seconds": s["decodeSeconds"],
                              "paging_clean": cell["paging_clean"], "prefetch": s.get("expertPrefetch")}), flush=True)
    pairs = []
    for round_id in range(rounds):
        pair = {c["arm"]: c for c in cells if c["round"] == round_id}
        a, b = pair["baseline"], pair["resident_overlap"]
        da, db = a["stats"], b["stats"]
        exact = da["output_ids"] == db["output_ids"]
        equal_work = all(da["stats"][k] == db["stats"][k] for k in ["decodeTokens", "decodeRecords", "prefillRecords"])
        eligible = exact and equal_work and a["paging_clean"] and b["paging_clean"]
        pairs.append({"round": round_id, "exact": exact, "equal_work": equal_work,
                      "eligible": eligible, "speed_ratio": da["stats"]["decodeSeconds"] / db["stats"]["decodeSeconds"]})
    ratios = [p["speed_ratio"] for p in pairs if p["eligible"]]
    write(out / "summary.json", {"pairs": pairs, "eligible_pairs": len(ratios),
        "median_speed_ratio": statistics.median(ratios) if ratios else None,
        "scope": "M5 Pro, fresh native processes, 10 GB fixed target, plain decode, one prompt, 64 output tokens; no GPU-directory implementation"})


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("mode", choices=["micro", "model"])
    p.add_argument("--out", type=Path, required=True)
    p.add_argument("--rounds", type=int, default=4)
    p.add_argument("--layers", type=int, default=48)
    args = p.parse_args()
    if not 1 <= args.rounds <= 8 or not 1 <= args.layers <= 48:
        p.error("bounded to 1..8 rounds and 1..48 layers")
    args.out.mkdir(parents=True, exist_ok=False)
    write(args.out / "protocol.json", {"mode": args.mode, "rounds": args.rounds, "layers": args.layers,
        "script_sha256": digest(Path(__file__)), "host_before": host_conditions(),
        "timing_rule": "paired same-round comparison, identical outputs, no system swapins/swapouts in either cell; pmset history is not a continuous thermal measurement",
        "claim_limit": "bounded exploratory test only; no M1 Max claim and no release/default qualification"})
    try:
        (micro(args.out, args.rounds, args.layers) if args.mode == "micro" else model(args.out, args.rounds))
    finally:
        write(args.out / "host-after.json", host_conditions())


if __name__ == "__main__":
    main()
