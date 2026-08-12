#!/usr/bin/env python3
"""Source-weighted stratified high-barrier diagnostic.

HYPOTHESIS / CONSUMER
  Replace one global maximal-deviation cutoff by source strata.  For a source
  n, execute the generated high first-passage schedule down to J_S and let

      W(n) = sum over executed parent blocks of
             max_{k<=m} |2 oddCount(k)-k|.

  Random-walk scaling predicts E W = O(sqrt(M)).  The transport consumer also
  needs the literal terminal bad target not to select abnormally large W:

      E[W 1_A] / (d sqrt(M)) = O(polylog M),

  where A is the timeout target at the switch and d is its uniform density.

OBSERVABLE
  Unconditional and target-conditioned W/sqrt(M), landing-mass enrichment,
  and their product.  Dyadic W/sqrt(M) tail masses are also printed.

FINITE SCOPE
  Complete dyadic shells and an exact fixed-ratio generated schedule.  Orbit,
  parity, and timeout decisions are exact; reported averages are float64.

POSITIVE CONTROL
  A deterministic hash endpoint target of density d should have weighted
  enrichment near one.

NEGATIVE CONTROL
  The top-d source-width event must have visibly larger conditional width.

KILL SIGNAL
  Target-weighted W/sqrt(M) tracking sqrt(log M) or a positive power of M,
  with a stable excess over the hash control.

CONTINUE SIGNAL
  Both E W/sqrt(M) and target-weighted enrichment remain bounded while the
  aligned-width control grows.

STATUS
  EMPIRICAL / complete finite shells only.
"""

from __future__ import annotations

import argparse
import hashlib
import math
from fractions import Fraction

import numpy as np

from audit_target_specific_block_covariance import first_passage_batch, parse_fraction
from audit_timeout_target_averaged_green import timeout_bad


def max_parity_deviation(values: np.ndarray, horizon: int) -> np.ndarray:
    current = values.astype(np.int64, copy=True)
    odd = np.zeros(values.size, dtype=np.int32)
    maximum = np.zeros(values.size, dtype=np.int32)
    for k in range(1, horizon + 1):
        is_odd = (current & 1).astype(bool)
        odd += is_odd.astype(np.int32)
        current = np.where(is_odd, (3 * current + 1) >> 1, current >> 1)
        deviation = np.abs(2 * odd - k)
        maximum = np.maximum(maximum, deviation)
    return maximum


def generated_schedule_width(
    M: int, S: int, r: Fraction
) -> tuple[np.ndarray, np.ndarray, int]:
    count = 1 << M
    current = np.arange(1 << M, 1 << (M + 1), dtype=np.int64)
    width = np.zeros(count, dtype=np.float64)
    stages = np.zeros(count, dtype=np.int16)
    live = np.ones(count, dtype=bool)

    for _ in range(M + 2):
        if not live.any():
            break
        ranks = np.floor(np.log2(current[live].astype(np.longdouble))).astype(np.int32)
        live_index = np.flatnonzero(live)
        for rank in np.unique(ranks):
            group_local = np.flatnonzero(ranks == rank)
            group = live_index[group_local]
            vals = current[group]
            width[group] += max_parity_deviation(vals, int(rank))
            stages[group] += 1
            q = (r.numerator * int(rank)) // r.denominator
            target_rank = S if q <= S else q
            current[group] = first_passage_batch(vals, 1 << target_rank)
            if target_rank == S:
                live[group] = False
    else:
        raise RuntimeError("generated schedule did not terminate")

    if live.any():
        raise RuntimeError("generated schedule retained live sources")
    band_lo = 1 << (S - 1)
    if not np.all((band_lo < current) & (current <= (1 << S))):
        raise AssertionError("switch landing escaped J_S")
    return current, width, int(stages.max(initial=0))


def hash_bad(y: np.ndarray, density: float) -> np.ndarray:
    out = np.zeros(y.size, dtype=bool)
    for i, value in enumerate(y):
        digest = hashlib.blake2b(str(int(value)).encode("ascii"), digest_size=8).digest()
        out[i] = int.from_bytes(digest, "big") / float(1 << 64) < density
    return out


