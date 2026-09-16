#!/usr/bin/env python3
"""Expert Lookahead forecast taps: routing agreement per tap (audit) and the prefetch twin with each
tap's arrival time (twin).

The engine can record router-reuse forecasts at three taps (`RouterForecastTap`): the boundary after a
source layer's MoE add, at a stride, and two attention taps that read the streams of the layer just
before the target once that layer's attention output has been added, alone or with its shared expert.
Between deferred barriers a stride-2 boundary forecast reaches the scheduler at the routing readback of
the layer before its target, which is exactly where an attention tap arrives. Neither subcommand runs
the engine; both read capture shards.

  audit   routing agreement of every recorded variant with the true routes over targets at or above
          --min-target: top-10 agreement, exact top-10 rows, recall at 16 and 24 candidates, agreement
          by layer group, and a residency-free margin calibration (candidates per row at or above each
          margin threshold, the share the router chose, and the share of chosen experts they cover)
  twin    the bounded prefetch twin on a residency run (the pilot) fed by a forecast capture joined pass
          by pass. A variant picks boundary strides and attention taps; boundary forecasts arrive at the
          completed layer when its barrier falls there and otherwise at the next routing readback (k4),
          or always at the completed layer (k1); attention taps arrive at their source layer's routing
          readback. Speculative reads wait while a demand batch reads (--no-demand-priority lifts it).
          Every threshold is swept so variants can be compared at matched read traffic.
"""
import argparse
import bisect
import json
import multiprocessing as mp
import time
from collections import defaultdict
from pathlib import Path

import numpy as np

import expert_lookahead as xla
import expert_lookahead_forecast as xf

LAYERS, EXPERTS, TOPK = xf.LAYERS, xf.EXPERTS, xf.TOPK
TAP_NAMES = {0: "boundary", 1: "attention", 2: "attention-shared", 3: "attention-corrected", 4: "attention-readout",
             5: "boundary-readout", 6: "attention-readout-corrected"}
THRESHOLDS = [-1e30, 0.0, 0.031, 0.062, 0.1, 0.15, 0.214, 0.3, 0.5, 0.75, 1.0]
SHIPPED = ("boundary-s2-k4", 0.062)


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def pass_variants(p):
    """Every forecast of one pass as {variant: {target: forecast}}; boundary variants are named by stride."""
    out = defaultdict(dict)
    for (src, tgt), f in p["forecasts"].items():
        out[f"s{tgt - src}"][tgt] = f
    for (src, tgt, tap), f in p.get("tap_forecasts", {}).items():
        out[TAP_NAMES[tap]][tgt] = f
    return out


# ---------------------------------------------------------------- audit

