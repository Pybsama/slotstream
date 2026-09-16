#!/usr/bin/env python3
"""Expert Lookahead learned correction for an attention tap (offline probe).

The attention tap forecasts layer T with T's router R_T applied to u, T's hyper-connection read of the
streams after T-1's attention add. A capture with --forecast-taps attention --forecast-inputs on --x2 on
records u for every row and target and T's true router input x2_T, so the true logits z = R_T x2_T and
the tap's logits p = R_T u are recomputed offline with the checkpoint's FP32 routers. Per target layer,
a ridge regression fits z - p ~ (u - mean) W_T + intercept on the training split (intercept unpenalized,
lambda scaled by the mean diagonal of the rows' uncentered Gram matrix), and p + correction is tested on
the validation split. Nothing here runs the engine.

  collect  per request, over complete verify passes with the tap for every target and x2 for every layer:
           u (float16 when every value fits), z, the true routes and the recorded tap ids, as .npy files,
           with two checks (top 10 of z against the routes; top 10 of the offline p against the record)
  fit      per layer: lambda by five-fold cross-validation grouped by training request (folds by sorted
           request id, every fifth), refit on all training rows, validation metrics for the tap, the full
           correction and its rank-128 truncation, and both corrected forecasts (top 24 per row)
  twin     expert_lookahead_taps.TapTwin on the residency run: the shipped boundary forecast and the tap
           from the taps capture, the tap recorded in this capture, and both corrected forms
"""
import argparse
import multiprocessing as mp
import time
from collections import defaultdict
from pathlib import Path

import numpy as np

import expert_lookahead as xla
import expert_lookahead_coroute as xco
import expert_lookahead_forecast as xf
import expert_lookahead_probes as xp
import expert_lookahead_taps as xtaps

LAYERS, EXPERTS, TOPK = xf.LAYERS, xf.EXPERTS, xf.TOPK
TAP = 1  # the tap whose recorded inputs the cache holds; collect and twin take --tap
TARGETS = list(range(1, LAYERS))
LAMBDAS = [0.01, 0.1, 1.0, 10.0, 100.0, 1000.0]
FOLDS, RANK, WIDTH = 5, 128, 24
FULL, TRUNCATED, SAME_CAPTURE = 102, 103, 201
GATES = None


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def splits():
    return {r["id"]: r["split"] for r in xla.corpus_manifest()["requests"]}


def top_sets_match(scores, ids):
    top = np.argpartition(-scores, TOPK - 1, axis=-1)[..., :TOPK]
    return np.all(np.sort(top, axis=-1) == np.sort(ids.astype(np.int64), axis=-1), axis=-1)


# ---------------------------------------------------------------- collect

def collect_request(task):
    capture_dir, row, cache_dir = task
    req = xf.load_request(Path(capture_dir), row, want_inputs=True, want_x2=True)
    if req is None:
        return row["id"], dict(error="no residency snapshot")
    us, zs, routes, recs, where = [], [], [], [], []
    skipped = 0
    for p in xf.complete_verify_passes(req):
        taps = {k[1]: f for k, f in p.get("tap_forecasts", {}).items() if k[2] == TAP and k[0] == k[1] - 1}
        if any(t not in taps or "inputs" not in taps[t] for t in TARGETS) or any(l not in p["x2"] for l in range(LAYERS)):
            skipped += 1
            continue
        r = min([taps[t]["rows"] for t in TARGETS] + [p["x2"][l].shape[0] for l in range(LAYERS)]
                + [p["routes"][l].shape[0] for l in range(LAYERS)])
        us.append(np.stack([taps[t]["inputs"].reshape(taps[t]["rows"], -1)[:r] for t in TARGETS]))
        zs.append(np.stack([p["x2"][l][:r] @ GATES[l].T for l in range(LAYERS)]))
        routes.append(np.stack([p["routes"][l][:r] for l in range(LAYERS)]))
        recs.append(np.stack([taps[t]["ids"][:r] for t in TARGETS]))
        where.extend((p["pass_id"], i) for i in range(r))
    if not us:
        return row["id"], dict(error="no usable passes", skipped=skipped)
    u, z = np.concatenate(us, axis=1), np.concatenate(zs, axis=1).astype(np.float32)
    rt, rec = np.concatenate(routes, axis=1).astype(np.uint16), np.concatenate(recs, axis=1).astype(np.uint16)
    big = float(np.abs(u).max())
    p_off = np.stack([u[i] @ GATES[t].T for i, t in enumerate(TARGETS)])
    checks = dict(stride0_top10_set_match=float(np.mean(top_sets_match(z, rt))),
                  offline_tap_top10_set_match=float(np.mean(top_sets_match(p_off, rec[..., :TOPK]))))
    u = u.astype(np.float16 if big < 60000 else np.float32)
    base = Path(cache_dir) / row["id"]
    for name, arr in (("u", u), ("z", z), ("routes", rt), ("rec", rec), ("where", np.array(where, np.int64))):
        np.save(f"{base}.{name}.npy", arr)
    return row["id"], dict(rows=int(u.shape[1]), passes=len(us), skipped=skipped, max_abs_input=big, dtype=str(u.dtype), **checks)


