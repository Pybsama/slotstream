---
type: decision
id: 01m51pk98b58s3z3eg7h5qp10a
created: 2026-10-16T06:32:39.435597+00:00
updated: 2026-10-16T06:32:39.435597+00:00
summary: Name the retained native Mac app Slotstream and remove separate-product promotion without changing the website
decided_on: 2026-10-16
evidence: '[[records/design/sevra-spec/overview]]'
reversible_if: Carlos explicitly chooses another product identity
title: Slotstream app identity
status: standing
---
# Slotstream app identity

On October 16, 2026 Carlos requested removal of the separate-product promotion from the Slotstream README and repository. Keep the native Mac app and name it Slotstream throughout its current UI, build products, development tools and documentation. The separate website remains unchanged and is reserved for another business; no replacement business scope is specified.

The independent engine CLI, Swift library and serving APIs keep their existing names and behavior. Existing Homes, backups and saved mini-apps remain readable. Persisted schema/path identifiers and a narrowly scoped legacy mini-app API alias remain compatibility details. Historical source evidence, measured runs and their coordinates remain unchanged.

New development bundles are Slotstream.app with the com.slotstream.mac.development identifier. Device preferences are copied once from the former bundle domain without replacing current settings. A prior default Home remains discoverable; new users start in ~/Slotstream/Home. No user Home is moved or rewritten by this repository change.

Current app contracts: [[records/design/sevra-spec/overview]], [[records/design/sevra-spec/runtime-contract]] and [[records/design/sevra-spec/implementation-status]]. Their historical record coordinates remain stable for evidence links. This decision supersedes the older separate-product name and promotion in those records.