def cmd_audit(args):
    run_dir = Path(args.run)
    rows = [r for r in xla.load_requests_jsonl(run_dir) if r.get("complete")]
    groups = list(range(0, LAYERS, 8))

    def fresh():
        return dict(rows=0, agree=0.0, exact=0, recall16=0.0, recall16_rows=0, recall24=0.0, recall24_rows=0,
                    agree_layer=np.zeros(LAYERS), rows_layer=np.zeros(LAYERS),
                    candidates=np.zeros(len(THRESHOLDS)), chosen_hits=np.zeros(len(THRESHOLDS)), chosen=0)

    stats = defaultdict(fresh)
    passes = 0
    for row in rows:
        req = xf.load_request(run_dir, row)
        if req is None:
            continue
        for p in xf.complete_verify_passes(req):
            variants = pass_variants(p)
            if not variants:
                continue
            passes += 1
            for name, targets in variants.items():
                s = stats[name]
                for tgt, f in targets.items():
                    if tgt < args.min_target:
                        continue
                    routes = p["routes"][tgt]
                    r = min(f["rows"], routes.shape[0])
                    for i in range(r):
                        real = set(routes[i].tolist())
                        ids, margins = f["ids"][i], f["margins"][i]
                        overlap = len(set(ids[:TOPK].tolist()) & real) / TOPK
                        s["rows"] += 1
                        s["agree"] += overlap
                        s["exact"] += overlap == 1.0
                        s["agree_layer"][tgt] += overlap
                        s["rows_layer"][tgt] += 1
                        if f["per_row"] >= 16:
                            s["recall16"] += len(set(ids[:16].tolist()) & real) / TOPK
                            s["recall16_rows"] += 1
                        if f["per_row"] >= 24:
                            s["recall24"] += len(set(ids[:24].tolist()) & real) / TOPK
                            s["recall24_rows"] += 1
                        s["chosen"] += TOPK
                        for j, threshold in enumerate(THRESHOLDS):
                            keep = ids[margins >= threshold].tolist()
                            s["candidates"][j] += len(keep)
                            s["chosen_hits"][j] += len(set(keep) & real)
        log(f"{row['id']}: {passes} passes")
    report = dict(schema="expert-lookahead-tap-audit-v1", run=str(run_dir), passes=passes, min_target=args.min_target,
                  requests=[r["id"] for r in rows], variants={})
    for name in sorted(stats):
        s = stats[name]
        n = max(s["rows"], 1)
        report["variants"][name] = dict(
            rows=s["rows"], top10_agreement=s["agree"] / n, exact_top10=s["exact"] / n,
            recall16=s["recall16"] / s["recall16_rows"] if s["recall16_rows"] else None,
            recall24=s["recall24"] / s["recall24_rows"] if s["recall24_rows"] else None,
            agreement_by_group={f"{g}-{g + 7}": float(s["agree_layer"][g:g + 8].sum() / max(s["rows_layer"][g:g + 8].sum(), 1))
                                for g in groups},
            margin_calibration=[dict(threshold=t, candidates_per_row=float(s["candidates"][j] / n),
                                     chosen_share=float(s["chosen_hits"][j] / max(s["candidates"][j], 1)),
                                     coverage=float(s["chosen_hits"][j] / max(s["chosen"], 1)))
                                for j, t in enumerate(THRESHOLDS)])
    xla.write_json(Path(args.out), report)
    print(f"{passes} passes, targets >= {args.min_target}")
    print(f"{'variant':18s} {'rows':>8s} {'top10':>7s} {'exact':>7s} {'rec16':>7s} {'rec24':>7s}")
    for name, v in report["variants"].items():
        fmt = lambda x: f"{x:7.4f}" if x is not None else "      -"
        print(f"{name:18s} {v['rows']:8d} {fmt(v['top10_agreement'])} {fmt(v['exact_top10'])} {fmt(v['recall16'])} {fmt(v['recall24'])}")


# ---------------------------------------------------------------- twin

