#!/usr/bin/env python3
"""
Generate the proof-architecture figure for
paper/collatz_first_passage_natural_density.md.

Panel (a) draws a REAL shortcut-Collatz orbit, selected to satisfy the (3.8)
envelope on its high certified block, so the picture cannot show dynamically
impossible behaviour.  Below the switch the annotation records the timeout
continuation used in Section 6.  Panel (b) is deliberately order-only: Lemmas
6.1 and 6.3 have unspecified fixed-parameter constants, so no
theorem-calibrated bar ratio is claimed or implied.

Geometry sources (manuscript):
  (3.8)  rho^k n^{1-eta} <= T^k(n) <= rho^k n^{1+eta}  -- envelope; in log_2 a
         band of slope a_0 - 1 and half-width eta*m, valid for 0 <= k <= log_2 n
  (6.1)  a_0 < r_hi < 1,  0 < tau < r_hi - a_0
  (6.4a) q_i = floor(r_hi*m_i), h_i = tau_{2^{q_i}}(n_i)
  Lemmas 6.1 and 6.4  feasible cumulative times occupy
                       O(sqrt(M log M)) integers

Output: paper/fig-architecture.svg      Usage: python3 make_architecture_figure.py
"""

import math

A0 = math.log2(3) / 2          # log_2 rho = A0 - 1
M = 40                         # illustrative source shell
R = 0.90                       # threshold rate (must exceed A0)
ETA = 0.05                     # envelope half-width rate (must be < R - A0)
KMAX = 72                      # steps shown in panel (a)

INK, SEC, MUTED = "#0b0b0b", "#52514e", "#898781"
RULE, BAND = "#c3c2b7", "#eeece4"
ACCENT = "#1c5cab"             # validated on white: all applicable checks PASS

W, H = 680, 424
X0, X1, Y0, Y1 = 78, 640, 36, 252
VTOP, VBOT = 43.5, 25.0
SERIF = "Georgia,'Times New Roman',serif"


def shortcut(n):
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def trace(n, steps):
    out, x = [n], n
    for _ in range(steps):
        x = shortcut(x)
        out.append(x)
    return out


def pick_source():
    """A source obeying (3.8) on its whole certified block 0 <= k <= M."""
    best = None
    for n in range(2 ** M + 1, 2 ** M + 6000, 2):
        v = [math.log2(x) for x in trace(n, KMAX + 2)]
        if any(abs(v[k] - (M + (A0 - 1) * k)) > ETA * M for k in range(M + 1)):
            continue
        score = sum(abs(v[k] - (M + (A0 - 1) * k)) for k in range(M + 1))
        if best is None or score < best[0]:
            best = (score, n, v)
    if best is None:
        raise SystemExit("no source satisfies the envelope; relax ETA")
    return best[1], best[2]


def sx(k):
    return X0 + k * (X1 - X0) / KMAX


def sy(v):
    return Y0 + (VTOP - v) * (Y1 - Y0) / (VTOP - VBOT)


