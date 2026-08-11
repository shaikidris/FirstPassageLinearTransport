# Phase 3: the L2 time-slice socket

**Date:** 2026-08-09
**Scope:** post-freeze research only
**Headline status:** unchanged
**Formalization status:** none; no Lean work authorized before the paper
inequality closes
**Relation to prior cycle:** mechanism-distinct alternative to
`phase3_switch_3adic_common_profile_cycle_2026_08_09.md` sections 12-24.
That note's identities are not contradicted; this note declines its
two-outer-scale producer and replaces it with a one-scale producer.

## 1. Cycle card

```text
STRONGEST PROVED BASELINE:
  fixed-polylogarithmic descent for every A > 9.9911133419...,
  every shortcut clock c > 2/log(4/3).

TARGET (primary):
  UFP.L2_omega (section 5): the aggregate landing density satisfies
      || phi ||_{L2(U_S)}  <=  M^{omega+o(1)}
  for one fixed omega < 1/4, with S = S_M = ceil(C_sw log(M+2)).

SUFFICIENT ROUTE (secondary, strictly stronger, and possibly capped):
  UFP.SLICE_omega: sum_h p(h) || psi_h ||_{L2(U_S)} <= M^{omega+o(1)}
  for the single-time-slice normalized landing laws.  Implies UFP.L2_omega
  by Minkowski (LA.2) at zero cost.  Section 9 (L6) records finite evidence
  that this route may not reach omega = 0 even if UFP.L2_0 is true.

NOT THE TARGET:
  - a maximum-fiber / worst-root inverse-tree bound (PH.MAX);
  - a two-outer-scale comparison at ranks M and K = M^lambda;
  - a common-profile construction F_h = a_h pi_S + R_h with a residual
    estimate;
  - arbitrary-event total variation;
  - equidistribution of T^h(n) for its own sake.

CONSUMES:
  the headline needs only mu^sch_{M,S}(C) -> 0 for the literal stopped
  target C of density delta = M^{-A kappa_* + o(1)}.

FREE BASELINE:  see section 4 (typed).

DOMINANT LOSS:
  one operation -- the triangle inequality over the feasible passage-time
  support, taken in L^infinity instead of L2.

KNOWN FALSE OR PAUSED ROUTES (inherited, not re-litigated):
  fixed-mode PCA; absolute Fourier/Haar summation; distribution-free
  pointwise sibling contraction; affine-quotient spectral gap; separate
  absolute filter-alignment control; uniform continuous LOSS.AC.

ONE KILL TEST:
  R(M,S) := OFFDIAG / m^2 tracking #H ~ M^{1/2}.  Executed, section 6.
```

## 2. The payoff curve is a single scalar

Every threshold in the project is one formula. With

\[
 \kappa_*=1-H_2(\log_32)=0.0500444728116693651860994204613\ldots,
\]

and `phi = d mu^sch_{M,S}/dU_S` the schedule-restricted landing density on
the band `J_S`, Cauchy-Schwarz against the literal target gives

\[
 \mu^{\rm sch}_{M,S}(C)\le\|\varphi\|_{L^2(U_S)}\,\delta^{1/2},
 \qquad
 \delta=M^{-A\kappa_*+o(1)}.
\]

Hence

\[
 \boxed{\ \|\varphi\|_{L^2(U_S)}\le M^{\omega+o(1)}
 \ \Longrightarrow\ A>\frac{2\omega}{\kappa_*}.\ }
\tag{PC}
\]

This reproduces every published number exactly:

| `omega` | `A > 2 omega / kappa_*` | meaning |
|---:|---:|---|
| `1/4` | `9.99111334195951505...` | current proved headline |
| `.245` | `9.79129107512032475...` | first Phase-3 benchmark |
| `.2425` | `9.69137994170072960...` | the `(lambda,d)=(.97,.001)` value TH.4 |
| `0` | every fixed `A>0` | UFP.Epoly-strength consequence |

The agreement to all printed digits with the prior cycle's `9.991113...`,
`9.791291...` and `9.6913799417...` is the check that (PC) is the project's
real scalar and not a new normalization.

