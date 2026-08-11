#!/usr/bin/env python3
"""Finite audit of reverse loss on the literal stopped bad target.

This diagnostic tests the source-weighted quantity left open by the exact
loss-truncation reduction.  For the source shell I_M it:

* retains the recursively certified high-phase sources down to switch rank S;
* forms the literal stopped low-phase bad target C^st_(S,L);
* takes the direct first passage from I_M to J_S;
* measures the scaled reverse loss E_(2^S) only on sources landing in C^st.

The proof-level sufficient quantity is

    Lambda = sum_{bad sources} E_(2^S)
             / (#time tags * target density * 2^M).

If Lambda is O(S^(2 theta)), the exact truncation inequality has effective
rank loss O(S^theta).  In particular bounded Lambda supports theta = 0.

Controls:

* random: a deterministic random target with the same cardinality;
* adversarial: the same number of endpoint cells having the largest retained
  reverse-loss mass.

Orbit, target-membership, and source-retention decisions are exact.  Reverse
loss is accumulated in float64 from exact rational increments; selected
quantiles are diagnostic only.

Status: EMPIRICAL, finite-scope, switch-composite target.  It is not a proof
of an all-depth loss moment and does not update the manuscript headline.
"""

from __future__ import annotations

import argparse
import math
from fractions import Fraction

import numpy as np

from audit_target_specific_block_covariance import (
    parse_fraction,
    recursive_high_mask,
    stopped_target,
)
from audit_weighted_collision_pressure import first_passage_statistics


A0 = math.log2(3.0) / 2.0


def target_metrics(
    retained: np.ndarray,
    endpoint_cells: np.ndarray,
    target_cells: np.ndarray,
    loss: np.ndarray,
    time_tag_count: int,
) -> dict[str, float]:
    source_count = retained.size
    target_density = float(target_cells.mean())
    selected = retained & target_cells[endpoint_cells]
    selected_count = int(selected.sum())
    selected_share = selected_count / source_count
    total_loss = float(loss[selected].sum())
    weighted_loss_share = total_loss / source_count

    if target_density > 0.0:
        mass_enrichment = selected_share / target_density
        loss_enrichment = weighted_loss_share / target_density
    else:
        mass_enrichment = math.nan
        loss_enrichment = math.nan

    neutral_scale = time_tag_count * target_density
    loss_lambda = (
        weighted_loss_share / neutral_scale
        if neutral_scale > 0.0
        else math.nan
    )
    selected_loss = loss[selected]
    if selected_count:
        quantiles = np.quantile(selected_loss, [0.5, 0.9, 0.99, 0.999])
        mean_loss = float(selected_loss.mean())
        max_loss = float(selected_loss.max())
    else:
        quantiles = np.zeros(4)
        mean_loss = 0.0
        max_loss = 0.0

    return {
        "target_density": target_density,
        "selected_count": float(selected_count),
        "selected_share": selected_share,
        "mass_enrichment": mass_enrichment,
        "weighted_loss_share": weighted_loss_share,
        "loss_enrichment": loss_enrichment,
        "loss_lambda": loss_lambda,
        "mean_loss": mean_loss,
        "p50_loss": float(quantiles[0]),
        "p90_loss": float(quantiles[1]),
        "p99_loss": float(quantiles[2]),
        "p999_loss": float(quantiles[3]),
        "max_loss": max_loss,
    }


def same_size_controls(
    M: int,
    retained: np.ndarray,
    endpoint_cells: np.ndarray,
    actual_target: np.ndarray,
    loss: np.ndarray,
    time_tag_count: int,
) -> tuple[dict[str, float], dict[str, float]]:
    cell_count = actual_target.size
    target_size = int(actual_target.sum())

    rng = np.random.default_rng(17011 + M)
    random_target = np.zeros(cell_count, dtype=bool)
    if target_size:
        random_target[rng.choice(cell_count, target_size, replace=False)] = True

    endpoint_loss = np.zeros(cell_count, dtype=np.float64)
    np.add.at(
        endpoint_loss,
        endpoint_cells[retained],
        loss[retained],
    )
    adversarial_target = np.zeros(cell_count, dtype=bool)
    if target_size:
        order = np.argsort(endpoint_loss, kind="stable")
        adversarial_target[order[-target_size:]] = True

    return (
        target_metrics(
            retained,
            endpoint_cells,
            random_target,
            loss,
            time_tag_count,
        ),
        target_metrics(
            retained,
            endpoint_cells,
            adversarial_target,
            loss,
            time_tag_count,
        ),
    )


