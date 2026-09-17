---
type: run
id: 01m2r4z7z78ecyqztk381padsq
created: 2026-09-17T17:00:03.431584+00:00
updated: 2026-09-17T17:00:44.199807+00:00
summary: Verify-pass kernel self-check verify-pass-rows on the first and final builds
binary: f9e23f6cf3e31b29a1c83a9aec5bc64a8b0cf1543e1eb0ca9cdf3ce86536d9a8 (first form); 7a581747832566258100703d14d9d90c8275269efefc1e93a36ca6e6cd02121e and the final build 8d86f10f5b6696d4 (final form, identical results)
captured_at: 2026-09-17
command: .build/release/slotstream-checks --tier t1 --filter verify-pass-rows --json
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Verify-pass kernel self-check verify-pass-rows on the first and final builds
tool: slotstream-checks (T1) verify-pass-rows
---
Raw output of the weights-free catalogue check `verify-pass-rows` (tier T1), which holds the verify-pass kernels on seeded synthetic tensors at the model's shapes: the row-invariant dense matmuls, the split verify attention at a short context, and, in the final build, the exact mode's attention at every key count where the pinned backend changes attention kernels, its indexer selection and quantized products. Expectations must hold; measurements record what the stock or split paths change and are not required.

Command: `.build/release/slotstream-checks --tier t1 --filter verify-pass-rows --json`, rendered below as one line per expectation and measurement. Each run took under 3 s. The JSON files are in the artifact archive.

## First form, binary f9e23f6cf3e31b29 (2026-09-17 09:40 build)

The split ran two rows per call over the whole pass's keys; the check compared it with one-row passes at 61 keys only.

```text
check verify-pass-rows: passed True (24 expectations)
PASS  row-invariant matmul: fp32 router 2560x512: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: fp32 router 2560x512: every row count from one to 8 took the row path
PASS  row-invariant matmul: fp32 router 2560x512: 9 rows keep the stock matmul
PASS  row-invariant matmul: bf16 GDN gate 2560x48: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: bf16 GDN gate 2560x48: every row count from one to 8 took the row path
PASS  row-invariant matmul: bf16 GDN gate 2560x48: 9 rows keep the stock matmul
PASS  row-invariant matmul: bf16 shared-expert gate 2560x1: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: bf16 shared-expert gate 2560x1: every row count from one to 8 took the row path
PASS  row-invariant matmul: bf16 shared-expert gate 2560x1: 9 rows keep the stock matmul
PASS  row-invariant matmul: bf16 indexer 2560x640: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: bf16 indexer 2560x640: every row count from one to 8 took the row path
PASS  row-invariant matmul: bf16 indexer 2560x640: 9 rows keep the stock matmul
PASS  row-invariant matmul: bf16 inject 10240x4: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: bf16 inject 10240x4: every row count from one to 8 took the row path
PASS  row-invariant matmul: bf16 inject 10240x4: 9 rows keep the stock matmul
PASS  split verify attention: 3 rows took the split path
PASS  split verify attention: 3 rows, no selection: every split row equals the one-row pass at its position
PASS  split verify attention: 3 rows, selection mask: every split row equals the one-row pass at its position
PASS  split verify attention: 4 rows took the split path
PASS  split verify attention: 4 rows, no selection: every split row equals the one-row pass at its position
PASS  split verify attention: 4 rows, selection mask: every split row equals the one-row pass at its position
PASS  split verify attention: 8 rows took the split path
PASS  split verify attention: 8 rows, no selection: every split row equals the one-row pass at its position
PASS  split verify attention: 8 rows, selection mask: every split row equals the one-row pass at its position
measure  stock_attention_3_rows_max_abs_delta = 4
measure  stock_matmul_bf16_GDN_gate_2560x48_cases_differing_of_24 = 2
measure  stock_matmul_bf16_indexer_2560x640_cases_differing_of_24 = 13
measure  stock_matmul_bf16_inject_10240x4_cases_differing_of_24 = 0
measure  stock_matmul_bf16_shared-expert_gate_2560x1_cases_differing_of_24 = 0
measure  stock_matmul_fp32_router_2560x512_cases_differing_of_24 = 24
```

## Final form, binaries 7a58174783256625 (11:20 build) and 8d86f10f5b6696d4 (11:57 build, the final one)

The exact mode runs one attention call per row over that row's own keys, from two rows up, and selects each row's index blocks at a one-row pass's shapes. The added expectations cover key counts 1,024, 1,025, 4,096, 8,193, 16,384, 32,769, 65,536 and 65,537 (2, 3 and 5 rows ending on each, with and without a block selection), a three-row indexer selection across a block boundary with 138 tied blocks at the budget, and 4-bit products of 1 to 5 rows in three output-width classes. A build between the two (binary 692c58efad242c69, the same check with the split rows counted in total only) passed the same 45 expectations and counted 32 of 128 split rows differing; its JSON was overwritten by the next run. The 11:57 build differs from the 11:20 build only by a behavior-preserving refactor of the mode selection and new T0 assertions, and gave the same 45 passes and the same measurements; its output is the one below.

