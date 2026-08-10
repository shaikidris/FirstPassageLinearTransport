#!/usr/bin/env python3
"""Finite audit of the target-specific source-block covariance.

This script tests the literal finite analogue of the post-Section-37
target-specific incidence reduction. It does not test endpoint or block
pressure as a proxy.

Fix a one-regime stopped schedule with rational parameters r and eta. For
the source shell I_M:

* ambient_loss retains direct first passages to J_S satisfying the proved
  rank-scaled loss cap D=(S+2)/r;
* recursive_high retains sources whose generated checkpoints above S all
  satisfy W_eta, then records their direct first passage to J_S.

The target C subset J_S is computed independently: it is the set of switch
landings whose literal low continuation has a first certification failure
before the terminal rank L.

For classes g=(h,s,u), source blocks b, and the reverse-interval incidence
profile psi_g,C(b), the script checks both centerings:

    incidence_upper = uniform_neutral + uniform_covariance,
    incidence_upper = retained_neutral + retained_covariance.

The second identity uses the actual retained block law

    p_b = A_ret(b) / N_ret.

It removes the marginal residual exactly: the retained class fluctuations
sum to zero both classwise and blockwise, so every common incidence profile
cancels before a positive part is taken.  The old uniform-centering identity
is retained only as a cross-check.

All source orbits and first-passage decisions are exhaustively enumerated.
Large vector W_eta tests use long-double logarithms with exact integer
fallback for comparisons within --near-tol of a boundary. The stopped
target itself is evaluated by exact integer power comparisons because r and
eta are rational.

Status: EMPIRICAL finite-scope mechanism evidence only. Favorable rows do
not prove an all-depth covariance estimate.
"""

from __future__ import annotations

import argparse
import math
from fractions import Fraction

import numpy as np

from audit_weighted_collision_pressure import first_passage_statistics


A0 = math.log2(3.0) / 2.0
LOG_RHO = np.longdouble(0.5 * math.log(3.0) - math.log(2.0))


def parse_fraction(text: str) -> Fraction:
    return Fraction(text)


def shortcut_step_scalar(n: int) -> int:
    return (3 * n + 1) // 2 if n & 1 else n // 2


def first_passage_scalar(n: int, threshold: int) -> tuple[int, int]:
    h = 0
    while n > threshold:
        n = shortcut_step_scalar(n)
        h += 1
        if h > 10000:
            raise RuntimeError("scalar first-passage horizon exceeded")
    return h, n


def in_w_exact(n: int, eta: Fraction) -> bool:
    """Exact membership in W_eta for rational eta."""
    p = eta.numerator
    q = eta.denominator
    if not 0 < p < q:
        raise ValueError("eta must lie strictly between zero and one")
    rank = n.bit_length() - 1
    cur = n
    two_q = 2 * q
    for k in range(rank + 1):
        lhs = pow(cur, two_q) * pow(2, two_q * k)
        rho_factor = pow(3, q * k)
        if lhs < rho_factor * pow(n, 2 * (q - p)):
            return False
        if lhs > rho_factor * pow(n, 2 * (q + p)):
            return False
        if k < rank:
            cur = shortcut_step_scalar(cur)
    return True


