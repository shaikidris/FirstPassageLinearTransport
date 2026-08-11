#!/usr/bin/env python3
"""Finite audit for the critical-exponent log-log endpoint proposal.

This script tests the two new quantitative ingredients only:

1. the exact maximal symmetric-walk probability against the proposed
   m^(-1/2) exp(-m I(t)) scale when t stays in a compact subset of
   (0, 1/2);
2. the scalar normalization obtained from

       L_M = ceil(A_FP log_2(M+2) + B log_2 log(M+3)).

It also audits the secondary endpoint B = 1/kappa_star with the
third-order multiplier (log log M)^D.  The D=0 row is the predeclared
boundary control: its scalar failure proxy stays of constant order and
therefore does not prove density convergence.

The walk probability is computed exactly by dynamic programming with Python
integers.  The asymptotic comparison is floating-point diagnostic output.
It is evidence for the proposed analytic proof, not an all-depth certificate.

The negative control takes t = 1/m.  It must visibly degrade because the
m^(-1/2) prefactor is not uniform as t approaches zero.
"""

from __future__ import annotations

import argparse
import math


A0 = math.log2(3.0) / 2.0
ETA_STAR = 1.0 - A0
LOG2_3 = math.log2(3.0)


def rate_I(t: float) -> float:
    if not 0.0 <= t < 0.5:
        raise ValueError("rate argument must lie in [0, 1/2)")
    if t == 0.0:
        return 0.0
    return (
        (0.5 + t) * math.log1p(2.0 * t)
        + (0.5 - t) * math.log1p(-2.0 * t)
    )


KAPPA_STAR = rate_I(ETA_STAR / LOG2_3) / math.log(2.0)
A_FP = 1.0 / (2.0 * KAPPA_STAR)


def exact_max_abs_bad_count(length: int, t: float) -> tuple[int, int]:
    """Count words with max |Y_j| > 2 t length exactly."""
    if length < 1:
        raise ValueError("length must be positive")
    crossing_level = math.floor(2.0 * t * length) + 1
    live: dict[int, int] = {0: 1}
    for _ in range(length):
        nxt: dict[int, int] = {}
        for position, count in live.items():
            for child in (position - 1, position + 1):
                if abs(child) < crossing_level:
                    nxt[child] = nxt.get(child, 0) + count
        live = nxt
    total = 1 << length
    return total - sum(live.values()), total