def evaluate(
    M: int,
    S: int,
    L: int,
    r: Fraction,
    eta: Fraction,
    near_tol: float,
    tail_thresholds: tuple[float, ...],
) -> dict[str, object]:
    retained, min_margin, near_count, checkpoint_count = recursive_high_mask(
        M, S, r, eta, near_tol
    )
    h, y, _, _, loss = first_passage_statistics(M, S)
    endpoints, bad = stopped_target(S, L, r, eta)

    band_lo = 1 << (S - 1)
    endpoint_cells = (y - band_lo - 1).astype(np.int64)
    if endpoint_cells.min() < 0 or endpoint_cells.max() >= bad.size:
        raise AssertionError("a first-passage endpoint escaped J_S")
    if endpoints.size != bad.size or endpoints.size != 1 << (S - 1):
        raise AssertionError("stopped target does not cover J_S exactly")

    time_tag_count = int(np.unique(h[retained]).size)
    actual = target_metrics(
        retained,
        endpoint_cells,
        bad,
        loss,
        time_tag_count,
    )
    random_control, adversarial_control = same_size_controls(
        M,
        retained,
        endpoint_cells,
        bad,
        loss,
        time_tag_count,
    )

    selected = retained & bad[endpoint_cells]
    selected_count = max(1, int(selected.sum()))
    tails = []
    max_truncation_violation = -math.inf
    target_density = actual["target_density"]
    selected_share = actual["selected_share"]
    threshold_y = 1 << S
    source_count = 1 << M
    for threshold in tail_thresholds:
        tail_count = int(np.count_nonzero(selected & (loss > threshold)))
        tail_share = tail_count / source_count
        conditional_tail = tail_count / selected_count
        truncation_rhs = time_tag_count * target_density * (
            threshold_y / source_count + 3.0 * threshold
        ) + tail_share
        max_truncation_violation = max(
            max_truncation_violation,
            selected_share - truncation_rhs,
        )
        tails.append(
            (threshold, conditional_tail, tail_share, truncation_rhs)
        )

    return {
        "M": M,
        "S": S,
        "L": L,
        "retained_share": float(retained.mean()),
        "time_tags": time_tag_count,
        "min_margin": min_margin,
        "near_count": near_count,
        "checkpoint_count": checkpoint_count,
        "actual": actual,
        "random": random_control,
        "adversarial": adversarial_control,
        "tails": tails,
        "max_truncation_violation": max_truncation_violation,
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--min-M", type=int, default=14)
    parser.add_argument("--max-M", type=int, default=22)
    parser.add_argument("--step", type=int, default=2)
    parser.add_argument("--S", type=int, default=None)
    parser.add_argument(
        "--s-factor",
        type=float,
        default=3.5,
        help="when --S is omitted, use round(s_factor * log(M+2))",
    )
    parser.add_argument("--L-gap", type=int, default=3)
    parser.add_argument("--r", type=parse_fraction, default=Fraction(9, 10))
    parser.add_argument("--eta", type=parse_fraction, default=Fraction(2, 5))
    parser.add_argument("--near-tol", type=float, default=1e-12)
    parser.add_argument(
        "--tail-thresholds",
        default="1,2,4,8",
        help="comma-separated reverse-loss tail thresholds",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    thresholds = tuple(float(x) for x in args.tail_thresholds.split(","))
    print(
        "status=EMPIRICAL finite_scope=literal_switch_composite_target "
        "headline_update=none"
    )
    print(
        "hypothesis=target_weighted_reverse_loss "
        "quantity=Lambda=sum_bad_E/(time_tags*target_density*2^M)"
    )
    print(
        "controls=random_same_cardinality,adversarial_top_endpoint_loss "
        f"r={args.r} eta={args.eta}"
    )
    proof_compatible = float(args.eta) < float(args.r) - A0
    print(
        "parameter_regime={} condition=eta<r-a0 value={}".format(
            "paper_compatible" if proof_compatible else "mechanism_only",
            proof_compatible,
        )
    )
    print(
        "M S L retained_share time_tags target_density selected_share "
        "mass_enrichment mean_loss p90_loss p99_loss p999_loss max_loss "
        "loss_enrichment loss_lambda random_loss_enrichment "
        "adversarial_loss_enrichment adversarial_loss_lambda"
    )

    max_lambda = (0.0, None)
    max_loss_enrichment = (0.0, None)
    for M in range(args.min_M, args.max_M + 1, args.step):
        S = args.S
        if S is None:
            S = int(round(args.s_factor * math.log(M + 2)))
        L = S - args.L_gap
        if not 1 <= L < S < M:
            continue
        result = evaluate(
            M,
            S,
            L,
            args.r,
            args.eta,
            args.near_tol,
            thresholds,
        )
        actual = result["actual"]
        random_control = result["random"]
        adversarial = result["adversarial"]
        key = (M, S, L)
        if actual["loss_lambda"] > max_lambda[0]:
            max_lambda = (actual["loss_lambda"], key)
        if actual["loss_enrichment"] > max_loss_enrichment[0]:
            max_loss_enrichment = (actual["loss_enrichment"], key)
        print(
            f"{M} {S} {L} {result['retained_share']:.12f} "
            f"{result['time_tags']} {actual['target_density']:.12f} "
            f"{actual['selected_share']:.12f} "
            f"{actual['mass_enrichment']:.10f} "
            f"{actual['mean_loss']:.10f} {actual['p90_loss']:.10f} "
            f"{actual['p99_loss']:.10f} {actual['p999_loss']:.10f} "
            f"{actual['max_loss']:.10f} {actual['loss_enrichment']:.10f} "
            f"{actual['loss_lambda']:.12f} "
            f"{random_control['loss_enrichment']:.10f} "
            f"{adversarial['loss_enrichment']:.10f} "
            f"{adversarial['loss_lambda']:.12f}"
        )
        print(
            "tails M={} ".format(M)
            + " ".join(
                "P_E_gt_{:g}={:.12f}:source={:.12f}".format(
                    threshold, conditional, source
                )
                for threshold, conditional, source, rhs in result["tails"]
            )
        )
        if result["max_truncation_violation"] > 1e-12:
            raise AssertionError("exact loss-truncation inequality failed")

    print(f"max_loss_lambda={max_lambda[0]:.12f} at={max_lambda[1]}")
    print(
        "max_loss_enrichment={:.10f} at={}".format(
            max_loss_enrichment[0], max_loss_enrichment[1]
        )
    )
    print("loss_truncation_check=PASS")
    print(
        "audit=SUPPORTIVE_ONLY "
        "guard=finite_trend_does_not_prove_target_weighted_loss_bound"
    )


if __name__ == "__main__":
    main()