def w_mask_vector(
    values: np.ndarray, eta: Fraction, near_tol: float
) -> tuple[np.ndarray, float, int]:
    """Vector W_eta membership, with exact fallback near a boundary."""
    if values.size == 0:
        return np.zeros(0, dtype=bool), math.inf, 0
    original = values.astype(np.int64, copy=True)
    current = original.copy()
    ranks = np.floor(np.log2(original.astype(np.longdouble))).astype(np.int32)
    max_rank = int(ranks.max())
    log_n = np.log(original.astype(np.longdouble))
    eta_float = np.longdouble(float(eta))
    good = np.ones(original.size, dtype=bool)
    min_abs_margin = np.full(original.size, np.inf, dtype=np.longdouble)

    for k in range(max_rank + 1):
        active = ranks >= k
        if not active.any():
            break
        log_current = np.log(current[active].astype(np.longdouble))
        lower = (
            np.longdouble(k) * LOG_RHO
            + (np.longdouble(1.0) - eta_float) * log_n[active]
        )
        upper = (
            np.longdouble(k) * LOG_RHO
            + (np.longdouble(1.0) + eta_float) * log_n[active]
        )
        margin = np.minimum(log_current - lower, upper - log_current)
        active_index = np.flatnonzero(active)
        good[active_index] &= margin >= 0
        min_abs_margin[active_index] = np.minimum(
            min_abs_margin[active_index], np.abs(margin)
        )
        if k < max_rank:
            odd = (current & 1).astype(bool)
            current = np.where(odd, (3 * current + 1) >> 1, current >> 1)

    near = np.flatnonzero(min_abs_margin <= np.longdouble(near_tol))
    for index in near:
        good[index] = in_w_exact(int(original[index]), eta)
    return good, float(min_abs_margin.min(initial=np.inf)), int(near.size)


def first_passage_batch(values: np.ndarray, threshold: int) -> np.ndarray:
    current = values.astype(np.int64, copy=True)
    landing = np.empty_like(current)
    live = np.arange(current.size, dtype=np.int64)
    time = 0
    while current.size:
        done = current <= threshold
        if done.any():
            landing[live[done]] = current[done]
            keep = ~done
            current = current[keep]
            live = live[keep]
            if not current.size:
                break
        odd = (current & 1).astype(bool)
        current = np.where(odd, (3 * current + 1) >> 1, current >> 1)
        time += 1
        if time > 10000:
            raise RuntimeError("batch first-passage horizon exceeded")
    return landing


def recursive_high_mask(
    M: int,
    S: int,
    r: Fraction,
    eta: Fraction,
    near_tol: float,
) -> tuple[np.ndarray, float, int, int]:
    """Retain the generated checkpoints down to the fixed switch rank S."""
    source_lo = 1 << M
    source_count = 1 << M
    sources = np.arange(source_lo, source_lo + source_count, dtype=np.int64)

    first_good, min_margin, near_count = w_mask_vector(
        sources, eta, near_tol
    )
    retained = np.zeros(source_count, dtype=bool)
    active_index = np.flatnonzero(first_good)
    current = sources[first_good]
    rank = M
    checkpoint_count = 0

    while current.size:
        q = (r.numerator * rank) // r.denominator
        if q <= S:
            retained[active_index] = True
            break
        landing = first_passage_batch(current, 1 << q)
        child_good, child_margin, child_near = w_mask_vector(
            landing, eta, near_tol
        )
        min_margin = min(min_margin, child_margin)
        near_count += child_near
        active_index = active_index[child_good]
        current = landing[child_good]
        checkpoint_count += 1
        if not current.size:
            break
        child_ranks = np.floor(
            np.log2(current.astype(np.longdouble))
        ).astype(np.int32)
        if not np.all(child_ranks == q - 1):
            raise AssertionError(
                "a retained landing did not enter the strict lower shell"
            )
        rank = q - 1

    return retained, min_margin, near_count, checkpoint_count


def stopped_low_bad(
    y: int, L: int, r: Fraction, eta: Fraction
) -> bool:
    """Literal first-certification failure for the low continuation."""
    current = y
    for _ in range(1000):
        rank = current.bit_length() - 1
        if rank < L:
            return False
        if not in_w_exact(current, eta):
            return True
        q = (r.numerator * rank) // r.denominator
        _, landing = first_passage_scalar(current, 1 << q)
        if q < L:
            return False
        current = landing
    raise RuntimeError("low stopped schedule did not terminate")