**Consequence.** The entire Phase-3 programme is the single scalar question
"lower `omega` below `1/4`", and the first benchmark is a **one per cent**
saving on one exponent.

## 3. Exact time-slice decomposition

Put `Y=2^S`, `J_S=(2^{S-1},2^S]`, `|J_S|=2^{S-1}`, and for `h` in the
declared feasible support `H`

\[
 F_h(y)=\#\{n\in I_M:\tau_Y(n)=h,\ T^h(n)=y,\ E_Y(n)\le D_S\},
 \qquad
 \varphi_h=\frac{|J_S|}{2^M}F_h .
\]

Then `phi = sum_h phi_h` and, exactly,

\[
 \mathbb E_{U_S}[\varphi_h]=p(h)=2^{-M}\#\{n\in I_M:\tau_Y(n)=h,\ E_Y\le D_S\},
 \qquad
 \sum_{h\in\mathcal H}p(h)\le1 .
\tag{TS.1}
\]

(TS.1) is **mass conservation across passage times**.  It is exact, free,
and the current assembly discards it entirely.

Lemma 4.5 of the manuscript with the rank-scaled cap `D_S=(S+2)/r_*` gives
the per-slice sup bound

\[
 \|\varphi_h\|_\infty\le 1+\tfrac32 D_S=:\Lambda_S=O(\log M),
\tag{TS.2}
\]

which is **polylogarithmic and uniform in `h`**.  Write the normalized slice
law `psi_h = phi_h / p(h)`, so `E_{U_S}[psi_h]=1`.

## 4. Loss autopsy: the whole `M^{1/2}` is one norm choice

The current proof aggregates the slices in `L^infinity`:

\[
 \|\varphi\|_\infty\le\sum_{h\in\mathcal H}\|\varphi_h\|_\infty
 \le\#\mathcal H\cdot\Lambda_S=M^{1/2+o(1)},
\tag{LA.1}
\]

because `#H = O(sqrt(M log M))` (Lemma 6.1) and (TS.2) **cannot see
`p(h)`**.  Interpolating against `||phi||_1 <= 1` then yields, for *every*
moment order `s>1`, the identical threshold `A>1/(2 kappa_*)`; the moment
order cancels.  That is an audited **method ceiling** for the entire
`L^infinity`-plus-mass interpolation family, and it is exactly the prior
cycle's `beta<1/4` burden.

Aggregating in `L2` instead costs nothing:

\[
 \boxed{\
 \|\varphi\|_{L^2(U_S)}
 \le\sum_{h\in\mathcal H}\|\varphi_h\|_{L^2(U_S)}
 =\sum_{h\in\mathcal H}p(h)\,\|\psi_h\|_{L^2(U_S)} .\ }
\tag{LA.2}
\]

Minkowski over the time support is free **precisely because the slice
`L2` norms carry the factor `p(h)` and the masses sum to one** by (TS.1).
The `M^{1/2}` in (LA.1) is therefore not an entropy loss, not a Diophantine
loss, and not an arithmetic loss: it is the cost of taking the triangle
inequality in the wrong norm before the time aggregation.  This is the
REORDER-REUSE operator of harness section 6.1a in its literal form.

Substituting the currently proved input `||psi_h||_2^2 <= ||psi_h||_inf =
Lambda_S/p(h)` into (LA.2) gives