class TapTwin:
    """One setting of the bounded scheduler twin over one pass (see the module docstring)."""

    def __init__(self, setting):
        self.strides = setting["strides"]
        self.taps = setting["taps"]
        self.arrival = setting["arrival"]
        self.per_row = setting["per_row"]
        self.threshold = setting["threshold"]
        self.issue_cap = setting["issue_cap"]
        self.cap = setting["cap"]
        self.lanes = setting["lanes"]
        self.barrier = setting["barrier"]
        self.service_ns = setting["service_ns"] * setting.get("service_factor", 1.0)
        self.fixed_ms, self.marginal_ms = setting["fixed_ms"], setting["marginal_ms"]
        self.demand_priority = setting["demand_priority"]

    def candidates(self, f):
        ids, margins = f["ids"][:, :self.per_row], f["margins"][:, :self.per_row]
        out, seen = [], set()
        rows, width = ids.shape
        for rank in range(width):
            for i in range(rows):
                if margins[i, rank] >= self.threshold:
                    e = int(ids[i, rank])
                    if e not in seen:
                        seen.add(e)
                        out.append(e)
        return out

    def run(self, item):
        boundary, tapped = item["forecasts"], item["tap_forecasts"]
        tl, resident, misses, read_end = item["timeline"], item["resident"], item["misses"], item["read_end"]
        starts, ends = tl["demand_start"], tl["layer_nanos"]
        lane_free = [tl["begin"]] * self.lanes
        live = []
        issued_keys = set()
        per_target = [0] * LAYERS
        c = dict(issued=0, timely=0, late=0, wasted=0, saved_ms=0.0, misses=sum(len(m) for m in misses))

        def unblock(t):
            # A speculative read does not start while a demand batch is reading.
            if not self.demand_priority:
                return t
            i = bisect.bisect_right(starts, t) - 1
            return read_end[i] if i >= 0 and t < read_end[i] else t

        def issue(target, f, now):
            if f is None or target >= LAYERS:
                return
            for e in self.candidates(f):
                key = target * EXPERTS + e
                if key in resident or key in issued_keys:
                    continue
                if per_target[target] >= self.issue_cap or len(live) >= self.cap:
                    return
                lane = min(range(self.lanes), key=lane_free.__getitem__)
                done = unblock(max(lane_free[lane], now)) + self.service_ns
                lane_free[lane] = done
                live.append((target, key, done))
                issued_keys.add(key)
                per_target[target] += 1
                c["issued"] += 1

        for l in range(LAYERS):
            timely = 0
            for target, key, done in live:
                if target != l:
                    continue
                if key - l * EXPERTS in misses[l]:
                    if done <= starts[l]:
                        timely += 1
                    else:
                        c["late"] += 1
                else:
                    c["wasted"] += 1
            live = [x for x in live if x[0] > l]
            c["timely"] += timely
            c["saved_ms"] += self.marginal_ms * timely + (self.fixed_ms if misses[l] and timely == len(misses[l]) else 0.0)
            # Arrivals at this layer's routing readback, before its demand batch.
            for tap in self.taps:
                issue(l + 1, tapped.get((l, l + 1, tap)), starts[l])
            if self.arrival == "k4" and l >= 1 and l % self.barrier != 0:
                # Boundary forecasts from layer l - 1, whose barrier was deferred, ride this readback.
                for s in self.strides:
                    issue(l - 1 + s, boundary.get((l - 1, l - 1 + s)), starts[l])
            # The completed-layer boundary.
            if self.arrival == "k1" or (l + 1) % self.barrier == 0 or l == LAYERS - 1:
                for s in self.strides:
                    issue(l + s, boundary.get((l, l + s)), ends[l])
        return c


ITEMS = []


def twin_task(setting):
    twin = TapTwin(setting)
    totals = defaultdict(float)
    for item in ITEMS:
        for k, v in twin.run(item).items():
            totals[k] += v
    return setting, dict(totals)


def join_forecasts(req, donor):
    """The boundary join (checked token by token and route by route), then the taps on the same pass order."""
    joined = xf.transplant_forecasts(req, donor)
    mine = [pid for pid in sorted(req["passes"]) if req["passes"][pid]["phase"] == 1]
    theirs = [pid for pid in sorted(donor["passes"]) if donor["passes"][pid]["phase"] == 1]
    for a, b in zip(mine, theirs):
        req["passes"][a]["tap_forecasts"] = donor["passes"][b].get("tap_forecasts", {})
    return joined


def read_ends(p, starts):
    out = list(starts)
    for l in range(LAYERS):
        e = p["demand"].get(l)
        if e is not None and e["read"] > e["start"]:
            out[l] = int(e["read"])
    return out


VARIANTS = {
    "boundary-s2-k4": dict(strides=[2], taps=[], arrival="k4"),
    "boundary-s2-k1": dict(strides=[2], taps=[], arrival="k1"),
    "boundary-s1-k1": dict(strides=[1], taps=[], arrival="k1"),
    "attention": dict(strides=[], taps=[1], arrival="k4"),
    "attention-shared": dict(strides=[], taps=[2], arrival="k4"),
    "attention-corrected": dict(strides=[], taps=[3], arrival="k4"),
    "attention-readout": dict(strides=[], taps=[4], arrival="k4"),
    "attention-readout-corrected": dict(strides=[], taps=[6], arrival="k4"),
    "boundary-s2-k4+attention": dict(strides=[2], taps=[1], arrival="k4"),
    "boundary-s2-k4+attention-shared": dict(strides=[2], taps=[2], arrival="k4"),
}


