---
type: decision
id: 01m51pk98b58s3z3eg7h5qp10a
created: 2026-10-16T06:32:39.435597+00:00
updated: 2026-10-16T21:04:01.173058+00:00
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

## Xcode package identity, October 16, 2026

The first rename commit used Slotstream for both the internal app executable product and the independent engine library. The Xcode job refused the combined graph with duplicate GUID PACKAGE-PRODUCT:Slotstream before compilation. Its failure is preserved in [the original job](https://github.com/carloslfu/slotstream/actions/runs/38862629893/job/116848184417). Local SwiftPM compilation did not reveal this Xcode-specific conflict.

The internal app product is now SlotstreamDesktop. The bundle, executable inside the bundle, Xcode scheme and visible application name remain Slotstream. Native build and UI-check scripts select the distinct internal product. Tools/check_mac_package_products.py compares the actual local Swift package manifests before native checks and Xcode builds; it reproduced the old collision and passes after the correction. The public engine library and CLI keep their names.

The Xcode application target also sets PRODUCT_MODULE_NAME to SlotstreamMac in Debug and Release. Leaving it implicit would name the app module Slotstream and shadow its imported engine module. The same gate reads the actual Xcode build configurations and rejected both old module settings before passing the explicit names. Product naming and module naming are separate graph constraints.


The follow-up [Xcode job](https://github.com/carloslfu/slotstream/actions/runs/38863685366/job/116851532622) exposed a separate case-insensitive intermediate-path collision. The native project Slotstream and engine package slotstream each had a target named Slotstream. Both wrote Slotstream.SwiftFileList under the same effective build directory, so the application compiler received the engine's source list without its package settings. The native Xcode target is now SlotstreamDesktop, with all scheme references updated; the user-facing scheme and product remain Slotstream. The gate also rejects native target names that collide with local package targets after case folding. It rejects the prior project and passes the corrected project. Full Xcode CI must still confirm the corrected build.