def main():
    n0, v = pick_source()

    passes, m_i, k = [], M, 0
    while len(passes) < 3:
        q = math.floor(R * m_i)
        while k < len(v) - 1 and v[k] > q:
            k += 1
        passes.append((k, q, v[k]))
        m_i = math.floor(v[k])
    k0, q0, _ = passes[0]

    P = []
    add = P.append
    add(f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" '
        f'width="100%" role="img" aria-labelledby="figt figd" font-family="{SERIF}">')
    add('<title id="figt">Proof architecture and the reduced set of possible passage times</title>')
    add('<desc id="figd">Panel a: a real shortcut-Collatz orbit descends inside the '
        'certified high-rank envelope of slope a0 minus 1; at each high threshold it '
        'makes a first passage into a landing band and is certified until the '
        'switch, below which the low rule either crosses within the parent rank or '
        'records a timeout. Panel b: a schematic order comparison records the reduction from '
        'all times in a linear horizon to O(sqrt(M log M)) possible passage times. The '
        'bar lengths do not represent theorem constants.</desc>')
    add('<defs><pattern id="hatch" width="7" height="7" patternTransform="rotate(45)" '
        'patternUnits="userSpaceOnUse">'
        f'<line x1="0" y1="0" x2="0" y2="7" stroke="{RULE}" stroke-width="1"/>'
        '</pattern></defs>')
    add(f'<rect width="{W}" height="{H}" fill="#ffffff"/>')

    add(f'<text x="0" y="14" font-size="12" fill="{INK}">'
        f'<tspan font-weight="bold">(a)</tspan> high certification and timeout '
        f'continuation — a real orbit in <tspan font-style="italic">I</tspan>'
        f'<tspan dy="3" font-size="8">M</tspan><tspan dy="-3">, M = 40</tspan></text>')

    # thresholds + landing bands
    for i, (kp, q, _) in enumerate(passes):
        yh, yl = sy(q), sy(q - 1)
        add(f'<rect x="{X0}" y="{yh:.1f}" width="{X1-X0}" height="{yl-yh:.1f}" '
            f'fill="{BAND}"/>')
        add(f'<line x1="{X0}" y1="{yh:.1f}" x2="{X1}" y2="{yh:.1f}" stroke="{MUTED}" '
            f'stroke-width="1"/>')
        add(f'<text x="{X0-9}" y="{yh+4:.1f}" text-anchor="end" font-size="11.5" '
            f'fill="{SEC}">2^q_{i}</text>')

    # block-0 envelope (hatched, valid 0<=k<=M) and block-1 envelope (outline)
    for idx, (kA, mA, style) in enumerate(
            [(0, M, 'fill="url(#hatch)" fill-opacity=".5" stroke="%s"' % RULE),
             (k0, passes[0][1], 'fill="none" stroke="%s" stroke-dasharray="3 3"' % MUTED)]):
        span = min(mA, KMAX - kA, 22 if idx else mA)
        up = [(sx(kA), sy(mA * (1 + ETA))), (sx(kA + span), sy(mA * (1 + ETA) + (A0 - 1) * span))]
        lo = [(sx(kA + span), sy(mA * (1 - ETA) + (A0 - 1) * span)), (sx(kA), sy(mA * (1 - ETA)))]
        pts = " ".join(f"{x:.1f},{y:.1f}" for x, y in up + lo)
        add(f'<polygon points="{pts}" {style} stroke-width="1"/>')

    # the orbit
    poly = " ".join(f"{sx(k):.1f},{sy(val):.1f}"
                    for k, val in enumerate(v) if k <= KMAX and VBOT <= val <= VTOP)
    add(f'<polyline points="{poly}" fill="none" stroke="{INK}" stroke-width="1.7" '
        f'stroke-linejoin="round"/>')
    for kp, q, val in passes:
        add(f'<circle cx="{sx(kp):.1f}" cy="{sy(val):.1f}" r="4.3" fill="#ffffff" '
            f'stroke="{INK}" stroke-width="1.8"/>')

    # axes
    add(f'<line x1="{X0}" y1="{Y0-8}" x2="{X0}" y2="{Y1}" stroke="{RULE}" stroke-width="1"/>')
    add(f'<line x1="{X0}" y1="{Y1}" x2="{X1}" y2="{Y1}" stroke="{RULE}" stroke-width="1"/>')
    add(f'<text x="{X0-9}" y="{sy(M)+4:.1f}" text-anchor="end" font-size="11.5" '
        f'fill="{SEC}">2^M</text>')
    add(f'<text x="0" y="{Y0-8}" font-size="11" fill="{MUTED}">orbit value</text>')
    add(f'<text x="{X1}" y="{Y1+16}" text-anchor="end" font-size="11" fill="{MUTED}">'
        f'shortcut steps k</text>')

    # annotations, placed clear of the marks
    add(f'<text x="{sx(3):.1f}" y="{sy(M*(1+ETA))-8:.1f}" font-size="11" fill="{SEC}">'
        f'certified envelope (3.8), slope a₀ − 1</text>')
    add(f'<line x1="{sx(k0):.1f}" y1="{sy(q0)-6:.1f}" x2="{sx(k0)+16:.1f}" '
        f'y2="{sy(q0)-21:.1f}" stroke="{MUTED}" stroke-width="1"/>')
    add(f'<text x="{sx(k0)+20:.1f}" y="{sy(q0)-23:.1f}" font-size="11" fill="{SEC}">'
        f'high first passage → certify until the switch (§6)</text>')
    add(f'<text x="{X0}" y="{Y1+16}" font-size="11" fill="{MUTED}">'
        f'below S: cross within m steps, or charge the timeout tail</text>')

    # ---------------- panel (b) ----------------
    add(f'<line x1="0" y1="286" x2="{W}" y2="286" stroke="{RULE}" stroke-width="1"/>')
    add(f'<text x="0" y="306" font-size="12" fill="{INK}">'
        f'<tspan font-weight="bold">(b)</tspan> reduction in possible passage times used by '
        f'the transport argument <tspan font-style="italic">(orders only)</tspan></text>')

    bx0, bx1 = 135, 625
    y_linear, y_support = 337, 373
    add(f'<text x="{bx0-10}" y="{y_linear+4}" text-anchor="end" font-size="11" '
        f'fill="{SEC}">direct horizon</text>')
    add(f'<rect x="{bx0}" y="{y_linear-7}" width="{bx1-bx0}" height="14" '
        f'fill="{BAND}" stroke="{RULE}" stroke-width="1"/>')
    add(f'<text x="{bx1-9}" y="{y_linear+4}" text-anchor="end" font-size="11" '
        f'fill="{SEC}">O(M) possible cumulative times</text>')

    add(f'<text x="{bx0-10}" y="{y_support+4}" text-anchor="end" font-size="11" '
        f'fill="{SEC}">Lemmas 6.1, 6.3</text>')
    add(f'<rect x="{bx0}" y="{y_support-7}" width="220" height="14" '
        f'fill="{ACCENT}"/>')
    add(f'<text x="{bx0+232}" y="{y_support+4}" font-size="11" fill="{SEC}">'
        f'O(√(M log M)) possible passage times</text>')
    add(f'<text x="{bx0}" y="407" font-size="10.5" fill="{MUTED}">'
        f'fraction of the linear horizon O(√(log M / M)) → 0; bar lengths are schematic</text>')

    add('</svg>')
    out = "\n".join(P) + "\n"
    open("fig-architecture.svg", "w").write(out)
    print(f"source n0 = {n0}")
    print(f"first passages (k, q) = {[(k, q) for k, q, _ in passes]}")
    print(f"wrote fig-architecture.svg ({len(out)} bytes)")


if __name__ == "__main__":
    main()
