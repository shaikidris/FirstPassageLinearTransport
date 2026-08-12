#!/usr/bin/env python3
"""Exact finite audit of the proposed moving-low timeout replacement.

HYPOTHESIS / CONSUMER
  Replace the low maximal-barrier certificate by the literal timeout rule

      tau_{2^q}(n) <= m,       n in I_m,       q = m - Delta.

  A timeout implies T^m(n) > 2^q.  The exact affine iterate and the crude
  correction bound imply

      T^m(n) < 3^(oddCount(n,m)+1).

  Therefore every timeout belongs to the upper odd-count tail

      3^(s+1) > 2^q.

  The terminal consumer needs this tail to have the same
  m^(-1/2) 2^(-kappa_* m) scale as the moving low maximal barrier.

OBSERVABLE
  timeout_fraction, endpoint_high_fraction, exact binomial majorant, and
  the minimum odd count among endpoint-high and timeout sources.

FINITE SCOPE
  Complete dyadic shells I_m for m in a configurable finite range.  The
  calculation is exact in integer arithmetic apart from printing floats.

POSITIVE CONTROL
  The empirical odd-count histogram must equal C(m,s) exactly.

NEGATIVE / BOUNDARY CONTROL
  At q=floor(a0*m), timeout is not expected to be exponentially sparse.

KILL SIGNAL
  A timeout with 3^(s+1) <= 2^q, which would refute the proposed affine
  majorant, or a parity histogram mismatch.

CONTINUE SIGNAL
  Zero containment violations and a decaying timeout fraction at fixed
  Delta, with the binomial tail providing a valid (possibly loose) bound.

STATUS
  FINITE-CERTIFICATE for the printed shells only.  The all-depth containment
  is a separate elementary paper lemma; this script does not promote it.
"""

from __future__ import annotations

import argparse
import math

import numpy as np


A0 = math.log2(3.0) / 2.0


def binomial_tail(m: int, threshold: int) -> int:
    return sum(math.comb(m, s) for s in range(max(0, threshold), m + 1))


def odd_threshold(q: int) -> int:
    """Least s with 3^(s+1) > 2^q, computed exactly."""
    s = 0
    two_q = 1 << q
    power = 3
    while power <= two_q:
        s += 1
        power *= 3
    return s


def audit_shell(m: int, q: int) -> dict[str, float | int]:
    start = 1 << m
    size = 1 << m
    x = np.arange(start, start + size, dtype=np.int64)
    endpoint = x.copy()
    active = np.ones(size, dtype=bool)
    hit_time = np.full(size, -1, dtype=np.int32)
    odd = np.zeros(size, dtype=np.int16)
    threshold = 1 << q

    for h in range(m + 1):
        newly = active & (endpoint <= threshold)
        hit_time[newly] = h
        active[newly] = False
        if h == m:
            break
        odd_step = (endpoint & 1).astype(bool)
        odd += odd_step.astype(np.int16)
        endpoint = np.where(odd_step, (3 * endpoint + 1) >> 1, endpoint >> 1)

    timeout = hit_time < 0
    endpoint_high = endpoint > threshold
    endpoint_containment_bad = timeout & ~endpoint_high
    if endpoint_containment_bad.any():
        raise AssertionError("a timeout did not have a high terminal endpoint")

    hist = np.bincount(odd.astype(np.int64), minlength=m + 1)
    expected = np.array([math.comb(m, s) for s in range(m + 1)], dtype=object)
    if any(int(hist[s]) != int(expected[s]) for s in range(m + 1)):
        raise AssertionError("parity odd-count histogram is not binomial")

    s0 = odd_threshold(q)
    containment_bad = timeout & (odd < s0)
    if containment_bad.any():
        i = int(np.flatnonzero(containment_bad)[0])
        raise AssertionError(
            "timeout escaped odd-count tail: m={} q={} n={} s={}".format(
                m, q, start + i, int(odd[i])
            )
        )

    tail = binomial_tail(m, s0)
    count = int(timeout.sum())
    return {
        "m": m,
        "q": q,
        "gap": m - q,
        "s0": s0,
        "timeout_count": count,
        "timeout_fraction": count / size,
        "tail_count": tail,
        "tail_fraction": tail / size,
        "tail_ratio": tail / count if count else math.inf,
        "endpoint_high_count": int(endpoint_high.sum()),
        "min_timeout_odd": int(odd[timeout].min()) if count else -1,
        "containment_violations": int(containment_bad.sum()),
    }


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--min-m", type=int, default=12)
    p.add_argument("--max-m", type=int, default=24)
    p.add_argument("--step", type=int, default=2)
    p.add_argument(
        "--gap",
        type=int,
        default=4,
        help="terminal moving-low rank gap q=m-gap (K0=2*gap when L=m)",
    )
    p.add_argument(
        "--boundary-control",
        action="store_true",
        help="also print q=floor(a0*m), where no sparse tail is expected",
    )
    return p.parse_args()


def print_row(label: str, d: dict[str, float | int]) -> None:
    print(
        "{} {} {} {} {} {} {} {:.12g} {} {:.12g} {:.6g} {} {}".format(
            label,
            d["m"],
            d["q"],
            d["gap"],
            d["s0"],
            d["timeout_count"],
            d["endpoint_high_count"],
            d["timeout_fraction"],
            d["tail_count"],
            d["tail_fraction"],
            d["tail_ratio"],
            d["min_timeout_odd"],
            d["containment_violations"],
        )
    )


def main() -> None:
    args = parse_args()
    print("status=FINITE-CERTIFICATE finite_scope=complete_dyadic_shell")
    print(
        "label m q gap odd_threshold timeout_count endpoint_high_count timeout_fraction "
        "tail_count tail_fraction tail_over_timeout min_timeout_odd violations"
    )
    for m in range(args.min_m, args.max_m + 1, args.step):
        q = m - args.gap
        if q < 1:
            continue
        print_row("terminal", audit_shell(m, q))
        if args.boundary_control:
            qb = max(1, int(math.floor(A0 * m)))
            print_row("boundary", audit_shell(m, qb))
    print("audit=PASS")


if __name__ == "__main__":
    main()
