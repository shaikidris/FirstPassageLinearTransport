# Phase 3 switch law: 3-adic multiresolution and common-profile cycle

**Date:** 2026-08-09

**Scope:** post-freeze research only

**Headline status:** unchanged

**Formalization status:** none; no Lean work is authorized before the paper
inequality closes

## 1. Cycle card

```text
STRONGEST PROVED BASELINE:
  fixed-polylogarithmic descent for every
  A > 9.9911133419..., with every shortcut clock
  c > 2/log(4/3).

LITERAL PHASE-3 TARGET:
  replace the terminal square-root time-support loss M^(1/2+o(1))
  by M^(alpha+o(1)) for one fixed alpha<1/2; first benchmark alpha=.49.

CURRENT ONE-SWITCH FORM:
  [Delta^+_(M,S,L)]_+
    <= M^(.49+o(1)) delta_(S,L) 2^M,
  where Delta^+ is the centered direct-switch mass of the literal stopped
  upper-first-exit target.

NOT THE TARGET:
  arbitrary-target equidistribution;
  a maximum fixed-correction-fiber theorem;
  an all-depth generated checkpoint theorem;
  a numerical PCA fit.

TARGET-SANITY:
  UNKNOWN-BUT-INTENDED.  The current theorem supplies exponent 1/2, so a
  strict .49 theorem is capacity-compatible and would lower the fixed
  polylog threshold to 9.791291... .

KILL TEST FOR THE PRESENT MECHANISM:
  if the literal target aligns with the dominant 3-adic congestion modes
  like an equal-size top-load target, or if a proposed low-rank projection
  captures no stable signed mechanism, generic PCA is rejected.
```

## 2. Exact 3-adic martingale identity

Let

\[
 J=J_S=(2^{S-1},2^S]\cap\mathbb N,
 \qquad Q=|J|,
\]

and let `U` be uniform probability on `J`.  Let `F(y)` be the direct switch
landing count after all permitted switch times are aggregated, put

\[
 N=\sum_{y\in J}F(y),\qquad
 f(y)=\frac{QF(y)}N,
\]

and let

\[
 g(y)=\mathbf1_{C^+}(y)-\delta,
 \qquad \delta=\frac{|C^+|}{Q}.
\]

Then `E_U f=1`, `E_U g=0`, and the centered switch discrepancy is

\[
 \Delta^+=N\,\mathbb E_U[(f-1)g].
\tag{PH.1}
\]

Let `A_a` be the partition of `J` by residues modulo `3^a`.  Set

\[
 f_a=\mathbb E_U[f\mid\mathcal A_a],\qquad
 g_a=\mathbb E_U[g\mid\mathcal A_a],
\]

with `f_0=1`, `g_0=0`.  Choose `A` so that `3^A>Q`; then `A_A` separates
the points of `J`.  Orthogonality of martingale differences gives the exact
diagonal identity

\[
 \boxed{
 \frac{\Delta^+}{N}
 =\sum_{a=1}^{A}
 \mathbb E_U[(f_a-f_{a-1})(g_a-g_{a-1})].
 }
\tag{PH.2}
\]

Indeed, martingale differences at unequal depths are orthogonal: if `a<b`,
the depth-`a` difference is `A_(b-1)`-measurable while the conditional mean
of the depth-`b` difference on `A_(b-1)` is zero.  Expanding `f-1` and `g`
therefore leaves only equal-depth terms.

The partial projection

\[
 \Delta_a=N\mathbb E_U[(f_a-1)g_a]
\]

satisfies

\[
 \Delta_a-\Delta_{a-1}
 =N\mathbb E_U[(f_a-f_{a-1})(g_a-g_{a-1})].
\tag{PH.3}
\]

Thus the finite diagnostic's successive projection increments are literal
signed 3-adic Haar contributions, not a heuristic attribution.

## 3. Exact inverse-branch interpretation

For a shortcut parity branch `w` of length `h`, with `s(w)` odd steps, the
iterate has the affine form

