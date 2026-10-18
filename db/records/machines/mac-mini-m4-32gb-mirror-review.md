---
type: machine
id: 01m572bxz00a988xg2cmwd3yvq
created: 2026-10-18T08:34:33.568092616+00:00
updated: 2026-10-18T08:34:33.568092616+00:00
summary: Mac mini M4 32 GiB, external and internal mirror comparison
chip: Apple M4
kind: mac
link: https://github.com/carloslfu/slotstream/pull/57
os: macOS 15.7.4, build 24G517
ram_gb: '32'
ssd: WD_BLACK SN8100 2 TB external; APPLE SSD AP0256Z 256 GB internal
title: Mac mini M4 32 GiB, external and internal mirror comparison
---
Read-only hardware observations captured for PR #57. The checkpoint copies are on distinct physical disks. Serial numbers, volume UUIDs and hostnames are excluded.

```json
{
  "hardware": {
    "chip": "Apple M4",
    "model": "Mac mini (Mac16,10)",
    "memory_bytes": 34359738368
  },
  "os": "ProductName:\t\tmacOS\nProductVersion:\t\t15.7.4\nBuildVersion:\t\t24G517\n",
  "storage": {
    "external": {
      "filesystem": "apfs",
      "physical_devices": [
        {
          "DeviceIdentifier": "disk6",
          "MediaName": "WD_BLACK SN8100 2000GB",
          "BusProtocol": "PCI-Express",
          "Internal": false,
          "SolidState": true,
          "TotalSize": 2000398934016,
          "DeviceBlockSize": 512,
          "Removable": false,
          "VirtualOrPhysical": "Physical"
        }
      ]
    },
    "internal": {
      "filesystem": "apfs",
      "physical_devices": [
        {
          "DeviceIdentifier": "disk0",
          "MediaName": "APPLE SSD AP0256Z",
          "BusProtocol": "Apple Fabric",
          "Internal": true,
          "SolidState": true,
          "TotalSize": 251000193024,
          "DeviceBlockSize": 4096,
          "Removable": false,
          "VirtualOrPhysical": "Unknown"
        }
      ]
    }
  }
}
```
