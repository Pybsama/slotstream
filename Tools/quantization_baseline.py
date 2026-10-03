#!/usr/bin/env python3
"""Run a frozen, small-memory baseline with raw evidence and no retries."""
import argparse
import json
import math
import os
from pathlib import Path
import statistics
import subprocess
import time
from prefill_bench import digest, preflight, vm_snapshot, model_identity, run_child, validate_metrics
from serve_bench import competing_jobs
from thermal_readiness import observe


def rates(data):
    stats = validate_metrics(data)
    n = len(data["output_ids"])
    intervals = stats.get("interTokenSeconds", [])
    if (n < 2 or len(intervals) != n - 1 or
            any(type(x) not in (int, float) or not math.isfinite(x) or x < 0 for x in intervals)
            or sum(intervals) <= 0 or stats["decodeSeconds"] <= 0):
        raise ValueError("missing or inconsistent committed-token timing")
    return {"steady_committed_tok_s": (n - 1) / sum(intervals),
            "legacy_decode_tok_s": n / stats["decodeSeconds"],
            "largest_token_stall_seconds": max(intervals),
            "first_token_seconds": stats.get("firstTokenSeconds"),
            "request_seconds": stats["requestSeconds"],
            "prefill_seconds": stats["prefillSeconds"],
            "output_tokens": n, "peak_memory_gb": stats.get("peakMemoryGB")}


def validate_observations(data, ceiling=10):
    stats = data["stats"]
    for key in ("generatorSystemBefore", "generatorSystemAfter"):
        if stats.get(key) != {"thermalState": "nominal", "lowPowerModeEnabled": False}:
            raise ValueError("generation conditions are missing or timing-ineligible")
    sampled = stats.get("sampledFootprint", {})
    peaks = [stats.get("peakMemoryGB"), stats.get("lifetimePhysicalFootprintPeakBytes", 0) / 1e9,
             sampled.get("peakBytes", 0) / 1e9]
    if (type(sampled.get("samples")) is not int or sampled["samples"] < 1
            or any(type(p) not in (int, float) or not math.isfinite(p) or not 0 < p <= ceiling for p in peaks)):
        raise ValueError("missing or out-of-budget process footprint observations")
    if stats.get("memoryPressureCancelled") or stats.get("runtimeError"):
        raise ValueError("generation did not complete normally")


def run(protocol_path, binary, model, out):
    protocol = json.loads(protocol_path.read_text())
    budget = protocol["resource_budget"]
    baseline = protocol["baseline"]
    if (protocol.get("schema") != 1 or budget["baseline_memory_gb"] != 10
            or budget["baseline_required_reclaimable_gb"] != 13
            or budget["baseline_runs"] != 3 or budget["baseline_maximum_run_seconds"] != 1800
            or baseline["max_tokens"] != 128 or baseline["max_context"] != 32768
            or baseline["mtp"] != "auto" or baseline["vision"] != "off"
            or baseline["sampling"] != "greedy"):
        raise ValueError("this baseline runner supports the frozen small-memory protocol only")
    out.mkdir(parents=True, exist_ok=False)
    (out / "protocol.json").write_bytes(protocol_path.read_bytes())
    identity = {"binary_sha256": digest(binary), "metallib_sha256": digest(binary.parent / "mlx.metallib"),
                "version": subprocess.check_output([str(binary), "--version"], text=True).strip(),
                "model_metadata": model_identity(model), "protocol_sha256": digest(protocol_path),
                "chip": subprocess.check_output(["sysctl", "-n", "machdep.cpu.brand_string"], text=True).strip(),
                "physical_ram_bytes": int(subprocess.check_output(["sysctl", "-n", "hw.memsize"], text=True)),
                "os": subprocess.check_output(["sw_vers"], text=True)}
    # Ambient developer toggles cannot silently redefine a baseline. Record
    # only removed names; never serialize arbitrary environment values.
    environment = {k: v for k, v in os.environ.items() if not k.startswith(("SLOTSTREAM_", "SS_DEBUG"))}
    identity["removed_override_names"] = sorted(set(os.environ) - set(environment))
    identity["host_observation_scope"] = "endpoint snapshots of known jobs, not continuous host isolation"
    (out / "identity.json").write_text(json.dumps(identity, indent=2) + "\n")
    (out / "prompt.txt").write_text(baseline["prompt"])
    rows = []
    for i in range(budget["baseline_runs"]):
        cell = out / f"run-{i + 1}"; cell.mkdir()
        row = {"run": i + 1, "valid": False}
        command = [str(binary), "run", "--model", str(model), "--memory-gb", "10", "--max-context", "32768",
                   "--mtp", "auto", "--vision", "off", "--greedy", "--max-tokens", "128",
                   "--sample-footprint", "--prompt-file", str(out / "prompt.txt"), "--stats-json", str(cell / "stats.json")]
        try:
            row["before"] = preflight(13)
            row["conditions_before"] = observe()
            row["competing_jobs_before"] = competing_jobs()
            if not row["conditions_before"]["ready"] or row["competing_jobs_before"]:
                raise RuntimeError("baseline preflight is not eligible; no model launched")
            (cell / "command.json").write_text(json.dumps(command) + "\n")
            start = time.monotonic()
            code = run_child(command, environment, cell, 1800)
            row["wall_seconds"] = time.monotonic() - start
            row["exit_code"] = code
            row["after"] = vm_snapshot()
            row["conditions_after"] = observe()
            row["competing_jobs_after"] = competing_jobs()
            if code != 0:
                raise RuntimeError("baseline model run failed; inspect stderr")
            data = json.loads((cell / "stats.json").read_text())
            row["metrics"] = rates(data)
            validate_observations(data)
            if data["stats"].get("runtimeError"):
                raise RuntimeError("model reported a runtime error")
            if any(row["before"][k] != row["after"][k] for k in ("swapins", "swapouts")):
                raise RuntimeError("global paging changed: functional data retained, timing ineligible")
            if not row["conditions_after"]["ready"] or row["competing_jobs_after"]:
                raise RuntimeError("end-of-run conditions are not eligible")
            if digest(binary) != identity["binary_sha256"] or model_identity(model) != identity["model_metadata"]:
                raise RuntimeError("binary or model identity changed")
            row["valid"] = True
        except Exception as error:
            row["failure"] = f"{type(error).__name__}: {error}"
        (cell / "receipt.json").write_text(json.dumps(row, indent=2) + "\n")
        rows.append(row)
        print(json.dumps({k: v for k, v in row.items() if k in ("run", "valid", "failure", "metrics")}), flush=True)
        if not row["valid"]:
            break  # no optional stopping/retries to chase a passing result
    valid = len(rows) == 3 and all(r["valid"] for r in rows)
    result = {"schema": 1, "valid": valid, "qualification": False, "rows": rows,
              "median_steady_committed_tok_s": statistics.median(r["metrics"]["steady_committed_tok_s"] for r in rows) if valid else None}
    (out / "summary.json").write_text(json.dumps(result, indent=2) + "\n")
    return valid


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--protocol", type=Path, default=Path("bench/quantization/screen-v1.json"))
    parser.add_argument("--binary", type=Path, required=True)
    parser.add_argument("--model", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()
    raise SystemExit(0 if run(args.protocol.resolve(), args.binary.resolve(), args.model.resolve(), args.out.resolve()) else 1)