def cmd_collect(args):
    global GATES, TAP
    TAP = args.tap
    GATES = xp.load_gates(args.model_dir)
    capture, cache = Path(args.capture), Path(args.cache)
    cache.mkdir(parents=True, exist_ok=True)
    split_of = splits()
    rows = [r for r in xla.load_requests_jsonl(capture) if r.get("complete") and split_of.get(r["id"]) in ("train", "validation")]
    summary = {}
    with mp.get_context("fork").Pool(args.workers) as pool:
        for rid, s in pool.imap_unordered(collect_request, [(str(capture), r, str(cache)) for r in rows]):
            s["split"] = split_of[rid]
            summary[rid] = s
            log(f"{rid} ({s['split']}): " + (s["error"] if "error" in s else
                f"{s['rows']} rows, {s['passes']} passes, {s['skipped']} skipped, stride0 {s['stride0_top10_set_match']:.5f}, "
                f"offline tap {s['offline_tap_top10_set_match']:.5f}, max |u| {s['max_abs_input']:.1f}"))
    ok = {k: v for k, v in summary.items() if "error" not in v}
    rows_total = sum(v["rows"] for v in ok.values()) or 1
    report = dict(schema="expert-lookahead-learned-collect-v1", capture=str(capture), cache=str(cache), requests=summary,
                  train=sorted(k for k, v in ok.items() if v["split"] == "train"),
                  validation=sorted(k for k, v in ok.items() if v["split"] == "validation"),
                  stride0_top10_set_match=sum(v["stride0_top10_set_match"] * v["rows"] for v in ok.values()) / rows_total,
                  offline_tap_top10_set_match=sum(v["offline_tap_top10_set_match"] * v["rows"] for v in ok.values()) / rows_total)
    xla.write_json(cache / "collect.json", report)
    print(f"{len(report['train'])} training and {len(report['validation'])} validation requests, stride0 "
          f"{report['stride0_top10_set_match']:.5f}, offline tap {report['offline_tap_top10_set_match']:.5f}")


# ---------------------------------------------------------------- fit

def load_rows(cache, rids, t):
    u = np.concatenate([np.load(cache / f"{rid}.u.npy", mmap_mode="r")[t - 1] for rid in rids]).astype(np.float64)
    z = np.concatenate([np.load(cache / f"{rid}.z.npy", mmap_mode="r")[t] for rid in rids]).astype(np.float64)
    r = np.concatenate([np.load(cache / f"{rid}.routes.npy", mmap_mode="r")[t] for rid in rids]).astype(np.int64)
    return u, u @ GATES[t].T.astype(np.float64), z, r


def moments(u, p, z):
    d = z - p
    return dict(n=len(u), G=u.T @ u, s=u.sum(0), B=u.T @ d, d=d.sum(0))


def ridge(st, lambdas):
    """One solution per lambda: (W, mean of u, mean of z - p); the intercept is unpenalized."""
    n = st["n"]
    mu, delta = st["s"] / n, st["d"] / n
    scale = np.trace(st["G"]) / st["G"].shape[0]
    evals, vecs = np.linalg.eigh(st["G"] - n * np.outer(mu, mu))
    q = vecs.T @ (st["B"] - n * np.outer(mu, delta))
    return [(vecs @ (q / (evals + lam * scale)[:, None]), mu, delta) for lam in lambdas], scale


