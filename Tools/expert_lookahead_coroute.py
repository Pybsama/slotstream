#!/usr/bin/env python3
"""Expert Lookahead co-routing prior for an attention tap (offline probe).

When layer T-1's routing readback returns, the host holds both T-1's routed experts for every row and the
attention tap's forecast for T. This probe asks whether T-1's routes sharpen that forecast. A table counted
on the training split's routes alone gives, for every layer T, the smoothed pointwise mutual information

    PMI_T(i, j) = log P(j at T | i at T-1) / P(j at T)

with P(j | i) = (C_T(i, j) + alpha P_T(j)) / (n_{T-1}(i) + alpha) and P_T(j) = (n_T(j) + 1) / (rows_T + 51.2).
A row's recorded candidate j is rescored as margin(j) + beta * (sum of PMI_T(i, j) over T-1's routed experts
i), and margins are re-anchored on the row's new tenth value. Only the tap's recorded candidates are
rescored, so recall at the recorded width cannot change, and beta = 0 reproduces the tap. beta is chosen by
leave-one-request-out over the evaluation requests, so no request's own routes pick its beta. Nothing here
runs the engine.

  table  count the complete verify passes of one split of a run into per-layer pair tables (.npz)
  audit  top-10 agreement, exact rows and recall at 16 and 24 of the tap and its rescored form over every
         beta, the leave-one-request-out choice, and alpha sensitivities
  twin   expert_lookahead_taps.TapTwin on a residency run fed by the tap and by the rescored tap (each
         request with its own fold's beta) on a finer threshold grid, matched to the shipped traffic
"""
import argparse
import hashlib
import json
import multiprocessing as mp
import time
from pathlib import Path

import numpy as np

import expert_lookahead as xla
import expert_lookahead_forecast as xf
import expert_lookahead_taps as xtaps

LAYERS, EXPERTS, TOPK = xf.LAYERS, xf.EXPERTS, xf.TOPK
BETAS = [0.0, 0.02, 0.05, 0.1, 0.2, 0.3, 0.5, 0.75, 1.0]
ALPHA, ALPHA_SENSITIVITIES = 20.0, (5.0, 80.0)
RESCORED = 101
THRESHOLDS = sorted(set(xtaps.THRESHOLDS + [0.0155, 0.0465, 0.08, 0.125, 0.18, 0.25, 0.4, 0.6, 1.5, 2.0]))
PMIS = {}
TAP = 1
MIN_TARGET = 2


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for block in iter(lambda: f.read(1 << 20), b""):
            h.update(block)
    return h.hexdigest()


def split_rows(run_dir, split):
    split_of = {r["id"]: r["split"] for r in xla.corpus_manifest()["requests"]}
    return [r for r in xla.load_requests_jsonl(run_dir) if r.get("complete") and split_of.get(r["id"]) == split]


# ---------------------------------------------------------------- table

def count_request(task):
    run_dir, row = task
    req = xf.load_request(Path(run_dir), row)
    if req is None:
        return row["id"], None
    pairs = [[] for _ in range(LAYERS)]
    prev = np.zeros((LAYERS, EXPERTS), np.int64)
    cur = np.zeros((LAYERS, EXPERTS), np.int64)
    rows = np.zeros(LAYERS, np.int64)
    passes = 0
    for p in xf.complete_verify_passes(req):
        passes += 1
        for t in range(1, LAYERS):
            a, b = p["routes"][t - 1], p["routes"][t]
            r = min(a.shape[0], b.shape[0])
            a, b = a[:r].astype(np.int64), b[:r].astype(np.int64)
            pairs[t].append((a[:, :, None] * EXPERTS + b[:, None, :]).ravel())
            prev[t] += np.bincount(a.ravel(), minlength=EXPERTS)
            cur[t] += np.bincount(b.ravel(), minlength=EXPERTS)
            rows[t] += r
    flat = [np.concatenate(x).astype(np.int32) if x else np.zeros(0, np.int32) for x in pairs]
    return row["id"], dict(pairs=flat, prev=prev, cur=cur, rows=rows, passes=passes)