```text
check verify-pass-rows: passed True (45 expectations)
PASS  row-invariant matmul: fp32 router 2560x512: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: fp32 router 2560x512: every row count from one to 8 took the row path
PASS  row-invariant matmul: fp32 router 2560x512: 9 rows keep the stock matmul
PASS  row-invariant matmul: bf16 GDN gate 2560x48: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: bf16 GDN gate 2560x48: every row count from one to 8 took the row path
PASS  row-invariant matmul: bf16 GDN gate 2560x48: 9 rows keep the stock matmul
PASS  row-invariant matmul: bf16 shared-expert gate 2560x1: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: bf16 shared-expert gate 2560x1: every row count from one to 8 took the row path
PASS  row-invariant matmul: bf16 shared-expert gate 2560x1: 9 rows keep the stock matmul
PASS  row-invariant matmul: bf16 indexer 2560x640: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: bf16 indexer 2560x640: every row count from one to 8 took the row path
PASS  row-invariant matmul: bf16 indexer 2560x640: 9 rows keep the stock matmul
PASS  row-invariant matmul: bf16 inject 10240x4: rows 2 to 8 equal the path one row at a time, 6 seeds
PASS  row-invariant matmul: bf16 inject 10240x4: every row count from one to 8 took the row path
PASS  row-invariant matmul: bf16 inject 10240x4: 9 rows keep the stock matmul
PASS  split verify attention: 3 rows took the split path
PASS  split verify attention: 3 rows, no selection: every split row equals the one-row pass at its position
PASS  split verify attention: 3 rows, selection mask: every split row equals the one-row pass at its position
PASS  split verify attention: 4 rows took the split path
PASS  split verify attention: 4 rows, no selection: every split row equals the one-row pass at its position
PASS  split verify attention: 4 rows, selection mask: every split row equals the one-row pass at its position
PASS  split verify attention: 8 rows took the split path
PASS  split verify attention: 8 rows, no selection: every split row equals the one-row pass at its position
PASS  split verify attention: 8 rows, selection mask: every split row equals the one-row pass at its position
PASS  exact verify attention: 1024 keys, no selection: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 1024 keys, selection mask: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 1025 keys, no selection: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 1025 keys, selection mask: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 4096 keys, no selection: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 4096 keys, selection mask: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 8193 keys, no selection: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 8193 keys, selection mask: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 16384 keys, no selection: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 16384 keys, selection mask: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 32769 keys, no selection: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 32769 keys, selection mask: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 65536 keys, no selection: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 65536 keys, selection mask: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 65537 keys, no selection: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact verify attention: 65537 keys, selection mask: every exact row of 2, 3 and 5 row passes equals the one-row pass at its position
PASS  exact indexer selection: each row of a three-row pass across a block boundary selects what a one-row pass at its position selects, with tied blocks at the budget
PASS  exact indexer selection: a row whose one-row pass fits the indexer budget has no selection
PASS  quantized matmul: 4-bit 2560x640: 1 to 5 rows equal the product one row at a time
PASS  quantized matmul: 4-bit 2560x6144: 1 to 5 rows equal the product one row at a time
PASS  quantized matmul: 4-bit 10240x2560: 1 to 5 rows equal the product one row at a time
measure  quantized_6_to_8_row_products_compared = 9
measure  quantized_6_to_8_row_products_differing = 0
measure  split_rows_differing_at_1024_keys_of_16 = 11
measure  split_rows_differing_at_1025_keys_of_16 = 12
measure  split_rows_differing_at_16384_keys_of_16 = 0
measure  split_rows_differing_at_32769_keys_of_16 = 0
measure  split_rows_differing_at_4096_keys_of_16 = 0
measure  split_rows_differing_at_65536_keys_of_16 = 0
measure  split_rows_differing_at_65537_keys_of_16 = 0
measure  split_rows_differing_at_8193_keys_of_16 = 9
measure  stock_attention_3_rows_max_abs_delta = 4
measure  stock_matmul_bf16_GDN_gate_2560x48_cases_differing_of_24 = 2
measure  stock_matmul_bf16_indexer_2560x640_cases_differing_of_24 = 13
measure  stock_matmul_bf16_inject_10240x4_cases_differing_of_24 = 0
measure  stock_matmul_bf16_shared-expert_gate_2560x1_cases_differing_of_24 = 0
measure  stock_matmul_fp32_router_2560x512_cases_differing_of_24 = 24
measure  whole_pass_indexer_score_rows_differing = 0
measure  whole_pass_selection_rows_compared_with_ties = 9
measure  whole_pass_selection_rows_differing_with_ties = 0
```

Reading: the split rows match the one-row pass at 4,096, 16,384, 32,769 and 65,536 or more keys on this GPU, and differ in 11, 12 and 9 of 16 rows at 1,024, 1,025 and 8,193 keys, where the backend switches from the one-pass to the two-pass kernel or changes its block count between a row's own key count and the pass's. The exact rows match everywhere. The whole-pass indexer scores and selection matched the one-row ones in this case, and so did 6 to 8 row quantized products on this GPU, whose smallest batch limit is 10.
