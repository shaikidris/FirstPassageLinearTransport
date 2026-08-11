#!/usr/bin/env python3
"""Exact kill test for a proposed q^(-1) first-crossing barrier gain.

The Collatz barrier uses a fixed walk height a approximately 2*t*q over a
word of length q.  This script decomposes the exact two-sided maximal event
by its unique first-crossing depth.  A first-crossing prefix at depth j has
2^(q-j) arbitrary continuations, so the completed first-crossing cylinders
reassemble the maximal event exactly.

The proposed gain would replace the sharp q^(-1/2) exponential scale by
q^(-3/2).  The printed claimed_over_max_reference ratio is exactly q, which
exposes the missing boundary-height numerator in the ballot formula.
"""

from __future__ import annotations

import argparse
import math


A0 = math.log2(3.0) / 2.0
ETA_STAR = 1.0 - A0
LOG2_3 = math.log2(3.0)
DEFAULT_T = ETA_STAR / LOG2_3


def rate_I(t: float) -> float:
    if not 0.0 < t < 0.5:
        raise ValueError("t must lie in (0, 1/2)")
    return (
        (0.5 + t) * math.log1p(2.0 * t)
        + (0.5 - t) * math.log1p(-2.0 * t)
    )


def parse_lengths(text: str) -> list[int]:
    lengths = [int(piece.strip()) for piece in text.split(",") if piece.strip()]
    if not lengths or any(length < 2 for length in lengths):
        raise ValueError("lengths must be comma-separated integers >= 2")
    return lengths


def first_crossing_decomposition(
    length: int, t: float
) -> tuple[int, int, list[int]]:
    """Return exact bad words, total words, and completed cylinders by depth."""
    crossing_level = math.floor(2.0 * t * length) + 1
    live: dict[int, int] = {0: 1}
    completed_by_depth = [0] * (length + 1)

    for depth in range(1, length + 1):
        nxt: dict[int, int] = {}
        crossing_prefixes = 0
        for position, count in live.items():
            for child in (position - 1, position + 1):
                if abs(child) >= crossing_level:
                    crossing_prefixes += count
                else:
                    nxt[child] = nxt.get(child, 0) + count
        completed_by_depth[depth] = crossing_prefixes << (length - depth)
        live = nxt

    total = 1 << length
    bad = total - sum(live.values())
    if sum(completed_by_depth) != bad:
        raise AssertionError("first-crossing cylinders do not reassemble")
    return bad, total, completed_by_depth


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--lengths", default="60,100,160,240,360")
    parser.add_argument("--t", type=float, default=DEFAULT_T)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    lengths = parse_lengths(args.lengths)
    if not 0.0 < args.t < 0.5:
        raise ValueError("t must lie in (0, 1/2)")

    print(
        "status=EXACT-KILL finite_scope=exact_symmetric_walk_dp "
        "target=first_crossing_q_inverse_gain"
    )
    print(
        "hypothesis=P(max_abs_crossing)<=C*q^(-3/2)*exp(-q*I(t)) "
        "consumer=remove_terminal_rank_factor"
    )
    print(
        "positive_control=first_crossing_cylinders_reassemble_maximal_event "
        "negative_control=claimed_reference_is_q_times_smaller "
        "kill_signal=claimed_ratio_grows_linearly_in_q"
    )
    print(
        "q t crossing_level bad_probability first_reassembly_error "
        "max_reference max_ratio claimed_reference claimed_ratio "
        "claimed_over_max_reference terminal_first_share"
    )

    exact_reassembly = True
    linear_reference = True
    for length in lengths:
        bad, total, by_depth = first_crossing_decomposition(length, args.t)
        probability = bad / total
        exponential = math.exp(-length * rate_I(args.t))
        max_reference = length ** (-0.5) * exponential
        claimed_reference = length ** (-1.5) * exponential
        max_ratio = probability / max_reference
        claimed_ratio = probability / claimed_reference
        reference_ratio = max_reference / claimed_reference
        terminal_first_share = by_depth[length] / bad if bad else 0.0
        reassembly_error = sum(by_depth) - bad
        exact_reassembly = exact_reassembly and reassembly_error == 0
        linear_reference = linear_reference and math.isclose(
            reference_ratio, float(length), rel_tol=1e-12, abs_tol=1e-12
        )
        crossing_level = math.floor(2.0 * args.t * length) + 1
        print(
            "{} {:.12g} {} {:.12g} {} {:.12g} {:.12g} {:.12g} "
            "{:.12g} {:.12g} {:.12g}".format(
                length,
                args.t,
                crossing_level,
                probability,
                reassembly_error,
                max_reference,
                max_ratio,
                claimed_reference,
                claimed_ratio,
                reference_ratio,
                terminal_first_share,
            )
        )

    print(
        "exact_reassembly={} claimed_over_max_reference_is_q={} "
        "audit={}".format(
            exact_reassembly,
            linear_reference,
            "KILL" if exact_reassembly and linear_reference else "REVIEW",
        )
    )


if __name__ == "__main__":
    main()
