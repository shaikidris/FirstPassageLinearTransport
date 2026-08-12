#!/usr/bin/env python3
"""Exact finite diagnostic for the two-term hybrid target HY.MIN.

The high phase uses the fixed-endpoint schedule

    x -> T^m(x),  m=floor(log2 x),

and accepts a stage when the exact sufficient condition

    3^(den(r) * (oddCount+1)) <= 2^(num(r) * m)

holds.  It stops once the generated rank is at most K=ceil(M^lambda).
The terminal phase is the timeout schedule down to L.

HYPOTHESIS / CONSUMER
  HY.MIN requires

      high_endpoint_bad_share + [actual_terminal_bad - neutral_reference]_+
        -> 0.

  The neutral reference uses the exact uniform-shell timeout-failure density
  separately at every realized switch rank.

OBSERVABLE
  Both HY.MIN terms, their sum, switch-rank support, and the terminal
  actual/reference enrichment.

FINITE SCOPE
  Complete dyadic source shells.  All orbit, goodness, timeout, and counting
  decisions are exact integer computations.

POSITIVE CONTROL
  Replacing the switch law by each uniform shell makes the centered terminal
  discrepancy exactly zero by construction.

NEGATIVE CONTROL
  An aligned law supported inside the bad subset at each rank gives the
  printed aligned discrepancy and must be visibly positive.

KILL SIGNAL
  A stable non-decaying high-phase bad share or positive reset discrepancy is
  adverse evidence.  It does not refute all depth without a lifting family.

CONTINUE SIGNAL
  Both terms decrease with M and the actual reset enrichment stays at or
  below one.

STATUS
  FINITE-CERTIFICATE for the printed shells; EMPIRICAL for asymptotics.
"""

from __future__ import annotations

import argparse
import math
from fractions import Fraction

import numpy as np

from audit_target_specific_block_covariance import parse_fraction


def iterate_with_odd(values: np.ndarray, horizon: int) -> tuple[np.ndarray, np.ndarray]:
    current = values.astype(np.int64, copy=True)
    odd = np.zeros(values.size, dtype=np.int16)
    for _ in range(horizon):
        is_odd = (current & 1).astype(bool)
        odd += is_odd.astype(np.int16)
        current = np.where(is_odd, (3 * current + 1) >> 1, current >> 1)
    return current, odd


def endpoint_stage_good(odd: np.ndarray, rank: int, r: Fraction) -> np.ndarray:
    # 3^(den*(s+1)) <= 2^(num*rank), evaluated exactly source by source.
    right = 1 << (r.numerator * rank)
    return np.array(
        [pow(3, r.denominator * (int(s) + 1)) <= right for s in odd],
        dtype=bool,
    )


def endpoint_high_switch(
    M: int, K: int, r: Fraction
) -> tuple[np.ndarray, np.ndarray, int]:
    size = 1 << M
    current = np.arange(1 << M, 1 << (M + 1), dtype=np.int64)
    bad = np.zeros(size, dtype=bool)
    active = np.ones(size, dtype=bool)
    stages = np.zeros(size, dtype=np.int16)

    for _ in range(M + 2):
        if not active.any():
            break
        active_index = np.flatnonzero(active)
        ranks = np.floor(np.log2(current[active].astype(np.longdouble))).astype(np.int32)
        already = ranks <= K
        if already.any():
            active[active_index[already]] = False
        todo_index = active_index[~already]
        todo_ranks = ranks[~already]
        if not todo_index.size:
            continue
        for rank in np.unique(todo_ranks):
            local = np.flatnonzero(todo_ranks == rank)
            group = todo_index[local]
            endpoint, odd = iterate_with_odd(current[group], int(rank))
            good = endpoint_stage_good(odd, int(rank), r)
            bad[group[~good]] = True
            active[group[~good]] = False
            current[group[good]] = endpoint[good]
            stages[group] += 1
    else:
        raise RuntimeError("endpoint high schedule did not terminate")

    if active.any():
        raise RuntimeError("endpoint high schedule retained active sources")
    return bad, current, int(stages.max(initial=0))


def bounded_first_passage_batch(
    values: np.ndarray, target: int, horizon: int
) -> tuple[np.ndarray, np.ndarray]:
    current = values.astype(np.int64, copy=True)
    landing = current.copy()
    hit = current <= target
    live = ~hit
    for _ in range(horizon):
        if not live.any():
            break
        group = np.flatnonzero(live)
        vals = current[group]
        is_odd = (vals & 1).astype(bool)
        vals = np.where(is_odd, (3 * vals + 1) >> 1, vals >> 1)
        current[group] = vals
        newly = vals <= target
        if newly.any():
            landed = group[newly]
            landing[landed] = vals[newly]
            hit[landed] = True
            live[landed] = False
    return hit, landing