def cmd_table(args):
    run_dir = Path(args.run)
    rows = split_rows(run_dir, args.split)
    joint = np.zeros((LAYERS, EXPERTS * EXPERTS), np.int64)
    prev = np.zeros((LAYERS, EXPERTS), np.int64)
    cur = np.zeros((LAYERS, EXPERTS), np.int64)
    nrows = np.zeros(LAYERS, np.int64)
    passes, used = 0, []
    with mp.get_context("fork").Pool(args.workers) as pool:
        for rid, c in pool.imap_unordered(count_request, [(str(run_dir), r) for r in rows]):
            if c is None:
                log(f"{rid}: no residency snapshot, skipped")
                continue
            for t in range(LAYERS):
                if c["pairs"][t].size:
                    joint[t] += np.bincount(c["pairs"][t], minlength=EXPERTS * EXPERTS)
            prev += c["prev"]
            cur += c["cur"]
            nrows += c["rows"]
            passes += c["passes"]
            used.append(rid)
            log(f"{rid}: {c['passes']} verify passes ({len(used)}/{len(rows)})")
    out = Path(args.out)
    np.savez_compressed(out, joint=joint.reshape(LAYERS, EXPERTS, EXPERTS).astype(np.int32), prev=prev, cur=cur, rows=nrows)
    meta = dict(schema="expert-lookahead-coroute-table-v1", run=str(run_dir), split=args.split, requests=sorted(used),
                passes=passes, rows_per_layer=nrows.tolist(), table=str(out), table_sha256=sha256(out))
    xla.write_json(out.with_suffix(".json"), meta)
    print(f"{len(used)} requests, {passes} verify passes, {int(nrows[1])} rows per layer, table {meta['table_sha256'][:16]}")


def pmi_tables(path, alpha):
    z = np.load(path)
    joint, prev, cur, rows = (z[k].astype(np.float64) for k in ("joint", "prev", "cur", "rows"))
    p = (cur + 1.0) / (rows[:, None] + EXPERTS / TOPK)
    cond = (joint + alpha * p[:, None, :]) / (prev[:, :, None] + alpha)
    return np.log(cond / p[:, None, :]).astype(np.float32)


# ---------------------------------------------------------------- audit

def row_scores(p, tgt, f, alpha):
    """Rows, recorded ids and margins of one forecast, each candidate's co-routing score, and the true routes."""
    prev, real = p["routes"][tgt - 1], p["routes"][tgt]
    r = min(f["rows"], f["ids"].shape[0], real.shape[0], prev.shape[0])
    ids = f["ids"][:r].astype(np.int64)
    s = np.take_along_axis(PMIS[alpha][tgt][prev[:r].astype(np.int64)].sum(axis=1), ids, axis=1)
    return r, ids, f["margins"][:r].astype(np.float64), s.astype(np.float64), real[:r]


def audit_request(task):
    run_dir, row = task
    req = xf.load_request(Path(run_dir), row)
    if req is None:
        return row["id"], None
    stats = {a: np.zeros((len(BETAS), 5)) for a in PMIS}
    layers = {a: np.zeros((len(BETAS), LAYERS, 2)) for a in PMIS}
    passes = 0
    for p in xf.complete_verify_passes(req):
        taps = [(k, f) for k, f in p.get("tap_forecasts", {}).items() if k[2] == TAP and k[1] >= MIN_TARGET]
        if not taps:
            continue
        passes += 1
        for (src, tgt, tap), f in taps:
            for alpha in PMIS:
                r, ids, margins, s, real = row_scores(p, tgt, f, alpha)
                chosen = (ids[:, :, None] == real[:, None, :]).any(axis=2)
                for b, beta in enumerate(BETAS):
                    order = np.argsort(-(margins + beta * s), axis=1, kind="stable")
                    hit = np.take_along_axis(chosen, order, axis=1)
                    top = hit[:, :TOPK].sum(axis=1)
                    st = stats[alpha][b]
                    st[0] += top.sum() / TOPK
                    st[1] += (top == TOPK).sum()
                    st[2] += hit[:, :16].sum() / TOPK
                    st[3] += hit[:, :24].sum() / TOPK
                    st[4] += r
                    layers[alpha][b, tgt, 0] += top.sum() / TOPK
                    layers[alpha][b, tgt, 1] += r
    return row["id"], dict(stats=stats, layers=layers, passes=passes)