\[
 \|\varphi\|_2\le\sqrt{\Lambda_S}\sum_h\sqrt{p(h)}
 \le\sqrt{\Lambda_S\,\#\mathcal H}=M^{1/4+o(1)},
\]

i.e. `omega = 1/4` and `A > 9.9911133419...`.  **The present headline is
exactly the `omega=1/4` instance of (PC).**  No free lunch has been taken:
the reformulation is exact and currently reproduces, not improves, the
theorem.

### Typed free-baseline comparison

```text
component                     free baseline            this note
-----------------------------------------------------------------------
EXPONENT   omega              1/4  (LA.1 + interp)     unchanged (1/4)
STRUCTURE  exact identity     none                     TS.1 + LA.2
INTERFACE  open producer      two-scale, filtered,     one-scale, single
                              signed, all-event        slice, averaged
QUANTIFIER burden             sup over events E,       none of these
                              two schedule supports,
                              two loss caps
SCOPE      target class       one literal target C     every target of
                                                       density delta
PAYOFF CEILING                A > 8.765210... (CP.23)  A > 0
```

The `EXPONENT` row is deliberately "unchanged".  This cycle is
**ARCHITECTURE + STRUCTURE** in the sense of harness 9.7, not THEOREM.

## 5. The new open target

\[
 \boxed{
 \textbf{(UFP.L2}_\omega\textbf{)}\qquad
 \|\varphi\|_{L^2(U_S)}\le M^{\omega+o(1)}
 }
\]

for one fixed `omega<1/4`, with `S=S_M=ceil(C_sw log(M+2))`.  By (PC) this
implies fixed-polylogarithmic descent for every `A > 2 omega / kappa_*`; in
particular `omega <= .245` gives the first Phase-3 benchmark and `omega = 0`
gives every fixed `A>0`.

Equivalently, in collision form,

\[
 \sum_{y\in J_S}F_{M,S}(y)^2\le M^{2\omega+o(1)}\,\frac{2^{2M}}{|J_S|},
\]

i.e. the total first-passage landing count has bounded normalized second
moment.  A sufficient route, free by (LA.2), is the single-slice statement

\[
 \textbf{(UFP.SLICE}_\omega\textbf{)}\qquad
 \sum_{h\in\mathcal H}p(h)\,\|\psi_h\|_{L^2(U_S)}\le M^{\omega+o(1)} .
\]

`||psi_h||_2^2` has an exact elementary meaning:

\[
 \|\psi_h\|_{L^2(U_S)}^2
 =|J_S|\cdot\Pr\bigl[T^h(n)=T^h(n')\ \big|\ \tau_Y(n)=\tau_Y(n')=h\bigr]
\]

for independent uniform sources -- the **collision probability of the
landing law at one fixed passage time, normalized against uniform**.  The
target says only that a single time slice does not concentrate on fewer
than `M^{-2 omega}|J_S|` landing points on average.

### Why the collision form is a promising home for the phase input

At fixed `h`, Lemma 4.2 pins the odd count `s` to at most two values.  For
two sources with the same `h` and the same landing, the exact affine
iterate gives

\[
 3^s n+c_w=2^hy=3^sn'+c_{w'}
 \quad\Longrightarrow\quad
 3^s(n-n')=c_{w'}-c_w ,
\]

so a single-slice collision is exactly a **coincidence among the affine
constants `c_w` of parity words of length `h` with `s` odd steps**.  Those
constants are sums of terms `2^a3^b`, so the collision count is an S-unit
coincidence count, which is where a `|| q log_2 3 ||` measure such as
Rhin's `kappa=143/10` applies **directly to the object being estimated**.
The prior cycle identified the same Diophantine input but could only reach
it through `CP.RECON`, which it records as OPEN.  This is a lead, not an
estimate: no bound is claimed here.

## 6. Executed diagnostic

Spec predeclared before the script (harness 9.12); script retained at
`research/audit_l2_time_slice_energy.py`; law measured is the
**unrestricted** direct first-passage law.

Calibrations both pass: aligned control `R=2007.0` against the predicted
`|J_S|=2048`; uniform control `R=0.980` against the predicted `1`.

Fixed `S=12`, growing `M` (`||phi||_2^2` is the quantity in (PC)):

| `M` | `#H` | DIAG | OFFDIAG | `\|phi\|_2^2` | proved ceiling `#H*Lambda_S` |
|---:|---:|---:|---:|---:|---:|
| 16 | 151 | .1327 | 2.8222 | 2.9549 | 2869 |
| 18 | 192 | .0954 | 2.8711 | 2.9665 | 3648 |
| 20 | 237 | .0764 | 2.8955 | 2.9719 | 4503 |
| 22 | 289 | .0652 | 2.9133 | 2.9785 | 5491 |
| 24 | 358 | .0576 | 2.9219 | 2.9795 | 6802 |

`#H` grows by `2.37x` over this range; `||phi||_2^2` grows by `1.008x`.
The diagonal decays as `Lambda_S/#H`, exactly as (TS.1)+(TS.2) predict.