def timeout_schedule_bad_values(values: np.ndarray, L: int, gap: int) -> np.ndarray:
    current = values.astype(np.int64, copy=True)
    bad = np.zeros(values.size, dtype=bool)
    active = np.ones(values.size, dtype=bool)
    for _ in range(1000):
        if not active.any():
            break
        index = np.flatnonzero(active)
        ranks = np.floor(np.log2(current[active].astype(np.longdouble))).astype(np.int32)
        done = ranks < L
        active[index[done]] = False
        todo_index = index[~done]
        todo_ranks = ranks[~done]
        for rank in np.unique(todo_ranks):
            local = np.flatnonzero(todo_ranks == rank)
            group = todo_index[local]
            target_rank = max(0, int(rank) - gap)
            hit, landing = bounded_first_passage_batch(
                current[group], 1 << target_rank, int(rank)
            )
            bad[group[~hit]] = True
            active[group[~hit]] = False
            current[group[hit]] = landing[hit]
    else:
        raise RuntimeError("timeout terminal schedule did not terminate")
    return bad


def uniform_terminal_density(q: int, L: int, gap: int) -> tuple[int, int]:
    values = np.arange(1 << q, 1 << (q + 1), dtype=np.int64)
    bad = timeout_schedule_bad_values(values, L, gap)
    return int(bad.sum()), values.size


def evaluate(M: int, lam: float, r: Fraction, L: int, gap: int) -> dict[str, float | int]:
    K = int(math.ceil(M ** lam))
    high_bad, switch, max_stages = endpoint_high_switch(M, K, r)
    success = ~high_bad
    terminal_bad = np.zeros(1 << M, dtype=bool)
    terminal_bad[success] = timeout_schedule_bad_values(switch[success], L, gap)

    ranks = np.floor(np.log2(switch[success].astype(np.longdouble))).astype(np.int32)
    reference_count = 0.0
    aligned_count = 0.0
    support = []
    for q in np.unique(ranks):
        count_q = int((ranks == q).sum())
        bad_q, total_q = uniform_terminal_density(int(q), L, gap)
        density_q = bad_q / total_q
        reference_count += count_q * density_q
        aligned_count += count_q * (1.0 - density_q)
        support.append((int(q), count_q, density_q))

    source_count = 1 << M
    actual_count = int(terminal_bad.sum())
    actual = actual_count / source_count
    reference = reference_count / source_count
    discrepancy = actual - reference
    high_share = float(high_bad.mean())
    return {
        "M": M,
        "K": K,
        "L": L,
        "max_stages": max_stages,
        "high_bad_share": high_share,
        "switch_success_share": float(success.mean()),
        "rank_support": len(support),
        "actual_terminal": actual,
        "neutral_terminal": reference,
        "terminal_enrichment": actual / reference if reference else math.nan,
        "reset_discrepancy": discrepancy,
        "reset_positive": max(0.0, discrepancy),
        "hy_min": high_share + max(0.0, discrepancy),
        "aligned_discrepancy": aligned_count / source_count,
    }


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--min-M", type=int, default=12)
    p.add_argument("--max-M", type=int, default=22)
    p.add_argument("--step", type=int, default=2)
    p.add_argument("--lambda", dest="lam", type=float, default=0.97)
    p.add_argument("--r", type=parse_fraction, default=Fraction(9, 10))
    p.add_argument("--L", type=int, default=4)
    p.add_argument("--timeout-gap", type=int, default=4)
    return p.parse_args()


def main() -> None:
    args = parse_args()
    print("status=FINITE-CERTIFICATE finite_scope=complete_dyadic_shell")
    print(
        "M K L max_stages high_bad_share switch_success_share rank_support "
        "actual_terminal neutral_terminal terminal_enrichment reset_discrepancy "
        "reset_positive HY_MIN aligned_discrepancy"
    )
    for M in range(args.min_M, args.max_M + 1, args.step):
        d = evaluate(M, args.lam, args.r, args.L, args.timeout_gap)
        print(
            f"{M} {d['K']} {d['L']} {d['max_stages']} "
            f"{d['high_bad_share']:.12g} {d['switch_success_share']:.12g} "
            f"{d['rank_support']} {d['actual_terminal']:.12g} "
            f"{d['neutral_terminal']:.12g} {d['terminal_enrichment']:.8g} "
            f"{d['reset_discrepancy']:.12g} {d['reset_positive']:.12g} "
            f"{d['hy_min']:.12g} {d['aligned_discrepancy']:.12g}"
        )
    print("audit=PASS")


if __name__ == "__main__":
    main()
