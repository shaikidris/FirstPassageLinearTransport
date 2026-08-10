#!/usr/bin/env python3
"""Finite diagnostic for the Section-36 weighted collision-pressure tail.

By default this measures the UNRESTRICTED direct first-passage law, not the
literal schedule-filtered Phase-3 family.  With ``--loss-rstar`` it applies
the exact sourcewise rank-scaled reverse-loss filter

    E_(2^S) <= (S + 2) / rstar.

That is closer to the Phase-3 consumer, but it is still an ambient direct
first-passage law rather than the recursively generated schedule family.
All outputs are therefore EMPIRICAL mechanism evidence only.

For the shortcut Collatz map and the source shell I_M, stop at the first
landing in J_S = (2^(S-1), 2^S].  Group sources by

    g = (first-passage time h, total odd count s, first odd position u).

For each class, with endpoint counts c_g(y), compute

    X_g = H * sum_y c_g(y) (c_g(y)-1) / n_g^2,
    T_M(R) = R^(1/3) * sum_{g : X_g >= R} n_g / 2^M.

The diagnostic also computes the analogous concentration of each class on
the H equal source blocks of length 2^M/H.  The latter tests the exact
source-block localization route, not a theorem implication in the reverse
direction.

Positive calibration: conditionally uniform endpoints give X_g about 1.
Negative calibration: G equal classes, each supported uniformly on H/G
endpoints, give X_g about G and T_M(G) about G^(1/3).

Finite scope: explicitly enumerated M only.  No finite trend proves or
refutes the all-depth GE.WTAIL statement without an inheritance theorem.
"""

from __future__ import annotations

import argparse
import math

import numpy as np


def first_passage_statistics(M: int, S: int):
    """Return finite arrays (h, y, odd count, first odd position, loss).

    The orbit statistics are integer-exact.  ``scaled_loss`` is accumulated
    in float64 from the exact increments ``2^S / (2 * T^(j+1)(n))``; this is
    used only for the diagnostic source filter.
    """
    if not 1 <= S < M:
        raise ValueError("require 1 <= S < M")

    threshold = 1 << S
    source_lo = 1 << M
    source_hi = 1 << (M + 1)
    values = np.arange(source_lo, source_hi, dtype=np.int64)
    live_index = np.arange(values.size, dtype=np.int64)

    hit_time = np.empty(values.size, dtype=np.int32)
    landing = np.empty(values.size, dtype=np.int64)
    odd_total = np.zeros(values.size, dtype=np.int32)
    first_odd = np.full(values.size, -1, dtype=np.int32)
    scaled_loss = np.zeros(values.size, dtype=np.float64)

    time = 0
    while values.size:
        done = values <= threshold
        if done.any():
            hit = live_index[done]
            hit_time[hit] = time
            landing[hit] = values[done]
            no_odd = first_odd[hit] < 0
            first_odd[hit[no_odd]] = time

            keep = ~done
            values = values[keep]
            live_index = live_index[keep]
            if not values.size:
                break

        odd = (values & 1).astype(bool)
        next_values = np.where(odd, (3 * values + 1) >> 1, values >> 1)
        if odd.any():
            odd_index = live_index[odd]
            unset = first_odd[odd_index] < 0
            first_odd[odd_index[unset]] = time
            odd_total[odd_index] += 1
            scaled_loss[odd_index] += threshold / (
                2.0 * next_values[odd].astype(np.float64)
            )
        values = next_values
        time += 1
        if time > 5000:
            raise RuntimeError("first-passage horizon exceeded")

    band_lo = 1 << (S - 1)
    if not np.all((band_lo < landing) & (landing <= threshold)):
        raise AssertionError("landing escaped the first-passage band")
    return hit_time, landing, odd_total, first_odd, scaled_loss


def compact_groups(h, s, u):
    """Compact the integer triples into consecutive group indices."""
    base = int(max(h.max(), s.max(), u.max())) + 1
    keys = (h.astype(np.int64) * base + s) * base + u
    _, inverse, counts = np.unique(keys, return_inverse=True, return_counts=True)
    return inverse.astype(np.int64), counts.astype(np.int64)


def grouped_off_diagonal(inverse, group_counts, cells, cell_count):
    """Ordered distinct collision counts in each compact group."""
    keys = inverse * cell_count + cells.astype(np.int64)
    unique_keys, multiplicities = np.unique(keys, return_counts=True)
    owner = unique_keys // cell_count
    off = np.zeros(group_counts.size, dtype=np.int64)
    np.add.at(off, owner, multiplicities * (multiplicities - 1))
    return off


def tail_summary(pressure, weights, max_level):
    moment = float(np.sum(weights * np.cbrt(pressure)))
    best = (0.0, 1.0, 0.0)
    rows = []
    for j in range(max_level + 1):
        radius = float(1 << j)
        mass = float(weights[pressure >= radius].sum())
        scaled = radius ** (1.0 / 3.0) * mass
        rows.append((j, radius, mass, scaled))
        if scaled > best[0]:
            best = (scaled, radius, mass)
    return moment, best, rows


