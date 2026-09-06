#!/usr/bin/env python3
"""Finite diagnostics for the Version 4 ballot strengthening.

These computations check constants and finite interfaces used by the written
proof.  They are not premises of any asymptotic theorem and do not replace the
outstanding Lean formalization.
"""

from __future__ import annotations

from fractions import Fraction
import math


LOG2 = math.log(2.0)
LOG3 = math.log(3.0)
P_STAR = LOG2 / LOG3
KAPPA_STAR = 1.0 + P_STAR * math.log2(P_STAR) + (1.0 - P_STAR) * math.log2(
    1.0 - P_STAR
)
A_FP = 1.0 / (2.0 * KAPPA_STAR)
C_STAR = 2.0 / math.log(4.0 / 3.0)


def shortcut(n: int) -> int:
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def check_constants() -> None:
    assert abs(KAPPA_STAR - 0.050044472811669) < 1.0e-14
    assert abs(A_FP - 9.991113341959) < 1.0e-12
    assert abs(C_STAR - 6.952118993564) < 1.0e-12
    assert abs(1.5 * C_STAR - 3.0 / math.log(4.0 / 3.0)) < 1.0e-14


def check_change_of_measure() -> None:
    lam = math.log(P_STAR / (1.0 - P_STAR)) / LOG3
    for m in range(1, 65):
        for s in range(m + 1):
            left_log = -m * LOG2 - s * math.log(P_STAR) - (m - s) * math.log(
                1.0 - P_STAR
            )
            z_m = s * LOG3 - m * LOG2
            right_log = -KAPPA_STAR * m * LOG2 - lam * z_m
            assert abs(left_log - right_log) < 2.0e-13 * (m + 1)


def ballot_statistics(barrier: float = 1.0) -> dict[int, float]:
    """Count surviving words by their odd count using O(m^2) dynamic programming."""

    checkpoints = {100, 400, 1600}
    states = {0: 1}
    answer: dict[int, float] = {}
    for j in range(1, max(checkpoints) + 1):
        next_states: dict[int, int] = {}
        for odd_count, count in states.items():
            for next_odd_count in (odd_count, odd_count + 1):
                z_j = next_odd_count * LOG3 - j * LOG2
                if z_j > -barrier:
                    next_states[next_odd_count] = (
                        next_states.get(next_odd_count, 0) + count
                    )
        states = next_states
        if j in checkpoints:
            count = sum(states.values())
            log_scaled = (
                1.5 * math.log(j)
                + j * KAPPA_STAR * LOG2
                + math.log(count)
                - j * LOG2
            )
            answer[j] = math.exp(log_scaled)
    return answer


def check_actual_timeouts() -> int:
    """Check the affine-prefix implication on the advertised finite range."""

    timeout_count = 0
    for m in range(6, 17):
        for gap in (1, 2, 3):
            q = m - gap
            threshold = 1 << q
            for source in range(1 << m, 1 << (m + 1)):
                value = source
                odd_count = 0
                orbit: list[tuple[int, int]] = []
                is_timeout = True
                for j in range(m + 1):
                    orbit.append((j, odd_count))
                    if value <= threshold:
                        is_timeout = False
                        break
                    if j < m:
                        odd_count += value % 2
                        value = shortcut(value)
                if not is_timeout:
                    continue

                timeout_count += 1
                barrier = (m + 1 - q) * LOG2 + m / (3.0 * threshold)
                for j, prefix_odd_count in orbit:
                    z_j = prefix_odd_count * LOG3 - j * LOG2
                    assert z_j > -barrier - 1.0e-12
    return timeout_count


def check_finite_maximum() -> int:
    """Check sixty finite instances of the multiplicative maximal inequality."""

    thresholds = (
        Fraction(1, 2),
        Fraction(1, 1),
        Fraction(5, 4),
        Fraction(2, 1),
        Fraction(4, 1),
    )
    checks = 0
    for length in range(1, 13):
        for threshold in thresholds:
            crossing = 0
            for word in range(1 << length):
                value = Fraction(1, 1)
                maximum = value
                for j in range(length):
                    value *= Fraction(3, 2) if (word >> j) & 1 else Fraction(1, 2)
                    maximum = max(maximum, value)
                crossing += maximum > threshold
            assert Fraction(crossing, 1 << length) <= 1 / threshold
            checks += 1
    return checks


def main() -> int:
    check_constants()
    check_change_of_measure()
    statistics = ballot_statistics()
    expected = {100: 36.3768626853, 400: 47.9267522658, 1600: 52.0010153304}
    for length, target in expected.items():
        assert abs(statistics[length] - target) < 1.0e-8
    timeout_count = check_actual_timeouts()
    assert timeout_count == 121_474
    maximum_checks = check_finite_maximum()
    assert maximum_checks == 60

    print("v4_ballot_strengthening_diagnostic=PASS")
    print(f"kappa_star={KAPPA_STAR:.15f}")
    print(f"A_FP={A_FP:.12f}")
    print(f"c_star={C_STAR:.12f}")
    print(
        "scaled_ballot_counts="
        + ",".join(f"m{m}:{statistics[m]:.8f}" for m in sorted(statistics))
    )
    print(f"actual_timeout_cases={timeout_count}")
    print(f"finite_maximum_checks={maximum_checks}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
