---
type: machine
id: 01m572bxz00a988xg2cmwd3yvq
created: 2026-10-18T08:34:33.568092616+00:00
updated: 2026-10-18T10:19:17.861150921+00:00
summary: Mac mini M4 32 GiB, external and internal mirror comparison
chip: Apple M4
kind: mac
link: https://github.com/carloslfu/slotstream/pull/57
os: macOS 15.7.4, build 24G517
ram_gb: '32'
ssd: WD_BLACK SN8100 2 TB external; APPLE SSD AP0256Z 256 GB internal
title: Mac mini M4 32 GiB, external and internal mirror comparison
---
The checkpoint copies are on separate physical disks: external WD_BLACK
SN8100 2 TB (`disk6`, APFS) and internal APPLE SSD AP0256Z 256 GB (`disk0`,
APFS). Hardware is Mac mini (Mac16,10), Apple M4, 34359738368 bytes RAM;
macOS 15.7.4 build 24G517.

[Raw hardware and storage observations](https://github.com/spikezz/slotstream/blob/9df0b1ad04669e7ceda2a2f75a0c237fe83fb9bd/db/sources/artifacts/mirror-review-20261018/hardware-storage.json)
retain the device information used to verify this distinction. Serial
numbers, volume UUIDs and hostnames are excluded.