Fixed `M=22`, growing `S`: `||phi||_2^2 = 2.919, 2.796, 3.009, 2.979,
2.948, 3.017` for `S=6,8,10,12,14,16`.  **No growth in `S`.**

Moving `S=round(1.6 log(M+2))`, `M=14..26`: `||phi||_2^2 = 2.534, 3.054,
3.077, 3.078, 3.075, 3.073, 3.073`.  Flat while `#H` grows `188 -> 435`.

Single-slice energies (the literal `UFP.SLICE` quantity):

| `(M,S)` | `#H` | mass-avg `\|psi_h\|_2^2` | Minkowski bd on `\|phi\|_2^2` | actual | proved ceiling |
|---:|---:|---:|---:|---:|---:|
| (18,10) | 203 | 7.94 | 6.33 | 3.006 | 3248 |
| (20,10) | 248 | 6.99 | 5.93 | 3.009 | 3968 |
| (22,10) | 308 | 6.49 | 5.70 | 3.009 | 4928 |
| (24,10) | 358 | 6.18 | 5.54 | 3.010 | 5728 |
| (22,12) | 289 | 6.97 | 5.91 | 2.979 | 5491 |
| (24,12) | 358 | 6.42 | 5.66 | 2.979 | 6802 |

Two facts matter here.  The mass-averaged single-slice energy is bounded
and **decreasing** in `M` at fixed `S`.  And at these ranks Minkowski
(LA.2) is lossy by only a factor of about two, so the aggregation step --
which the prior cycle treated as the hard part -- is not where the
difficulty lives.  Both statements are qualified by (L6) below.

**Shot-noise control.**  A perfectly uniform slice of `N_h` sources over
`|J_S|` cells has `||psi_h||_2^2 = 1 + (|J_S|-1)/N_h` by pure discreteness.
That floor must be subtracted before reading any `S`-dependence:

| `(M,S)` | mass-avg | noise floor | noise-corrected excess | aggregate floor |
|---:|---:|---:|---:|---:|
| (22,6) | 5.45 | 1.002 | 5.45 | 1.0000 |
| (22,8) | 5.13 | 1.009 | 5.12 | 1.0000 |
| (22,10) | 6.49 | 1.038 | 6.45 | 1.0001 |
| (22,12) | 6.97 | 1.141 | 6.82 | 1.0005 |
| (22,14) | 8.94 | 1.549 | 8.40 | 1.0020 |
| (22,16) | 12.95 | 3.062 | 10.89 | 1.0078 |

The **aggregate** statistic has a negligible floor (`1.0000-1.0078`) and is
therefore the trustworthy one; the single-slice statistic is materially
contaminated at large `S`.  After correction the single-slice excess still
grows with `S` (`5.45 -> 10.89` over `S=6..16`), which is the content of
(L6).

Lag structure: `C(Delta)/independent(Delta)` is `2.07, 2.80, 3.69, 3.43,
2.54, 1.95, 3.02, 2.20, 2.44, 4.41, 3.66` for `Delta = 1..200`.  It does
**not** decay.  So the bounded `R` is *not* time decorrelation; all slices
share one bounded-energy shape.  This is the prior cycle's (PH.7) common
profile, and the `L2` formulation reaches it **without constructing `pi_S`
and without any residual estimate**.

### F7 rare-family search (mandatory, same run)

Excising the affine-invariant reservoirs at `(M,S)=(22,12)`:

| excision | `\|excised\|` | `R` | `\|phi\|_2^2` |
|---|---:|---:|---:|
| none | 0 | 2.9133 | 2.9785 |
| `v_2(y+1)>=4` | 128 | 2.9473 | 2.6150 |
| `v_2(y+1)>=6` | 32 | 2.9246 | 2.8859 |
| `v_3(y+1)>=2` | 228 | 2.9215 | 2.5564 |
| `v_3(y+1)>=4` | 25 | 2.9003 | 2.9387 |

Neither reservoir drives the statistic and neither carries the maximum.
So the `(3/2)^d` symbolic family and the `IR.8` upper-failure reservoir are
**not** obstructions to `UFP.SLICE`, and reservoir excision (the `C_sw`
knob of IR.11/IR.12) is **not** a required mechanism for this route.

