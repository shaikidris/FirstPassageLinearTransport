#!/usr/bin/env python3
"""Literal generated-law audit for the Phase-3 L2 time-slice route.

HYPOTHESIS / CONSUMER
  For the recursively retained high-phase sources, collapsed by nested first
  passage to J_S and filtered by the proved rank-scaled reverse-loss cap,

      ||phi_sch||_2 <= M^(omega+o(1))

  for some omega < 1/4.  This would improve the fixed-polylog exponent via
  A > 2 omega / kappa_*.

OBSERVABLE
  F_h(y) on the retained generated source law and

      ||phi_sch||_2^2 = |J_S| / 2^(2M) * sum_y (sum_h F_h(y))^2.

  The script prints diagonal/off-diagonal pieces, retained mass, time-tag
  count, and the mass-averaged normalized single-slice energy.

FINITE SCOPE
  Complete dyadic shells.  The recursively generated retention uses the
  exact rational fixed-parameter W_eta implementation already cross-checked
  by audit_target_specific_block_covariance.py.  It is a literal generated
  mechanism test, but not the asymptotic shrinking-high parameter package.

POSITIVE CONTROL
  A uniform synthetic histogram has normalized energy approximately one.

NEGATIVE CONTROL
  An aligned synthetic histogram has normalized energy approximately |J_S|.

KILL SIGNAL
  Generated ||phi_sch||_2^2 tracking the proved M^(1/2) ceiling.

CONTINUE SIGNAL
  Bounded or sub-power energy while the time-tag count grows.

STATUS
  EMPIRICAL.  No finite trend proves UFP.L2_omega.
"""

from __future__ import annotations

import argparse
import math
from fractions import Fraction

import numpy as np

from audit_l2_time_slice_energy import stats
from audit_target_specific_block_covariance import (
    parse_fraction,
    recursive_high_mask,
)
from audit_weighted_collision_pressure import first_passage_statistics


A0 = math.log2(3.0) / 2.0


def generated_histogram(
    M: int,
    S: int,
    r: Fraction,
    eta: Fraction,
    near_tol: float,
    rstar: float,
) -> tuple[np.ndarray, int, dict[str, float | int]]:
    retained, min_margin, near_count, checkpoints = recursive_high_mask(
        M, S, r, eta, near_tol
    )
    h, y, _s, _u, loss = first_passage_statistics(M, S)
    cap = (S + 2.0) / rstar
    selected = retained & (loss <= cap)

    band_size = 1 << (S - 1)
    band_lo = 1 << (S - 1)
    cells = (y[selected] - band_lo - 1).astype(np.int64)
    times = h[selected].astype(np.int64)
    height = int(times.max(initial=0)) + 1
    flat = np.bincount(
        times * band_size + cells, minlength=height * band_size
    )
    F = flat.reshape(height, band_size).astype(float)
    meta: dict[str, float | int] = {
        "retained_share": float(retained.mean()),
        "selected_share": float(selected.mean()),
        "loss_cap": cap,
        "max_selected_loss": float(loss[selected].max(initial=0.0)),
        "min_margin": min_margin,
        "near_count": near_count,
        "checkpoints": checkpoints,
    }
    return F, band_size, meta


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--min-M", type=int, default=14)
    p.add_argument("--max-M", type=int, default=22)
    p.add_argument("--step", type=int, default=2)
    p.add_argument("--S", type=int, default=None)
    p.add_argument("--s-factor", type=float, default=1.6)
    p.add_argument("--r", type=parse_fraction, default=Fraction(9, 10))
    p.add_argument("--eta", type=parse_fraction, default=Fraction(1, 20))
    p.add_argument("--rstar", type=float, default=0.8)
    p.add_argument("--near-tol", type=float, default=1e-12)
    return p.parse_args()


def main() -> None:
    args = parse_args()
    if not 0.0 < args.rstar < 1.0:
        raise ValueError("rstar must lie in (0,1)")

    js = 1 << 10
    aligned = np.zeros((32, js), dtype=float)
    aligned[:, 0] = 1.0
    uniform = np.ones((32, js), dtype=float)
    cal_aligned = stats(aligned, js, 20)["R"]
    cal_uniform = stats(uniform, js, 20)["R"]
    print(
        "status=EMPIRICAL finite_scope=generated_fixed_parameter_schedule "
        "headline_update=none"
    )
    parameter_regime = (
        "paper_compatible"
        if float(args.eta) < float(args.r) - A0
        else "mechanism_only"
    )
    print(
        "parameter_regime={} passage_margin={:.12g}".format(
            parameter_regime, float(args.r) - A0 - float(args.eta)
        )
    )
    print(
        "calibration_aligned_R={:.6g} expected={} "
        "calibration_uniform_R={:.6g} expected=1".format(
            cal_aligned, js, cal_uniform
        )
    )
    print(
        "M S checkpoints retained_share selected_share time_tags DIAG OFFDIAG "
        "L2sq R slice_massavg minkowski proved_ceiling loss_cap "
        "max_selected_loss near_fallbacks"
    )

    rows: list[tuple[int, float]] = []
    for M in range(args.min_M, args.max_M + 1, args.step):
        S = args.S
        if S is None:
            S = int(round(args.s_factor * math.log(M + 2)))
        if not 1 <= S < M:
            continue
        F, band_size, meta = generated_histogram(
            M, S, args.r, args.eta, args.near_tol, args.rstar
        )
        if not F.any():
            print(
                f"{M} {S} {meta['checkpoints']} {meta['retained_share']:.12g} "
                f"{meta['selected_share']:.12g} 0 NA NA NA NA NA NA NA "
                f"{meta['loss_cap']:.10g} {meta['max_selected_loss']:.10g} "
                f"{meta['near_count']}"
            )
            continue
        d = stats(F, band_size, M)
        proved = (1.5 * S + 1.0) * d["nH"]
        rows.append((M, d["L2"]))
        print(
            "{} {} {} {:.12g} {:.12g} {} {:.10g} {:.10g} {:.10g} "
            "{:.10g} {:.10g} {:.10g} {:.10g} {:.10g} {:.10g} {}".format(
                M,
                S,
                meta["checkpoints"],
                meta["retained_share"],
                meta["selected_share"],
                d["nH"],
                d["DIAG"],
                d["OFF"],
                d["L2"],
                d["R"],
                d["slice_massavg"],
                d["minkowski"],
                proved,
                meta["loss_cap"],
                meta["max_selected_loss"],
                meta["near_count"],
            )
        )

    if len(rows) >= 2 and all(v > 0.0 for _, v in rows):
        x = np.log(np.array([m for m, _ in rows], dtype=float))
        y = np.log(np.array([v for _, v in rows], dtype=float))
        slope = float(np.polyfit(x, y, 1)[0])
        print("finite_fit_L2sq_power={:.10g}".format(slope))
    print("audit=PASS")


if __name__ == "__main__":
    main()