\[
 T^h(n)=\frac{3^{s(w)}n+c_w}{2^h}.
\]

Consequently a fixed landing `y` has reverse source

\[
 n=\frac{2^hy-c_w}{3^{s(w)}}
\tag{PH.4}
\]

only when one generated congruence modulo `3^(s(w))` holds.  The source-shell
and first-passage conditions cut the allowed `y` values further by exact
integer intervals.  Therefore the physical switch load is a sum of
interval-restricted 3-adic progressions.  Incomplete progression remainders
cannot be dropped in the bit-exhausted regime.

Equation (PH.2) is the cancellation-preserving way to pair those generated
3-adic loads with the dyadic upper-first-exit language.

## 4. Finite diagnostic and calibrations

The audit used complete source and target shells for the rows below.  Orbit
and source counts were exact integers.  Corridor comparisons used floating
logarithms, so all rows remain `EMPIRICAL`.

The equal-cardinality controls were:

- `most_loaded`: choose the endpoints with the largest physical loads;
- `least_loaded`: choose those with the smallest loads;
- `hashed`: deterministic pseudo-random equal-size target.

The top-load control aligns with the first ternary mode with cosine between
`.9986` and `.99999` in the tested rows, so the audit detects genuine
adversarial alignment.

Literal stopped-upper rows:

| `(M,S,L)` | density `delta` | actual / neutral | exact normalized discrepancy |
|---:|---:|---:|---:|
| `(16,10,6)` | `.6328125` | `.95449` | `-.028799` |
| `(18,12,8)` | `.5595703` | `.98797` | `-.006731` |
| `(20,12,8)` | `.5595703` | `.98673` | `-.007427` |
| `(22,14,10)` | `.4838867` | `.98255` | `-.008444` |

The sign is not a finite identity: `(M,S,L)=(14,8,4)` has enrichment
`1.01881`.  Hence a theorem cannot simply assert that every stopped-upper
target is anti-enriched.

At `(M,S,L)=(20,12,8)`, the successive exact 3-adic Haar contributions to
the unnormalized discrepancy are approximately

```text
+2525, +1046, -791, -1362, +722, -9285, -443.
```

At `(22,14,10)` they are approximately

```text
+6511, -10289, +3358, -141, -2609, -4320, -5917, -37123, +15818.
```

Thus the favorable total is signed and multiscale.  A bounded collection of
coarse ternary modes does not explain it.  In a sampled sparse-target row
`(M,S,L)=(64,40,30)`, the total centered discrepancy was about
`-2.21e-4`, while every projection through depth seven was still positive.
The compensating depth therefore grows with the switch precision.

**Scoped kill:** numerical PCA on a fixed number of 3-adic modes cannot be
the proof.  The surviving method needs an all-scale recurrence or spectral
theorem.

## 5. Common-profile signal

After aggregating all switch times, the complete physical landing profile is
far flatter than the per-time bound suggests:

| `(M,S)` | maximum load / mean load |
|---:|---:|
| `(20,12)` | `13.0692` |
| `(22,14)` | `11.4780` |

The unrestricted direct first-passage audit at `M=22` gives normalized
maxima `6.35, 7.82, 12.41, 11.25, 14.39, 19.13, 20.13` for
`S=8,10,12,14,16,18,20`, respectively.  These are finite values only; they
do not prove polynomial maximum load.

More importantly, at fixed `S=12`, the complete normalized landing profiles
stabilize as the outer shell grows:

| outer-shell pair | total variation | squared Hellinger distance |
|---:|---:|---:|
| `16 -> 18` | `.04448` | `.002938` |
| `18 -> 20` | `.02190` | `.000750` |
| `20 -> 22` | `.01043` | `.000184` |

The distances roughly halve every two shell bits, while the target mass and
normalized maximum are stable.  This is evidence for a physical
first-passage common profile and a Markov-renewal limit.  It is not a proof
of uniform convergence when `S=O(log M)`.

## 6. Why a maximum theorem is not the first target

A uniform bound