### Verdict against the predeclared threshold

`ROUTE ALIVE`.  Fitted exponent of `||phi||_2^2` in `M` over the moving-`S`
run is `-0.004`, far below the predeclared indeterminate band `[0.15,0.35]`
and inconsistent with the `#H` scaling of the union-bound mechanism.

**Status: EMPIRICAL.**  This promotes nothing.  See section 8.

## 7. Anti-circularity card (harness 9.3)

```text
Old target T:  TH.SIGNED_0 / DT.MIN / IR.MIN (two-scale signed pairing).
New target S:  UFP.L2_omega  (route: UFP.SLICE_omega, sufficient by LA.2).

Proof that S implies T:  IT DOES NOT.  S bypasses T at the consumer, in
  the same sense in which section 14 of the prior cycle bypasses
  SW.COMP.49.  S implies the headline consequence for which T was being
  built, via LA.2 and PC.  This must not be recorded as a relaxation of T.

Why S is strictly easier (burden removed):
  - no second outer scale K = M^lambda, hence no intermediate-scale energy
    floor and no beta >= 1/(4(1+4d)) ceiling; the CP.23 limit A > 8.765210
    does not apply;
  - no translated feasible-time supports (the CP.15H interface obligation);
  - no filter-alignment defect term F_{X,S}(g); SK.3, the term the prior
    cycle proved does not close separately, does not occur;
  - no all-event uniformity; a single averaged scalar replaces sup over E;
  - no common-profile construction and no residual estimate (PH.7/PH.8);
  - no outer-shell telescoping, hence the DT.13 summation obstruction
    (delta * sum_X 1/sqrt(X log X) = M^{1/2-A kappa_*}) does not arise.

Information irreversibly discarded:
  the transport exponent; all event-level information beyond one L2 scalar;
  any statement about the two-scale difference.  S does not imply
  UFP.CAUCHY, UFP.TARGET, or SW.COMP.49.

Scope NOT discarded (honest counterweight):
  S is target-uniform -- it controls every target of density delta, where
  UFP.TARGET_{d,lambda} is target-specific.  In that one respect S is a
  STRONGER statement than the target it replaces.  It is a different point
  in the trade space, not uniformly weaker.

New ingredient:
  mass conservation across passage times (TS.1), which the L^infinity
  assembly discards, plus the choice to aggregate in L2.

Failure mode:
  the mass-averaged single-slice collision probability genuinely grows like
  M^{1/2} in the joint limit S ~ C_sw log M, M -> infinity.

Finite kill test:
  executed, section 6; predeclared threshold; result ALIVE.
```

## 8. Slack localization card (harness 9.6a)

```text
literal quantity consumed:      || phi ||_{L2(U_S)}^2
reference-model prediction:     O(1) if a single slice is quasi-uniform
best proved bound:              #H * Lambda_S = M^{1/2+o(1)}
audited method ceiling:         M^{1/2}; identical for every moment order,
                                so the whole interpolation family is spent
exact value on the same object: 2.79 - 3.08 over every (M,S) tested,
                                including the moving-S regime
first proof operation where the gap appears:
                                the triangle inequality over h in H, taken
                                in L^infinity (LA.1)
gap in final-assembly units:    factor 1000 - 2300 at M = 18..24
structural conditioning tested: passage-time lag Delta; band rank S; outer
                                rank M; v_2 and v_3 target reservoirs
location and sign of residual:  a single bounded-energy common shape,
                                energy ~ 3, uniform in M and S; no lag decay
candidate deterministic mechanism:
                                S-unit coincidence count among the affine
                                constants c_w (section 5)
next exact decomposition:       collision form of || psi_h ||_2^2 at fixed
                                (h,s) via 3^s(n-n') = c_{w'} - c_w
finite scope / all-depth need:  see section 9 limitation (L1)
kill condition:                 mass-averaged || psi_h ||_2 growing like a
                                power of M in the joint S ~ log M limit
```

## 9. Honest limitations