def leave_one_out(per_request, alpha):
    total = sum(r["stats"][alpha] for r in per_request.values())
    chosen, pooled = {}, np.zeros(5)
    for rid in sorted(per_request):
        mine = per_request[rid]["stats"][alpha]
        others = total - mine
        b = int(np.argmax(others[:, 0] / np.maximum(others[:, 4], 1)))  # ties keep the smaller beta
        chosen[rid] = BETAS[b]
        pooled += mine[b]
    return chosen, pooled


def summary(st):
    n = max(st[4], 1)
    return dict(rows=int(st[4]), top10_agreement=float(st[0] / n), exact_top10=float(st[1] / n),
                recall16=float(st[2] / n), recall24=float(st[3] / n))


def cmd_audit(args):
    global TAP, MIN_TARGET
    TAP, MIN_TARGET = args.tap, args.min_target
    for alpha in (ALPHA,) + ALPHA_SENSITIVITIES:
        PMIS[alpha] = pmi_tables(args.table, alpha)
    run_dir = Path(args.run)
    rows = split_rows(run_dir, args.split)
    per_request = {}
    with mp.get_context("fork").Pool(args.workers) as pool:
        for rid, res in pool.imap_unordered(audit_request, [(str(run_dir), r) for r in rows]):
            if res is None:
                log(f"{rid}: no residency snapshot, skipped")
                continue
            per_request[rid] = res
            log(f"{rid}: {res['passes']} passes ({len(per_request)}/{len(rows)})")
    report = dict(schema="expert-lookahead-coroute-audit-v1", run=str(run_dir), split=args.split, tap=args.tap,
                  min_target=args.min_target, table=str(args.table), table_sha256=sha256(args.table),
                  requests=sorted(per_request), passes=sum(r["passes"] for r in per_request.values()),
                  alpha=ALPHA, betas=BETAS, by_alpha={})
    for alpha in PMIS:
        total = sum(r["stats"][alpha] for r in per_request.values())
        layers = sum(r["layers"][alpha] for r in per_request.values())
        chosen, pooled = leave_one_out(per_request, alpha)
        report["by_alpha"][str(alpha)] = dict(
            curve=[dict(beta=beta, **summary(total[b])) for b, beta in enumerate(BETAS)],
            leave_one_out=dict(beta_by_request=chosen, **summary(pooled)),
            agreement_by_group={str(beta): {f"{g}-{g + 7}": float(layers[b, g:g + 8, 0].sum() / max(layers[b, g:g + 8, 1].sum(), 1))
                                            for g in range(0, LAYERS, 8)} for b, beta in enumerate(BETAS)})
    primary = report["by_alpha"][str(ALPHA)]
    report["tap"] = args.tap
    report["baseline"] = primary["curve"][0]
    report["loo"] = primary["leave_one_out"]
    report["loo_gain"] = report["loo"]["top10_agreement"] - report["baseline"]["top10_agreement"]
    xla.write_json(Path(args.out), report)
    print(f"{report['passes']} passes, tap {xtaps.TAP_NAMES[args.tap]}, targets >= {args.min_target}")
    for alpha, block in report["by_alpha"].items():
        print(f"alpha {alpha}: {'beta':>6s} {'top10':>7s} {'exact':>7s} {'rec16':>7s} {'rec24':>7s}")
        for c in block["curve"]:
            print(f"          {c['beta']:6.2f} {c['top10_agreement']:7.4f} {c['exact_top10']:7.4f} {c['recall16']:7.4f} {c['recall24']:7.4f}")
        loo = block["leave_one_out"]
        print(f"          leave-one-request-out {loo['top10_agreement']:.4f} (exact {loo['exact_top10']:.4f}, rec16 "
              f"{loo['recall16']:.4f}), betas {sorted(set(loo['beta_by_request'].values()))}")
    print(f"primary gain over the tap: {report['loo_gain']:+.4f}")


# ---------------------------------------------------------------- twin

