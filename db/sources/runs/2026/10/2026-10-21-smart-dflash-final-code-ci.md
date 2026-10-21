---
type: run
id: 01m5g90ekwbax22t3dkq7cjeb9
created: 2026-10-21T22:23:47.324173+00:00
updated: 2026-10-21T22:23:48.392920+00:00
summary: Hosted engine, Mac app and context checks pass for the final native Smart DFlash code
binary: Hosted builds from source ed0c6c9d04a5433f75ce6639e3984abcf6b8bdfe; candidate integrity checked by the engine workflow
captured_at: 2026-10-21
command: gh run view with status, conclusion, headSha, jobs and workflow metadata; exact invocations preserved below
discarded: 'false'
machines: '[[records/machines/github-actions-macos-26]]'
title: Smart DFlash final code hosted verification
tool: GitHub CLI and GitHub Actions
---
# Smart DFlash final code CI receipt

GitHub Actions completed the engine, native Mac app and context-proxy workflows
successfully for source commit `ed0c6c9d04a5433f75ce6639e3984abcf6b8bdfe`.
The captured JSON includes the query commands, exact source identity, job and
step outcomes, timestamps and public run URLs. These are hosted build and
weights-free checks. The actual-model tests and their separate binary identities
remain in [[sources/runs/2026/10/2026-10-21-smart-dflash-review]].

The engine workflow includes release compilation, external-library import,
planner/startup gates, static/runtime safety checks, sampler/governor goldens,
the check catalogue, instrumented tests, coverage generation and verification
that the tested candidate bytes remain unchanged. The Mac app workflow includes
the Xcode build, scripted checks and light/dark offscreen snapshots. This is not
a signed public release or a physical 16/64 GB model test.