def evaluate(M: int, S: int, loss_rstar: float | None):
    h, y, s, u, scaled_loss = first_passage_statistics(M, S)

    source_count = 1 << M
    sources = np.arange(1 << M, 1 << (M + 1), dtype=np.int64)
    if loss_rstar is None:
        selected = np.ones(source_count, dtype=bool)
        loss_cap = math.inf
    else:
        if not 0.0 < loss_rstar < 1.0:
            raise ValueError("loss-rstar must lie strictly between 0 and 1")
        loss_cap = (S + 2.0) / loss_rstar
        selected = scaled_loss <= loss_cap

    h = h[selected]
    y = y[selected]
    s = s[selected]
    u = u[selected]
    sources = sources[selected]
    inverse, group_counts = compact_groups(h, s, u)

    band_size = 1 << (S - 1)
    endpoint_cells = (y - (1 << (S - 1)) - 1).astype(np.int64)
    endpoint_off = grouped_off_diagonal(
        inverse, group_counts, endpoint_cells, band_size
    )

    block_length = source_count // band_size
    source_blocks = ((sources - (1 << M)) // block_length).astype(np.int64)
    block_off = grouped_off_diagonal(
        inverse, group_counts, source_blocks, band_size
    )

    denominators = group_counts.astype(float) ** 2
    endpoint_pressure = band_size * endpoint_off.astype(float) / denominators
    block_pressure = band_size * block_off.astype(float) / denominators
    weights = group_counts.astype(float) / source_count

    endpoint_moment, endpoint_best, endpoint_rows = tail_summary(
        endpoint_pressure, weights, S - 1
    )
    block_moment, block_best, block_rows = tail_summary(
        block_pressure, weights, S - 1
    )

    return {
        "M": M,
        "S": S,
        "selected": int(selected.sum()),
        "selected_share": float(selected.mean()),
        "loss_cap": loss_cap,
        "max_selected_loss": float(scaled_loss[selected].max(initial=0.0)),
        "min_rejected_loss": float(scaled_loss[~selected].min(initial=math.inf)),
        "groups": int(group_counts.size),
        "max_h": int(h.max()),
        "endpoint_moment": endpoint_moment,
        "endpoint_tail_sup": endpoint_best[0],
        "endpoint_worst_R": endpoint_best[1],
        "endpoint_worst_mass": endpoint_best[2],
        "endpoint_max_X": float(endpoint_pressure.max(initial=0.0)),
        "block_moment": block_moment,
        "block_tail_sup": block_best[0],
        "block_worst_R": block_best[1],
        "block_worst_mass": block_best[2],
        "block_max_X": float(block_pressure.max(initial=0.0)),
        "endpoint_rows": endpoint_rows,
        "block_rows": block_rows,
    }


def parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--min-M", type=int, default=14)
    parser.add_argument("--max-M", type=int, default=22)
    parser.add_argument("--step", type=int, default=2)
    parser.add_argument(
        "--S",
        type=int,
        default=None,
        help="fixed terminal rank; default is round(s_factor * log(M+2))",
    )
    parser.add_argument("--s-factor", type=float, default=1.6)
    parser.add_argument(
        "--loss-rstar",
        type=float,
        default=None,
        help=(
            "apply the exact filter E_(2^S) <= (S+2)/rstar; "
            "the resulting law is still an ambient, not generated, law"
        ),
    )
    parser.add_argument(
        "--show-tail",
        action="store_true",
        help="print every dyadic endpoint/block tail after each summary row",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    law = (
        "unrestricted_direct_first_passage"
        if args.loss_rstar is None
        else "loss_filtered_ambient_direct_first_passage"
    )
    print("status=EMPIRICAL law={}".format(law))
    if args.loss_rstar is not None:
        print(
            "loss_filter=E_(2^S)<=(S+2)/rstar rstar={:.12g} "
            "scope_guard=not_literal_recursive_schedule".format(
                args.loss_rstar
            )
        )
    print(
        "calibration_positive=uniform_endpoint_X_approximately_1 "
        "calibration_negative=G_block_aligned_classes_tail_approximately_G^(1/3)"
    )
    print(
        "M S selected selected_share loss_cap max_selected_loss "
        "min_rejected_loss groups max_h endpoint_moment endpoint_tail_sup endpoint_worst_R "
        "endpoint_worst_mass endpoint_max_X block_moment block_tail_sup "
        "block_worst_R block_worst_mass block_max_X"
    )
    for M in range(args.min_M, args.max_M + 1, args.step):
        S = args.S
        if S is None:
            S = int(round(args.s_factor * math.log(M + 2)))
        if not 1 <= S < M:
            continue
        result = evaluate(M, S, args.loss_rstar)
        print(
            "{M} {S} {selected} {selected_share:.12f} {loss_cap:.10f} "
            "{max_selected_loss:.10f} {min_rejected_loss:.10f} "
            "{groups} {max_h} "
            "{endpoint_moment:.10f} {endpoint_tail_sup:.10f} "
            "{endpoint_worst_R:.0f} {endpoint_worst_mass:.12f} "
            "{endpoint_max_X:.10f} {block_moment:.10f} "
            "{block_tail_sup:.10f} {block_worst_R:.0f} "
            "{block_worst_mass:.12f} {block_max_X:.10f}".format(**result)
        )
        if args.show_tail:
            for endpoint_row, block_row in zip(
                result["endpoint_rows"], result["block_rows"]
            ):
                j, radius, endpoint_mass, endpoint_scaled = endpoint_row
                _, _, block_mass, block_scaled = block_row
                print(
                    "tail M={} S={} j={} R={:.0f} "
                    "endpoint_mass={:.12f} endpoint_scaled={:.10f} "
                    "block_mass={:.12f} block_scaled={:.10f}".format(
                        M,
                        S,
                        j,
                        radius,
                        endpoint_mass,
                        endpoint_scaled,
                        block_mass,
                        block_scaled,
                    )
                )


if __name__ == "__main__":
    main()