\[
 \max_y F(y)\ll\operatorname{poly}(S)\frac{2^M}{2^S}
\tag{PH.MAX}
\]

would give linear transport for every target and would improve the headline
far beyond the `.49` benchmark.  It is also a worst-root inverse-tree
theorem and may be false asymptotically.  The exact symbolic affine walk has
normalized maximum densities

```text
2.00, 3.14, 4.80, 7.27, 10.98, 16.53
```

through 3-adic depth six, showing exponential maximum growth despite benign
Shannon information.  This does not refute (PH.MAX) for the physical merged
law, but it warns that a worst-fiber theorem may recreate the known rare
3-adic reservoirs.

The first proof target should therefore remain an averaged subcritical
moment or the literal signed target pairing.

## 7. Mechanism-distinct producer: merged `3/2` energy

Let the unnormalized physical direct landing density be

\[
 \varphi_{M,S}(y)=\frac{|J_S|}{2^M}F^{\rm dir}_{M,S}(y).
\]

Define

\[
 \mathcal E_{3/2}^{\rm dir}(M,S)
 =\mathbb E_{U_S}[\varphi_{M,S}^{3/2}].
\tag{PH.5}
\]

Pointwise domination of generated switch landings by unrestricted direct
landings and monotonicity of `x^(3/2)` permit this ambient producer.  For any
target `C` of uniform density `delta`, Holder gives

\[
 \frac1{2^M}\sum_{y\in C}F(y)
 \le
 \bigl(\mathcal E_{3/2}^{\rm dir}(M,S)\bigr)^{2/3}
 \delta^{1/3}.
\tag{PH.6}
\]

The current separate-time merger estimate corresponds to the energy cost

\[
 \mathcal E_{3/2}^{\rm dir}(M,S_M)
 \ll M^{1/4+o(1)}.
\]

Therefore the exact incremental substitute for `SW.UP.49` is

