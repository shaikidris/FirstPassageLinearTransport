#!/usr/bin/env python3
"""
Phase-3 L2 time-slice diagnostic.

Companion to research/phase3_l2_time_slice_socket_2026_08_09.md.
The specification in section 6 of that note was predeclared before this
script was written (harness 9.12).

LAW MEASURED
  Unrestricted direct first-passage law for the shortcut map
      T(n) = n/2 (n even),  (3n+1)/2 (n odd).
  The schedule-restricted law is a pointwise restriction of this law, so
  F^sch_h <= F_h pointwise.  Filters shrink the feasible time set; they are
  not a mechanism for creating time alignment.  Deviation declared.

EXACT QUANTITIES   (I_M = [2^M, 2^{M+1}),  Y = 2^S,  J_S = (2^{S-1}, 2^S])
  F_h(y)          = #{n in I_M : tau_Y(n) = h, T^h(n) = y}
  p(h)            = 2^{-M} sum_y F_h(y),          m = sum_h p(h)
  phi_h(y)        = (|J_S| / 2^M) F_h(y)
  <phi_h, phi_h'> = (|J_S| / 2^{2M}) sum_y F_h(y) F_h'(y)
  DIAG            = sum_h <phi_h, phi_h>
  OFFDIAG         = sum_{h != h'} <phi_h, phi_h'>
  ||phi||_2^2     = DIAG + OFFDIAG          <- the quantity in payoff curve (PC)
  R               = OFFDIAG / m^2           <- time-coherence ratio
  psi_h           = phi_h / p(h)            <- normalized single-slice law
  ||psi_h||_2^2   = |J_S| * collision probability of the slice-h landing law

PAYOFF CURVE (PC):   ||phi||_2 <= M^{omega+o(1)}  ==>  A > 2 omega / kappa_*,
  kappa_* = 1 - H_2(log_3 2) = 0.05004447281166936518...

PREDECLARED KILL THRESHOLD (fixed S, growing M)
  ||phi||_2^2 tracking #H ~ M^{1/2}              -> ROUTE DEAD
  fitted exponent in [0.15, 0.35]                -> INDETERMINATE
  flat / no power growth                         -> ROUTE ALIVE (EMPIRICAL only)

SCOPE
  Finite and EMPIRICAL.  Promotes nothing.  An all-depth claim needs the
  harness F4 inheritance gate, which this script does not supply.

Usage:  python3 audit_l2_time_slice_energy.py
"""

import math

import numpy as np


# --------------------------------------------------------------------------
# exact first passage
# --------------------------------------------------------------------------

def first_passage(M, S):
    """Return (h, y) = (tau_Y(n), T^h(n)) for every n in I_M, with Y = 2^S."""
    Y = 1 << S
    x = np.arange(1 << M, 1 << (M + 1), dtype=np.int64)
    hs = np.empty(x.size, dtype=np.int32)
    ys = np.empty(x.size, dtype=np.int64)
    idx = np.arange(x.size, dtype=np.int64)
    t = 0
    while x.size:
        done = x <= Y
        if done.any():
            hs[idx[done]] = t
            ys[idx[done]] = x[done]
            keep = ~done
            x, idx = x[keep], idx[keep]
            if not x.size:
                break
        odd = (x & 1).astype(bool)
        x = np.where(odd, (3 * x + 1) >> 1, x >> 1)
        t += 1
        if t > 4000:
            raise RuntimeError("horizon exceeded")
    return hs, ys


def histogram(hs, ys, S):
    """F[h, y-index] over the band J_S."""
    JS = 1 << (S - 1)
    lo = 1 << (S - 1)
    yi = (ys - lo - 1).astype(np.int64)
    hh = hs.astype(np.int64)
    H = int(hh.max()) + 1
    return np.bincount(hh * JS + yi, minlength=H * JS).reshape(H, JS).astype(float), JS