def cmd_twin(args):
    audit = xla.read_json(args.audit)
    alpha, tap = float(audit["alpha"]), int(audit["tap"])
    PMIS[alpha] = pmi_tables(args.table, alpha)
    beta_of = audit["loo"]["beta_by_request"]
    tap_name = xtaps.TAP_NAMES[tap]
    variants = {"boundary-s2-k4": dict(strides=[2], taps=[], arrival="k4"),
                tap_name: dict(strides=[], taps=[tap], arrival="k4"),
                f"{tap_name}-coroute": dict(strides=[], taps=[RESCORED], arrival="k4")}
    run_dir, forecast_dir = Path(args.run), Path(args.forecast_run)
    donor_rows = {r["id"]: r for r in xla.load_requests_jsonl(forecast_dir) if r.get("complete")}
    rows = [r for r in split_rows(run_dir, args.split) if r["id"] in donor_rows and r["id"] in beta_of]
    cost_report = xla.read_json(args.cost_model)
    fixed_ms = float(cost_report["read_cost_model"]["intercept_ms"])
    marginal_ms = float(cost_report["read_cost_model"]["slope_ms_per_record"])
    service, decode_ns, joined, rescored = [], 0, 0, 0
    for row in rows:
        req = xf.load_request(run_dir, row)
        donor = xf.load_request(forecast_dir, donor_rows[row["id"]])
        if req is None or donor is None:
            continue
        joined += xtaps.join_forecasts(req, donor)
        resident = xf.resident_at_pass_start(req)
        for e in req["events"]:
            n = len(e["miss"])
            if n and e["read"] > e["start"]:
                service.append((e["read"] - e["start"]) / n)
        beta = float(beta_of[row["id"]])
        for p in xf.complete_verify_passes(req):
            if p["pass_id"] not in resident or not (p["forecasts"] or p.get("tap_forecasts")):
                continue
            taps = dict(p.get("tap_forecasts", {}))
            for (src, tgt, t), f in list(taps.items()):
                if t != tap or tgt < 1:
                    continue
                r, ids, margins, s, _ = row_scores(p, tgt, f, alpha)
                new = margins + beta * s
                order = np.argsort(-new, axis=1, kind="stable")
                ids2, new2 = np.take_along_axis(ids, order, axis=1), np.take_along_axis(new, order, axis=1)
                taps[(src, tgt, RESCORED)] = dict(ids=ids2, margins=new2 - new2[:, TOPK - 1:TOPK], rows=r, per_row=f["per_row"])
                rescored += 1
            tl = xf.timeline(p)
            tl["demand_start"] = [int(x) for x in np.maximum.accumulate(np.array(tl["demand_start"], dtype=np.int64))]
            xtaps.ITEMS.append(dict(forecasts={k: v for k, v in p["forecasts"].items() if k[1] > k[0]},
                                    tap_forecasts=taps, timeline=tl, read_end=xtaps.read_ends(p, tl["demand_start"]),
                                    resident=resident[p["pass_id"]], misses=xf.miss_sets(p)))
            decode_ns += p["end"] - p["begin"]
        log(f"{row['id']}: {len(xtaps.ITEMS)} passes so far (beta {beta})")
    service_ns = float(np.median(service))
    base = dict(per_row=args.per_row, issue_cap=args.issue_cap, cap=args.cap, lanes=args.lanes, barrier=args.barrier,
                service_ns=service_ns, fixed_ms=fixed_ms, marginal_ms=marginal_ms, demand_priority=True)
    settings = [dict(base, variant=name, threshold=threshold, **variant)
                for name, variant in variants.items() for threshold in THRESHOLDS]
    log(f"{len(xtaps.ITEMS)} passes joined ({joined}), {rescored} forecasts rescored, {len(settings)} settings")
    with mp.get_context("fork").Pool(args.workers) as pool:
        results = list(pool.imap_unordered(xtaps.twin_task, settings, chunksize=1))
    decode_s = decode_ns / 1e9
    table = []
    for setting, t in results:
        m = t["misses"] or 1
        table.append(dict(variant=setting["variant"], threshold=setting["threshold"], issued=int(t["issued"]),
                          timely=int(t["timely"]), late=int(t["late"]), wasted=int(t["wasted"]), misses=int(t["misses"]),
                          timely_coverage=t["timely"] / m, precision=t["timely"] / t["issued"] if t["issued"] else 0.0,
                          saved_ms=t["saved_ms"], projected_ratio=decode_s / max(decode_s - t["saved_ms"] / 1000, 1e-9)))
    order = list(variants)
    table.sort(key=lambda r: (order.index(r["variant"]), r["threshold"]))
    shipped = next(r for r in table if (r["variant"], r["threshold"]) == xtaps.SHIPPED)
    matched = {}
    for name in order:
        curve = sorted((r for r in table if r["variant"] == name), key=lambda r: r["issued"])
        xs = [r["issued"] for r in curve]
        if not xs or not xs[0] <= shipped["issued"] <= xs[-1]:
            matched[name] = None
            continue
        matched[name] = {k: float(np.interp(shipped["issued"], xs, [r[k] for r in curve]))
                         for k in ("timely_coverage", "wasted", "timely", "projected_ratio")}
    tap_m, co_m = matched.get(tap_name), matched.get(f"{tap_name}-coroute")
    report = dict(schema="expert-lookahead-coroute-twin-v1", run=str(run_dir), forecast_run=str(forecast_dir),
                  audit=str(args.audit), audit_sha256=sha256(args.audit), table_sha256=sha256(args.table), alpha=alpha,
                  tap=tap, beta_by_request=beta_of, requests=[r["id"] for r in rows], passes=len(xtaps.ITEMS),
                  joined_passes=joined, rescored_forecasts=rescored, decode_seconds=decode_s, setting=base,
                  thresholds=THRESHOLDS, table=table, shipped=shipped, matched_to_shipped_traffic=matched,
                  coverage_gain=(co_m["timely_coverage"] - tap_m["timely_coverage"]) if tap_m and co_m else None,
                  wasted_change=(co_m["wasted"] - tap_m["wasted"]) if tap_m and co_m else None)
    xla.write_json(Path(args.out), report)
    print(f"{len(xtaps.ITEMS)} passes, {shipped['misses']} misses, decode {decode_s:.1f} s, shipped issued {shipped['issued']}")
    print(f"{'variant':26s} {'thr':>6s} {'issued':>8s} {'timely':>8s} {'wasted':>8s} {'cov':>6s} {'prec':>6s} {'ratio':>6s}")
    for r in table:
        thr = "none" if r["threshold"] < -1e29 else f"{r['threshold']:.4g}"
        print(f"{r['variant']:26s} {thr:>6s} {r['issued']:8d} {r['timely']:8d} {r['wasted']:8d} "
              f"{r['timely_coverage']:6.3f} {r['precision']:6.3f} {r['projected_ratio']:6.3f}")
    print("matched to the shipped setting's issued reads:")
    for name, m in matched.items():
        print(f"  {name:26s} " + ("outside the swept range" if m is None else
              f"coverage {m['timely_coverage']:.4f}, wasted {m['wasted']:.0f}, projected {m['projected_ratio']:.3f}"))
    if report["coverage_gain"] is not None:
        print(f"co-routing coverage gain {report['coverage_gain']:+.4f}, wasted change {report['wasted_change']:+.0f}")


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command", required=True)
    p = sub.add_parser("table")
    p.add_argument("--run", required=True, help="run whose routes are counted, e.g. the pilot capture")
    p.add_argument("--split", default="train")
    p.add_argument("--out", required=True, help="table path ending in .npz; metadata goes beside it as .json")
    p.add_argument("--workers", type=int, default=4)
    p.set_defaults(fn=cmd_table)
    p = sub.add_parser("audit")
    p.add_argument("--run", required=True, help="capture with the tap forecasts, e.g. xla3-taps-20260915/capture")
    p.add_argument("--table", required=True)
    p.add_argument("--out", required=True)
    p.add_argument("--split", default="validation")
    p.add_argument("--tap", type=int, default=1, help="1 attention, 2 attention-shared")
    p.add_argument("--min-target", type=int, default=2)
    p.add_argument("--workers", type=int, default=4)
    p.set_defaults(fn=cmd_audit)
    p = sub.add_parser("twin")
    p.add_argument("--run", required=True, help="residency run, e.g. the pilot capture")
    p.add_argument("--forecast-run", required=True)
    p.add_argument("--table", required=True)
    p.add_argument("--audit", required=True, help="audit report whose leave-one-request-out betas are used")
    p.add_argument("--cost-model", required=True)
    p.add_argument("--out", required=True)
    p.add_argument("--split", default="validation")
    p.add_argument("--per-row", type=int, default=10)
    p.add_argument("--issue-cap", type=int, default=32)
    p.add_argument("--cap", type=int, default=64)
    p.add_argument("--lanes", type=int, default=16)
    p.add_argument("--barrier", type=int, default=4)
    p.add_argument("--workers", type=int, default=4)
    p.set_defaults(fn=cmd_twin)
    args = parser.parse_args()
    args.fn(args)


if __name__ == "__main__":
    main()