def evaluate(M: int, S: int, r: Fraction, timeout_gap: int) -> dict[str, object]:
    landing, width, max_stages = generated_schedule_width(M, S, r)
    band_lo = 1 << (S - 1)
    endpoints = np.arange(band_lo + 1, (1 << S) + 1, dtype=np.int64)
    target = np.array(
        [timeout_bad(int(y), S, timeout_gap) for y in endpoints], dtype=bool
    )
    density = float(target.mean())
    cells = (landing - band_lo - 1).astype(np.int64)
    selected = target[cells]

    scale = math.sqrt(M)
    mean_width = float(width.mean() / scale)
    selected_share = float(selected.mean())
    mass_enrichment = selected_share / density if density else math.nan
    conditional_width = float(width[selected].mean() / scale) if selected.any() else math.nan
    width_enrichment = conditional_width / mean_width if mean_width and selected.any() else math.nan

    hashed = hash_bad(landing, density)
    hash_mass = float(hashed.mean()) / density if density else math.nan
    hash_width = (
        float(width[hashed].mean() / scale) / mean_width if hashed.any() and mean_width else math.nan
    )

    top_count = max(1, int(round(density * width.size)))
    top = np.partition(width, width.size - top_count)[-top_count:]
    aligned_width = float(top.mean() / scale) / mean_width

    tails = []
    normalized = width / scale
    max_level = int(math.ceil(math.log2(max(1.0, float(normalized.max(initial=1.0))))))
    for j in range(max_level + 1):
        threshold = float(1 << j)
        mass = float((normalized >= threshold).mean())
        contribution = float(normalized[normalized >= threshold].sum() / normalized.size)
        tails.append((threshold, mass, contribution))

    return {
        "M": M,
        "S": S,
        "max_stages": max_stages,
        "density": density,
        "selected_share": selected_share,
        "mass_enrichment": mass_enrichment,
        "mean_width": mean_width,
        "conditional_width": conditional_width,
        "width_enrichment": width_enrichment,
        "weighted_enrichment": mass_enrichment * width_enrichment,
        "hash_weighted": hash_mass * hash_width,
        "aligned_width": aligned_width,
        "max_width": float(normalized.max(initial=0.0)),
        "tails": tails,
    }


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--min-M", type=int, default=14)
    p.add_argument("--max-M", type=int, default=22)
    p.add_argument("--step", type=int, default=2)
    p.add_argument("--S", type=int, default=None)
    p.add_argument("--s-factor", type=float, default=3.5)
    p.add_argument("--r", type=parse_fraction, default=Fraction(9, 10))
    p.add_argument("--timeout-gap", type=int, default=4)
    p.add_argument("--show-tail", action="store_true")
    return p.parse_args()


def main() -> None:
    args = parse_args()
    print("status=EMPIRICAL finite_scope=complete_generated_fixed_ratio_schedule")
    print(
        "M S max_stages target_density selected_share mass_enrichment "
        "mean_width_over_sqrtM conditional_width_over_sqrtM width_enrichment "
        "weighted_enrichment hash_weighted_enrichment aligned_width_enrichment "
        "max_width_over_sqrtM"
    )
    for M in range(args.min_M, args.max_M + 1, args.step):
        S = args.S if args.S is not None else int(round(args.s_factor * math.log(M + 2)))
        if not 2 <= S < M:
            continue
        d = evaluate(M, S, args.r, args.timeout_gap)
        print(
            f"{M} {S} {d['max_stages']} {d['density']:.12g} "
            f"{d['selected_share']:.12g} {d['mass_enrichment']:.8g} "
            f"{d['mean_width']:.10g} {d['conditional_width']:.10g} "
            f"{d['width_enrichment']:.8g} {d['weighted_enrichment']:.8g} "
            f"{d['hash_weighted']:.8g} {d['aligned_width']:.8g} {d['max_width']:.8g}"
        )
        if args.show_tail:
            for threshold, mass, contribution in d["tails"]:
                print(
                    f"tail M={M} threshold={threshold:g} mass={mass:.12g} "
                    f"contribution={contribution:.12g}"
                )
    print("audit=PASS")


if __name__ == "__main__":
    main()