```text
(L1) THE JOINT LIMIT IS NOT TESTED, AND CANNOT BE.  The theorem needs
     S ~ C_sw log M with both S and M large.  Reaching S = 10 in that
     regime needs M ~ 500.  The two tables vary S at fixed M and M at
     fixed S; together they are suggestive and they are not the joint
     limit.  This is the same objection the prior cycle correctly raises
     against its own section 5 data, and it applies here unchanged.

(L2) THE RANKS CANNOT SEE THE EXPONENT.  At M = 26, M^{0.49} = 4.9 and
     M^{0.50} = 5.1.  No finite run at these sizes can distinguish the
     benchmark from the current theorem.  What the data discriminates is
     the MECHANISM -- flat versus tracking #H -- not the exponent.

(L3) sup_h || psi_h ||_2^2 is 17 - 133 and noisy, far above the
     mass-average of 5 - 9.  The uniform-in-h version of UFP.SLICE looks
     materially worse behaved than the averaged version.  Only the
     averaged form is claimed as the target, and LA.2 only needs the
     averaged form.

(L4) F4 GATE NOT DISCHARGED.  No inheritance, spectral, or monotonicity
     certificate has been produced for the favourable trend.  Per harness
     section 5 the trend is EMPIRICAL and the statement is OPEN.  It is
     equally true that nothing here refutes the route.

(L5) THE OPEN PART IS STILL OPEN.  Nothing in this note proves any
     omega < 1/4.  The contribution is that the burden is now one
     averaged scalar at one scale instead of a signed two-scale pairing
     with two filter interfaces.

(L6) THE MINKOWSKI ROUTE MAY BE CAPPED.  After subtracting the shot-noise
     floor, the mass-averaged single-slice energy still grows with S
     (5.45 -> 10.89 over S = 6..16 at M = 22) while the aggregate
     ||phi||_2^2 does not (2.80 - 3.02 over the same range).  If that
     growth is genuinely geometric, say 2^{cS}, then with
     S = C_sw log M the Minkowski route delivers only
         omega = (c/2) * C_sw * log 2 > 0,
     even if UFP.L2_0 is true.  A crude fit gives c ~ .1 and, at
     C_sw = 1.6, omega ~ .055, hence A > 2.2 -- still far better than
     9.9911 and better than the two-scale ceiling 8.765210, but not 0.
     Caveats: only six S values, one M, and S = 16 at M = 22 is a thin
     regime (128 sources per landing point).  CONSEQUENCE FOR TARGETING:
     UFP.L2_omega is the primary target; UFP.SLICE_omega is a sufficient
     route that should be used for the benchmark and NOT relied on for
     the omega = 0 claim.  Reaching omega = 0 likely requires the
     off-diagonal directly, i.e. the coincidence count of section 5.
```

## 10. Cycle close

```text
New theorem, identity, certificate, or obstruction:
  TS.1 mass conservation across passage times (exact, previously discarded);
  LA.2 free Minkowski time aggregation in L2 (exact);
  PC payoff curve A > 2 omega / kappa_*, verified against all three
  published thresholds to full printed precision;
  audited method ceiling: every L^s interpolation off the L^infinity cap
  gives exactly A > 1/(2 kappa_*), independent of s.

What was strictly narrowed:
  the Phase-3 burden becomes one scalar, UFP.L2_omega, at one outer scale,
  with no filter-alignment term, no second scale, no common-profile
  construction, no residual estimate, and no all-event uniformity.
  Benchmark = a one per cent saving on one exponent.

What remains equally hard:
  a genuine estimate.  The normalized second moment of the first-passage
  landing count at moving S = O(log M) is unproved and is the whole
  content.  (L6) further shows the cheap Minkowski route is probably not
  by itself enough for omega = 0.

Scalar payoff:
  conditional.  omega <= .245 -> A > 9.79129107512...;
  omega = 0 -> every fixed A > 0, which exceeds the two-scale route's
  own best conditional ceiling A > 8.765210... (CP.23).

Status and source of truth:
  manuscript and Lean UNCHANGED.  proof-state.md unchanged.  This note is
  research-only.  Progress class: ARCHITECTURE + STRUCTURE, not THEOREM.

Route decision:
  ALIVE / PROMOTED TO PRIMARY PRODUCER CANDIDATE, pending an independent
  adversarial audit of (PC) and (LA.2), which are the two load-bearing
  exact steps.  The prior cycle's sections 12-24 are not withdrawn; they
  are demoted to the stronger-but-capped alternative producer.

Resume only with:
  (a) any proof of || psi_h ||_2^2 <= M^{1/2-epsilon} on average over h; or
  (b) an S-unit coincidence estimate for c_w at fixed (h,s); or
  (c) an explicit physical family forcing the mass-averaged single-slice
      collision probability up to M^{1/2} at moving S; or
  (d) a refutation of LA.2 or PC -- these are elementary and should be
      attacked first, precisely because everything else depends on them.
```