def agreement_sum(scores, routes):
    top = np.argpartition(-scores, TOPK - 1, axis=1)[:, :TOPK]
    return float((top[:, :, None] == routes[:, None, :]).any(axis=2).sum() / TOPK)


def metrics(scores, routes):
    order = np.argsort(-scores, axis=1, kind="stable")[:, :WIDTH]
    hit = (order[:, :, None] == routes[:, None, :]).any(axis=2)
    top = hit[:, :TOPK].sum(axis=1)
    return np.array([top.sum() / TOPK, (top == TOPK).sum(), hit[:, :16].sum() / TOPK, hit[:, :WIDTH].sum() / TOPK, len(scores)])


def summarize(acc):
    n = max(acc[4], 1)
    return dict(rows=int(acc[4]), top10_agreement=float(acc[0] / n), exact_top10=float(acc[1] / n),
                recall16=float(acc[2] / n), recall24=float(acc[3] / n))


def forecast_arrays(scores):
    order = np.argsort(-scores, axis=1, kind="stable")[:, :WIDTH]
    values = np.take_along_axis(scores, order, axis=1)
    return order.astype(np.uint16), (values - values[:, TOPK - 1:TOPK]).astype(np.float32)


def cmd_fit(args):
    global GATES
    GATES = xp.load_gates(args.model_dir)
    cache, out = Path(args.cache), Path(args.out)
    (out / "forecasts").mkdir(parents=True, exist_ok=True)
    collected = xla.read_json(cache / "collect.json")
    train, val = collected["train"], collected["validation"]
    folds = [[rid for i, rid in enumerate(train) if i % FOLDS == k] for k in range(FOLDS)]
    val_rows = [int(np.load(cache / f"{rid}.where.npy", mmap_mode="r").shape[0]) for rid in val]
    bounds = np.concatenate([[0], np.cumsum(val_rows)])
    groups = {name: np.zeros((LAYERS, 5)) for name in ("tap", "tap_recorded", "full", "rank")}
    per_request = {rid: {k: np.zeros((len(TARGETS), n, WIDTH), np.uint16 if k.startswith("ids") else np.float32)
                         for k in ("ids_full", "margins_full", "ids_rank", "margins_rank")} for rid, n in zip(val, val_rows)}
    layers, factors = [], dict(a=[], b=[], mu=[], delta=[])
    for t in TARGETS:
        started = time.time()
        stats, held = [], []
        for fold in folds:
            u, p, z, r = load_rows(cache, fold, t)
            stats.append(moments(u, p, z))
            held.append((u, p, r))
        total = {k: sum(s[k] for s in stats) for k in stats[0]}
        cv = np.zeros(len(LAMBDAS))
        cv_rows = 0
        for k in range(FOLDS):
            solutions, _ = ridge({key: total[key] - stats[k][key] for key in total}, LAMBDAS)
            u, p, r = held[k]
            for j, (w, mu, delta) in enumerate(solutions):
                cv[j] += agreement_sum(p + (u - mu) @ w + delta, r)
            cv_rows += len(u)
        best = max(range(len(LAMBDAS)), key=lambda j: (round(cv[j], 9), j))
        solutions, scale = ridge(total, [LAMBDAS[best]])
        w, mu, delta = solutions[0]
        left, sv, right = np.linalg.svd(w, full_matrices=False)
        a, b = left[:, :RANK] * sv[:RANK], right[:RANK]
        u, p, z, r = load_rows(cache, val, t)
        rec = np.concatenate([np.load(cache / f"{rid}.rec.npy", mmap_mode="r")[t - 1] for rid in val]).astype(np.int64)
        full = p + (u - mu) @ w + delta
        rank = p + ((u - mu) @ a) @ b + delta
        recorded_order = rec[:, :WIDTH]
        hit = (recorded_order[:, :, None] == r[:, None, :]).any(axis=2)
        top = hit[:, :TOPK].sum(axis=1)
        groups["tap_recorded"][t] = [top.sum() / TOPK, (top == TOPK).sum(), hit[:, :16].sum() / TOPK, hit[:, :WIDTH].sum() / TOPK, len(r)]
        for name, scores in (("tap", p), ("full", full), ("rank", rank)):
            groups[name][t] = metrics(scores, r)
        for form, scores in (("full", full), ("rank", rank)):
            ids, margins = forecast_arrays(scores)
            for i, rid in enumerate(val):
                per_request[rid][f"ids_{form}"][t - 1] = ids[bounds[i]:bounds[i + 1]]
                per_request[rid][f"margins_{form}"][t - 1] = margins[bounds[i]:bounds[i + 1]]
        factors["a"].append(a.astype(np.float32)); factors["b"].append(b.astype(np.float32))
        factors["mu"].append(mu.astype(np.float32)); factors["delta"].append(delta.astype(np.float32))
        layers.append(dict(target=t, train_rows=int(total["n"]), gram_scale=float(scale), lambda_factor=LAMBDAS[best],
                           cv_agreement=[float(x / max(cv_rows, 1)) for x in cv], singular_values_head=[float(x) for x in sv[:8]],
                           rank_energy=float((sv[:RANK] ** 2).sum() / max((sv ** 2).sum(), 1e-30)),
                           validation={name: summarize(groups[name][t]) for name in groups}))
        v = layers[-1]["validation"]
        log(f"T={t}: lambda x{LAMBDAS[best]}, cv {max(layers[-1]['cv_agreement']):.4f}, validation tap {v['tap']['top10_agreement']:.4f} "
            f"full {v['full']['top10_agreement']:.4f} rank {v['rank']['top10_agreement']:.4f} ({time.time() - started:.1f} s)")
    for rid in val:
        np.savez(out / "forecasts" / f"{rid}.npz", where=np.load(cache / f"{rid}.where.npy"), **per_request[rid])
    np.savez(out / "rank128.npz", a=np.stack(factors["a"]), b=np.stack(factors["b"]), mu=np.stack(factors["mu"]),
             delta=np.stack(factors["delta"]), targets=np.array(TARGETS))
    gate_rows = slice(2, LAYERS)
    pooled = {name: summarize(acc[gate_rows].sum(axis=0)) for name, acc in groups.items()}
    by_group = {name: {f"{g}-{g + 7}": summarize(acc[max(g, 2):g + 8].sum(axis=0))["top10_agreement"] for g in range(0, LAYERS, 8)}
                for name, acc in groups.items()}
    fp16_mib = dict(full=len(TARGETS) * EXPERTS * GATES.shape[2] * 2 / 2**20,
                    rank=len(TARGETS) * RANK * (EXPERTS + GATES.shape[2]) * 2 / 2**20)
    report = dict(schema="expert-lookahead-learned-fit-v1", cache=str(cache), train=train, validation=val, folds=folds,
                  lambdas=LAMBDAS, rank=RANK, min_target=2, layers=layers, validation_pooled=pooled, validation_by_group=by_group,
                  gains=dict(full=pooled["full"]["top10_agreement"] - pooled["tap"]["top10_agreement"],
                             rank=pooled["rank"]["top10_agreement"] - pooled["tap"]["top10_agreement"]),
                  fp16_weight_mib=fp16_mib, checks=dict(stride0=collected["stride0_top10_set_match"],
                                                        offline_tap=collected["offline_tap_top10_set_match"],
                                                        recorded_tap_agreement=pooled["tap_recorded"]["top10_agreement"]))
    xla.write_json(out / "fit.json", report)
    print(f"{'form':14s} {'rows':>8s} {'top10':>7s} {'exact':>7s} {'rec16':>7s} {'rec24':>7s}")
    for name, s in pooled.items():
        print(f"{name:14s} {s['rows']:8d} {s['top10_agreement']:7.4f} {s['exact_top10']:7.4f} {s['recall16']:7.4f} {s['recall24']:7.4f}")
    print(f"gains: full {report['gains']['full']:+.4f}, rank-{RANK} {report['gains']['rank']:+.4f}; FP16 weights "
          f"full {fp16_mib['full']:.1f} MiB, rank {fp16_mib['rank']:.1f} MiB")


