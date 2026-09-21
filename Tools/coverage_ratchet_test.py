#!/usr/bin/env python3
"""Weights-free regression checks for coverage_ratchet.py."""

from coverage_ratchet import compare


def main():
    measured = {
        "Sources/Slotstream/Existing.swift": (70, 100),
        "Sources/Slotstream/New.swift": (90, 100),
        "Sources/Slotstream/Up.swift": (80, 100),
    }
    floor = {
        "Sources/Slotstream/Existing.swift": 80.0,
        "Sources/Slotstream/Up.swift": 70.0,
    }
    failures, gains, missing = compare(measured, floor)
    assert failures == [("Sources/Slotstream/Existing.swift", 80.0, 70.0)]
    assert gains == [("Sources/Slotstream/Up.swift", 70.0, 80.0)]
    assert missing == [("Sources/Slotstream/New.swift", 90.0)]

    # LLVM's attribution can move by up to two lines on unrelated edits. That
    # is more than 0.1 point in a small file and must not become a false red.
    failures, gains, missing = compare(
        {"Sources/Slotstream/Stable.swift": (375, 417)},
        {"Sources/Slotstream/Stable.swift": 90.31},
    )
    assert failures == []
    assert gains == []
    assert missing == []

    failures, _, _ = compare(
        {"Sources/Slotstream/RealDrop.swift": (374, 417)},
        {"Sources/Slotstream/RealDrop.swift": 90.31},
    )
    assert failures == [
        ("Sources/Slotstream/RealDrop.swift", 90.31, 100.0 * 374 / 417)
    ]

    # Floors are stored to two decimals. SlotpackDownload.swift's floor, 310 of
    # 319 lines, was written as 97.18, above the 97.1787 it measured, so CI
    # failed a timing-dependent drop of exactly two lines (2026-09-21).
    rounded = {"Sources/Slotstream/Rounded.swift": round(100.0 * 310 / 319, 2)}
    failures, _, _ = compare({"Sources/Slotstream/Rounded.swift": (308, 319)}, rounded)
    assert failures == []
    failures, _, _ = compare({"Sources/Slotstream/Rounded.swift": (307, 319)}, rounded)
    assert failures == [
        ("Sources/Slotstream/Rounded.swift", 97.18, 100.0 * 307 / 319)
    ]
    print("coverage ratchet checks pass")


if __name__ == "__main__":
    main()