def stats(F, JS, M, mask_y=None):
    if mask_y is not None:
        F = F[:, ~mask_y]
        JS = F.shape[1]
    rows = F.sum(1)
    tot2 = float((F.sum(0) ** 2).sum())
    dia2 = float((F ** 2).sum())
    c = JS / (2.0 ** (2 * M))
    diag, off = c * dia2, c * (tot2 - dia2)
    m = rows.sum() / 2.0 ** M
    ok = rows > 0
    p = rows / 2.0 ** M
    e = np.zeros(rows.size)
    e[ok] = JS * (F[ok] ** 2).sum(1) / rows[ok] ** 2
    return dict(
        nH=int(ok.sum()), m=m, DIAG=diag, OFF=off, L2=diag + off, R=off / m ** 2,
        maxphi=float(F.sum(0).max()) * JS / 2.0 ** M,
        slice_massavg=float((p[ok] * e[ok]).sum() / p[ok].sum()),
        minkowski=float((p[ok] * np.sqrt(e[ok])).sum()) ** 2,
    )


def padic(y1, q):
    v = np.zeros(y1.size, dtype=np.int64)
    t = y1.copy()
    while True:
        m = (t % q == 0) & (t > 0)
        if not m.any():
            return v
        v[m] += 1
        t = np.where(m, t // q, t)


# --------------------------------------------------------------------------

def main():
    JS = 1 << 11
    Fa = np.zeros((50, JS)); Fa[:, 7] = 1.0
    Fu = np.ones((50, JS))
    cal = lambda F: ((F.sum(0) ** 2).sum() - (F ** 2).sum()) / F.sum() ** 2 * JS
    print("CALIBRATION  aligned control  R = %8.2f   expect ~|J_S| = %d" % (cal(Fa), JS))
    print("CALIBRATION  uniform control  R = %8.4f   expect ~1" % cal(Fu))

    hdr = ("%3s %3s %6s %8s %10s %12s %9s %12s %11s %10s"
           % ("M", "S", "#H", "DIAG", "OFFDIAG", "||phi||_2^2", "R",
              "slice avg", "Minkowski", "proved bd"))

    def row(M, S, mask=None):
        F, js = histogram(*first_passage(M, S), S)
        d = stats(F, js, M, mask)
        print("%3d %3d %6d %8.4f %10.4f %12.4f %9.4f %12.3f %11.3f %10.0f"
              % (M, S, d["nH"], d["DIAG"], d["OFF"], d["L2"], d["R"],
                 d["slice_massavg"], d["minkowski"], (1.5 * S + 1) * d["nH"]))
        return d

    print("\n=== fixed S = 12, growing M ===\n" + hdr)
    for M in (16, 18, 20, 22, 24):
        row(M, 12)

    print("\n=== fixed M = 22, growing S ===\n" + hdr)
    for S in (6, 8, 10, 12, 14, 16):
        row(22, S)

    print("\n=== moving S = round(1.6 log(M+2))  (the theorem's regime) ===\n" + hdr)
    for M in (14, 16, 18, 20, 22, 24, 26):
        row(M, int(round(1.6 * math.log(M + 2))))

    print("\n=== F7 rare-family search at (M,S) = (22,12) ===")
    F, js = histogram(*first_passage(22, 12), 12)
    y1 = np.arange((1 << 11) + 1, (1 << 12) + 1) + 1
    v2e, v3e = padic(y1, 2), padic(y1, 3)
    print("%-18s %10s %9s %13s" % ("excision", "|excised|", "R", "||phi||_2^2"))
    for lab, mask in [("none", None),
                      ("v2(y+1)>=4", v2e >= 4), ("v2(y+1)>=6", v2e >= 6),
                      ("v3(y+1)>=2", v3e >= 2), ("v3(y+1)>=4", v3e >= 4)]:
        d = stats(F, js, 22, mask)
        print("%-18s %10d %9.4f %13.4f"
              % (lab, 0 if mask is None else int(mask.sum()), d["R"], d["L2"]))

    print("\n=== lag structure: C(Delta) vs independent baseline ===")
    rows = F.sum(1); p = rows / 2.0 ** 22
    c = js / (2.0 ** 44)
    H = F.shape[0]
    print("%6s %12s %14s %8s" % ("Delta", "C(Delta)", "independent", "ratio"))
    for D in (1, 2, 3, 5, 10, 20, 40, 80, 120, 160, 200):
        if D >= H:
            break
        cd = c * float((F[:H - D] * F[D:]).sum())
        ind = float((p[:H - D] * p[D:]).sum())
        print("%6d %12.6f %14.6f %8.3f" % (D, cd, ind, cd / ind if ind else 0.0))


if __name__ == "__main__":
    main()