## 11. Cycle 2: proof attempt on UFP.L2_omega

Section 10 closed a reformulation.  The harness then requires the next
output to be a bound, exact identity, finite certificate, counterexample,
or named theorem with hypotheses checked.  This section is that attempt.
It does **not** close the target; it produces one negative inventory
result, two exact identities, and a named stall.

### 11.1 Inventory search: NEGATIVE

The proved transport inventory is **linear in the target size**:
Proposition 4.6 gives
`#{n : tau <= H, landing in B, E_Y <= D} <= H(1+3D)(2^M/Y)|B|`.
Apply it to the level sets `B_k = {y : F(y) > 2^k}`:

\[
 2^k|B_k|\le\sum_{y\in B_k}F(y)\le C\,\#\mathcal H\,D_S\,2^{M-S}|B_k|,
\]

and the `|B_k|` cancels.  The only surviving information is
`F(y) <= C #H D_S 2^{M-S}` -- the `L^infinity` bound again.

\[
 \boxed{
 \text{A transport estimate linear in }|B|\text{ cannot yield any}
 \text{ second-moment bound beyond }L^1\!-\!L^\infty\text{ interpolation.}}
\]

So no reordering of the existing inventory reaches `omega < 1/4`; a
genuinely new estimate is required.  This is an independent second
confirmation of the method ceiling found in section 4, obtained from the
consumer side rather than the producer side.

### 11.2 Exact coordinate: the landing map is linear up to `O(log M)`

From (4.3) with `kappa = kappa_{h,s} = 3^s/2^h`,

\[
 n=\frac{y}{\kappa}\prod_{j<h}\Bigl(1-\frac1{2x_{j+1}}\Bigr),
 \qquad
 1-\frac{E_Y(n)}{Y}\le\prod_{j<h}(\cdot)\le1,
\]

hence, for every source passing the loss filter `E_Y <= D_S`,

\[
 \boxed{\ \kappa n\ \le\ y\ \le\ \kappa n\Bigl(1-\frac{D_S}{Y}\Bigr)^{-1}
 \ =\ \kappa n+\varepsilon(n),
 \qquad 0\le\varepsilon(n)\le(1+o(1))\,D_S .\ }
\tag{NL}
\]

The blur is **additive and of size `O(log M)`**, while the spacing between
the preimages of consecutive landing points is `kappa^{-1} ~ 2^{M-S}`.

Numerical check of (NL) on the literal law (`max |y - kappa n|`, all
`n in I_M`):

| `(M,S)` | max | mean | sign |
|---:|---:|---:|:--|
| (18,10) | 2.713 | 0.509 | `>= 0` |
| (20,12) | 3.963 | 0.511 | `>= 0` |
| (22,12) | 3.966 | 0.511 | `>= 0` |
| (22,14) | 4.672 | 0.513 | `>= 0` |

One-sided and growing linearly in `S`, exactly as (NL) asserts.

### 11.3 Deduction: collisions are short-range

If two sources at the same `(h,s)` share a landing point then
`kappa|n-n'| = |varepsilon(n)-varepsilon(n')| <= D_S`, so