```json
{
  "captured_at": "2026-10-21T22:23:43.087259+00:00",
  "source_commit": "ed0c6c9d04a5433f75ce6639e3984abcf6b8bdfe",
  "runs": [
    {
      "command": [
        "gh",
        "run",
        "view",
        "39680693199",
        "--repo",
        "carloslfu/slotstream",
        "--json",
        "status,conclusion,headSha,jobs,url,createdAt,updatedAt,event,workflowName"
      ],
      "result": {
        "conclusion": "success",
        "createdAt": "2026-10-21T21:40:32Z",
        "event": "push",
        "headSha": "ed0c6c9d04a5433f75ce6639e3984abcf6b8bdfe",
        "jobs": [
          {
            "completedAt": "2026-10-21T21:51:16Z",
            "conclusion": "success",
            "databaseId": 119502089538,
            "name": "public-library",
            "startedAt": "2026-10-21T21:43:16Z",
            "status": "completed",
            "steps": [
              {
                "completedAt": "2026-10-21T21:43:19Z",
                "conclusion": "success",
                "name": "Set up job",
                "number": 1,
                "startedAt": "2026-10-21T21:43:18Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:43:47Z",
                "conclusion": "success",
                "name": "Run actions/checkout@v7",
                "number": 2,
                "startedAt": "2026-10-21T21:43:19Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:43:47Z",
                "conclusion": "success",
                "name": "toolchain",
                "number": 3,
                "startedAt": "2026-10-21T21:43:47Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:51:11Z",
                "conclusion": "success",
                "name": "the library is importable from outside the package",
                "number": 4,
                "startedAt": "2026-10-21T21:43:47Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:51:13Z",
                "conclusion": "success",
                "name": "Post Run actions/checkout@v7",
                "number": 8,
                "startedAt": "2026-10-21T21:51:11Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:51:15Z",
                "conclusion": "success",
                "name": "Complete job",
                "number": 9,
                "startedAt": "2026-10-21T21:51:13Z",
                "status": "completed"
              }
            ],
            "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693199/job/119502089538"
          },
          {
            "completedAt": "2026-10-21T22:23:17Z",
            "conclusion": "success",
            "databaseId": 119502089917,
            "name": "weights-free",
            "startedAt": "2026-10-21T21:45:53Z",
            "status": "completed",
            "steps": [
              {
                "completedAt": "2026-10-21T21:45:55Z",
                "conclusion": "success",
                "name": "Set up job",
                "number": 1,
                "startedAt": "2026-10-21T21:45:54Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:15Z",
                "conclusion": "success",
                "name": "Run actions/checkout@v7",
                "number": 2,
                "startedAt": "2026-10-21T21:45:55Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:47:03Z",
                "conclusion": "success",
                "name": "harness entry points (before the native build)",
                "number": 3,
                "startedAt": "2026-10-21T21:46:15Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:47:03Z",
                "conclusion": "success",
                "name": "toolchain",
                "number": 4,
                "startedAt": "2026-10-21T21:47:03Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:47:06Z",
                "conclusion": "success",
                "name": "pinned Metal library",
                "number": 5,
                "startedAt": "2026-10-21T21:47:03Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:02:31Z",
                "conclusion": "success",
                "name": "release build",
                "number": 6,
                "startedAt": "2026-10-21T21:47:06Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:02:37Z",
                "conclusion": "success",
                "name": "preserve the candidate before testing",
                "number": 7,
                "startedAt": "2026-10-21T22:02:31Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:02:42Z",
                "conclusion": "success",
                "name": "Run actions/upload-artifact@v4",
                "number": 8,
                "startedAt": "2026-10-21T22:02:37Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:04:10Z",
                "conclusion": "success",
                "name": "planner startup and checkpoint gates (fail early)",
                "number": 9,
                "startedAt": "2026-10-21T22:02:42Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:04:11Z",
                "conclusion": "success",
                "name": "pinned dbmd (the brain gates inside static_gates.sh need it)",
                "number": 10,
                "startedAt": "2026-10-21T22:04:10Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:21:54Z",
                "conclusion": "success",
                "name": "static and runtime safety gates",
                "number": 11,
                "startedAt": "2026-10-21T22:04:11Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:22:10Z",
                "conclusion": "success",
                "name": "sampler and governor goldens",
                "number": 12,
                "startedAt": "2026-10-21T22:21:54Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:23:09Z",
                "conclusion": "success",
                "name": "check catalogue (every check by name)",
                "number": 13,
                "startedAt": "2026-10-21T22:22:10Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:23:11Z",
                "conclusion": "success",
                "name": "the tested bytes still match the candidate",
                "number": 14,
                "startedAt": "2026-10-21T22:23:09Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:23:12Z",
                "conclusion": "success",
                "name": "Post Run actions/checkout@v7",
                "number": 28,
                "startedAt": "2026-10-21T22:23:11Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:23:15Z",
                "conclusion": "success",
                "name": "Complete job",
                "number": 29,
                "startedAt": "2026-10-21T22:23:12Z",
                "status": "completed"
              }
            ],
            "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693199/job/119502089917"
          },
          {
            "completedAt": "2026-10-21T22:02:49Z",
            "conclusion": "success",
            "databaseId": 119502090013,
            "name": "coverage",
            "startedAt": "2026-10-21T21:46:23Z",
            "status": "completed",
            "steps": [
              {
                "completedAt": "2026-10-21T21:46:25Z",
                "conclusion": "success",
                "name": "Set up job",
                "number": 1,
                "startedAt": "2026-10-21T21:46:24Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:43Z",
                "conclusion": "success",
                "name": "Run actions/checkout@v7",
                "number": 2,
                "startedAt": "2026-10-21T21:46:25Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:43Z",
                "conclusion": "success",
                "name": "toolchain",
                "number": 3,
                "startedAt": "2026-10-21T21:46:43Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:45Z",
                "conclusion": "success",
                "name": "pinned Metal library",
                "number": 4,
                "startedAt": "2026-10-21T21:46:43Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:02:41Z",
                "conclusion": "success",
                "name": "instrumented checks and coverage collection",
                "number": 5,
                "startedAt": "2026-10-21T21:46:45Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:02:41Z",
                "conclusion": "success",
                "name": "coverage changes (advisory)",
                "number": 6,
                "startedAt": "2026-10-21T22:02:41Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:02:43Z",
                "conclusion": "success",
                "name": "coverage report",
                "number": 7,
                "startedAt": "2026-10-21T22:02:41Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:02:44Z",
                "conclusion": "success",
                "name": "Post Run actions/checkout@v7",
                "number": 14,
                "startedAt": "2026-10-21T22:02:43Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:02:46Z",
                "conclusion": "success",
                "name": "Complete job",
                "number": 15,
                "startedAt": "2026-10-21T22:02:44Z",
                "status": "completed"
              }
            ],
            "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693199/job/119502090013"
          }
        ],
        "status": "completed",
        "updatedAt": "2026-10-21T22:23:18Z",
        "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693199",
        "workflowName": "ci"
      }
    },
    {
      "command": [
        "gh",
        "run",
        "view",
        "39680693003",
        "--repo",
        "carloslfu/slotstream",
        "--json",
        "status,conclusion,headSha,jobs,url,createdAt,updatedAt,event,workflowName"
      ],
      "result": {
        "conclusion": "success",
        "createdAt": "2026-10-21T21:40:31Z",
        "event": "push",
        "headSha": "ed0c6c9d04a5433f75ce6639e3984abcf6b8bdfe",
        "jobs": [
          {
            "completedAt": "2026-10-21T22:01:12Z",
            "conclusion": "success",
            "databaseId": 119502089563,
            "name": "xcode",
            "startedAt": "2026-10-21T21:45:46Z",
            "status": "completed",
            "steps": [
              {
                "completedAt": "2026-10-21T21:45:48Z",
                "conclusion": "success",
                "name": "Set up job",
                "number": 1,
                "startedAt": "2026-10-21T21:45:47Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:35Z",
                "conclusion": "success",
                "name": "Run actions/checkout@v7",
                "number": 2,
                "startedAt": "2026-10-21T21:45:48Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:35Z",
                "conclusion": "success",
                "name": "toolchain",
                "number": 3,
                "startedAt": "2026-10-21T21:46:35Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:40Z",
                "conclusion": "success",
                "name": "pinned dbmd and Metal library, which the app bundle carries",
                "number": 4,
                "startedAt": "2026-10-21T21:46:35Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:01:06Z",
                "conclusion": "success",
                "name": "Xcode project build, ad hoc signed",
                "number": 5,
                "startedAt": "2026-10-21T21:46:40Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:01:07Z",
                "conclusion": "success",
                "name": "Post Run actions/checkout@v7",
                "number": 10,
                "startedAt": "2026-10-21T22:01:06Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:01:10Z",
                "conclusion": "success",
                "name": "Complete job",
                "number": 11,
                "startedAt": "2026-10-21T22:01:07Z",
                "status": "completed"
              }
            ],
            "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693003/job/119502089563"
          },
          {
            "completedAt": "2026-10-21T22:14:28Z",
            "conclusion": "success",
            "databaseId": 119502089767,
            "name": "checks",
            "startedAt": "2026-10-21T21:45:26Z",
            "status": "completed",
            "steps": [
              {
                "completedAt": "2026-10-21T21:45:28Z",
                "conclusion": "success",
                "name": "Set up job",
                "number": 1,
                "startedAt": "2026-10-21T21:45:28Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:19Z",
                "conclusion": "success",
                "name": "Run actions/checkout@v7",
                "number": 2,
                "startedAt": "2026-10-21T21:45:28Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:19Z",
                "conclusion": "success",
                "name": "toolchain",
                "number": 3,
                "startedAt": "2026-10-21T21:46:19Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:46:19Z",
                "conclusion": "success",
                "name": "pinned dbmd",
                "number": 4,
                "startedAt": "2026-10-21T21:46:19Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:14:23Z",
                "conclusion": "success",
                "name": "scripted checks, no model weights",
                "number": 5,
                "startedAt": "2026-10-21T21:46:19Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:14:25Z",
                "conclusion": "success",
                "name": "offscreen view snapshots, light and dark",
                "number": 6,
                "startedAt": "2026-10-21T22:14:23Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:14:25Z",
                "conclusion": "success",
                "name": "Post Run actions/checkout@v7",
                "number": 12,
                "startedAt": "2026-10-21T22:14:25Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T22:14:27Z",
                "conclusion": "success",
                "name": "Complete job",
                "number": 13,
                "startedAt": "2026-10-21T22:14:25Z",
                "status": "completed"
              }
            ],
            "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693003/job/119502089767"
          }
        ],
        "status": "completed",
        "updatedAt": "2026-10-21T22:14:29Z",
        "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693003",
        "workflowName": "slotstream-mac"
      }
    },
    {
      "command": [
        "gh",
        "run",
        "view",
        "39680693062",
        "--repo",
        "carloslfu/slotstream",
        "--json",
        "status,conclusion,headSha,jobs,url,createdAt,updatedAt,event,workflowName"
      ],
      "result": {
        "conclusion": "success",
        "createdAt": "2026-10-21T21:40:32Z",
        "event": "push",
        "headSha": "ed0c6c9d04a5433f75ce6639e3984abcf6b8bdfe",
        "jobs": [
          {
            "completedAt": "2026-10-21T21:43:13Z",
            "conclusion": "success",
            "databaseId": 119502089090,
            "name": "software-contracts",
            "startedAt": "2026-10-21T21:40:36Z",
            "status": "completed",
            "steps": [
              {
                "completedAt": "2026-10-21T21:40:37Z",
                "conclusion": "success",
                "name": "Set up job",
                "number": 1,
                "startedAt": "2026-10-21T21:40:36Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:41:07Z",
                "conclusion": "success",
                "name": "Run actions/checkout@v7",
                "number": 2,
                "startedAt": "2026-10-21T21:40:37Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:43:07Z",
                "conclusion": "success",
                "name": "Context source and transport proxies, without MLX or weights",
                "number": 3,
                "startedAt": "2026-10-21T21:41:07Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:43:09Z",
                "conclusion": "success",
                "name": "Context evidence and deferred native cases",
                "number": 4,
                "startedAt": "2026-10-21T21:43:07Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:43:10Z",
                "conclusion": "success",
                "name": "Post Run actions/checkout@v7",
                "number": 8,
                "startedAt": "2026-10-21T21:43:09Z",
                "status": "completed"
              },
              {
                "completedAt": "2026-10-21T21:43:11Z",
                "conclusion": "success",
                "name": "Complete job",
                "number": 9,
                "startedAt": "2026-10-21T21:43:10Z",
                "status": "completed"
              }
            ],
            "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693062/job/119502089090"
          }
        ],
        "status": "completed",
        "updatedAt": "2026-10-21T21:43:14Z",
        "url": "https://github.com/carloslfu/slotstream/actions/runs/39680693062",
        "workflowName": "context-proxies"
      }
    }
  ]
}
```