def stopped_target(
    S: int, L: int, r: Fraction, eta: Fraction
) -> tuple[np.ndarray, np.ndarray]:
    band_lo = 1 << (S - 1)
    threshold = 1 << S
    endpoints = np.arange(band_lo + 1, threshold + 1, dtype=np.int64)
    bad = np.array(
        [stopped_low_bad(int(y), L, r, eta) for y in endpoints],
        dtype=bool,
    )
    return endpoints, bad


def compact_groups_with_stats(
    h: np.ndarray, s: np.ndarray, u: np.ndarray
) -> tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray, np.ndarray]:
    base = int(max(h.max(), s.max(), u.max())) + 1
    keys = (h.astype(np.int64) * base + s) * base + u
    unique, inverse, counts = np.unique(
        keys, return_inverse=True, return_counts=True
    )
    group_u = unique % base
    middle = unique // base
    group_s = middle % base
    group_h = middle // base
    return (
        inverse.astype(np.int64),
        counts.astype(np.int64),
        group_h.astype(np.int64),
        group_s.astype(np.int64),
        group_u.astype(np.int64),
    )


def floor_block_index(
    numerator: int, denominator: int, source_lo: int, block_length: int
) -> int:
    return (numerator - source_lo * denominator) // (
        block_length * denominator
    )


def incidence_profile(
    M: int,
    S: int,
    h: int,
    s: int,
    target_endpoints: np.ndarray,
    D: Fraction,
) -> np.ndarray:
    """Exact reverse-interval incidence counts over the H source blocks."""
    H = 1 << (S - 1)
    Y = 1 << S
    source_lo = 1 << M
    source_hi = 1 << (M + 1)
    block_length = (1 << M) // H
    profile = np.zeros(H, dtype=np.int32)
    power_two = 1 << h
    power_three = pow(3, s)
    shrink_num = Y * D.denominator - D.numerator
    shrink_den = Y * D.denominator
    if shrink_num <= 0:
        raise ValueError("loss interval requires D/Y < 1")

    for y_numpy in target_endpoints:
        y = int(y_numpy)
        lower_num = power_two * y * shrink_num
        lower_den = power_three * shrink_den
        upper_num = power_two * y
        upper_den = power_three
        if upper_num < source_lo * upper_den:
            continue
        if lower_num >= source_hi * lower_den:
            continue
        first = floor_block_index(
            lower_num, lower_den, source_lo, block_length
        )
        last = floor_block_index(
            upper_num, upper_den, source_lo, block_length
        )
        first = max(0, first)
        last = min(H - 1, last)
        if first <= last:
            profile[first : last + 1] += 1
    return profile


def algebra_controls() -> tuple[bool, float, float]:
    H = 8
    uniform_classes = np.ones((2, H), dtype=float)
    profiles = np.array(
        [
            [1, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 0],
        ],
        dtype=float,
    )
    aligned_classes = np.array(
        [
            [4, 4, 0, 0, 0, 0, 0, 0],
            [0, 0, 4, 4, 0, 0, 0, 0],
        ],
        dtype=float,
    )

    def retained_covariance(a: np.ndarray) -> float:
        retained = a.sum()
        p = a.sum(axis=0) / retained
        class_mass = a.sum(axis=1)
        centered = a - class_mass[:, None] * p[None, :]
        return float(np.sum(centered * profiles))

    positive = retained_covariance(uniform_classes)
    negative = retained_covariance(aligned_classes)
    return abs(positive) < 1e-12 and negative > 0, positive, negative