def parse_outer_shells(text: str) -> list[int]:
    values = [int(piece.strip()) for piece in text.split(",") if piece.strip()]
    if not values or any(value < 4 for value in values):
        raise ValueError("outer shell list must contain integers >= 4")
    return values


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--outer-shells",
        default="1000,10000,100000,1000000",
        help="comma-separated outer shell ranks M",
    )
    parser.add_argument("--B", type=float, default=21.0)
    parser.add_argument(
        "--secondary-D",
        type=float,
        default=1.0,
        help="power D in the secondary multiplier (log log M)^D",
    )
    parser.add_argument("--K0", type=float, default=8.0)
    parser.add_argument("--K1", type=float, default=8.0)
    parser.add_argument("--switch-C", type=float, default=40.0)
    parser.add_argument(
        "--max-walk-length",
        type=int,
        default=500,
        help="cap exact-DP length while retaining the literal moving t",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    outer_shells = parse_outer_shells(args.outer_shells)
    if (
        args.B <= 0.0
        or args.secondary_D <= 0.0
        or args.K0 <= 0.0
        or args.K1 <= 0.0
    ):
        raise ValueError("B, secondary-D, K0, and K1 must be positive")

    print(
        "status=EMPIRICAL finite_scope=exact_symmetric_walk_dp "
        "target=critical_endpoint_loglog_and_secondary_endpoint"
    )
    print(
        "hypothesis=maximal_bad_probability"
        "<=C*m^(-1/2)*exp(-m*I(t)); "
        "consumer=critical_low_target_density"
    )
    print(
        "positive_control=t_moving_in_compact_interval "
        "negative_control=t=1/m_and_secondary_D=0 "
        "kill_signal=positive_ratio_unbounded_with_length "
        "continue_signal=positive_ratio_bounded_and_secondary_normalization_bounded"
    )
    print(
        "constants A_FP={:.15g} kappa_star={:.15g} "
        "critical_B={:.15g} B={:.15g} secondary_D={:.15g}".format(
            A_FP,
            KAPPA_STAR,
            1.0 / KAPPA_STAR,
            args.B,
            args.secondary_D,
        )
    )
    print(
        "M L S eta lambda r gap t walk_m exact_bad_probability "
        "positive_ratio boundary_ratio rate_gap_times_L scalar_proxy "
        "scalar_normalized secondary_L secondary_proxy secondary_reference "
        "secondary_normalized secondary_boundary_L secondary_boundary_proxy"
    )

    positive_ratios: list[float] = []
    boundary_ratios: list[float] = []
    secondary_normalized_values: list[float] = []
    secondary_boundary_values: list[float] = []
    for M in outer_shells:
        log_m = math.log(M)
        loglog_m = math.log(log_m)
        L = math.ceil(
            A_FP * math.log2(M + 2.0)
            + args.B * math.log2(math.log(M + 3.0))
        )
        S = math.ceil(args.switch_C * math.log(M + 2.0))
        if not L < S < M:
            raise ValueError(
                "schedule ordering failed at M={}: L={}, S={}".format(M, L, S)
            )
        eta = ETA_STAR - args.K0 / L
        lam = 1.0 - args.K1 / L
        r = 1.0 - args.K0 / (2.0 * L)
        gap = r - A0 - eta
        t = lam * eta / LOG2_3
        if not 0.0 < t < 0.5:
            raise ValueError("moving walk height left (0, 1/2)")

        walk_m = min(L - 1, args.max_walk_length)
        bad, total = exact_max_abs_bad_count(walk_m, t)
        probability = bad / total
        reference = walk_m ** (-0.5) * math.exp(-walk_m * rate_I(t))
        positive_ratio = probability / reference
        positive_ratios.append(positive_ratio)

        boundary_t = 1.0 / walk_m
        boundary_bad, boundary_total = exact_max_abs_bad_count(
            walk_m, boundary_t
        )
        boundary_probability = boundary_bad / boundary_total
        boundary_reference = walk_m ** (-0.5) * math.exp(
            -walk_m * rate_I(boundary_t)
        )
        boundary_ratio = boundary_probability / boundary_reference
        boundary_ratios.append(boundary_ratio)

        b_star = rate_I(ETA_STAR / LOG2_3)
        b_moving = rate_I(t)
        rate_gap_times_L = (b_star - b_moving) * L

        scalar_proxy = (
            math.sqrt(M * log_m)
            * math.sqrt(L)
            * 2.0 ** (-KAPPA_STAR * L)
        )
        scalar_reference = log_m ** (1.0 - args.B * KAPPA_STAR)
        scalar_normalized = scalar_proxy / scalar_reference

        critical_B = 1.0 / KAPPA_STAR
        secondary_L = math.ceil(
            A_FP * math.log2(M + 2.0)
            + critical_B * math.log2(math.log(M + 3.0))
            + args.secondary_D * math.log2(loglog_m)
        )
        secondary_proxy = (
            math.sqrt(M * log_m)
            * math.sqrt(secondary_L)
            * 2.0 ** (-KAPPA_STAR * secondary_L)
        )
        secondary_reference = loglog_m ** (
            -args.secondary_D * KAPPA_STAR
        )
        secondary_normalized = secondary_proxy / secondary_reference
        secondary_normalized_values.append(secondary_normalized)

        secondary_boundary_L = math.ceil(
            A_FP * math.log2(M + 2.0)
            + critical_B * math.log2(math.log(M + 3.0))
        )
        secondary_boundary_proxy = (
            math.sqrt(M * log_m)
            * math.sqrt(secondary_boundary_L)
            * 2.0 ** (-KAPPA_STAR * secondary_boundary_L)
        )
        secondary_boundary_values.append(secondary_boundary_proxy)

        print(
            "{} {} {} {:.12g} {:.12g} {:.12g} {:.12g} {:.12g} {} "
            "{:.12g} {:.12g} {:.12g} {:.12g} {:.12g} {:.12g} {} "
            "{:.12g} {:.12g} {:.12g} {} {:.12g}".format(
                M,
                L,
                S,
                eta,
                lam,
                r,
                gap,
                t,
                walk_m,
                probability,
                positive_ratio,
                boundary_ratio,
                rate_gap_times_L,
                scalar_proxy,
                scalar_normalized,
                secondary_L,
                secondary_proxy,
                secondary_reference,
                secondary_normalized,
                secondary_boundary_L,
                secondary_boundary_proxy,
            )
        )

    boundary_degrades = boundary_ratios[-1] > boundary_ratios[0]
    positive_bounded = max(positive_ratios) < 20.0
    secondary_bounded = max(secondary_normalized_values) < 20.0
    secondary_boundary_nonvanishing = min(secondary_boundary_values) > 0.1
    print(
        "max_positive_ratio={:.12g} boundary_ratio_first={:.12g} "
        "boundary_ratio_last={:.12g} positive_bounded={} "
        "boundary_degrades={} max_secondary_normalized={:.12g} "
        "min_secondary_boundary_proxy={:.12g} secondary_bounded={} "
        "secondary_boundary_nonvanishing={} audit={}".format(
            max(positive_ratios),
            boundary_ratios[0],
            boundary_ratios[-1],
            positive_bounded,
            boundary_degrades,
            max(secondary_normalized_values),
            min(secondary_boundary_values),
            secondary_bounded,
            secondary_boundary_nonvanishing,
            (
                "PASS"
                if (
                    positive_bounded
                    and boundary_degrades
                    and secondary_bounded
                    and secondary_boundary_nonvanishing
                )
                else "REVIEW"
            ),
        )
    )


if __name__ == "__main__":
    main()