def cmd_twin(args):
    run_dir, forecast_dir = Path(args.run), Path(args.forecast_run)
    donor_rows = {r["id"]: r for r in xla.load_requests_jsonl(forecast_dir) if r.get("complete")}
    split_of = {r["id"]: r["split"] for r in xla.corpus_manifest()["requests"]}
    rows = [r for r in xla.load_requests_jsonl(run_dir)
            if r.get("complete") and split_of.get(r["id"]) == args.split and r["id"] in donor_rows]
    cost_report = xla.read_json(args.cost_model)
    fixed_ms = float(cost_report["read_cost_model"]["intercept_ms"])
    marginal_ms = float(cost_report["read_cost_model"]["slope_ms_per_record"])
    service, decode_ns, joined = [], 0, 0
    for row in rows:
        req = xf.load_request(run_dir, row)
        donor = xf.load_request(forecast_dir, donor_rows[row["id"]])
        if req is None or donor is None:
            continue
        joined += join_forecasts(req, donor)
        resident = xf.resident_at_pass_start(req)
        for e in req["events"]:
            n = len(e["miss"])
            if n and e["read"] > e["start"]:
                service.append((e["read"] - e["start"]) / n)
        for p in xf.complete_verify_passes(req):
            if p["pass_id"] not in resident or not (p["forecasts"] or p.get("tap_forecasts")):
                continue
            tl = xf.timeline(p)
            tl["demand_start"] = [int(x) for x in np.maximum.accumulate(np.array(tl["demand_start"], dtype=np.int64))]
            ITEMS.append(dict(forecasts={k: v for k, v in p["forecasts"].items() if k[1] > k[0]},
                              tap_forecasts=p.get("tap_forecasts", {}), timeline=tl,
                              read_end=read_ends(p, tl["demand_start"]), resident=resident[p["pass_id"]],
                              misses=xf.miss_sets(p)))
            decode_ns += p["end"] - p["begin"]
        log(f"{row['id']}: {len(ITEMS)} passes so far")
    service_ns = float(np.median(service))
    base = dict(per_row=args.per_row, issue_cap=args.issue_cap, cap=args.cap, lanes=args.lanes, barrier=args.barrier,
                service_ns=service_ns, fixed_ms=fixed_ms, marginal_ms=marginal_ms, demand_priority=not args.no_demand_priority)
    settings = []
    for name, variant in VARIANTS.items():
        for threshold in THRESHOLDS:
            settings.append(dict(base, variant=name, threshold=threshold, **variant))
    sensitivities = []
    for name in ("boundary-s2-k4", "attention", "attention-shared"):
        for extra in (dict(demand_priority=not base["demand_priority"]), dict(service_factor=2.0), dict(cap=32)):
            sensitivities.append(dict(base, variant=name, threshold=0.062, sensitivity=json.dumps(extra, sort_keys=True),
                                      **VARIANTS[name], **extra))
    log(f"{len(ITEMS)} passes joined ({joined}), service {service_ns / 1e6:.3f} ms/record, "
        f"{len(settings)} settings and {len(sensitivities)} sensitivities")
    with mp.get_context("fork").Pool(args.workers) as pool:
        results = list(pool.imap_unordered(twin_task, settings + sensitivities, chunksize=1))
    decode_s = decode_ns / 1e9
    table, sens = [], []
    for setting, t in results:
        m = t["misses"] or 1
        row = dict(variant=setting["variant"], threshold=setting["threshold"], issued=int(t["issued"]), timely=int(t["timely"]),
                   late=int(t["late"]), wasted=int(t["wasted"]), misses=int(t["misses"]),
                   timely_coverage=t["timely"] / m, precision=t["timely"] / t["issued"] if t["issued"] else 0.0,
                   traffic_amplification=(m + t["wasted"]) / m, saved_ms=t["saved_ms"],
                   projected_ratio=decode_s / max(decode_s - t["saved_ms"] / 1000, 1e-9))
        if "sensitivity" in setting:
            row["sensitivity"] = setting["sensitivity"]
            sens.append(row)
        else:
            table.append(row)
    order = list(VARIANTS)
    table.sort(key=lambda r: (order.index(r["variant"]), r["threshold"]))
    shipped = next(r for r in table if (r["variant"], r["threshold"]) == SHIPPED)
    matched = {}
    for name in order:
        curve = sorted((r for r in table if r["variant"] == name), key=lambda r: r["issued"])
        xs = [r["issued"] for r in curve]
        if not xs or not xs[0] <= shipped["issued"] <= xs[-1]:
            matched[name] = None
            continue
        matched[name] = dict(
            issued=shipped["issued"],
            timely_coverage=float(np.interp(shipped["issued"], xs, [r["timely_coverage"] for r in curve])),
            wasted=float(np.interp(shipped["issued"], xs, [r["wasted"] for r in curve])),
            projected_ratio=float(np.interp(shipped["issued"], xs, [r["projected_ratio"] for r in curve])))
    report = dict(schema="expert-lookahead-tap-twin-v1", run=str(run_dir), forecast_run=str(forecast_dir),
                  requests=[r["id"] for r in rows], passes=len(ITEMS), joined_passes=joined, decode_seconds=decode_s,
                  setting=base, thresholds=THRESHOLDS, table=table, sensitivities=sens, shipped=shipped,
                  matched_to_shipped_traffic=matched)
    xla.write_json(Path(args.out), report)
    print(f"{len(ITEMS)} passes, {shipped['misses']} misses, decode {decode_s:.1f} s, service {service_ns / 1e6:.3f} ms")
    print(f"{'variant':32s} {'thr':>6s} {'issued':>8s} {'timely':>8s} {'late':>6s} {'wasted':>8s} {'cov':>6s} {'prec':>6s} {'amp':>5s} {'ratio':>6s}")
    for r in table:
        thr = "none" if r["threshold"] < -1e29 else f"{r['threshold']:.3f}"
        print(f"{r['variant']:32s} {thr:>6s} {r['issued']:8d} {r['timely']:8d} {r['late']:6d} {r['wasted']:8d} "
              f"{r['timely_coverage']:6.3f} {r['precision']:6.3f} {r['traffic_amplification']:5.2f} {r['projected_ratio']:6.3f}")
    print("matched to the shipped setting's issued reads:")
    for name, m in matched.items():
        print(f"  {name:32s} " + ("outside the swept range" if m is None else
              f"coverage {m['timely_coverage']:.3f}, wasted {m['wasted']:.0f}, projected {m['projected_ratio']:.3f}"))
    print("sensitivities at threshold 0.062:")
    for r in sorted(sens, key=lambda r: (r["sensitivity"], order.index(r["variant"]))):
        print(f"  {r['sensitivity']:32s} {r['variant']:18s} issued {r['issued']:7d} cov {r['timely_coverage']:.3f} "
              f"prec {r['precision']:.3f} ratio {r['projected_ratio']:.3f}")


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command", required=True)
    p = sub.add_parser("audit")
    p.add_argument("--run", required=True)
    p.add_argument("--out", required=True)
    p.add_argument("--min-target", type=int, default=2, help="first target layer counted (stride 2 starts at 2)")
    p.set_defaults(fn=cmd_audit)
    p = sub.add_parser("twin")
    p.add_argument("--run", required=True, help="residency run, e.g. the pilot capture")
    p.add_argument("--forecast-run", required=True, help="capture with the forecasts to join (same requests)")
    p.add_argument("--cost-model", required=True)
    p.add_argument("--out", required=True)
    p.add_argument("--split", default="validation")
    p.add_argument("--per-row", type=int, default=10)
    p.add_argument("--issue-cap", type=int, default=32)
    p.add_argument("--cap", type=int, default=64, help="records held at once (slot adoption's reservation cap)")
    p.add_argument("--lanes", type=int, default=16)
    p.add_argument("--barrier", type=int, default=4)
    p.add_argument("--no-demand-priority", action="store_true")
    p.add_argument("--workers", type=int, default=4)
    p.set_defaults(fn=cmd_twin)
    args = parser.parse_args()
    args.fn(args)


if __name__ == "__main__":
    main()