def evaluate_model(
    M: int,
    S: int,
    L: int,
    target_bad: np.ndarray,
    h_all: np.ndarray,
    y_all: np.ndarray,
    s_all: np.ndarray,
    u_all: np.ndarray,
    loss_all: np.ndarray,
    selected: np.ndarray,
    model: str,
    D: Fraction,
    min_w_margin: float,
    exact_fallbacks: int,
    checkpoints: int,
) -> dict[str, float | int | str]:
    N = 1 << M
    H = 1 << (S - 1)
    source_lo = 1 << M
    band_lo = 1 << (S - 1)
    block_length = N // H
    if not selected.any():
        raise RuntimeError("retained family is empty")

    sources = np.arange(source_lo, source_lo + N, dtype=np.int64)[selected]
    h = h_all[selected]
    y = y_all[selected]
    s = s_all[selected]
    u = u_all[selected]
    loss = loss_all[selected]
    inverse, group_counts, group_h, group_s, _ = compact_groups_with_stats(
        h, s, u
    )
    groups = group_counts.size
    source_blocks = ((sources - source_lo) // block_length).astype(np.int64)
    endpoint_cells = (y - band_lo - 1).astype(np.int64)

    target_endpoints = np.arange(
        band_lo + 1, (1 << S) + 1, dtype=np.int64
    )[target_bad]
    delta = float(target_bad.mean())
    target_hit = target_bad[endpoint_cells]
    actual_target = int(target_hit.sum())

    profiles = np.zeros((groups, H), dtype=np.int32)
    cache: dict[tuple[int, int], np.ndarray] = {}
    for gid in range(groups):
        key = (int(group_h[gid]), int(group_s[gid]))
        profile = cache.get(key)
        if profile is None:
            profile = incidence_profile(
                M, S, key[0], key[1], target_endpoints, D
            )
            cache[key] = profile
        profiles[gid] = profile

    hs_values = np.column_stack((group_h, group_s))
    hs_pairs, group_to_hs = np.unique(
        hs_values, axis=0, return_inverse=True
    )
    profile_rank = hs_pairs.shape[0]
    collapsed_counts = np.zeros(profile_rank, dtype=np.int64)
    collapsed_block_counts = np.zeros((profile_rank, H), dtype=np.int64)
    collapsed_profiles = np.full((profile_rank, H), -1, dtype=np.int32)
    for gid, cid in enumerate(group_to_hs):
        collapsed_counts[cid] += group_counts[gid]
        if collapsed_profiles[cid, 0] < 0:
            collapsed_profiles[cid] = profiles[gid]
        elif not np.array_equal(collapsed_profiles[cid], profiles[gid]):
            raise AssertionError("incidence profile unexpectedly depends on u")

    pair_key = inverse * H + source_blocks
    block_counts = np.bincount(
        pair_key, minlength=groups * H
    ).reshape(groups, H)
    collapsed_block_counts.fill(0)
    for gid, cid in enumerate(group_to_hs):
        collapsed_block_counts[cid] += block_counts[gid]
    incidence_upper = int(
        np.sum(block_counts.astype(np.int64) * profiles.astype(np.int64))
    )
    profile_sums = profiles.sum(axis=1, dtype=np.int64)
    uniform_neutral = float(np.dot(group_counts, profile_sums) / H)
    uniform_covariance = float(incidence_upper - uniform_neutral)
    uniform_reassembly_error = float(
        incidence_upper - (uniform_neutral + uniform_covariance)
    )

    retained = int(selected.sum())
    psi_star = (
        group_counts.astype(float) @ profiles.astype(float)
    ) / retained
    retained_block_mass = np.bincount(
        source_blocks, minlength=H
    ).astype(float)
    retained_block_law = retained_block_mass / retained
    retained_neutral = float(np.dot(retained_block_mass, psi_star))
    retained_covariance = float(incidence_upper - retained_neutral)
    retained_reassembly_error = float(
        incidence_upper - (retained_neutral + retained_covariance)
    )
    marginal_deviation = retained_block_mass - retained / H
    marginal_residual = float(np.dot(marginal_deviation, psi_star))
    centered_a = (
        block_counts.astype(float)
        - group_counts.astype(float)[:, None] / H
    )
    class_profile = float(
        np.sum(centered_a * (profiles.astype(float) - psi_star[None, :]))
    )
    decomposition_error = float(
        uniform_covariance - class_profile - marginal_residual
    )
    retained_centered_a = (
        block_counts.astype(float)
        - group_counts.astype(float)[:, None] * retained_block_law[None, :]
    )
    retained_common_profile = float(
        np.sum(
            retained_centered_a
            * (profiles.astype(float) - psi_star[None, :])
        )
    )
    retained_common_error = float(
        retained_covariance - retained_common_profile
    )
    collapsed_psi_star = (
        collapsed_counts.astype(float) @ collapsed_profiles.astype(float)
    ) / retained
    collapsed_centered = (
        collapsed_block_counts.astype(float)
        - collapsed_counts.astype(float)[:, None]
        * retained_block_law[None, :]
    )
    collapsed_covariance = float(
        np.sum(
            collapsed_centered
            * (collapsed_profiles.astype(float) - collapsed_psi_star[None, :])
        )
    )
    collapsed_joint_law = collapsed_block_counts.astype(float) / retained
    collapsed_product_law = (
        collapsed_counts.astype(float)[:, None] / retained
    ) * retained_block_law[None, :]
    collapsed_product_support = collapsed_product_law > 0.0
    collapsed_chi2 = float(
        np.sum(
            np.square(
                collapsed_joint_law[collapsed_product_support]
                - collapsed_product_law[collapsed_product_support]
            )
            / collapsed_product_law[collapsed_product_support]
        )
    )
    time_support = int(np.unique(hs_pairs[:, 0]).size)
    max_odd_counts_per_time = max(
        int(np.sum(hs_pairs[:, 0] == hh)) for hh in np.unique(hs_pairs[:, 0])
    )
    reverse_scale_over_block = np.array(
        [
            (2.0 ** int(hh))
            / (3.0 ** int(ss))
            / block_length
            for hh, ss in hs_pairs
        ],
        dtype=float,
    )
    min_reverse_scale_over_block = float(reverse_scale_over_block.min())
    max_reverse_scale_over_block = float(reverse_scale_over_block.max())
    joint_law = block_counts.astype(float) / retained
    product_law = (
        group_counts.astype(float)[:, None] / retained
    ) * retained_block_law[None, :]
    product_support = product_law > 0.0
    chi2_dependence = float(
        np.sum(
            np.square(joint_law[product_support] - product_law[product_support])
            / product_law[product_support]
        )
    )

    uniform_covariance_positive = max(uniform_covariance, 0.0)
    retained_covariance_positive = max(retained_covariance, 0.0)
    scale = delta * N
    uniform_covariance_ratio = (
        uniform_covariance_positive / scale if scale > 0 else math.inf
    )
    retained_covariance_ratio = (
        retained_covariance_positive / scale if scale > 0 else math.inf
    )
    retained_alpha_eff = (
        math.log(retained_covariance_ratio) / math.log(M)
        if retained_covariance_ratio > 0
        else -math.inf
    )
    actual_enrichment = (
        actual_target / (delta * retained)
        if delta > 0 and retained > 0
        else math.inf
    )
    marginal_tv = float(
        0.5 * np.abs(retained_block_mass / retained - 1.0 / H).sum()
    )
    max_row_degree = 0
    for hh, ss in cache:
        for yy in target_endpoints:
            degree = int(
                incidence_profile(
                    M, S, int(hh), int(ss), np.array([yy]), D
                ).astype(bool).sum()
            )
            max_row_degree = max(max_row_degree, degree)
    max_column_degree = int(profiles.max(initial=0))
    l1_bound = math.ceil(3.0 * float(D)) + 2
    l2_bound = math.ceil(3.0 * float(D)) + 5
    uniform_coarse_neutral = l1_bound * delta * retained
    retained_coarse_neutral = l1_bound * delta * N
    chi2_socket_bound_share = math.sqrt(
        (retained / N)
        * l1_bound
        * l2_bound
        * delta
        * chi2_dependence
    )
    chi2_socket_slack = (
        chi2_socket_bound_share
        / (retained_covariance_positive / N)
        if retained_covariance_positive > 0.0
        else math.inf
    )
    profile_rank_bound_share = math.sqrt(
        max(profile_rank - 1, 0) * l1_bound * l2_bound * delta
    )
    profile_rank_bound_slack = (
        profile_rank_bound_share
        / (retained_covariance_positive / N)
        if retained_covariance_positive > 0.0
        else math.inf
    )

    if actual_target > incidence_upper:
        raise AssertionError(
            "actual target mass exceeds the reverse-incidence upper bound"
        )
    if abs(uniform_reassembly_error) > 1e-8:
        raise AssertionError("uniform incidence reassembly failed")
    if abs(retained_reassembly_error) > 1e-8:
        raise AssertionError("retained incidence reassembly failed")
    if abs(decomposition_error) > 1e-6:
        raise AssertionError("uniform common-profile decomposition failed")
    if abs(retained_common_error) > 1e-6:
        raise AssertionError("retained common-profile cancellation failed")
    if abs(collapsed_covariance - retained_covariance) > 1e-6:
        raise AssertionError("collapse over u changed retained covariance")
    if max_odd_counts_per_time > 2:
        raise AssertionError("more than two odd counts occurred at one time")
    if min_reverse_scale_over_block < 0.5 - 1e-12:
        raise AssertionError("reverse scale fell below the GE.BL2 window")
    if max_reverse_scale_over_block >= 3.0 + 1e-12:
        raise AssertionError("reverse scale exceeded the GE.BL2 window")
    if collapsed_chi2 > profile_rank - 1 + 1e-8:
        raise AssertionError("generic profile-rank chi-square bound failed")
    if retained_neutral > retained_coarse_neutral + 1e-8:
        raise AssertionError("retained neutral term exceeded TB.RET bound")
    if retained_covariance_positive / N > chi2_socket_bound_share + 1e-8:
        raise AssertionError("TB.18 chi-square socket failed")
    if max_row_degree > l1_bound or max_column_degree > l2_bound:
        raise AssertionError("incidence degree exceeded the proved bound")

    return {
        "M": M,
        "S": S,
        "L": L,
        "model": model,
        "target_size": int(target_bad.sum()),
        "delta": delta,
        "retained": retained,
        "retained_share": retained / N,
        "groups": groups,
        "max_loss": float(loss.max(initial=0.0)),
        "D": float(D),
        "actual_target": actual_target,
        "actual_target_share": actual_target / N,
        "actual_enrichment": actual_enrichment,
        "incidence_upper": incidence_upper,
        "incidence_slack": incidence_upper - actual_target,
        "uniform_neutral": uniform_neutral,
        "uniform_coarse_neutral": uniform_coarse_neutral,
        "uniform_covariance": uniform_covariance,
        "uniform_covariance_ratio": uniform_covariance_ratio,
        "retained_neutral": retained_neutral,
        "retained_coarse_neutral": retained_coarse_neutral,
        "retained_covariance": retained_covariance,
        "retained_covariance_positive": retained_covariance_positive,
        "retained_covariance_ratio": retained_covariance_ratio,
        "retained_alpha_eff": retained_alpha_eff,
        "retained_common_profile": retained_common_profile,
        "profile_rank": profile_rank,
        "time_support": time_support,
        "max_odd_counts_per_time": max_odd_counts_per_time,
        "min_reverse_scale_over_block": min_reverse_scale_over_block,
        "max_reverse_scale_over_block": max_reverse_scale_over_block,
        "collapsed_covariance": collapsed_covariance,
        "collapsed_chi2": collapsed_chi2,
        "profile_rank_bound_share": profile_rank_bound_share,
        "profile_rank_bound_slack": profile_rank_bound_slack,
        "chi2_dependence": chi2_dependence,
        "chi2_socket_bound_share": chi2_socket_bound_share,
        "chi2_socket_slack": chi2_socket_slack,
        "class_profile": class_profile,
        "marginal_residual": marginal_residual,
        "marginal_tv": marginal_tv,
        "uniform_reassembly_error": uniform_reassembly_error,
        "retained_reassembly_error": retained_reassembly_error,
        "retained_common_error": retained_common_error,
        "decomposition_error": decomposition_error,
        "max_row_degree": max_row_degree,
        "max_column_degree": max_column_degree,
        "l1_bound": l1_bound,
        "l2_bound": l2_bound,
        "min_w_margin": min_w_margin,
        "exact_fallbacks": exact_fallbacks,
        "checkpoints": checkpoints,
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--min-M", type=int, default=12)
    parser.add_argument("--max-M", type=int, default=20)
    parser.add_argument("--step", type=int, default=2)
    parser.add_argument("--S", type=int, default=8)
    parser.add_argument("--L", type=int, default=5)
    parser.add_argument("--r", type=parse_fraction, default=Fraction(9, 10))
    parser.add_argument("--eta", type=parse_fraction, default=Fraction(1, 10))
    parser.add_argument(
        "--models",
        default="ambient_loss,recursive_high",
        help="comma-separated subset of ambient_loss,recursive_high",
    )
    parser.add_argument("--near-tol", type=float, default=1e-12)
    parser.add_argument(
        "--allow-outside-theorem-params",
        action="store_true",
        help=(
            "run a mechanism-only calibration when eta is outside the "
            "paper range; output remains explicitly guarded"
        ),
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    if not 1 <= args.L < args.S:
        raise ValueError("require 1 <= L < S")
    theorem_parameters = (
        A0 + float(args.eta) < float(args.r) < 1.0
        and 0.0 < float(args.eta) < 1.0 - A0
    )
    if not theorem_parameters and not args.allow_outside_theorem_params:
        raise ValueError(
            "parameters are outside the paper range; use "
            "--allow-outside-theorem-params only for a guarded calibration"
        )
    models = [item.strip() for item in args.models.split(",") if item.strip()]
    unknown = set(models) - {"ambient_loss", "recursive_high"}
    if unknown:
        raise ValueError("unknown models: {}".format(sorted(unknown)))

    control_ok, uniform_control, aligned_control = algebra_controls()
    if not control_ok:
        raise AssertionError("algebra calibration failed")
    _, target_bad = stopped_target(args.S, args.L, args.r, args.eta)
    D = Fraction(args.S + 2, 1) / args.r
    print(
        "status=EMPIRICAL finite_scope=complete_dyadic_shells "
        "target=literal_recursive_low_stopped_failure "
        "grouping=(h,s,u) covariance=target_specific_reverse_incidence"
    )
    print(
        "hypothesis=[retained_covariance]_+"
        "<=M^(alpha+o(1))*delta*2^M "
        "benchmark_alpha=0.49"
    )
    print(
        "zero_control=class_independent_block_law covariance={:.12g} "
        "positive_control=class_profile_alignment covariance={:.12g} "
        "control_status=PASS".format(uniform_control, aligned_control)
    )
    print(
        "parameters r={} eta={} S={} L={} target_size={} target_delta={:.12g} "
        "loss_cap_D={}".format(
            args.r,
            args.eta,
            args.S,
            args.L,
            int(target_bad.sum()),
            float(target_bad.mean()),
            D,
        )
    )
    print(
        "scope_guard=fixed_finite_schedule_not_headline_logarithmic_parameter_range "
        "theorem_parameters={} promotion_guard=no_all_depth_claim".format(
            theorem_parameters
        )
    )
    print(
        "M S L model target_size delta retained retained_share groups max_loss D "
        "actual_target actual_target_share actual_enrichment incidence_upper "
        "incidence_slack uniform_neutral uniform_coarse_neutral "
        "uniform_covariance uniform_covariance_ratio retained_neutral "
        "retained_coarse_neutral retained_covariance "
        "retained_covariance_positive retained_covariance_ratio "
        "retained_alpha_eff retained_common_profile profile_rank "
        "time_support max_odd_counts_per_time min_reverse_scale_over_block "
        "max_reverse_scale_over_block collapsed_covariance collapsed_chi2 "
        "profile_rank_bound_share profile_rank_bound_slack chi2_dependence "
        "chi2_socket_bound_share chi2_socket_slack class_profile "
        "marginal_residual marginal_tv "
        "max_row_degree max_column_degree l1_bound l2_bound min_w_margin "
        "exact_fallbacks checkpoints uniform_reassembly_error "
        "retained_reassembly_error retained_common_error decomposition_error"
    )

    for M in range(args.min_M, args.max_M + 1, args.step):
        if not args.S < M:
            continue
        h, y, s, u, loss = first_passage_statistics(M, args.S)
        loss_selected = loss <= float(D) + 1e-12
        recursive_mask = None
        recursive_meta = (math.inf, 0, 0)
        if "recursive_high" in models:
            recursive_mask, margin, fallbacks, checkpoints = recursive_high_mask(
                M, args.S, args.r, args.eta, args.near_tol
            )
            recursive_meta = (margin, fallbacks, checkpoints)
            violating = recursive_mask & ~loss_selected
            if violating.any():
                raise AssertionError(
                    "recursive retained family violated the rank-scaled loss cap"
                )

        for model in models:
            if model == "ambient_loss":
                selected = loss_selected
                meta = (math.inf, 0, 0)
            else:
                assert recursive_mask is not None
                selected = recursive_mask
                meta = recursive_meta
            if not selected.any():
                print(
                    "empty_model M={} S={} L={} model={} "
                    "reason=no_retained_sources".format(
                        M, args.S, args.L, model
                    )
                )
                continue
            result = evaluate_model(
                M,
                args.S,
                args.L,
                target_bad,
                h,
                y,
                s,
                u,
                loss,
                selected,
                model,
                D,
                meta[0],
                meta[1],
                meta[2],
            )
            print(
                "{M} {S} {L} {model} {target_size} {delta:.12g} "
                "{retained} {retained_share:.12g} {groups} {max_loss:.12g} "
                "{D:.12g} {actual_target} {actual_target_share:.12g} "
                "{actual_enrichment:.12g} {incidence_upper} {incidence_slack} "
                "{uniform_neutral:.12g} {uniform_coarse_neutral:.12g} "
                "{uniform_covariance:.12g} {uniform_covariance_ratio:.12g} "
                "{retained_neutral:.12g} {retained_coarse_neutral:.12g} "
                "{retained_covariance:.12g} "
                "{retained_covariance_positive:.12g} "
                "{retained_covariance_ratio:.12g} "
                "{retained_alpha_eff:.12g} "
                "{retained_common_profile:.12g} {profile_rank} "
                "{time_support} {max_odd_counts_per_time} "
                "{min_reverse_scale_over_block:.12g} "
                "{max_reverse_scale_over_block:.12g} "
                "{collapsed_covariance:.12g} {collapsed_chi2:.12g} "
                "{profile_rank_bound_share:.12g} "
                "{profile_rank_bound_slack:.12g} {chi2_dependence:.12g} "
                "{chi2_socket_bound_share:.12g} "
                "{chi2_socket_slack:.12g} {class_profile:.12g} "
                "{marginal_residual:.12g} {marginal_tv:.12g} "
                "{max_row_degree} {max_column_degree} {l1_bound} {l2_bound} "
                "{min_w_margin:.12g} {exact_fallbacks} {checkpoints} "
                "{uniform_reassembly_error:.3g} "
                "{retained_reassembly_error:.3g} "
                "{retained_common_error:.3g} "
                "{decomposition_error:.3g}".format(
                    **result
                )
            )


if __name__ == "__main__":
    main()