\[
 \boxed{\ |n-n'|\le D_S\,\kappa^{-1}=O\!\left(D_S 2^{M-S}\right).\ }
\tag{SR}
\]

This is a rigorous consequence of (NL), not a heuristic.  Consequently

\[
 \sum_{y}F_{h}(y)^2
 \le\sum_{0<|d|\le CD_S2^{M-S}}
   \#\bigl(V_{h,s}\cap(V_{h,s}-d)\bigr)
   +\sum_y F_h(y),
\tag{AE}
\]

where `V_{h,s} = {n in I_M : tau_Y(n)=h, odd count s}`.

\[
 \boxed{
 \textbf{UFP.L2}_\omega\ \Longleftarrow\
 \text{short-shift autocorrelation bound for }V_{h,s}
 \text{ at shifts }|d|\le D_S2^{M-S}.}
\]

The trivial bound on (AE) reproduces `Lambda_S p(h)` exactly, so nothing
has been given away; the target is now a **named classical object** --
the additive energy / short-shift correlation of the first-passage source
set -- rather than a bespoke two-scale pairing.

### 11.4 Regeneration lever: the prefix is exactly equidistributed, for free

Proposition 2.2 (parity-vector bijection) says `n mod 2^k` determines the
first `k` parity bits.  Take `k = M-S`, which is **exactly the shift scale
in (SR)**.  On any interval of length `2^{M-S}`, `n mod 2^{M-S}` takes
every value exactly once.  Therefore

\[
 \boxed{
 \text{the first }M-S\text{ parity steps are \emph{exactly} equidistributed}
 \text{ on every interval at the collision scale, with no error term.}}
\]

This is free, exact, and at precisely the right scale.  It is the strongest
available input and it is not used anywhere in the current assembly.

### 11.5 Where the attempt stalls

Membership in `V_{h,s}` constrains all `h ~ 4.819(M-S)` steps, i.e. about
`3.819(M-S)` steps beyond the equidistributed prefix.  Writing
`z = T^{M-S}(n) = (3^{s_1}n + c_{w_1})/2^{M-S}`, the prefix `w_1` ranges
bijectively over `{0,1}^{M-S}`, but the event that the continuation from
`z` has residual time `h-(M-S)` and residual odd count `s-s_1` is not
controlled by the prefix distribution alone.

```text
NAMED MISSING INPUT:
  prefix/suffix decorrelation (a renewal estimate) for the first-passage
  word at the regeneration scale k = M-S:  the residual (time, odd-count)
  law of the continuation, conditioned on the prefix, must not correlate
  with the prefix beyond a factor M^{2 omega}.

WHY IT IS THE RIGHT SHAPE:
  it is a statement about ONE law at ONE scale.  No second outer shell,
  no translated time support, no filter-alignment defect, no signed
  cancellation, no target.  Compare the prior cycle's AR.7, whose two
  load-bearing terms are a phase renewal AND a filter alignment.

WHAT IT IS NOT:
  it is not the affine-quotient spectral gap (killed, SK.4-SK.6): that
  concerned the map A(u)=3u+2 on a dyadic quotient.  Here the prefix
  equidistribution is exact and the open part is the CONDITIONAL law of
  the suffix, which SK.4-SK.6 say nothing about.
```

### 11.6 Cycle 2 close

```text
New identity / certificate / obstruction:
  NL   landing map linear in the source up to additive O(log M)  [verified];
  SR   collisions are short-range, |n-n'| <= D_S 2^{M-S}  [deduced from NL];
  AE   UFP.L2 reduces to a short-shift autocorrelation bound;
  11.4 exact free equidistribution of the length-(M-S) prefix;
  11.1 NEGATIVE: linear-in-|B| transport cannot give any second-moment
       gain -- the existing inventory is provably spent.

What was strictly narrowed:
  from "bound an L2 energy" to "bound the additive energy of V_{h,s} at
  shifts <= D_S 2^{M-S}", with the prefix half of the word already exactly
  equidistributed at that very scale.

What remains equally hard:
  prefix/suffix decorrelation.  This is the whole remaining content and it
  is not reducible to any proved statement in the package.

Scalar payoff:
  none yet.  omega is unchanged at 1/4.  Progress class: STRUCTURE +
  NEGATIVE (harness 9.7).  No status change anywhere.

Route decision:
  ALIVE.  Next bounded attempt is 11.5, not another reformulation; a third
  consecutive narrowing-only cycle would trigger the 9.4 plateau interrupt
  and a parking decision.
```