\[
 \boxed{
 \mathcal E_{3/2}^{\rm dir}(M,S_M)
 \le M^{\beta+o(1)}
 \quad\text{for one fixed }\beta<\frac14.
 }
\tag{UFP.Ebeta}

Indeed, (PH.6) and `delta=M^(-A kappa+o(1))` give decay as soon as

\[
 A\kappa>2\beta.
\]

Taking `beta<.245` yields the desired threshold

\[
 A>\frac{.49}{1-H_2(\log_3 2)}=9.791291\ldots.
\]

The stronger q-only theorem

\[
 \boxed{
 \mathcal E_{3/2}^{\rm dir}(M,S)
 \le C(S+1)^B
 }
\tag{UFP.Epoly}

uniformly in the outer shell would remove the square-root time loss entirely
and would imply fixed-polylogarithmic descent for every fixed `A>0` after
reassembly.  This consequence is much stronger than the first benchmark and
must not be treated as proved or as the mandatory first target.

## 8. Correct interpretation of the PCA proposal

For each arrival time `h`, let `F_h` be the landing profile.  The generic
proof compares

\[
 \left\|\sum_hF_h\right\|_{3/2}^{3/2}
\]

with the separate tagged energies and pays the number of feasible times.
The finite time-by-3-adic matrices have a large common right profile.  A rank
one common component is expensive under the tagged comparison even though it
should be summed before taking the norm.

The rigorous replacement is a physical common-profile/Markov-renewal
decomposition, not a numerical rotation:

\[
 F_h=a_h\pi_S+R_h,
\tag{PH.7}
\]

where `pi_S` is defined independently of the current outer shell and time,
has controlled `3/2` energy, and the aggregated residual has a strict
spectral saving.  A sufficient theorem is, schematically,

\[
 \|\pi_S\|_{L^{3/2}(U_S)}^{3/2}\le\operatorname{poly}(S),
\qquad
 \left\|\sum_hR_h\right\|_{L^{3/2}(U_S)}^{3/2}
 \le M^{1/4-\varepsilon+o(1)}.
\tag{PH.8}
\]

The exact killed operator

\[
 (Q_Yf)(z)=f(2z)
 +\mathbf1_{z\equiv2\ (3)}
  \mathbf1_{(2z-1)/3>Y}
  f((2z-1)/3)
\]

and boundary operator `(B_Yf)(y)=f(2y)` supply the physical recurrence.  The
required spectral state is two-dimensional:

1. Archimedean height/mantissa above the killing boundary;
2. generated 3-adic phase.

The symbolic affine walk alone does not close (PH.8).  A commuting transfer
or a direct Markov-renewal theorem for the physical killed operator is still
required.

## 9. Closeout

```text
NEW PROVED-PAPER IDENTITY:
  exact 3-adic martingale/Haar diagonal pairing (PH.2)-(PH.3).

STRICTLY NARROWED:
  the user's PCA proposal is a common-profile Markov-renewal problem;
  fixed low-rank PCA is empirically rejected;
  the exact incremental energy burden is beta<1/4 in UFP.Ebeta.

EMPIRICAL:
  literal target near-neutral or negatively aligned in tested rows;
  adversarial target detected with near-unit coherence;
  fixed-S physical landing profiles converge rapidly across outer shells;
  merged maximum and 3/2 energy remain small at accessible ranks.

EQUALLY HARD:
  all-scale physical/projective transfer after bit exhaustion;
  a spectral or renewal estimate uniform when S=O(log M).

REJECTED / SCOPED KILLS:
  fixed-number-of-modes PCA;
  absolute Fourier/Haar summation;
  symbolic mixing without a physical commuting theorem;
  treating the finite maximum-load trend as an all-depth theorem.

ACTIVE ROUTE:
  UFP.Ebeta for one beta<1/4 through a physical common-profile decomposition.

FALLBACK:
  the target-specific signed Haar sum (PH.2), with all scales retained.

ROUTE DECISION:
  ALIVE / NARROWED.  No manuscript, Main theorem, or Lean status change.

RESUME ONLY WITH:
  an exact common-profile recurrence for the physical killed operator;
  a Markov-renewal/spectral inequality giving beta<1/4;
  or an explicit physical inverse-tree family forcing beta>=1/4.
```

## 10. Common-profile interpolation milestone

The common-profile route does not need pointwise convergence of the direct
landing law.  A weak event-uniform comparison already gives the strict
energy saving required by Phase 3.

Let `U_S` be uniform probability on `J_S`.  Let `f >= 0` be the
unnormalized direct landing density with respect to `U_S`, and suppose that
`pi >= 0` is a common reference density.  Assume

\[
 \int f\,dU_S\le 1,\qquad
 \int \pi\,dU_S\le 1,\qquad
 \int\pi^{3/2}\,dU_S\le E_0,
\tag{CP.1}
\]

\[
 \sup_{E\subseteq J_S}
 \left|\int_E(f-\pi)\,dU_S\right|
 \le \varepsilon,
 \qquad
 \|f\|_\infty\le L.
\tag{CP.2}
\]

Then the finite Hahn decomposition gives, for the positive excess
`r_+=(f-pi)_+`,

\[
 \int r_+\,dU_S\le\varepsilon.
\tag{CP.3}
\]

Moreover `r_+<=f<=L` and `f<=pi+r_+`.  Since

\[
 (a+b)^{3/2}
 \le \sqrt2\,(a^{3/2}+b^{3/2})
 \qquad(a,b\ge0),
\]

and therefore

\[
\begin{aligned}
 \int f^{3/2}\,dU_S
 &\le
 \sqrt2\int\pi^{3/2}\,dU_S
 +\sqrt2\int r_+^{3/2}\,dU_S\\
 &\le
 \sqrt2 E_0
 +\sqrt2\,\varepsilon\sqrt L.
\end{aligned}
\tag{CP.4}
\]

This is an exact deterministic inequality.  It preserves rare large fibers:
the common profile is charged in its native `3/2` energy, while only the
positive non-common excess pays the product of its square-root height and
its total mass.  No pointwise bound on `pi` is assumed.

For the direct switch law, the proved tagged-fiber cap and the compressed
time support give

\[
 L\le M^{1/2+o(1)}.
\tag{CP.5}
\]

Consequently, the common-profile theorem

\[
 \boxed{
 \sup_{E\subseteq J_{S_M}}
 \left|\mu^{\rm dir}_{M,S_M}(E)-\Pi_{M,S_M}(E)\right|
 \le M^{-d+o(1)},
 \qquad
 \int\left(\frac{d\Pi_{M,S_M}}{dU_{S_M}}\right)^{3/2}dU_{S_M}
 \le (S_M+1)^{O(1)}
 }
\tag{UFP.CP_d}
\]

implies

\[
 \boxed{
 \mathcal E_{3/2}^{\rm dir}(M,S_M)
 \le M^{1/4-d+o(1)}+O(1).
 }
\tag{CP.6}
\]

Thus `UFP.CP_d` proves `UFP.Ebeta` with

\[
 \beta=\max\{0,1/4-d\}.
\tag{CP.7}
\]

If

\[
 \kappa_*=1-H_2(\log_3 2)=0.0500444728\ldots,
\]

the resulting fixed-polylog threshold is

\[
 \boxed{
 A>\frac{1/2-2d}{\kappa_*}
 }
\tag{CP.8}
\]

when `0<d<1/4`.  In particular:

| profile exponent `d` | energy exponent `beta` | strict threshold for `A` |
|---:|---:|---:|
| `0` | `.25` | `9.991113...` |
| `.005` | `.245` | `9.791291...` |
| `.01` | `.24` | `9.591469...` |
| `d -> (5/143)^-` | `beta -> .2150349...` | `A -> 8.593755...` from above |

So the first Phase-3 benchmark requires only a fixed common-profile rate
`d>.005`; it does not require a maximum-fiber theorem or a full q-only
energy bound.

## 11. Transfer audit for the phase mechanism

The common-profile proof in the natural-counting transport architecture has
the analytic rate

\[
 n^{-1/(2\kappa)}(\log n)^{1-1/(2\kappa)},
\tag{CP.9}
\]

where `n` is the valuation-tube scale and the phase input is

\[
 \|q\log_2 3\|_{\mathbb R/\mathbb Z}
 \ge c q^{1-\kappa}.
\]

The checked Rhin value is `kappa=143/10`, hence every strict

\[
 d<\frac1{2\kappa}=\frac5{143}=0.034965\ldots
\tag{CP.10}
\]

is compatible with the phase estimate.  The local Gaussian error is of
order `n^(-1/2) polylog(n)` and is not binding.

This analytic calculation transfers to the long-switch geometry only if
the physical tube is parameterized by the outer logarithmic gap

\[
 G=M-S_M\asymp M,
\]

rather than by the terminal rank `S_M=O(log M)`.  With `n asymp G`, (CP.9)
is a power of `M`; with `n asymp S_M`, it is only a power of `log M` and is
too weak for (UFP.CP_d).

The reusable exact affine kernel is

\[
 Z_m(F)=\sum_{z\in F}\frac{3^m p_m(z\bmod3^m)}z,
\tag{CP.11}
\]

where `p_m` is the correction-residue law of an iid positive-geometric
terminal valuation suffix.  The corresponding subcritical `3/2` profile,
not a maximum-fiber bound, is the proposed `Pi` in (UFP.CP_d).  The long
prefix is supposed to contribute only the scalar phase multiplier; after
normalization that multiplier has one common center.  A mere scalar cap on
`Z_m(F)` is not a pointwise density bound and cannot replace the displayed
`3/2`-energy condition.

The external common-profile theorem itself cannot simply be cited as
`UFP.CP_d`: its printed source blocks have a fixed small power gap above the
target.  Our switch has outer gap `M-S_M asymp M`.  What transfers is the
finite affine/Gaussian/phase calculation.  What remains to prove locally is
the following one statement.

\[
 \boxed{
 \begin{minipage}{0.86\linewidth}
 Reconstruct the literal long-switch first-passage law from an
 `O(sqrt(M log M))` outer-gap valuation tube and the common terminal suffix
 kernel (CP.11), with total event-uniform error `M^{-d+o(1)}` for one
 `d>.005`.
 \end{minipage}
 }
\tag{CP.RECON}
\]

All incomplete source-band endpoints, terminal coverage, exact-to-nominal
mass replacement, and the initial powers-of-two fibers must remain in this
reconstruction.  None may be hidden in the common kernel.

The proof-state update is therefore:

```text
COMMON-PROFILE -> ENERGY INTERPOLATION (CP.4):  PROVED-PAPER;
UFP.CP_d -> UFP.E_(1/4-d):                     PROVED-PAPER;
UFP.CP_d -> improved fixed-polylog threshold:  PROVED-PAPER;
phase-rate capacity d<5/143:                   VERIFIED ANALYTIC CAPACITY;
long-switch physical reconstruction CP.RECON: OPEN;
Phase-3 headline improvement:                  NOT YET PROVED.
```

## 12. Exact removal of the initial powers-of-two fibers

One part of `CP.RECON` can be discharged without an estimate.  Let

\[
 I_M=[2^M,2^{M+1})\cap\mathbb N,
 \qquad B=2^S,
 \qquad S<M.
\]

Partition `I_M` by the initial 2-adic valuation.  For `0<=v<M`, division by
`2^v` is a bijection from

\[
 \{n\in I_M:v_2(n)=v\}
\]

onto the odd integers in `I_(M-v)`, and this fiber has cardinality
`2^(M-v-1)`.  Hence its normalized source weight is exactly

\[
 w_v=2^{-v-1}.
\tag{CP.12}
\]

For `v<=M-S`, the odd core `u=n/2^v` is still above `B` (at the endpoint
`v=M-S`, `u` is odd whereas `B` is even).  The first `v` shortcut steps are
pure halvings, so

\[
 \tau_B(n)=v+\tau_B(u),
 \qquad
 T^{\tau_B(n)}(n)=T^{\tau_B(u)}(u).
\tag{CP.13}
\]

All remaining sources hit `B` during the initial halving string.  Their
total normalized mass is exactly

\[
 r_{M,S}
 =1-\sum_{v=0}^{M-S}2^{-v-1}
 =2^{S-M-1}.
\tag{CP.14}
\]

Equivalently, each all-even first-passage landing in `(B/2,B]` has at most
one source in the dyadic shell, giving the same bound directly.

Let `mu_(M,S)` be the full-shell direct landing submeasure and
`mu^odd_(K,S)` the normalized direct landing submeasure from odd sources in
`I_K`.  Equations (CP.12)--(CP.14) give the exact convex disintegration

\[
 \boxed{
 \mu_{M,S}
 =\sum_{v=0}^{M-S}2^{-v-1}\mu^{\rm odd}_{M-v,S}
  +R_{M,S},
 \qquad
 R_{M,S}(J_S)\le2^{S-M-1}.
 }
\tag{CP.15}
\]

This disintegration preserves a common profile without a valuation-count
loss.  More precisely, suppose one density `Pi_S` of mass at most one
satisfies, uniformly for `K>=M/2`,

\[
 \sup_E|\mu^{\rm odd}_{K,S}(E)-\Pi_S(E)|
 \le C K^{-d}.
\tag{CP.16}
\]

For `S=o(M)`, split (CP.15) at `v=floor(M/2)`.  The first part costs at most
`C 2^d M^(-d)`.  The geometric weight of the second part is
`O(2^(-M/2))`; using the trivial unit event bound there, and also charging
`R_(M,S)` together with the omitted common-profile mass, gives

\[
 \boxed{
 \sup_E|\mu_{M,S}(E)-\Pi_S(E)|
 \le C2^dM^{-d}+O(2^{-M/2}+2^{S-M}).
 }
\tag{CP.17}
\]

Therefore the full-shell common-profile theorem reduces rigorously to its
odd-source version on outer ranks `K>=M/2`.  No uniform theorem is required
for the exponentially downweighted small odd cores, and the initial
powers-of-two channel cannot consume the desired polynomial saving.

```text
CP.RECON COMPONENT STATUS:
  initial 2-adic disintegration:          PROVED-PAPER;
  convex mixing without fiber-count loss: PROVED-PAPER;
  all-even boundary mass:                 PROVED-PAPER, exponentially small;
  odd-source outer-gap common profile:    OPEN / load-bearing.
```

## 13. Two-scale physical Cauchy socket

The ideal profile in `UFP.CP_d` need not have a separately proved energy
bound.  It can be replaced by the physical direct law at one intermediate
outer rank.

Let `f_(M,S)` and `f_(K,S)` be the unnormalized direct landing densities on
the same target band `J_S`, for `S<K<M`.  Suppose the already proved
baseline estimates give

\[
 \int f_{K,S}^{3/2}\,dU_S\le K^{1/4+o(1)},
 \qquad
 \|f_{M,S}\|_\infty\le M^{1/2+o(1)}.
\tag{CP.18}
\]

Assume only the two-scale, event-uniform comparison

\[
 \boxed{
 \sup_{E\subseteq J_S}
 \left|\mu^{\rm dir}_{M,S}(E)-\mu^{\rm dir}_{K,S}(E)\right|
 \le K^{-d+o(1)}.
 }
\tag{UFP.CAUCHY_d}
\]

Apply (CP.4) with `pi=f_(K,S)`, observing that the proof of (CP.4) uses
only the `3/2` energy of `pi`, not a pointwise cap.  This gives

\[
 \mathcal E_{3/2}^{\rm dir}(M,S)
 \le
 K^{1/4+o(1)}
 +K^{-d+o(1)}M^{1/4+o(1)}.
\tag{CP.19}
\]

Choose

\[
 K=\lceil M^\lambda\rceil,
 \qquad
 \lambda=\frac1{1+4d}.
\tag{CP.20}
\]

The two powers in (CP.19) are then equal, and

\[
 \boxed{
 \mathcal E_{3/2}^{\rm dir}(M,S_M)
 \le M^{\beta(d)+o(1)},
 \qquad
 \beta(d)=\frac1{4(1+4d)}<\frac14.
 }
\tag{CP.21}
\]

This argument permits the common physical component to contain arbitrarily
large rare fibers.  They occur in both `f_(M,S)` and `f_(K,S)` and are paid
through the baseline energy at rank `K`; only the positive scale-to-scale
remainder is interpolated.

The Phase-3 benchmark `beta<.245` is equivalent to

\[
 \boxed{d>\frac1{196}=0.0051020408\ldots.}
\tag{CP.22}
\]

As `d` tends to the strict phase cap `5/143` from below,

\[
 \beta=\frac{143}{652}=0.21932515\ldots,
 \qquad
 A>8.765210\ldots.
\tag{CP.23}
\]

The cap itself is not claimed: the analytic phase theorem supplies every
strict `d<5/143`.  Accordingly, (CP.23) is a limiting threshold approached
from above.

The canonical open theorem should therefore be the two-scale physical
statement `UFP.CAUCHY_d`, not a maximum theorem and not a theorem asserting
bounded energy of an ideal common profile.  Its quantifiers are only those
consumed by the schedule:

```text
S = S_M = O(log M);
K = ceil(M^(1/(1+4d)));
one fixed d > 1/196;
the literal direct first-passage laws on J_S;
all endpoint events E, so positive excess is retained only after comparison.
```

The empirical fixed-`S` total-variation stabilization in section 5 tests
this theorem in the correct direction, but does not prove its moving
`S=O(log M)`, all-depth form.

```text
NEW CANONICAL PRODUCER:
  UFP.CAUCHY_d for one d>1/196.

PROVED CONSEQUENCES:
  UFP.CAUCHY_d -> beta=1/[4(1+4d)];
  d>1/196 -> alpha<.49 time-support replacement;
  d=5/143 capacity -> potential A>8.765210... .

OPEN:
  the physical two-scale comparison itself.
```