# ---------------------------------------------------------------- twin

def cmd_twin(args):
    global TAP
    TAP = args.tap
    run_dir, taps_dir, capture_dir, fit_dir = Path(args.run), Path(args.taps_run), Path(args.capture), Path(args.fit)
    fit = xla.read_json(fit_dir / "fit.json")
    taps_rows = {r["id"]: r for r in xla.load_requests_jsonl(taps_dir) if r.get("complete")}
    learned_rows = {r["id"]: r for r in xla.load_requests_jsonl(capture_dir) if r.get("complete")}
    rows = [r for r in xco.split_rows(run_dir, "validation") if r["id"] in fit["validation"] and r["id"] in taps_rows]
    cost_report = xla.read_json(args.cost_model)
    fixed_ms = float(cost_report["read_cost_model"]["intercept_ms"])
    marginal_ms = float(cost_report["read_cost_model"]["slope_ms_per_record"])
    service, decode_ns, joined, attached = [], 0, 0, 0
    for row in rows:
        rid = row["id"]
        req = xf.load_request(run_dir, row)
        donor = xf.load_request(taps_dir, taps_rows[rid])
        learned = xf.load_request(capture_dir, learned_rows[rid])
        if req is None or donor is None or learned is None:
            continue
        joined += xtaps.join_forecasts(req, donor)
        saved = np.load(fit_dir / "forecasts" / f"{rid}.npz")
        arrays = {k: saved[k] for k in saved.files}
        index = defaultdict(list)
        for n, (pid, _) in enumerate(arrays["where"]):
            index[int(pid)].append(n)
        mine = [pid for pid in sorted(req["passes"]) if req["passes"][pid]["phase"] == 1]
        theirs = [pid for pid in sorted(learned["passes"]) if learned["passes"][pid]["phase"] == 1]
        for a, b in zip(mine, theirs):
            pa, pb = req["passes"][a], learned["passes"][b]
            if pa["tokens"] != pb["tokens"]:
                raise SystemExit(f"{rid}: pass {a} and learned pass {b} decode different tokens")
            taps = dict(pa.get("tap_forecasts", {}))
            for (src, tgt, tap), e in pb.get("tap_forecasts", {}).items():
                if tap == TAP:
                    taps[(src, tgt, SAME_CAPTURE)] = e
            rows_idx = index.get(b)
            if rows_idx:
                for code, form in ((FULL, "full"), (TRUNCATED, "rank")):
                    for t in TARGETS:
                        taps[(t - 1, t, code)] = dict(ids=arrays[f"ids_{form}"][t - 1][rows_idx],
                                                      margins=arrays[f"margins_{form}"][t - 1][rows_idx],
                                                      rows=len(rows_idx), per_row=WIDTH)
                attached += 1
            pa["tap_forecasts"] = taps
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
            xtaps.ITEMS.append(dict(forecasts={k: v for k, v in p["forecasts"].items() if k[1] > k[0]},
                                    tap_forecasts=p.get("tap_forecasts", {}), timeline=tl,
                                    read_end=xtaps.read_ends(p, tl["demand_start"]), resident=resident[p["pass_id"]],
                                    misses=xf.miss_sets(p)))
            decode_ns += p["end"] - p["begin"]
        log(f"{rid}: {len(xtaps.ITEMS)} passes so far, {attached} passes with corrected forecasts")
    variants = {"boundary-s2-k4": dict(strides=[2], taps=[], arrival="k4"),
                "attention": dict(strides=[], taps=[TAP], arrival="k4"),
                "attention-this-capture": dict(strides=[], taps=[SAME_CAPTURE], arrival="k4"),
                "attention-learned-full": dict(strides=[], taps=[FULL], arrival="k4"),
                f"attention-learned-rank{RANK}": dict(strides=[], taps=[TRUNCATED], arrival="k4")}
    service_ns = float(np.median(service))
    base = dict(per_row=args.per_row, issue_cap=args.issue_cap, cap=args.cap, lanes=args.lanes, barrier=args.barrier,
                service_ns=service_ns, fixed_ms=fixed_ms, marginal_ms=marginal_ms, demand_priority=True)
    settings = [dict(base, variant=name, threshold=threshold, **variant) for name, variant in variants.items() for threshold in xco.THRESHOLDS]
    log(f"{len(xtaps.ITEMS)} passes joined ({joined}), {len(settings)} settings")
    with mp.get_context("fork").Pool(args.workers) as pool:
        results = list(pool.imap_unordered(xtaps.twin_task, settings, chunksize=1))
    decode_s = decode_ns / 1e9
    table = []
    for setting, t in results:
        m = t["misses"] or 1
        table.append(dict(variant=setting["variant"], threshold=setting["threshold"], issued=int(t["issued"]), timely=int(t["timely"]),
                          late=int(t["late"]), wasted=int(t["wasted"]), misses=int(t["misses"]), timely_coverage=t["timely"] / m,
                          precision=t["timely"] / t["issued"] if t["issued"] else 0.0, saved_ms=t["saved_ms"],
                          projected_ratio=decode_s / max(decode_s - t["saved_ms"] / 1000, 1e-9)))
    order = list(variants)
    table.sort(key=lambda r: (order.index(r["variant"]), r["threshold"]))
    shipped = next(r for r in table if (r["variant"], r["threshold"]) == xtaps.SHIPPED)
    matched = {}
    for name in order:
        curve = sorted((r for r in table if r["variant"] == name), key=lambda r: r["issued"])
        xs = [r["issued"] for r in curve]
        matched[name] = None if not xs or not xs[0] <= shipped["issued"] <= xs[-1] else {
            k: float(np.interp(shipped["issued"], xs, [r[k] for r in curve])) for k in ("timely_coverage", "wasted", "timely", "projected_ratio")}
    ref = matched["attention-this-capture"]
    gains = {name: None if not ref or not matched[name] else dict(coverage=matched[name]["timely_coverage"] - ref["timely_coverage"],
                                                                  wasted=matched[name]["wasted"] - ref["wasted"])
             for name in ("attention-learned-full", f"attention-learned-rank{RANK}")}
    report = dict(schema="expert-lookahead-learned-twin-v1", run=str(run_dir), taps_run=str(taps_dir), capture=str(capture_dir),
                  fit=str(fit_dir), requests=[r["id"] for r in rows], passes=len(xtaps.ITEMS), joined_passes=joined,
                  corrected_passes=attached, decode_seconds=decode_s, setting=base, thresholds=xco.THRESHOLDS, table=table,
                  shipped=shipped, matched_to_shipped_traffic=matched, gains_over_this_capture_tap=gains)
    xla.write_json(Path(args.out), report)
    print(f"{len(xtaps.ITEMS)} passes, {shipped['misses']} misses, shipped issued {shipped['issued']}")
    for name, m in matched.items():
        print(f"  {name:28s} " + ("outside the swept range" if m is None else
              f"coverage {m['timely_coverage']:.4f}, wasted {m['wasted']:.0f}, projected {m['projected_ratio']:.3f}"))
    for name, g in gains.items():
        print(f"  {name}: " + ("n/a" if g is None else f"coverage {g['coverage']:+.4f}, wasted {g['wasted']:+.0f}"))


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command", required=True)
    p = sub.add_parser("collect")
    p.add_argument("--capture", required=True)
    p.add_argument("--cache", required=True)
    p.add_argument("--model-dir", default=str(xla.MODEL))
    p.add_argument("--workers", type=int, default=3)
    p.add_argument("--tap", type=int, default=1, help="forecast tap code whose recorded inputs are collected (1 attention, 4 attention-readout)")
    p.set_defaults(fn=cmd_collect)
    p = sub.add_parser("fit")
    p.add_argument("--cache", required=True)
    p.add_argument("--out", required=True)
    p.add_argument("--model-dir", default=str(xla.MODEL))
    p.set_defaults(fn=cmd_fit)
    p = sub.add_parser("twin")
    p.add_argument("--run", required=True, help="residency run, e.g. the pilot capture")
    p.add_argument("--taps-run", required=True, help="taps capture with the boundary forecasts and the recorded tap")
    p.add_argument("--capture", required=True, help="the learned capture")
    p.add_argument("--fit", required=True)
    p.add_argument("--cost-model", required=True)
    p.add_argument("--out", required=True)
    p.add_argument("--per-row", type=int, default=10)
    p.add_argument("--issue-cap", type=int, default=32)
    p.add_argument("--cap", type=int, default=64)
    p.add_argument("--lanes", type=int, default=16)
    p.add_argument("--barrier", type=int, default=4)
    p.add_argument("--workers", type=int, default=4)
    p.add_argument("--tap", type=int, default=1, help="forecast tap code the fit corrected (1 attention, 4 attention-readout)")
    p.set_defaults(fn=cmd_twin)
    args = parser.parse_args()
    args.fn(args)


if __name__ == "__main__":
    main()
