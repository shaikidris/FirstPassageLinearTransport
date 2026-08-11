#!/usr/bin/env python3
"""Finite audit of the proposed beta_v fixed-weight residue uniformity.

Write a source as

    n = 2^k (H + B) + v,

and, after the first k shortcut-Collatz steps,

    T^k(n) = 3^r (H + B) + beta_v.

The proposed source-block argument needs beta_v modulo 2^t to be nearly
uniform after conditioning on the prefix odd count r.  This script measures
the maximum residue load divided by its uniform mean.  It also refines by
the first-odd position u, because the actual statistics grouping records u.

The finite computation is exact for the enumerated prefixes.  It is evidence
only: no finite trend proves uniformity when t and S grow with the outer
scale.
"""

from __future__ import annotations

import argparse
import math

import numpy as np


def max_to_mean(values: np.ndarray, modulus: int) -> tuple[float, int]:
    if values.size == 0:
        return math.nan, 0
    counts = np.bincount(values % modulus, minlength=modulus)
    return float(counts.max() / (values.size / modulus)), int(
        np.count_nonzero(counts)
    )


def evaluate(k: int, S: int, t: int) -> dict[str, float | int]:
    if not 1 <= t <= S:
        raise ValueError("require 1 <= t <= S")
    if k > 25:
        raise ValueError("k>25 is outside the intended exhaustive scope")

    H = 1 << (S - 1)
    M = k + S - 1
    modulus = 1 << t
    v = np.arange(1 << k, dtype=np.int64)
    values = (1 << M) + v
    odd_count = np.zeros(v.size, dtype=np.int16)
    first_odd = np.full(v.size, -1, dtype=np.int16)

    for depth in range(k):
        odd = (values & 1).astype(bool)
        first_odd[(first_odd < 0) & odd] = depth
        odd_count += odd.astype(np.int16)
        values = np.where(odd, (3 * values + 1) >> 1, values >> 1)
    first_odd[first_odd < 0] = k

    beta = values - np.array(
        [pow(3, int(r)) * H for r in odd_count], dtype=np.int64
    )
    central_r = k // 2
    fixed_r = odd_count == central_r
    ratio_r, occupied_r = max_to_mean(beta[fixed_r], modulus)

    fixed_r_u0 = fixed_r & (first_odd == 0)
    ratio_u0, occupied_u0 = max_to_mean(beta[fixed_r_u0], modulus)

    worst_ratio = -math.inf
    worst_u = -1
    worst_size = 0
    worst_occupied = 0
    for u in range(k + 1):
        mask = fixed_r & (first_odd == u)
        if not mask.any():
            continue
        ratio, occupied = max_to_mean(beta[mask], modulus)
        if ratio > worst_ratio:
            worst_ratio = ratio
            worst_u = u
            worst_size = int(mask.sum())
            worst_occupied = occupied

    return {
        "k": k,
        "S": S,
        "t": t,
        "modulus": modulus,
        "r": central_r,
        "size_r": int(fixed_r.sum()),
        "ratio_r": ratio_r,
        "occupied_r": occupied_r,
        "size_u0": int(fixed_r_u0.sum()),
        "ratio_u0": ratio_u0,
        "occupied_u0": occupied_u0,
        "worst_u": worst_u,
        "worst_u_size": worst_size,
        "worst_u_ratio": worst_ratio,
        "worst_u_occupied": worst_occupied,
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--min-k", type=int, default=12)
    parser.add_argument("--max-k", type=int, default=22)
    parser.add_argument("--step", type=int, default=2)
    parser.add_argument(
        "--S",
        type=int,
        default=None,
        help="fixed S; default ceil(s_factor*log2(k+2))",
    )
    parser.add_argument("--s-factor", type=float, default=2.0)
    parser.add_argument(
        "--t",
        type=int,
        default=None,
        help="fixed modulus exponent; default S-1",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    print(
        "status=EMPIRICAL finite_scope=exhaustive_prefixes "
        "hypothesis=beta_fixed_weight_uniformity "
        "observable=max_residue_load_over_uniform_mean"
    )
    print(
        "positive_control=synthetic_uniform_ratio_1 "
        "negative_control=singleton_ratio_2^t "
        "kill_guard=fixed_weight_ratio_not_first_odd_refined_max_alone"
    )
    print(
        "k S t modulus r size_r ratio_r occupied_r size_u0 ratio_u0 "
        "occupied_u0 worst_u worst_u_size worst_u_ratio worst_u_occupied"
    )
    for k in range(args.min_k, args.max_k + 1, args.step):
        S = args.S
        if S is None:
            S = math.ceil(args.s_factor * math.log2(k + 2))
        t = args.t if args.t is not None else S - 1
        result = evaluate(k, S, t)
        print(
            "{k} {S} {t} {modulus} {r} {size_r} {ratio_r:.10f} "
            "{occupied_r} {size_u0} {ratio_u0:.10f} {occupied_u0} "
            "{worst_u} {worst_u_size} {worst_u_ratio:.10f} "
            "{worst_u_occupied}".format(**result)
        )


if __name__ == "__main__":
    main()
