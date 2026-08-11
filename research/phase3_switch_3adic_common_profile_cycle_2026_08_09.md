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
  improve the fixed-polylog threshold A>9.991113...; first benchmark
  A>9.791291..., corresponding to the old transport benchmark alpha=.49.

CURRENT WEAKEST-CONSUMER FORM:
  natural-density headline:
    [mu^sch_(M,S)(C^st) - mu^sch_(M^lambda,S)(C^st)]_+
      <= delta_(S,L) + o(1);
  quantitative logarithmic exceptional rate:
    [mu^sch_(M,S)(C^st) - mu^sch_(M^lambda,S)(C^st)]_+
      <= delta_(S,L) + M^(-lambda*d+o(1))
    for one lambda<.98 and one d>0.
  Either form, together with the already proved intermediate-scale
  fractional-moment bound, directly yields the first strict threshold
  improvement at the corresponding level of quantitative precision.  The
  older SW.COMP.49 statement remains a stronger, optional transport theorem
  rather than the mandatory target.

NOT THE TARGET:
  arbitrary-target equidistribution;
  a maximum fixed-correction-fiber theorem;
  an all-depth generated checkpoint theorem;
  a numerical PCA fit.

TARGET-SANITY:
  FEASIBLE as a direct final consumer.  The current theorem is recovered at
  lambda=1; every fixed lambda<.98 would lower the fixed-polylog threshold
  to at most 9.791291... .

KILL TEST FOR THE PRESENT MECHANISM:
  if a generated all-depth family keeps the positive scale-to-scale target
  excess bounded away from zero, the natural-density mechanism fails.  If
  it decays but more slowly than every power of M, only the quantitative
  power-rate mechanism fails.
  Failure of fixed low-rank PCA alone kills only that representation.
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

## 7. Mechanism-distinct producer: schedule-restricted merged `3/2` energy

The energy producer must retain the two restrictions used by the proved
transport theorem.  Let `H_(M,S)` be the feasible cumulative-time support
for the prescribed schedule and let `D_S` be its proved reverse-loss cap.
Define

\[
 F^{\rm sch}_{M,S}(y)
 =\#\{n\in I_M:\tau_{2^S}(n)\in\mathcal H_{M,S},\quad
       T^{\tau_{2^S}(n)}(n)=y,\quad
       \operatorname{Loss}_{2^S}(n)\le D_S\}.
\tag{PH.5a}
\]

The generated switch sources satisfy these restrictions, so their landing
profile is pointwise dominated by `F^sch`.  This is the correct ambient law;
the unrestricted direct first-passage law does not have the proved
`M^(1/2+o(1))` pointwise density cap.

Let the unnormalized schedule-restricted landing density be

\[
 \varphi^{\rm sch}_{M,S}(y)
 =\frac{|J_S|}{2^M}F^{\rm sch}_{M,S}(y).
\]

Define

\[
 \mathcal E_{3/2}^{\rm sch}(M,S)
 =\mathbb E_{U_S}[(\varphi^{\rm sch}_{M,S})^{3/2}].
\tag{PH.5}
\]

For any target `C` of uniform density `delta`, pointwise domination and
Holder give

\[
 \frac1{2^M}\sum_{y\in C}F(y)
 \le
 \bigl(\mathcal E_{3/2}^{\rm sch}(M,S)\bigr)^{2/3}
 \delta^{1/3}.
\tag{PH.6}
\]

The support-sensitive tagged-fiber estimate gives

\[
 \|\varphi^{\rm sch}_{M,S_M}\|_\infty
 \le M^{1/2+o(1)}
\tag{PH.6a}
\]

because `#H_(M,S_M)<=M^(1/2+o(1))` and all remaining loss and terminal-rank
factors are polylogarithmic.  Since the density has mass at most one, this
also gives the baseline energy cost

\[
 \mathcal E_{3/2}^{\rm sch}(M,S_M)
 \ll M^{1/4+o(1)}.
\]

Therefore the exact incremental substitute for `SW.UP.49` is

\[
 \boxed{
 \mathcal E_{3/2}^{\rm sch}(M,S_M)
 \le M^{\beta+o(1)}
 \quad\text{for one fixed }\beta<\frac14.
 }
\tag{UFP.Ebeta}
\]

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
 \mathcal E_{3/2}^{\rm sch}(M,S)
 \le C(S+1)^B
 }
\tag{UFP.Epoly}
\]

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

## 9. First-cycle closeout (superseded by the typed audit in sections 12--15)

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

ACTIVE ROUTE AT THIS CHECKPOINT:
  UFP.Ebeta for one beta<1/4 through a physical common-profile decomposition.
  Sections 12--15 later replace this by a typed schedule law and a weaker
  target-only scale-comparison consumer.

FALLBACK:
  the target-specific signed Haar sum (PH.2), with all scales retained.

ROUTE DECISION AT THIS CHECKPOINT:
  ALIVE / NARROWED.  No manuscript, Main theorem, or Lean status change.

RESUME ONLY WITH:
  an exact common-profile recurrence for the physical killed operator;
  a Markov-renewal/spectral inequality giving beta<1/4;
  or an explicit physical inverse-tree family forcing beta>=1/4.
```

## 10. Common-profile interpolation milestone

The common-profile route does not need pointwise convergence of the
schedule-restricted landing law.  A weak event-uniform comparison already
gives the strict energy saving required by Phase 3.

Let `U_S` be uniform probability on `J_S`.  Let `f >= 0` be an
unnormalized schedule-restricted landing density with respect to `U_S`, and
suppose that `pi >= 0` is a common reference density.  Assume

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

For the schedule-restricted switch law, the proved tagged-fiber cap and the
compressed time support give

\[
 L\le M^{1/2+o(1)}.
\tag{CP.5}
\]

Consequently, the common-profile theorem

\[
 \boxed{
 \sup_{E\subseteq J_{S_M}}
 \left|\mu^{\rm sch}_{M,S_M}(E)-\Pi_{M,S_M}(E)\right|
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
 \mathcal E_{3/2}^{\rm sch}(M,S_M)
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

## 12. Initial powers of two: unrestricted and schedule-tagged laws

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

First ignore the schedule time and loss filters.  Let `mu_(M,S)` be the
unrestricted full-shell direct landing submeasure and `mu^odd_(K,S)` the
normalized unrestricted direct landing submeasure from odd sources in
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

This unrestricted identity does **not** by itself feed the Phase-3 energy
producer: the square-root density cap belongs to the schedule-restricted
law.  The filters must be transported as part of the identity.

Let `mu^(H,D)_(M,S)` be the direct landing submeasure restricted by

\[
 \tau_{2^S}(n)\in\mathcal H,
 \qquad
 \operatorname{Loss}_{2^S}(n)\le D,
\]

and define

\[
 \mathcal H-v=\{h-v:h\in\mathcal H,\ h\ge v\}.
\tag{CP.15a}
\]

The first `v` steps of `n=2^v u` are even, hence contribute zero reverse
loss.  Using (CP.13), one obtains the exact filter-preserving identities

\[
 \operatorname{Loss}_{2^S}(n;v+h)
 =\operatorname{Loss}_{2^S}(u;h),
 \qquad
 v+h\in\mathcal H\iff h\in\mathcal H-v.
\tag{CP.15b}
\]

Therefore

\[
 \boxed{
 \mu^{\mathcal H,D}_{M,S}
 =\sum_{v=0}^{M-S}2^{-v-1}
   \mu^{{\rm odd},\,\mathcal H-v,D}_{M-v,S}
  +R^{\mathcal H,D}_{M,S},
 \qquad
 R^{\mathcal H,D}_{M,S}(J_S)\le2^{S-M-1}.
 }
\tag{CP.15H}
\]

This is the typed disintegration required by the schedule law.  It exposes
a new interface obligation: the inherited odd-source law uses the translated
support `H-v`, not the independently constructed support `H_(M-v,S)`.

The translation family can nevertheless be truncated exactly.  For any
integer `V` with `0<=V<=M-S`, the total omitted geometric weight in
(CP.15H) is at most `2^(-V-1)`.  Thus

\[
 \mu^{\mathcal H,D}_{M,S}
 =\sum_{v=0}^{V}2^{-v-1}
   \mu^{{\rm odd},\,\mathcal H-v,D}_{M-v,S}
  +R^{\mathcal H,D}_{M,S,V},
 \qquad
 R^{\mathcal H,D}_{M,S,V}(J_S)
 \le2^{-V-1}+2^{S-M-1}.
\tag{CP.15T}
\]

Taking `V=ceil(B log_2 M)` makes this error `O(M^(-B))`.  Consequently the
initial-valuation interface needs control of only `O(log M)` translated
supports, not all `M-S+1` valuation classes.  This is an exact reduction,
not the missing common-profile estimate.

```text
CP.RECON COMPONENT STATUS:
  unrestricted 2-adic disintegration:       PROVED-PAPER;
  schedule-tagged disintegration CP.15H:    PROVED-PAPER;
  logarithmic translation truncation:       PROVED-PAPER;
  all-even boundary mass:                   PROVED-PAPER, exponentially small;
  translated-support profile comparison:    OPEN / load-bearing;
  odd-source outer-gap common profile:      OPEN / load-bearing.
```

## 13. Typed two-scale physical Cauchy socket

The ideal profile in `UFP.CP_d` need not have a separately proved energy
bound.  It can be replaced by the physical **schedule-restricted** law at
one intermediate outer rank.  This restriction is load-bearing.

Let `f^sch_(M,S)` and `f^sch_(K,S)` be the unnormalized landing densities on
the same target band `J_S`, using their declared feasible-time supports and
reverse-loss caps, for `S<K<M`.  The support-sensitive transport theorem
gives the baseline estimates

\[
 \int (f^{\rm sch}_{K,S})^{3/2}\,dU_S\le K^{1/4+o(1)},
 \qquad
 \|f^{\rm sch}_{M,S}\|_\infty\le M^{1/2+o(1)},
\tag{CP.18}
\]

provided the intermediate law has a feasible-time support of cardinality
`K^(1/2+o(1))` and `S=O(log K)`.  The proved duration-corridor theorem is
uniform in the target rank, so this condition is available for every fixed
scale relation `K=M^lambda`, after enlarging the fixed switch constant by a
factor depending on `lambda`.  It is not available for the unrestricted
direct law, whose free time horizon has linear rather than square-root size.

For fixed `d>0` and `0<lambda<1`, set `K=ceil(M^lambda)`.  The typed open
comparison is

\[
 \boxed{
 \sup_{E\subseteq J_S}
 \left|\mu^{\rm sch}_{M,S}(E)-\mu^{\rm sch}_{K,S}(E)\right|
 \le K^{-d+o(1)}.
 }
\tag{UFP.CAUCHY^{sch}_{d,\lambda}}
\]

Here both schedule supports, both loss caps, and the normalization by the
corresponding full source shell are part of the theorem statement.  In
particular, (CP.15H) does not prove this comparison: it produces translated
supports `H_(M,S)-v`, which need not equal `H_(K,S)`.  Proving that their
aggregate landing shapes agree, or charging the support mismatch, is part of
the open physical reconstruction.

Apply (CP.4) with `pi=f^sch_(K,S)`, observing that the proof of (CP.4) uses
only the `3/2` energy of `pi`, not a pointwise cap.  This gives

\[
 \mathcal E_{3/2}^{\rm sch}(M,S)
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
 \mathcal E_{3/2}^{\rm sch}(M,S_M)
 \le M^{\beta(d)+o(1)},
 \qquad
 \beta(d)=\frac1{4(1+4d)}<\frac14.
 }
\tag{CP.21}
\]

This argument permits the common physical component to contain arbitrarily
large rare fibers.  They occur in both `f^sch_(M,S)` and `f^sch_(K,S)` and
are paid through the baseline energy at rank `K`; only the positive
scale-to-scale remainder is interpolated.

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

For the `3/2` benchmark, optimize by taking
`lambda=1/(1+4d)`.  The canonical open theorem should therefore be the typed
two-scale physical statement `UFP.CAUCHY^sch_(d,lambda)`, not a maximum
theorem and not a theorem asserting bounded energy of an ideal common
profile.  Its quantifiers are only those consumed by the schedule:

```text
S = S_M = O(log M);
K = ceil(M^lambda), lambda=1/(1+4d);
one fixed d > 1/196;
the literal schedule-restricted first-passage laws on J_S;
all endpoint events E, so positive excess is retained only after comparison.
```

The empirical fixed-`S` total-variation stabilization in section 5 tests
this theorem in the correct direction, but does not prove its moving
`S=O(log M)`, all-depth form.

```text
NEW CANONICAL PRODUCER:
  UFP.CAUCHY^sch_(d,lambda) for one d>1/196 and
  lambda=1/(1+4d).

PROVED CONSEQUENCES:
  UFP.CAUCHY^sch_(d,lambda) -> beta=1/[4(1+4d)];
  d>1/196 -> alpha<.49 time-support replacement;
  d=5/143 capacity -> potential A>8.765210... .

OPEN:
  the physical two-scale comparison itself;
  translated-support alignment exposed by CP.15H.
```

## 14. Weakest-consumer reset: compare only the literal stopped target

The event-uniform comparison in section 13 is stronger than the fixed-
polylogarithmic consumer needs.  Let

\[
 C=C^{\rm st}_{S,L}=C^-_{S,L}\sqcup C^+_{S,L}\subseteq J_S,
 \qquad
 \delta_{S,L}=\frac{|C|}{|J_S|}
 \le M^{-A\kappa_*+o(1)}
\tag{TC.1}
\]

be the literal stopped composite target used by the terminal schedule: the
terminal-lower channel together with the upper/timeout channel.  If one of
these channels has already been charged separately, the argument below may
use the remaining channel alone.  For fixed `0<lambda<1`, put
`K=ceil(M^lambda)`.  The smaller open input is the one-sided, one-event
comparison

\[
 \boxed{
 \left[
 \mu^{\rm sch}_{M,S}(C)-\mu^{\rm sch}_{K,S}(C)
 \right]_+
 \le \delta_{S,L}+K^{-d+o(1)}
 \quad\text{for one fixed }d>0.
 }
\tag{UFP.TARGET_{d,\lambda}}
\]

No comparison is requested on any other endpoint event.  The target, switch
rank, loss cap, feasible-time support, and full-shell normalization are all
literal.  The intermediate law uses the same subset `C` of `J_S`; only the
outer source shell and its declared schedule support change.

This input already improves the final theorem.  For any fixed moment order
`s>1`, the proved pointwise schedule cap gives

\[
 \mathcal E_s^{\rm sch}(K,S)
 \le K^{(s-1)/2+o(1)}.
\tag{TC.2}
\]

Holder at the intermediate scale gives

\[
 \mu^{\rm sch}_{K,S}(C)
 \le
 K^{(s-1)/(2s)+o(1)}
 \delta_{S,L}^{(s-1)/s}.
\tag{TC.3}
\]

Combining (TC.1)--(TC.3),

\[
 \boxed{
 \mu^{\rm sch}_{M,S}(C)
 \le
 M^{-\frac{s-1}{s}(A\kappa_*-\lambda/2)+o(1)}
 +M^{-A\kappa_*+o(1)}
 +M^{-\lambda d+o(1)}.
 }
\tag{TC.4}
\]

Thus the terminal failure density tends to zero whenever

\[
 \boxed{A>\frac{\lambda}{2\kappa_*}.}
\tag{TC.5}
\]

The moment order cancels from the threshold; it changes only the convergence
rate.  This calculation uses no energy interpolation at the outer scale.
In particular, any fixed `lambda<.98` and any fixed `d>0` give the first
benchmark

\[
 A>\frac{.49}{\kappa_*}=9.791291\ldots.
\tag{TC.6}
\]

This is a direct consumer-level bypass of `SW.COMP.49`, not a proof of that
stronger source-weighted transport statement.

### Anti-circularity and target-sanity card

```text
OLD TARGET:
  SW.COMP.49, a relative M^.49-times-target-density transport estimate.

NEW TARGET:
  UFP.TARGET_(d,lambda), one-sided comparison of the one literal target
  between outer scales M and K=M^lambda.

IMPLICATION:
  UFP.TARGET_(d,lambda) + the already proved intermediate-scale fractional
  moment bound imply the terminal failure estimate TC.4 and hence the
  fixed-polylog theorem for A>lambda/(2 kappa_*).

STRICTLY EASIER BURDEN:
  no all-event total variation; no outer-scale energy improvement; no
  relative control by delta; no statement for arbitrary targets.

INFORMATION DISCARDED:
  the transport exponent and every endpoint event other than the actual
  stopped target.  The new theorem does not imply SW.COMP.49.

NEW INGREDIENT:
  one-sided physical scale-to-scale anti-enrichment for the literal target.

FAILURE MODE / KILL TEST:
  a generated sequence on which
  the centered scale-difference pairing defined in section 16 stays
  positive by more than every power of M.  Finite data can reject a proposed
  recurrence but cannot kill the all-depth statement by itself.

TARGET-SANITY:
  FEASIBLE as a direct headline consumer.  It is weaker than the all-event
  Cauchy socket and makes no claim about an improved transport exponent.
```

## 15. General fractional-moment audit of the stronger Cauchy socket

The all-event theorem from section 13 remains useful as a stronger producer,
but its true conditional payoff is larger than the original `3/2` benchmark.
Let `s=1+t>1` and put

\[
 \gamma=\frac{s-1}{2}=\frac t2.
\tag{FM.1}
\]

The pointwise cap and unit mass give the baseline

\[
 \mathcal E_s^{\rm sch}(X,S)\le X^{\gamma+o(1)}.
\tag{FM.2}
\]

If `UFP.CAUCHY^sch_(d,lambda)` holds, the deterministic interpolation proof
of (CP.4), now using
`(a+b)^s<=2^(s-1)(a^s+b^s)`, gives

\[
 \mathcal E_s^{\rm sch}(M,S)
 \le
 M^{\lambda\gamma+o(1)}
 +M^{\gamma-\lambda d+o(1)}.
\tag{FM.3}
\]

For a theorem available at the balancing scale

\[
 \lambda=\frac{\gamma}{\gamma+d},
\]

the resulting energy exponent is

\[
 \boxed{
 \beta_s=\frac{\gamma^2}{\gamma+d}.
 }
\tag{FM.4}
\]

Target Holder then closes when

\[
 \boxed{
 A>
 \frac{\beta_s}{\kappa_*(s-1)}
 =\frac{\gamma}{2\kappa_*(\gamma+d)}.
 }
\tag{FM.5}
\]

For fixed `d>0`, the right side tends to zero as `s` tends to one from
above.  Therefore a **parameter-uniform** version of the all-event Cauchy
theorem, available at the corresponding fixed `lambda` for each requested
`A`, would imply fixed-polylogarithmic descent for every fixed `A>0`.

This is only a derived conditional consequence.  One theorem at the
`3/2`-optimized value `lambda=1/(1+4d)` does not supply the other scales.
The parameter-uniform strengthening is classified
`OUT-OF-SCOPE-STRONG` relative to the `.49` benchmark and is not silently
adopted as the current burden.

```text
STATUS AFTER THE TYPED AUDIT:
  schedule/unrestricted law split:                 PROVED-PAPER;
  filter-preserving disintegration CP.15H:         PROVED-PAPER;
  logarithmic valuation-tail truncation CP.15T:    PROVED-PAPER;
  target-only implication TC.4--TC.6:              PROVED-PAPER;
  general-s interpolation FM.3--FM.5:              PROVED-PAPER;
  UFP.TARGET_(d,lambda) for any useful pair:       OPEN;
  UFP.CAUCHY^sch_(d,lambda):                       OPEN / stronger;
  parameter-uniform Cauchy family:                 OPEN / OUT-OF-SCOPE-STRONG;
  Phase-3 headline improvement:                    NOT YET PROVED.

NEXT EXACT TARGET:
  first prove the centered target pairing is o(1) for one fixed lambda<.98;
  then seek UFP.TARGET_(d,lambda) for one fixed d>0 if the quantitative
  logarithmic exceptional rate is to be preserved.  Retain translated time
  supports and take the positive part only after the two physical scales
  are compared.
```

## 16. Exact centered two-scale Haar reduction

There is no need to force the total masses of the two schedule-restricted
laws to agree.  Let

\[
 f_M=\frac{d\mu^{\rm sch}_{M,S}}{dU_S},
 \qquad
 f_K=\frac{d\mu^{\rm sch}_{K,S}}{dU_S},
 \qquad
 m_X=\int f_X\,dU_S,
\]

and put `g=1_C-delta`, where `delta=|C|/|J_S|`.  Then exactly

\[
 \mu^{\rm sch}_{M,S}(C)-\mu^{\rm sch}_{K,S}(C)
 =\delta(m_M-m_K)+\mathbb E_{U_S}[(f_M-f_K)g].
\tag{TH.1}
\]

Since both masses lie in `[0,1]`, the positive contribution of the first
term is at most `delta`.  Hence `UFP.TARGET_(d,lambda)` follows from the
strictly smaller centered statement

\[
 \boxed{
 \left[
 \mathbb E_{U_S}[(f_M-f_K)
   (\mathbf1_C-\delta)]
 \right]_+
 \le K^{-d+o(1)}.
 }
\tag{UFP.CENTER_{d,\lambda}}
\]

This is why the harmless `delta` term was retained in the raw target
comparison.  Demanding convergence of total schedule mass would add an
unused theorem.

The 3-adic martingale calculation in section 2 applies to the signed
density `f_M-f_K`.  Let

\[
 q_a=\mathbb E[f_M-f_K\mid\mathcal A_a],
 \qquad
 g_a=\mathbb E[g\mid\mathcal A_a].
\]

For a terminal depth `A` whose residue partition separates `J_S`, unequal
martingale depths are orthogonal and therefore

\[
 \boxed{
 \mathbb E_{U_S}[(f_M-f_K)g]
 =\sum_{a=1}^{A}
   \mathbb E_{U_S}[(q_a-q_{a-1})(g_a-g_{a-1})].
 }
\tag{TH.2}
\]

Unlike (PH.2), the common physical profile cancels before any absolute value
or positive part is taken.  The exact remaining theorem is now:

\[
 \boxed{
 \left[
 \sum_{a=1}^{A}
   \mathbb E_{U_S}[(q_a-q_{a-1})(g_a-g_{a-1})]
 \right]_+
 \le K^{-d+o(1)}
 }
\tag{TH.SIGNED}
\]

for one fixed `lambda<.98` and `d>0`, with `S,L=O(log M)` from the literal
schedule.  All 3-adic depths are summed before the positive part.  Fixed-
mode PCA, absolute Haar summation, and a maximum-fiber estimate remain
rejected.

To prevent another moving-target cycle, fix the first attempted constants as

\[
 \boxed{
 \lambda_0=\frac{97}{100},
 \qquad
 d_0=\frac1{1000}.
 }
\tag{TH.3}
\]

Then (TC.5) gives the strict threshold

\[
 A>\frac{.97}{2\kappa_*}
 =9.6913799417\ldots,
\tag{TH.4}
\]

which has genuine slack over the first requested benchmark
`A>9.791291...`.  The exponent `d_0` is deliberately weak and lies far
below the available analytic phase-rate capacity; the unproved issue is the
physical, moving-`S`, schedule-tagged recurrence, not the numerical rate.

### Interface card and bounded next attempt

```text
PRODUCER:
  difference of the two schedule-restricted physical landing laws at
  outer ranks M and K=M^lambda.

OUTPUT / NORMALIZATION:
  signed density f_M-f_K on the same finite band J_S, normalized by each
  law's own full source shell and paired against uniform U_S.

CONSUMER:
  only the centered stopped target g=1_C-delta.

EXACT BRIDGES:
  TH.1 removes total-mass mismatch at cost delta;
  TH.2 diagonalizes the remaining pairing by all 3-adic Haar depths;
  TC.4 converts o(1) signed decay into the natural-density improvement and
  a polynomial signed saving into the quantitative improvement.

BOUNDARY TERMS THAT MUST REMAIN:
  translated feasible-time supports from CP.15H;
  the O(log M) initial-valuation translations from CP.15T;
  incomplete source bands and the all-even endpoint channel.

NEXT BOUNDED ATTEMPT:
  use the exact adjacent-shell recurrence AR.6 below.  Estimate only the
  aggregate odd-core phase-renewal plus filter-alignment pairing, with the
  outer-scale common term subtracted before estimation.  First target o(1);
  retain O(K^-1/1000) as the quantitative upgrade.

KILL CONDITION FOR THAT RECURRENCE:
  an explicit physical branch family whose aggregate positive TH.2
  contribution stays bounded away from zero, or a recurrence coefficient
  whose best audited accumulated rate is non-decaying.  Slower-than-power
  decay kills only the quantitative target.  Failure of a positive norm
  bound is not a kill because TH.2 is signed.
```

This completes the algebraic part of the next attempt.  The live analytic
burden is `TH.SIGNED`; it has not yet been proved.

## 17. Exact marked killed-operator recurrence

The scalar killed operator from section 8 omits the reverse-loss filter used
by the schedule law.  The filter can be retained exactly by adjoining the
accumulated scaled loss as a state coordinate.

Put `Y=2^S`.  For a finitely supported function
`Phi(x,ell)` on states `x>Y` and rational losses `ell>=0`, define the forward
killed operator

\[
\begin{aligned}
 (\mathscr Q_Y\Phi)(z,\ell)
 &={\bf1}_{z>Y}\,\Phi(2z,\ell)\\
 &\quad+{\bf1}_{z>Y}{\bf1}_{z\equiv2\ (3)}
   {\bf1}_{(2z-1)/3>Y}{\bf1}_{\ell\ge Y/(2z)}
   \Phi\!\left(\frac{2z-1}{3},\ell-\frac{Y}{2z}\right).
\end{aligned}
\tag{MK.1}
\]

The first term is the even predecessor.  In the second term the predecessor
is odd and its shortcut image is `z`; that step adds exactly

\[
 Y\,\operatorname{reverseLoss}=\frac{Y}{2z}
\]

to the scaled reverse-loss coordinate.  Define the boundary operator on
`J_S=(Y/2,Y]` by

\[
 (\mathscr B_Y\Phi)(y,\ell)=\Phi(2y,\ell).
\tag{MK.2}
\]

An odd shortcut step is strictly increasing, so every first crossing from
above `Y` into `J_S` is the even step `2y -> y`; no odd boundary branch is
missing from (MK.2).

### Loss-normalization audit guard

The state `ell` in (MK.1) is the additive loss used by the active transport
theorem:

\[
 E_Y(n)=Y\sum_{j<h}u_j(n),
 \qquad
 u_j(n)=
 \begin{cases}
  1/(2T^{j+1}(n)),&T^j(n)\text{ odd},\\
  0,&T^j(n)\text{ even}.
 \end{cases}
\tag{MK.2a}
\]

Consequently an odd step ending at `z` contributes exactly `Y/(2z)` to
`ell`.  This agrees with `reverseLoss`, `reverseLossTotal`, and
`scaledReverseLoss` in the formal package and with (4.9)--(4.12) of the
paper.

It must not be replaced by

\[
 -Y\log\left(1-\frac1{2z}\right).
\tag{MK.2b}
\]

The latter is the increment of the logarithm of the exact reverse product,
which is a different statistic.  A multiplicative rational coordinate can
encode that product exactly, but its logarithmic cap is not the additive
filter consumed by the loss-filtered tagged-fiber theorem.  The paper uses

\[
 1-E_Y/Y\le\prod_{j<h}(1-u_j)\le1
\]

to turn the additive filter into the required distortion control.  Thus
(MK.1) is exact for the active theorem and requires no multiplicative-state
repair.

Let

\[
 \Phi_M^{(0)}(x,\ell)
 =\mathbf1_{I_M}(x)\mathbf1_{\ell=0}.
\tag{MK.3}
\]

Induction on `h` gives the exact path interpretation: the coefficient
`(mathscr Q_Y^h Phi_M^(0))(z,ell)` counts sources in `I_M` which remain above `Y`
through time `h`, arrive at `z`, and have accumulated scaled reverse loss
exactly `ell`.  Consequently the typed schedule landing profile is

\[
 \boxed{
 F^{\mathcal H,D}_{M,S}(y)
 =\sum_{\substack{h\in\mathcal H\\h\ge1}}
   \ \sum_{0\le\ell\le D}
   (\mathscr B_Y\mathscr Q_Y^{h-1}\Phi_M^{(0)})(y,\ell).
 }
\tag{MK.4}
\]

Every sum in (MK.4) is finite because only losses generated by finitely many
paths of the declared lengths occur.  Formula (MK.4) simultaneously retains
first passage, the exact time tag, the physical height boundary, 3-adic
phase, and the loss cap.

Let `P_a` denote conditional expectation on `J_S` by residue modulo `3^a`.
For `X` equal to `M` or `K`, define

\[
 \Psi_X(y)
 =\frac{|J_S|}{2^X}
   \sum_{\substack{h\in\mathcal H_{X,S}\\h\ge1}}
   \sum_{0\le\ell\le D_{X,S}}
   (\mathscr B_Y\mathscr Q_Y^{h-1}\Phi_X^{(0)})(y,\ell).
\tag{MK.5}
\]

Then the signed Haar state in (TH.2) is literally

\[
 q_a=P_a(\Psi_M-\Psi_K).
\tag{MK.6}
\]

Thus `TH.SIGNED` is an explicit finite-rank projection of the difference of
two marked killed resolvents.  No independence, exact-uniformity, or
unrestricted-law substitution has entered.

```text
MARKED OPERATOR STATUS:
  exact state and transition MK.1:             PROVED-PAPER;
  exact first-passage boundary MK.2:           PROVED-PAPER;
  exact schedule/loss representation MK.4:     PROVED-PAPER;
  exact two-scale Haar socket MK.5--MK.6:       PROVED-PAPER;
  signed decay TH.SIGNED at (.97,.001):         OPEN;

FIRST IRREVERSIBLE LOSS STILL AHEAD:
  any absolute value, positive norm, or modewise maximum applied to MK.6.
  The next proof must subtract the common two-scale component and sum all
  depths before taking the positive part.
```

## 18. Exact adjacent-shell renewal

The filter-preserving valuation disintegration (CP.15H) gives an exact
one-shell recurrence.  For an integer time set `H`, put

\[
 \mathcal H-1=\{h-1:h\in\mathcal H,\ h\ge1\}.
\tag{AR.1}
\]

Then

\[
 \boxed{
 \mu^{\mathcal H,D}_{X+1,S}
 =\frac12\mu^{{\rm odd},\mathcal H,D}_{X+1,S}
  +\frac12\mu^{\mathcal H-1,D}_{X,S}
  +\mathcal R^{\mathcal H,D}_{X,S},
 }
\tag{AR.2}
\]

where `mathcal R` is a signed boundary measure satisfying

\[
 \boxed{
 \|\mathcal R^{\mathcal H,D}_{X,S}\|_{\rm TV}
 \le 2^{S-X-1}.
 }
\tag{AR.3}
\]

Indeed, separate the `v=0` term in (CP.15H) at outer rank `X+1` and put
`u=v-1` in the remaining sum.  The latter sum is one half of (CP.15H) at
outer rank `X` with time set `H-1`, except for its all-even remainder.
Explicitly,

\[
 \mathcal R^{\mathcal H,D}_{X,S}
 =R^{\mathcal H,D}_{X+1,S}
  -\frac12R^{\mathcal H-1,D}_{X,S}.
\tag{AR.4}
\]

The two positive boundary masses are at most `2^(S-X-2)` each after the
factor `1/2`, proving (AR.3).  No asymptotic estimate or independence input
enters this identity.

For the canonical schedule supports and caps, abbreviate

\[
 \mu^{\rm sch}_{X,S}
 =\mu^{\mathcal H_{X,S},D_{X,S}}_{X,S}.
\]

Subtracting `mu^sch_(X,S)` from (AR.2) gives

\[
\boxed{
\begin{aligned}
 \mu^{\rm sch}_{X+1,S}-\mu^{\rm sch}_{X,S}
 ={}&\frac12\left(
   \mu^{{\rm odd},\mathcal H_{X+1,S},D_{X+1,S}}_{X+1,S}
   -\mu^{\rm sch}_{X,S}\right)\\
 &+\frac12\left(
   \mu^{\mathcal H_{X+1,S}-1,D_{X+1,S}}_{X,S}
   -\mu^{\rm sch}_{X,S}\right)
 +\mathcal R_{X,S}.
\end{aligned}}
\tag{AR.5}
\]

Pair (AR.5) with the single centered stopped target
`g=1_C-delta` and telescope from `K` to `M`.  Since `|g|<=1`,

\[
\begin{aligned}
 \langle\mu^{\rm sch}_{M,S}-\mu^{\rm sch}_{K,S},g\rangle
 =\frac12\sum_{X=K}^{M-1}\bigl(&\mathcal O_{X,S}(g)
 +\mathcal F_{X,S}(g)\bigr)
 +O(2^{S-K}),
\end{aligned}
\tag{AR.6}
\]

where

\[
\begin{aligned}
 \mathcal O_{X,S}(g)
 &=\left\langle
 \mu^{{\rm odd},\mathcal H_{X+1,S},D_{X+1,S}}_{X+1,S}
 -\mu^{\rm sch}_{X,S},g\right\rangle,\\
 \mathcal F_{X,S}(g)
 &=\left\langle
 \mu^{\mathcal H_{X+1,S}-1,D_{X+1,S}}_{X,S}
 -\mu^{\rm sch}_{X,S},g\right\rangle.
\end{aligned}
\tag{AR.7}
\]

The first term is the **odd-core physical phase renewal**.  Writing an odd
source as `n=2u+1`, its first shortcut image is `3u+2`; this is where the
joint Archimedean phase shift and generated 3-adic residue structure live.
The second term is the **filter-alignment defect** caused only by the change
in feasible-time support and loss cap.  These are logically distinct
analytic obligations.

Because `S=O(log M)` and `K=M^lambda`, the accumulated boundary charge
`O(2^(S-K))` is smaller than every power of `M`.  The real warning is
different: there are `M-K` adjacent increments.  Neither term in (AR.7)
should be bounded positively shell by shell.  The sums over `X`, both terms,
and all 3-adic Haar depths must remain signed until the final positive part.

Thus (AR.6), rather than a generic energy estimate, is the exact next proof
socket:

\[
 \boxed{
 \left[
 \sum_{X=K}^{M-1}
   \bigl(\mathcal O_{X,S}(g)+\mathcal F_{X,S}(g)\bigr)
 \right]_+=o(1)
 }
\tag{AR.MIN}
\]

for the natural-density headline, or `O(K^(-d+o(1)))` for the quantitative
exceptional-rate theorem.

## 19. Minimum headline theorem versus quantitative theorem

The fixed power saving in `TH.SIGNED` is not required merely to improve the
strict natural-density threshold.  The weaker statement

\[
 \boxed{
 \left[
 \mathbb E_{U_S}[(f_M-f_K)(\mathbf1_C-\delta)]
 \right]_+=o(1)
 }
\tag{TH.SIGNED_0}
\]

at one fixed `lambda<.98` is enough.  The intermediate-scale term in
(TC.3) tends to zero for

\[
 A>\frac{\lambda}{2\kappa_*},
\]

and both `delta` and the comparison error then tend to zero.  This proves a
strictly improved natural-density threshold, but supplies no fixed
power-logarithmic exceptional-set rate.

The frozen pair

\[
 (\lambda,d)=(.97,.001)
\]

remains the first quantitative target.  It yields the conditional threshold

\[
 A>9.6913799417\ldots
\]

while preserving a power-logarithmic exceptional count.  The two targets
must therefore be recorded separately:

```text
MINIMUM HEADLINE TARGET:
  TH.SIGNED_0, equivalently AR.MIN = o(1).

QUANTITATIVE TARGET:
  TH.SIGNED at lambda=.97 and d=.001,
  equivalently the right side of AR.MIN is O(K^(-.001+o(1))).

NEW EXACT RECURRENCE:
  adjacent-shell renewal AR.2--AR.7:             PROVED-PAPER;
  accumulated boundary remainder O(2^(S-K)):    PROVED-PAPER;

OPEN ANALYTIC TERMS:
  signed aggregate odd-core phase renewal:       OPEN / load-bearing;
  signed aggregate filter alignment:             OPEN / load-bearing;

AUDIT CORRECTION:
  additive MK.1 loss state:                       PROVED-PAPER / exact;
  proposed logarithmic-loss replacement:          REJECTED / wrong interface;

PHASE-3 HEADLINE IMPROVEMENT:
  NOT YET PROVED.
```
## 20. Common loss cap and an aligned interval producer

The notation `D_(X,S)` in (AR.5)--(AR.7) hides a simplification.  At a
fixed landing rank `S`, the rank-scaled loss theorem gives the same cap at
every outer rank:

\[
 \boxed{
 D_S=\frac{S+2}{r_*}.
 }
\tag{AI.1}
\]

Indeed, (6.5) of the paper states

\[
 E_{2^q}(n)<\frac{q+2}{r_*}
\]

for every generated first-bad landing at rank `q`; setting `q=S` removes
the outer rank completely.  Thus the filter-alignment term has no changing
loss cap.  The additive loss increment of an odd first step remains part of
the exact marked dynamics and must not be discarded.

There is also a deterministic interval choice for the feasible-time
support.  Write

\[
 \Delta_{\rm dr}=1-a_0,
 \qquad
 C_H=\frac{D_{\rm hi}+\tau+3}{1-\sqrt{r_{\rm hi}}},
 \qquad
 W_X=C_H\sqrt{(X+1)\log(X+2)}.
\tag{AI.2}
\]

Here `D_hi` is the shrinking-barrier tolerance coefficient, not the loss
cap (AI.1).  Define

\[
 \boxed{
 \widehat{\mathcal H}_{X,S}
 =\left\{h\in\mathbb N_{>0}:
  \left|\Delta_{\rm dr}h-(X+1-S)\right|\le W_X
 \right\}.
 }
\tag{AI.3}
\]

Every literal shrinking-barrier run from `I_X` ending at rank `S` has its
cumulative time in this interval.  To see this, specialize
`ShrinkingRecertificationRun.deviation_add_potential_le` to `q=S`.  The
low-rank term in the potential occurs on both sides and cancels exactly;
the remaining difference is `W_X`.  Moreover,

\[
 \#\widehat{\mathcal H}_{X,S}
 \le 2+\frac{2W_X}{\Delta_{\rm dr}}
 =O\!\left(\sqrt{X\log X}\right).
\tag{AI.4}
\]

Consequently replacing the literal feasible-time set by the containing
interval (AI.3) preserves both interfaces consumed by the headline proof:

1. every generated first-bad source is still retained;
2. the support-sensitive tagged-fiber bound still costs only
   `X^(1/2+o(1))` when `S=O(log X)`.

This is a transfer to a larger ambient landing law, not a claim that the
literal feasible-time set is itself an interval.

The interval family has a bounded adjacent mismatch.  Put

\[
 c_X=\frac{X+1-S}{\Delta_{\rm dr}},
 \qquad
 w_X=\frac{W_X}{\Delta_{\rm dr}}.
\]

Then `Hhat_(X,S)` is the set of positive integers in
`[c_X-w_X,c_X+w_X]`, while `Hhat_(X+1,S)-1` has center

\[
 c_{X+1}-1=c_X+\frac{a_0}{\Delta_{\rm dr}}.
\tag{AI.5}
\]

Also

\[
\begin{aligned}
 0\le W_{X+1}-W_X
 &\le C_H\,
 \frac{\log(X+3)+1}
 {\sqrt{(X+1)\log(X+2)}}.
\end{aligned}
\tag{AI.6}
\]

For (AI.6), rationalize the difference of the two square roots and use

\[
 (X+2)\log(X+3)-(X+1)\log(X+2)
 \le\log(X+3)+1.
\]

The right side of (AI.6) tends to zero.  Hence there are constants `X0`
and `B_H`, depending only on the fixed barrier data, such that for all
`X>=X0` and `S<X`,

\[
 \boxed{
 \#\left(
 (\widehat{\mathcal H}_{X+1,S}-1)
 \mathbin\triangle
 \widehat{\mathcal H}_{X,S}
 \right)\le B_H.
 }
\tag{AI.7}
\]

One may take any integer strictly larger than
`2(a_0+1)/Delta_dr+2`: after (AI.6) is at most one, the two real interval
endpoints move by at most `(a_0+1)/Delta_dr`, and rounding costs at most one at
each endpoint.

```text
ALIGNED-INTERVAL STATUS:
  outer-rank-independent loss cap AI.1:          PROVED-PAPER;
  containing interval AI.3:                      PROVED-PAPER;
  square-root support size AI.4:                 PROVED-PAPER;
  bounded adjacent symmetric difference AI.7:   PROVED-PAPER;
  headline implication for the enlarged law:    PROVED-PAPER;
  signed comparison for the enlarged law:        OPEN.
```

## 21. Exact sibling-paired adjacent-shell generator

The adjacent-shell recurrence can be sharpened further.  Once the outer
rank lies strictly above `S`, no all-even boundary remainder is needed for
a one-shell comparison.

Put `Y=2^S`.  For a finite time set `H`, loss cap `D`, and centered target
function `g` on `J_S`, define

\[
 \Gamma^{\mathcal H,D}_g(x)
 =\mathbf1_{\{\tau_Y(x)\in\mathcal H\}}
  \mathbf1_{\{E_Y(x)\le D\}}
  g\!\left(T^{\tau_Y(x)}(x)\right),
\tag{SG.1}
\]

with value zero when the declared first passage does not exist.  The pairing
of the interval landing law with `g` is exactly

\[
 \langle\widehat\mu_{X,S},g\rangle
 =2^{-X}\sum_{u\in I_X}
  \Gamma^{\widehat{\mathcal H}_{X,S},D_S}_g(u).
\tag{SG.2}
\]

Every element of `I_(X+1)` is uniquely either `2u` or `2u+1` with
`u in I_X`.  Let

\[
 A(u)=3u+2.
\tag{SG.3}
\]

For `X>S`, both `u` and `A(u)` lie above `Y`, and the shortcut dynamics give
the exact identities

\[
\begin{array}{lll}
 \tau_Y(2u)=1+\tau_Y(u),
 &L_Y(2u)=L_Y(u),
 &E_Y(2u)=E_Y(u),\\[1mm]
 \tau_Y(2u+1)=1+\tau_Y(A(u)),
 &L_Y(2u+1)=L_Y(A(u)),
 &E_Y(2u+1)=E_Y(A(u))+\dfrac{Y}{2A(u)}.
\end{array}
\tag{SG.4}
\]

Define the odd-child observable

\[
 \Gamma^{\rm odd}_{X+1,S,g}(u)
 =\mathbf1_{\{\tau_Y(A(u))\in
       \widehat{\mathcal H}_{X+1,S}-1\}}
  \mathbf1_{\{E_Y(A(u))+Y/(2A(u))\le D_S\}}
  g(L_Y(A(u))).
\tag{SG.5}
\]

Partitioning the complete source shell into its sibling pairs now gives

\[
\boxed{
\begin{aligned}
 &\langle\widehat\mu_{X+1,S}-\widehat\mu_{X,S},g\rangle\\
 &\quad=2^{-X}\sum_{u\in I_X}
 \left[
  \frac12\Gamma^{\widehat{\mathcal H}_{X+1,S}-1,D_S}_g(u)
  +\frac12\Gamma^{\rm odd}_{X+1,S,g}(u)
  -\Gamma^{\widehat{\mathcal H}_{X,S},D_S}_g(u)
 \right].
\end{aligned}}
\tag{SG.6}
\]

This identity is exact and has no remainder.  Equivalently, its bracket is
one half of the odd-core difference plus one half of the time-filter
difference.  Unlike (AR.6), however, both differences now use the same
parent `u`; their cancellation cannot be destroyed by comparing two
unrelated aggregate measures.

The arithmetic state exposed by the odd child is also exact:

\[
 \boxed{A(u)+1=3(u+1),\qquad
 A^j(u)+1=3^j(u+1).}
\tag{SG.7}
\]

Thus an odd-child string of length `j` creates precisely the terminal
3-adic suffix `-1 mod 3^j`.  At depth `a>=1`,

\[
 A(u)\equiv2+3(u\bmod 3^{a-1})\pmod{3^a},
\tag{SG.8}
\]

so one ternary digit is inserted and the remaining phase is inherited.
This is the exact common-suffix reservoir; it rules out replacing (SG.6)
by a maximum or a separate positive norm, but it does not decide the signed
target pairing.

The Archimedean part has only two shell outcomes.  The lower set

\[
 U_X^- =\{u\in I_X:A(u)<2^{X+2}\}
\]

has cardinality

\[
 \#U_X^-=\left\lfloor\frac{2^X-1}{3}\right\rfloor,
\tag{SG.9}
\]

and its complement has cardinality `2^X-#U_X^-`.  On these sets `A(u)`
lies respectively in shells `I_(X+1)` and `I_(X+2)`.  Hence the exact
minimal state is the promised two-dimensional one: the adjacent dyadic
shell phase together with the inherited 3-adic suffix, with time and loss
kept as marks rather than estimated separately.

Telescoping (SG.6) gives the new literal closure criterion

\[
 \boxed{
 \left[
 \sum_{X=K}^{M-1}2^{-X}\sum_{u\in I_X}
  \mathfrak d_{X,S,g}(u)
 \right]_+=o(1),
 }
\tag{SG.MIN}
\]

where `d_(X,S,g)(u)` is the bracket in (SG.6).  A power bound gives the
quantitative version.  `SG.MIN` is a transfer of `TH.SIGNED_0`, not a new
relaxation: its value is that the two compensating children and both marks
are now in one common source coordinate.

## 22. First prove-or-kill result for the sibling route

The bounded interval mismatch (AI.7) cannot be estimated positively on its
own at the desired threshold.  The support-sensitive tagged-fiber theorem
gives, for `O(1)` boundary time tags and a target of density `delta`, only

\[
 O(D_S\delta)+O(2^{S-X}\delta)
\tag{SK.1}
\]

per outer shell.  Summing this absolute estimate through `M-K` shells costs

\[
 O(MD_S\delta).
\tag{SK.2}
\]

At the first target threshold

\[
 A\kappa_*=\frac{\lambda}{2}=0.485,
\]

(SK.2) grows like `M^(0.515+o(1))`; it does not even tend to zero.  Thus,
using the currently available per-tag transport estimate,

\[
 \boxed{
 \text{separate positive control of the filter boundary does not close.}
 }
\tag{SK.3}
\]

The same warning applies to the small odd-step loss increment in (SG.5):
without an anti-concentration theorem for the accumulated loss at the cap,
its small numerical size does not bound the mass in the thin boundary
layer.

A pointwise sibling inequality is also false without the literal target
structure.  Even in the aligned, unmarked model, choose a bounded observable
which is zero on `I_X` and one on the disjoint affine image `A(I_X)`.  The
bracket in (SG.6) is then `1/2` for every parent.  Therefore no
distribution-free local sign, local contraction, or parentwise
supermartingale can prove `SG.MIN`.  The arithmetic first-exit target and
the aggregation over outer shells are load-bearing.

There is an exact spectral version of the same obstruction.  On every
dyadic quotient `Z/(2^m)`, translation by one conjugates the affine map to
multiplication by three:

\[
 u\longmapsto A(u)=3u+2,
 \qquad
 u+1\longmapsto3(u+1).
\tag{SK.4}
\]

Hence its pullback `U_A` is a permutation operator.  The ideal aligned
sibling average

\[
 \mathcal P_m=\frac12(I+U_A)
\tag{SK.5}
\]

has eigenvalue one on every function constant on an `A`-orbit.  In
particular, parity is invariant because `A(u)` and `u` have the same parity.
There is therefore no spectral gap on the full centered function space at
any dyadic depth, let alone uniformly as the target depth grows.  A symbolic
solver applied only to the affine quotient must find these unit modes; it
cannot prove `SG.MIN`.

This spectral statement concerns convergence of the positive averaging
operator `P_m`.  It is not yet the operator in the aligned unmarked bracket.
For one common observable `Gamma`, that bracket is instead

\[
 \frac12\bigl(\Gamma(A(u))-\Gamma(u)\bigr)
 =\frac12(U_A-I)\Gamma(u).
\tag{SK.6}
\]

Consequently every `A`-invariant mode is annihilated exactly by the signed
core.  The absence of a gap for `P_m` kills positive-mixing or repeated-
averaging proofs, but it does not identify an invariant-mode obstruction to
the signed difference.  The physical bracket differs from (SK.6) only
because its even and odd children carry different time and loss marks.  The
open quantity is therefore the residual after the common signed core has
been extracted, not the invariant projection of that core.

This does not refute the physical route.  The full observable in (SG.6)
contains first passage, the moving time window, the exact loss reserve, and
the stopped target.  What (SK.4)--(SK.6) prove is that averaging the affine
quotient cannot supply a contraction, while the common signed affine core
already kills its invariant modes.  The marks create the remaining mismatch;
dropping them before the signed decomposition is invalid.

The surviving next theorem must therefore be joint and signed.  The smallest
useful form is a sourcewise packet/coboundary estimate for the complete
bracket in (SG.6), with the positive part taken only after summing all
parents and all outer shells.  Any argument that first bounds the even-time
boundary, the odd common-suffix term, or individual Haar depths positively
recreates a proved method ceiling.

```text
NEW THEOREMS / IDENTITIES:
  common cap and aligned interval AI.1--AI.7:       PROVED-PAPER;
  exact sibling generator SG.1--SG.6:               PROVED-PAPER;
  exact dyadic/3-adic child state SG.7--SG.9:        PROVED-PAPER;

SCOPED KILL:
  separate absolute filter alignment via the
  available per-tag transport estimate:             FALSE AS A CLOSURE METHOD;
  distribution-free pointwise sibling contraction:  FALSE;
  affine-quotient spectral gap / PCA alone:           FALSE;

STRICTLY NARROWED:
  no boundary remainder;
  no outer-rank loss-cap mismatch;
  no comparison of unrelated odd and parent laws;
  all compensation is in one parent/children bracket.

SUPERSESSION:
  AR.2 remains a correct valuation-disintegration identity, but SG.6
  supersedes AR.6 as the active adjacent-shell proof socket because direct
  sibling pairing has no all-even remainder.

EQUALLY HARD:
  target-specific control of the deep signed core together with the literal
  time- and loss-mark mismatches.

NEXT EXACT TARGET:
  extract the common difference (U_A-I)/2 from SG.6, cancel every component
  visible modulo 2^X over the complete shell, and prove that the combined
  deep-tail and mark-boundary residual is o(1) after summing all outer shells;
  or exhibit an inherited physical family whose positive combined residual
  stays bounded away from zero.

PHASE-3 HEADLINE IMPROVEMENT:
  NOT YET PROVED.
```

## 23. Audit of the dyadic-truncation sketch

The proposed truncation contains one exact new cancellation, but its two
suggested boundary closures require correction.  This section records the
largest theorem that survives the audit.

### 23.1 Constants and the exact orbit quotient

The constant in (AI.2) is

\[
 a_0=\frac{\log_2 3}{2}=\log_4 3
 =0.792481250360\ldots,
 \qquad
 \Delta_{\rm dr}=1-a_0=0.207518749639\ldots.
\tag{DT.1}
\]

This is distinct from `log_3 2`, which occurs only in the entropy constant
`kappa_*`.  Thus (AI.2)--(AI.7) use the correct shortcut drift.

The `A`-orbit quotient can also be described exactly.  Translation by one
conjugates `A` modulo `2^m` to multiplication by three.  Besides the fixed
class `v=u+1=0`, write a nonzero class as

\[
 v=2^a w,
 \qquad 0\le a<m,
 \qquad w\in(\mathbb Z/2^{m-a}\mathbb Z)^\times.
\tag{DT.2}
\]

For `k=m-a`, multiplication by three has one orbit when `k=1,2` and two
orbits when `k>=3`.  Indeed

\[
 \operatorname{ord}_{2^k}(3)=2^{k-2}\qquad(k\ge3),
\tag{DT.3}
\]

by the standard valuation identity
`v_2(3^(2^j)-1)=j+2`, while the odd-unit group has order `2^(k-1)`.
For `k>=3` the two cosets are distinguished by

\[
 w\bmod 8\in\{1,3\}
 \quad\hbox{or}\quad
 w\bmod 8\in\{5,7\}.
\tag{DT.4}
\]

Hence the number of `A`-orbits, and therefore the dimension of its invariant
function space, is

\[
 1+1+1+2(m-2)=2m-1.
\tag{DT.5}
\]

This logarithmic quotient is exact, but (SK.6) shows that it is already in
the kernel of the common signed difference.

### 23.2 Exact complete-shell cancellation

Let `Phi` be any function on `Z/(2^m)` and extend it periodically to the
integers.  Since `A(u)=3u+2` is a permutation modulo `2^m` and `I_X` is a
disjoint union of complete residue systems whenever `m<=X`, one has

\[
 \boxed{
 \sum_{u\in I_X}\bigl(\Phi(A(u))-\Phi(u)\bigr)=0
 }
 \qquad(m\le X).
\tag{DT.6}
\]

In particular, let `P_m Gamma_X` be any chosen low-depth projection of the
common marked observable

\[
 \Gamma_X=\Gamma_g^{\widehat{\mathcal H}_{X,S},D_S}
\tag{DT.7}
\]

which depends only on the residue modulo `2^m`.  Then the common odd core
satisfies the exact identity

\[
\begin{aligned}
 &\sum_{u\in I_X}\bigl(\Gamma_X(A(u))-\Gamma_X(u)\bigr)\\
 &\quad=
 \sum_{u\in I_X}
 \bigl((I-P_m)\Gamma_X(A(u))-(I-P_m)\Gamma_X(u)\bigr).
\end{aligned}
\tag{DT.8}
\]

Taking `m=X` removes the entire component visible on the source dyadic
quotient, at zero cost.

The time interval (AI.3) gives, uniformly over feasible switch times when
`S=o(X)`,

\[
 h=\frac{X+1-S}{\Delta_{\rm dr}}+O(\sqrt{X\log X}),
 \qquad
 \frac Xh=\Delta_{\rm dr}+o(1).
\tag{DT.9}
\]

Thus the quotient depth `X` is about `20.75%` of the physical first-passage
time.  This is a deterministic scale calculation, not yet a norm saving:
the observable contains discontinuous time, loss, and target indicators, so
an arbitrary projection `P_X` need not approximate it.  Calling (DT.8) a
`20.75%` reduction is valid only at the level of exposed coordinates.  A
bound for the residual on the remaining coordinates is still required.

The near condition `h<=X` is equivalent asymptotically to
`X<=S/a_0=1.2618... S`.  It does not cover the terminal Phase-3 regime
`S=O(log M)` and `X` ranging far above `S`.

### 23.3 Exact three-term residual

Write

\[
 \Gamma_X^{\rm ev}(u)
 =\Gamma_g^{\widehat{\mathcal H}_{X+1,S}-1,D_S}(u),
 \qquad
 \Gamma_X^{\rm od}(u)
 =\Gamma^{\rm odd}_{X+1,S,g}(u).
\tag{DT.10}
\]

Adding and subtracting the common observable at `u` and `A(u)` rewrites the
complete bracket in (SG.6) as

\[
\boxed{
\begin{aligned}
 \mathfrak d_{X,S,g}(u)
 ={}&\frac12\bigl(\Gamma_X(A(u))-\Gamma_X(u)\bigr)\\
 &+\frac12\bigl(\Gamma_X^{\rm ev}(u)-\Gamma_X(u)\bigr)\\
 &+\frac12\bigl(\Gamma_X^{\rm od}(u)-\Gamma_X(A(u))\bigr).
\end{aligned}}
\tag{DT.11}
\]

The first line is the signed affine core.  The second is the even-child time
window mismatch.  The third contains the odd-child time mismatch and the
thin loss-reserve boundary.  Combining (DT.8) with (DT.11) is the exact
truncation socket; no absolute value has been taken.

### 23.4 Why the two proposed boundary lemmas do not close the cycle

The literal uniform statement

\[
 \sup_t\widehat\mu_{X,S}\{|E_Y-t|\le w\}\le Cw^\theta
 \quad\hbox{for every }w>0
\tag{DT.12}
\]

is false for every finite atomic law with a positive atom.  Center the
interval at an atom of mass `p`; letting `w` tend to zero would force
`p<=Cw^theta`, a contradiction.  A lattice-aware inequality with an explicit
maximum-atom term would be valid only if that atom term were itself bounded.
The weaker quantity actually consumed here is the source-weighted cap
boundary

\[
 \boxed{
 2^{-X}\#\left\{u\in I_X:
 D_S-\frac{2^S}{2A(u)}<E_Y(A(u))\le D_S
 \right\},
 }
\tag{DT.LOSS}
\]

with the time and target marks retained.  A summable bound for the signed
aggregate of (DT.LOSS), not distribution-free anti-concentration at every
center and every width, is the honest loss-boundary target.

The local Gaussian sentence following (CP.9) is also not an available local
limit theorem for the literal physical switch time.  Section 11 records
`CP.RECON` as open; the Gaussian estimate belongs to the proposed affine/
phase reconstruction and has not been transferred to the stopped law.
Moreover, even granting a target-weighted per-layer estimate of order
`delta/sqrt(X log X)`, summation over the outer shells gives

\[
 \delta\sum_{X\le M}\frac1{\sqrt{X\log X}}
 =M^{1/2-A\kappa_*+o(1)}.
\tag{DT.13}
\]

At the first Phase-3 target `A kappa_*=0.485`, this is
`M^(0.015+o(1))`, not `o(1)`.  A separate absolute local-limit estimate
therefore recovers only the old square-root threshold.  Improvement requires
a signed cancellation of entering and leaving boundary layers, or an
additional target-conditioned saving.

### 23.5 Corrected closure criterion

Define the three residuals in (DT.11), replacing the affine-core line by its
high-depth form (DT.8) with `m=X`, and retain their signs.  The exact next
theorem is

\[
 \boxed{
 \left[
  \sum_{X=K}^{M-1}2^{-X}
  \left(
   R^{\rm tail}_{X,S,g}
   +R^{\rm time}_{X,S,g}
   +R^{\rm loss}_{X,S,g}
  \right)
 \right]_+=o(1),
 }
\tag{DT.MIN}
\]

where the three terms are the corresponding complete-shell sums in
(DT.8)--(DT.11).  The positive part is taken only after the deep core, both
time-boundary directions, the loss boundary, and all outer shells have been
combined.  Proving the terms separately in absolute value recreates (SK.3)
and (DT.13).

This is a genuine reduction of `SG.MIN`: the complete `2^X`-periodic part of
the common core has been discarded exactly.  It is not yet a bound for the
remaining tail and therefore gives no Phase-3 exponent improvement by
itself.

```text
STATUS-CHANGE CARD
Literal statement before:
  cancel the A-invariant projection of the complete marked bracket.
Literal statement after:
  prove DT.MIN for the high-depth common core plus the exact time/loss mark
  mismatches after complete-shell modular cancellation.
Exact logical difference:
  the former target is vacuous for the aligned common core because its
  operator is (U_A-I)/2; the latter retains precisely the mark-created and
  high-depth residuals.
Paper proof location:
  SK.6 and DT.6--DT.11.
Quantifier and parameter-dependence audit:
  one terminal rank S, all outer shells K<=X<M, the literal generated target,
  one positive part after full aggregation.
Formal declaration / build / axiom scan:
  not started; the analytic inequality is still open.
Counterexample or missing inference justifying demotion:
  invariant modes are killed identically by (U_A-I); LOSS.AC is contradicted
  by every positive atom; CP.RECON remains open and DT.13 misses the target.
Public API and manuscript locations affected:
  none; Phase 3 is research-only and the proved V3 headline is unchanged.
```

```text
AUDITED SKETCH STATUS:
  a0=log_4(3), Delta_dr=1-a0:                    CONFIRMED;
  A-orbit count 2m-1 and class description:       PROVED-PAPER;
  signed operator (U_A-I)/2:                      PROVED-PAPER;
  complete-shell modular cancellation DT.6:       PROVED-PAPER;
  coordinate-depth fraction Delta_dr:             PROVED-PAPER / scale only;
  claimed automatic deep-tail saving:             NOT PROVED;
  uniform continuous LOSS.AC for the atomic law:   FALSE;
  literal switch-time local limit from CP.9:       NOT AVAILABLE;
  separate local-limit closure at A*kappa=.485:    FALSE AS A METHOD;
  combined signed residual DT.MIN:                 OPEN / load-bearing;
  Phase-3 headline improvement:                    NOT YET PROVED.
```

## 24. Audit of the affine-reservoir prove-or-kill cycle

The reservoir cycle supplies one genuine target-space bound, but it does not
reduce the full physical theorem to the moderate invariant sectors alone.
Two interfaces must be corrected before recording its payoff.

### 24.1 Correct loss coordinate and odd-ladder bound

The active reverse-loss mark is the additive coordinate in (MK.2a), not the
logarithm of the reverse product.  An odd step ending at `z` contributes

\[
 \frac{Y}{2z}
\tag{IR.1}
\]

exactly.  Therefore the expression
`-Y log(1-1/(2A^j(u)))` is not the loss increment consumed by the tagged-
fiber theorem.

The useful bound proposed in the cycle nevertheless survives with the
correct coordinate.  Since

\[
 A^j(u)=3^j(u+1)-1
\tag{IR.2}
\]

and, for `j>=1`,

\[
 2A^j(u)=2\cdot3^j(u+1)-2\ge3^j(u+1),
\]

one has

\[
 \boxed{
 \sum_{j\ge1}\frac{Y}{2A^j(u)}
 \le\frac{Y}{u+1}\sum_{j\ge1}3^{-j}
 =\frac{Y}{2(u+1)}.
 }
\tag{IR.3}
\]

For `u>=2^K` this is at most `2^(S-K-1)`.  This proves that the
*numerical displacement* added by a complete odd ladder is
superpolynomially small.  It does not discharge the loss indicator: an
arbitrarily small displacement can still cross `E_Y=D_S` on a large atomic
boundary set.  Thus (IR.3) is exact infrastructure, while the signed
loss-boundary contribution in (DT.LOSS) remains open.

### 24.2 Exact invariant upper-failure reservoir

Let `y in I_m` and put `t=v_2(y+1)`.  For `0<=j<=t`, the first `t`
shortcut steps are odd and

\[
 T^j(y)+1=\left(\frac32\right)^j(y+1).
\tag{IR.4}
\]

Let

\[
 \kappa_\eta=\frac{2\eta}{\log_2 3}.
\tag{IR.5}
\]

There is a fixed `C_eta` such that

\[
 t\ge\kappa_\eta(m+1)+C_\eta
\tag{IR.6}
\]

implies `(sqrt 3)^t>=4y^eta`, and hence

\[
 T^t(y)>\rho^t y^{1+\eta}.
\tag{IR.7}
\]

The orbit is increasing throughout the preceding odd run, so it has not
crossed the lower first-passage threshold.  Apart from the separately
handled power endpoint, the low-block stopped upper-failure target therefore
contains

\[
 \boxed{
 E_T=\{y\in J_S:v_2(y+1)\ge T\},
 \qquad
 T=\lceil\kappa_\eta S+C_\eta\rceil.
 }
\tag{IR.8}
\]

Because `v_2(A(y)+1)=v_2(y+1)`, this is an exact target-side affine-
invariant reservoir.  It refutes pointwise or distribution-free
orthogonality of the stopped target to the affine orbit partition.  It does
not contradict (SK.6) or (DT.6): those identities annihilate invariant
components of the *common signed source core*, whereas (IR.8) says that the
marked target function itself has a nonzero invariant component.

### 24.3 High target-valuation sectors are negligible

The reservoir has uniform density

\[
 \frac{|E_T|}{|J_S|}\ll2^{-T}.
\tag{IR.9}
\]

The support-sensitive loss-filtered transport theorem, with
`D_S=O(S)` and `#H_(X,S)=X^(1/2+o(1))`, gives for `X=M` and
`X=K=M^lambda`

\[
 \boxed{
 \mu^{\rm sch}_{X,S}(E_T)
 \ll X^{1/2+o(1)}2^{-T}.
 }
\tag{IR.10}
\]

Here the harmless term `2^(S-X)2^(-T)` from the `1` in the tagged-fiber
bound is absorbed.  The manuscript permits the fixed switch coefficient in

\[
 S=\lceil C_{\rm sw}\log(M+2)\rceil
\tag{IR.11}
\]

to be enlarged after the low parameters are fixed.  It changes only the
`O(log M)` low-phase clock contribution, not the leading clock or the target
exponent.  Choosing

\[
 \kappa_\eta C_{\rm sw}\log2
 >\frac12+\lambda d+\varepsilon_0
\tag{IR.12}
\]

therefore yields

\[
 \boxed{
 \mu^{\rm sch}_{M,S}(E_T)+\mu^{\rm sch}_{K,S}(E_T)
 =O(M^{-\lambda d-\varepsilon_0/2}).
 }
\tag{IR.13}
\]

This is the theorem-level gain from the cycle: high-valuation atoms of the
target-side affine partition can be removed below the quantitative error
budget.

### 24.4 Exact target-space projection and the missing complement

To make the projection formula typed, take the affine-orbit partition modulo
`2^S`, restrict its atoms to `J_S`, and discard empty intersections.  Denote
the resulting sigma-algebra on the landing band by `I_S`.  For

\[
 q=f_M-f_K,
 \qquad
 g=\mathbf1_C-\delta,
\tag{IR.14}
\]

conditional expectation gives the exact orthogonal decomposition

\[
\boxed{
 \langle q,g\rangle
 =\langle\mathbb E[q\mid\mathcal I_S],
          \mathbb E[g\mid\mathcal I_S]\rangle
 +R_S^\perp,
 }
\tag{IR.15}
\]

where

\[
 R_S^\perp=
 \langle q-\mathbb E[q\mid\mathcal I_S],
         g-\mathbb E[g\mid\mathcal I_S]\rangle.
\tag{IR.16}
\]

If `O_(S,t,epsilon)` are the nonempty restricted orbit atoms, the invariant
term is

\[
\boxed{
 \sum_{t,\varepsilon}
 \bigl(\mu_M(O_{S,t,\varepsilon})
       -\mu_K(O_{S,t,\varepsilon})\bigr)
 \left(
  \frac{|C\cap O_{S,t,\varepsilon}|}{|O_{S,t,\varepsilon}|}
  -\delta
 \right).
 }
\tag{IR.17}
\]

The absolute contribution of the terms `t>=T` is bounded by the left side
of (IR.13).  Thus only `O(S)=O(log M)` moderate atoms remain in the
*invariant component*.

However, `R_S^perp` is still an unproved part of the same physical pairing.
The eigenvalues `1/(2-exp(2*pi*i*k/L))` describe an ideal unmarked geometric
resolvent on one affine orbit.  Their strict damping for `k!=0` is not a
bound for (IR.16): the physical landing law contains moving time supports,
first passage, the additive loss filter, and incomplete source bands.  No
commuting theorem between that marked source recurrence and the target-space
projection `I_S` has been proved.

Consequently the moderate-sector statement alone does not imply
`TH.SIGNED`, `DT.MIN`, or the Phase-3 headline.  The correct complete target
after removing (IR.13) is

\[
\boxed{
 \left[
  I^{\rm mod}_{S,T}+R_S^\perp
 \right]_+
 \le K^{-d+o(1)},
 }
\tag{IR.MIN}
\]

where `I^(mod)_(S,T)` is (IR.17) restricted to `t<T`.  For the
natural-density-only version the right side may be replaced by `o(1)`.
Both terms must be retained until their signed sum is formed.

This is an exact transfer of `TH.SIGNED` with a quantitatively negligible
high-valuation remainder.  It is not a relaxation to `MOD-INV` alone.

```text
ANTI-CIRCULARITY CARD
Old target:
  TH.SIGNED / DT.MIN for the complete marked two-scale pairing.
Proposed external target:
  MOD-INV on moderate affine-invariant sectors alone.
Audit result:
  MOD-INV does not imply the old target because R_S^perp is omitted.
Correct new target:
  IR.MIN = moderate invariant contribution plus the marked noninvariant
  complement, after the high-valuation invariant tail is removed by IR.13.
Strict burden removed:
  every target-space orbit atom with v_2(y+1)>=T.
New ingredient:
  exact invariant upper-failure reservoir plus support-sensitive transport.
Failure mode / kill test:
  a moderate atom or a marked noninvariant family whose combined positive
  IR.MIN contribution stays bounded away from zero.
```

```text
AFFINE-RESERVOIR CYCLE STATUS:
  affine orbit classification:                    PROVED-PAPER (DT.2--DT.5);
  logarithmic expression as active loss mark:      FALSE / wrong interface;
  additive odd-ladder displacement IR.3:           PROVED-PAPER;
  loss-boundary mass from displacement alone:      OPEN;
  invariant upper-failure reservoir IR.8:          PROVED-PAPER;
  high target-valuation contribution IR.13:        PROVED-PAPER / negligible;
  target-space projection IR.15--IR.17:             PROVED-PAPER identity;
  moderate invariant signed estimate MOD-INV:      OPEN;
  physical noninvariant complement R_S^perp:        OPEN / load-bearing;
  claim that MOD-INV is the sole active remainder:  FALSE;
  complete corrected target IR.MIN:                 OPEN;
  TH.SIGNED / Phase-3 headline improvement:         OPEN / NOT PROVED;
  manuscript and Lean status:                       UNCHANGED.
```

## 25. Moving-scale conversion to an arbitrary divergent endpoint

This section records the exact quantifier upgrade suggested by the fact that
every source belongs to one known dyadic shell.  It is a conditional
reassembly, not a proof of the missing scale-comparison theorem.

### 25.1 Literal shellwise target

Fix one function

\[
 f:\mathbb N\longrightarrow(0,\infty),
 \qquad f(n)\longrightarrow\infty,
\tag{MS.1}
\]

and one shortcut clock constant `c>2/log(4/3)`.  The good set may depend on
`f`; the witness time may depend on `n`.  For the shell `I_M`, define the
monotone tail lower envelope

\[
 F_M=\inf_{n\ge2^M}f(n).
\tag{MS.2}
\]

Then `F_M -> infinity` and `F_M<=f(n)` for every `n in I_M`.  Put

\[
 u_M=\sqrt{\log_2(M+2)},
 \qquad
 L_M=\left\lfloor
       \min\{\log_2F_M,u_M\}
     \right\rfloor.
\tag{MS.3}
\]

After an irrelevant finite startup,

\[
 L_M\longrightarrow\infty,
 \qquad
 L_M=o(\log M),
 \qquad
 2^{L_M}\le f(n)\quad(n\in I_M).
\tag{MS.4}
\]

The clipping by `u_M` loses nothing: proving a smaller endpoint than `f(n)`
is allowed, and it makes the moving-scale relation uniform even when `f`
itself grows quickly.

Choose fixed constants

\[
 0<\kappa<\kappa_*,
 \qquad
 0<\theta<2\kappa,
 \qquad
 \kappa_*=1-H_2(\log_32),
\tag{MS.5}
\]

and define the comparison scale

\[
 K_M=\left\lceil2^{\theta L_M}\right\rceil.
\tag{MS.6}
\]

Thus `K_M -> infinity`, `K_M=M^(o(1))`, and the former fixed exponent is

\[
 \lambda(M)=\frac{\log K_M}{\log M}\longrightarrow0.
\tag{MS.7}
\]

This is the precise meaning of a moving-scale theorem.  No parameter is
chosen from the individual residue `n`; it is chosen once for the whole
shell from `M` and the fixed function `f`.

### 25.2 Scalar terminal budget

At outer rank `K_M`, the proved support-sensitive first-passage profile has
the reference cost

\[
 K_M^{1/2+o(1)}2^{-\kappa L_M}
 =2^{-(\kappa-\theta/2+o(1))L_M}
 \longrightarrow0.
\tag{MS.8}
\]

The strict inequality `theta<2 kappa` is exactly the terminal budget.  It
works however slowly `L_M` tends to infinity.  The scalar obstruction is
therefore gone once the outer physical landing law can be replaced by its
law at scale `K_M` with an error tending to zero as `K_M -> infinity`.

Let

\[
 S_M=\lceil C_{\rm sw}\log_2(K_M+2)\rceil,
 \qquad L_M<S_M<K_M,
\tag{MS.9}
\]

where the fixed switch coefficient is chosen large enough.  Let
`C_M=C^(st)_(S_M,L_M)` be the same literal stopped terminal target as in
section 14, and put

\[
 g_M=\mathbf1_{C_M}-\delta_M\mathbf1_{J_{S_M}},
 \qquad
 \delta_M=\frac{|C_M|}{|J_{S_M}|}.
\tag{MS.10}
\]

### 25.3 Direct moving-scale closure criterion

The most compact missing theorem is the uniform comparison

\[
\boxed{
 \left[
  \langle\mu^{\rm sch}_{M,S_M}
          -\mu^{\rm sch}_{K_M,S_M},g_M\rangle
 \right]_+
 \le \varepsilon(K_M),
 \qquad
 \varepsilon(K)\longrightarrow0.
}
\tag{MS.RESET}
\]

The convergence must be uniform over the admissible moving terminal
parameters in (MS.3)--(MS.10).  A theorem proved only for each fixed
`lambda>0`, with constants allowed to diverge as `lambda` decreases, cannot
be substituted into (MS.RESET).

Under (MS.RESET), source centering gives

\[
\begin{aligned}
 \mu^{\rm sch}_{M,S_M}(C_M)
 &\le
 \mu^{\rm sch}_{K_M,S_M}(C_M)
 +\delta_M
 +\varepsilon(K_M)\\
 &\le
 2^{-(\kappa-\theta/2+o(1))L_M}
 +\delta_M+\varepsilon(K_M)
 \longrightarrow0.
\end{aligned}
\tag{MS.11}
\]

The total-mass correction `delta_M` is paid once, between the two endpoint
laws.  It must not be paid once per intermediate scale.

### 25.4 How the existing fixed-ratio target could imply MS.RESET

There is a more reusable route that does not prove an all-gap comparison in
one step.  Fix

\[
 0<\lambda_0<1,
 \qquad d>0,
\tag{MS.12}
\]

and write `X'=ceil(X^lambda_0)`.  Strengthen the current quantitative
`TH.SIGNED` target only by making its parameter dependence explicit:

For this iteration, take `mu^(sch)_(X,S)` to be the enlarged aligned law from
section 20, with the outer-rank-independent loss cap `D_S` from (AI.1) and
the canonical interval support `Hhat_(X,S)` from (AI.3).  This law is defined
from `(X,S)` alone.  Equations (AI.1)--(AI.7) and the proved literal-to-
enlarged headline implication show that consecutive comparisons use exactly
the same intermediate law; no pair-dependent redefinition is present.

\[
\boxed{
 \left[
  \langle\mu^{\rm sch}_{X,S}-\mu^{\rm sch}_{X',S},
          \mathbf1_{C^{\rm st}_{S,L}}-\delta_{S,L}\rangle
 \right]_+
 \le
 C(S+1)^C(X')^{-d}
}
\tag{TH.ITER}
\]

uniformly for the same physical law and every admissible

\[
 L<S\le C_{\rm sw}\log_2(X'+2).
\tag{MS.13}
\]

The requirement that the *same* law `mu^(sch)_(X,S)` occur in consecutive
applications is load-bearing.  Pair-dependent feasible-time filters, loss
caps, or normalizations would break the telescope and must first be aligned.

Starting from `X_0=M`, let

\[
 X_{j+1}=\lceil X_j^{\lambda_0}\rceil
\tag{MS.14}
\]

and stop at the first `J` with

\[
 \log_2X_J\le\theta L_M.
\tag{MS.15}
\]

Up to harmless rounding,

\[
 2^{\lambda_0\theta L_M}<X_J\le2^{\theta L_M}.
\tag{MS.16}
\]

Use `K_M=X_J` and keep the single target `g_M` fixed throughout the
telescope.  The coarse-scale errors form a reverse geometric tail:

\[
 \sum_{j<J}(X_{j+1})^{-d}
 \le 2K_M^{-d}
\tag{MS.17}
\]

for all sufficiently large `M`.  Polynomial factors in `S_M=O(L_M)` are
absorbed because

\[
 K_M^{-d}
 \le2^{-\lambda_0\theta dL_M+o(L_M)}.
\tag{MS.18}
\]

Crucially, the centered identity is telescoped first:

\[
 \langle\mu_M-\mu_{K_M},g_M\rangle
 =\sum_{j<J}
   \langle\mu_{X_j}-\mu_{X_{j+1}},g_M\rangle.
\tag{MS.19}
\]

Only after (MS.19) is formed are positive parts used.  The uncentered
`delta_M` correction is then paid once at the two endpoints.  Repeating the
one-step `UFP.TARGET` estimate with its separate `+delta_M` term would cost
`J delta_M`; for an arbitrarily slowly divergent `f`, that product need not
tend to zero.  Thus the quantitative centered theorem `TH.ITER`, rather than
the qualitative fixed-`lambda` theorem, is the correct iterable interface.

### 25.5 Conditional natural-density theorem

Assume either (MS.RESET), or the semigroup-compatible theorem (TH.ITER).
For each shell set

\[
 G_M=I_M\setminus\operatorname{Fail}^{\rm sh}_{M,L_M}.
\tag{MS.20}
\]

Equations (MS.8)--(MS.19), together with the already proved initial and
boundary estimates, give

\[
 \frac{|I_M\setminus G_M|}{2^M}=e_M,
 \qquad e_M\longrightarrow0.
\tag{MS.21}
\]

The shellwise dependence causes no natural-density loss.  For every fixed
startup `N_0`, dyadic summation gives

\[
 \limsup_{X\to\infty}
 \frac{\#\{n\le X:n\notin\bigcup_MG_M\}}{X}
 \le2\sup_{m\ge N_0}e_m.
\tag{MS.22}
\]

Hence `union_M G_M` has natural density one.  For `n in G_M`, the existing
first-passage execution gives

\[
 \boxed{
 \exists k<c\log n:\quad T^k(n)<2^{L_M}\le f(n).
 }
\tag{MS.23}
\]

Because `S_M=O(L_M)=o(\log M)`, the current same-witness
`n^(1+beta)` orbit ceiling also survives for every fixed `beta>0`.

Thus (TH.ITER) would yield the natural-density analogue of Tao's arbitrary-
diverging endpoint, together with the explicit first-passage clock and the
existing orbit ceiling.  This is a conditional consequence only.

### 25.6 Target-sanity, anti-circularity, and status

```text
LITERAL TARGET:
  for every fixed f(n)->infinity, c>2/log(4/3), and beta>0, construct a
  natural-density-one set (depending on f,c,beta) on which one witness
  k<c log n reaches below f(n) and stays below n^(1+beta) through k.

CAPACITY / POSITIVE CALIBRATION:
  L_M->infinity supplies a growing terminal target; f(n)=(log n)^A recovers
  the fixed-polylog scale.

NEGATIVE BOUNDARY:
  bounded f gives bounded L_M and K_M, so neither MS.8 nor MS.18 vanishes.
  No fixed bounded endpoint is claimed.

TARGET-SANITY STATUS:
  UNKNOWN-BUT-INTENDED.  The scalar and natural-density assembly close;
  the physical moving-scale comparison is open.

OLD TARGET:
  TH.SIGNED for one fixed pair K=M^lambda.

NEW TARGET:
  TH.ITER for one fixed coarse ratio lambda_0, uniform in the lower terminal
  band and composable along a geometric chain.

CLASSIFICATION:
  a genuine strengthening in uniformity, not a reformulation.  Its payoff
  is also stronger: it implies MS.RESET for lambda(M)->0 and hence every
  divergent endpoint f.

LOAD-BEARING NEW REQUIREMENTS:
  a fixed power d>0 in the centered comparison;
  uniformity for L<S=O(log X');
  target held fixed across the coarse-scale telescope.

ALREADY DISCHARGED INTERFACES:
  AI.1 gives one loss cap D_S independent of the outer rank;
  AI.3 gives one feasible-time interval Hhat_(X,S) depending only on X,S;
  AI.7 controls adjacent support mismatch;
  the enlarged law still contains every literal headline failure.

KILL TEST:
  an explicit moving target family with L->infinity for which a fixed-ratio
  centered increment has positive size at least X'^(-o(1)), or a proof that
  the required physical laws cannot be aligned under scale composition.
```

```text
MOVING-SCALE STATUS:
  shellwise target selector MS.2--MS.7:              PROVED-PAPER;
  terminal scalar budget MS.8:                       PROVED-PAPER;
  shellwise-to-natural-density assembly MS.22:       PROVED-PAPER;
  pair-independent aligned-law iteration interface:   PROVED-PAPER (AI.1--AI.7);
  MS.RESET -> arbitrary-diverging endpoint MS.23:    PROVED-PAPER implication;
  TH.ITER -> MS.RESET by coarse telescoping:          PROVED-PAPER implication;
  TH.ITER:                                            OPEN;
  arbitrary-diverging natural-density headline:      NOT PROVED;
  manuscript and Lean status:                        UNCHANGED.

NEXT EXACT TARGET:
  prove or kill TH.ITER for the aligned enlarged law at the frozen values
  lambda_0=.97 and d=.001, uniformly for L<S<=C_sw log_2(X'+2).  The
  interface audit is complete; the remaining burden is the signed physical
  scale comparison itself.
```

## 26. Moving-scale proof cycle: totalized passage and harmonic renewal

This cycle applies the proof harness to the open physical comparison in
Section 25.  It separates an exact new reduction from a tempting but false
mixing heuristic.

### 26.1 Literal consumer and backward failure analysis

The consumer is still (MS.RESET), and hence the arbitrary-diverging endpoint
in (MS.23).  The weakest useful producer is not necessarily the marked
pairwise estimate (TH.ITER).  It is enough to compare the **totalized direct
first-passage laws** at the terminal target.

Let `Pass_S(n)` be the **unrestricted** direct first-passage landing in the
terminal shell, with a cemetery value if no such passage occurs.  The
scheduled high-phase timeout is charged separately in `HighFail_M`.  For a
stopped terminal target `C=C^st_(S,L)`, put

\[
 \Phi_{S,L}(n)
 =
 \mathbf 1_{\{\operatorname{Pass}_S(n)\in C\}}.
\tag{HP.1}
\]

On every state strictly above the terminal boundary,

\[
 \Phi_{S,L}(Tn)=\Phi_{S,L}(n).
\tag{HP.2}
\]

This includes the cemetery case.  Strict threshold nesting and the existing
single-switch reduction imply

\[
 \operatorname{Fail}_{M,L}
 \subseteq
 \operatorname{HighFail}_M
 \cup
 \{n:\Phi_{S,L}(n)=1\}.
\tag{HP.3}
\]

Consequently, a comparison theorem for the totalized law can bypass the
time and loss marks used by the elementary tagged-fibre proof.  Those marks
remain useful for (TH.ITER), but they are not logically intrinsic to the
headline consumer.

This is an assembly simplification, not yet an estimate: the distribution of
`Phi_(S,L)` under the outer shell remains to be controlled.

### 26.2 Exact flat--harmonic decomposition

For the dyadic shell

\[
 I_X=[2^X,2^{X+1})\cap\mathbb N,
\]

write `U_X` for normalized counting measure and `H_X` for normalized harmonic
measure, with weight proportional to `1/n`.  Let `nu^U_(X,S)` and
`nu^H_(X,S)` be their totalized first-passage pushforwards.  For any two outer
scales `X>X'>S` and any centered terminal test `g`, identically

\[
\begin{aligned}
 \langle\nu^U_{X,S}-\nu^U_{X',S},g\rangle
 &=\langle\nu^U_{X,S}-\nu^H_{X,S},g\rangle\\
 &\quad+\langle\nu^H_{X,S}-\nu^H_{X',S},g\rangle\\
 &\quad+\langle\nu^H_{X',S}-\nu^U_{X',S},g\rangle.
\end{aligned}
\tag{HP.4}
\]

No absolute values have been inserted in (HP.4).  It exposes two distinct
burdens:

1. flat-to-harmonic passage comparison at each endpoint scale;
2. scale stability of the harmonic passage law.

If both are controlled by one terminal error `epsilon(S)->0`, then the direct
reset (MS.RESET) follows without a fixed-power intermediate scale and without
the coarse telescope in (MS.14).

### 26.3 Exact harmonic sibling recurrence

Let the shortcut Collatz map be

\[
 T(2u)=u,
 \qquad
 T(2u+1)=A(u)=3u+2.
\]

For any `0<=Phi<=1` satisfying `Phi(Tn)=Phi(n)` above the terminal boundary,
define the unnormalized harmonic shell mass

\[
 \mathcal H_X(\Phi)=\sum_{u\in I_X}\frac{\Phi(u)}u.
\tag{HP.5}
\]

Splitting `I_(X+1)` into even and odd children gives

\[
 \mathcal H_{X+1}(\Phi)
 =
 \frac12\mathcal H_X(\Phi)
 +
 \sum_{u\in I_X}\frac{\Phi(A(u))}{2u+1}.
\tag{HP.6}
\]

The odd weight has the exact decomposition

\[
 \frac1{2u+1}
 =
 \frac3{2(3u+2)}
 +
 \frac1{2(2u+1)(3u+2)}.
\tag{HP.7}
\]

Therefore

\[
 \boxed{
 \mathcal H_{X+1}(\Phi)
 =
 \frac12\mathcal H_X(\Phi)
 +
 \frac32
 \sum_{u\in I_X}\frac{\Phi(3u+2)}{3u+2}
 +\mathcal R_X(\Phi)
 }
\tag{HP.8}
\]

with the explicit positive remainder

\[
 0\le\mathcal R_X(\Phi)
 =
 \sum_{u\in I_X}
 \frac{\Phi(3u+2)}{2(2u+1)(3u+2)}
 \le\frac1{12\,2^X}.
\tag{HP.9}
\]

Thus harmonic reweighting removes the large branch distortion exactly, up to
an exponentially small boundary term.  The only nontrivial term in (HP.8) is
the target-weighted mass on the affine progression

\[
 3I_X+2
 =
 \{z:z\equiv2\pmod3,\ 3\cdot2^X+2\le z<6\cdot2^X\}.
\tag{HP.10}
\]

This identifies the residual obstruction precisely: it is a `3`-adic phase
discrepancy of the **first-passage observable**, not a discrepancy of the raw
source interval and not a positive moment of the landing fibres.

### 26.4 Worked example and empirical kill test

The naive shortcut would assert that a direct first-passage landing is close
to uniform on its terminal shell once the outer scale is moderately larger.
Exact complete-shell enumeration rejects that mechanism at accessible depth.
For unrestricted direct passage from `I_X` to rank `floor(rX)`, the total
variation distance from the uniform terminal law was:

| `r` | tested `X` | observed TV range |
|---:|---:|---:|
| `0.82` | `12,14,16,18,20` | `0.475--0.488` |
| `0.85` | `12,14,16,18,20` | `0.463--0.480` |
| `0.90` | `12,14,16,18,20` | `0.460--0.463` |
| `0.95` | `12,14,16,18,20` | `0.386--0.389` |

All terminal cells were occupied.  Restricting to passage times `h<=X` did
not repair uniformity: at `(r,X)=(0.90,20)` the retained source mass was
`0.7944` and the centered TV distance was `0.3296`; at `(0.95,20)` the
corresponding values were `0.8852` and `0.3135`.

This does **not** disprove target-specific convergence or (TH.ITER).  It kills
only the proposed proof by uniformizing the whole entrance law.  The surviving
claim must exploit the special stopped target, preserve its sign, or compare
both laws through a common harmonic profile.

For one literal-style recursive low target with `(r,eta)=(0.9,0.2)`, fixed
`(S,L)=(10,6)`, and outer scales `X=12,14,16,18,20,22`, the measured target
masses were

\[
 0.912353516,
 0.912353516,
 0.913436890,
 0.913833618,
 0.913569450,
 0.913724899.
\tag{HP.11}
\]

The increments oscillate in sign and are small, which is compatible with a
common-profile theorem, but this is `EMPIRICAL` evidence only.  The diagnostic
target is a calibration of the stopped language, not a substitute for the
canonical filtered object.

### 26.5 What has and has not been proved

The exact recurrence (HP.8) is the first new proof step in this cycle.  It
also explains why the two-dimensional/PCA intuition was incomplete: after
harmonic normalization, one coordinate is neutralized algebraically, while
the other is the arithmetic phase `z mod 3` propagated through later affine
branches.  A covariance ellipse alone does not control that phase.

The next analytic theorem has two load-bearing parts.  For narrow
multiplicative bands `B` above the terminal boundary, seek a profile
`Pi_(S,L)` independent of the outer band such that

\[
 \left|
 \mathbb E_{H_B}\Phi_{S,L}
 -\Pi_{S,L}
 \right|
 \le
 C(S+1)^B\,R^{-d},
\tag{HP.BAND}
\]

for one fixed `d>0`, uniformly in `L<S=O(log R)`, **and** the profile density
`pi=dPi/dU_S` must obey, for example,

\[
 \int_{J_S}\pi^{3/2}\,dU_S\le (S+1)^{B_0}.
\tag{HP.ENERGY}
\]

Without (HP.ENERGY), band independence alone gives no reason for a sparse
stopped target to have small profile mass.  Exact convex mixing of the bands
must be retained so that no factor equal to the number of bands is
introduced.  A terminal error `epsilon(S)->0` would already suffice for the
direct moving-scale reset; the fixed-power form is stronger than logically
necessary.

This is the point at which phase separation for `log 3/log 2`, local Gaussian
control of the odd-count bands, or an equivalent generated coboundary must
enter.  It is also the precise overlap with known flat-to-harmonic
first-passage bridges in the literature.  Using such a theorem is a method
change and requires a full structural-transfer and priority audit; it cannot
be presented as a consequence of the existing tagged-fibre estimates.

```text
PROVED-PAPER IN THIS CYCLE:
  totalized target observable is orbit-invariant above the boundary (HP.2);
  marked-law filters are not intrinsic to the headline inclusion (HP.3);
  exact flat--harmonic three-term identity (HP.4);
  exact harmonic sibling recurrence and exponential remainder (HP.6--HP.9).

EMPIRICAL:
  full entrance law remains far from uniform at X<=20;
  one stopped-target calibration has small, sign-oscillating scale increments.

REJECTED AS A PROOF MECHANISM:
  replace the switch entrance law by the uniform terminal law;
  control the target by total variation of the full entrance law;
  infer the moving-scale theorem from a two-dimensional covariance/PCA bound.

OPEN:
  HP.BAND plus HP.ENERGY, or their target-specific consequence MS.PROFILE;
  TH.ITER for the marked aligned law;
  MS.RESET and the arbitrary-diverging natural-density headline.

DECISION:
  the cycle has progressed beyond a pure reformulation: the loss/time marks
  can be bypassed at the headline level, and harmonic weighting yields the
  exact recurrence (HP.8).  It has not closed the analytic phase estimate.

NEXT PROVE-OR-KILL TARGET:
  derive HP.BAND first for the literal stopped observable at one frozen band
  ratio and one d>0, keeping complete-band convex weights and the signed
  residue-class phase.  Kill the route if an explicit generated affine family
  produces a nondecaying positive band discrepancy.
```

### 26.6 Exact common-profile closure theorem

The normalization gate above has a clean deterministic payoff.  Let `mu` be
the totalized landing law on `J_S`, let `Pi` have density `pi` with respect to
`U_S`, and suppose

\[
 \sup_E|\mu(E)-\Pi(E)|\le\varepsilon_S,
 \qquad
 \int\pi^{3/2}\,dU_S\le P_S.
\tag{HP.12}
\]

For every `C subset J_S` of uniform density `delta`, Holder gives

\[
 \Pi(C)
 =\int_C\pi\,dU_S
 \le
 \left(\int\pi^{3/2}\,dU_S\right)^{2/3}
 U_S(C)^{1/3}
 \le P_S^{2/3}\delta^{1/3}.
\tag{HP.13}
\]

Therefore

\[
 \boxed{
 \mu(C)\le P_S^{2/3}\delta^{1/3}+\varepsilon_S.
 }
\tag{MS.PROFILE}
\]

For the literal moving schedule,

\[
 \delta_{S,L}\ll e^{-\kappa L},
 \qquad
 S\asymp L,
 \qquad
 P_S\le(S+1)^{B_0},
 \qquad
 \varepsilon_S\longrightarrow0.
\tag{HP.14}
\]

Hence

\[
 P_S^{2/3}\delta_{S,L}^{1/3}
 \ll
 (S+1)^{2B_0/3}e^{-\kappa L/3}
 \longrightarrow0.
\tag{HP.15}
\]

Combining (HP.3), (MS.PROFILE), and the already proved high-phase estimate
closes (MS.RESET), and therefore (MS.23), provided the two profile inputs in
(HP.12) are proved uniformly for the physical totalized law.

This is a genuine weakening of (TH.ITER): no fixed power of the outer scale,
no comparison between two marked laws, and no relative error at the tiny
target density are needed.  The phase error may decay arbitrarily slowly as
a function of the terminal rank, as long as it tends to zero.

### 26.7 Audit against the existing `q<2` renewal and the known bridge

The frozen short-corridor development contains a real subcritical
`q=1+theta<2` correction-fibre theory.  In particular its reverse-spend
kernel has ratio strictly below one for `0<theta<1`; `theta=1/2` is the
required `q=3/2` point.  This is strong evidence for (HP.ENERGY), and it is a
reusable producer rather than the false `q>2` moment route.

It does **not** automatically prove (HP.ENERGY) for `Pi_(S,L)`.  A structural
transfer is still required from:

1. the fixed-total correction-residue moment;
2. the terminal suffix kernel;
3. the reconstructed first-passage endpoint profile.

For the periodic residue weight `w(r)=R p(r)`, one exact part of that transfer
is elementary.  On any interval `J` of length `N`, each residue modulo `R`
occurs at most `N/R+1` times, so for every `q>1`,

\[
 \frac1N\sum_{n\in J}w(n\bmod R)^q
 \le
 \left(1+\frac RN\right)
 \frac1R\sum_{r\bmod R}w(r)^q.
\tag{HP.16}
\]

Thus complete-block mixing does not lose the `q=3/2` moment.  The remaining
nontrivial transfer is the first-passage reconstruction, where many terminal
suffix states are pushed to the same endpoint.  That step may not be replaced
by (HP.16) alone.

The known natural-counting first-passage bridge supplies precisely the other
kind of input: a band-uniform flat/harmonic comparison through a common
profile with every strict phase exponent `d<5/143`, followed by exact convex
mixing.  Its local theorem is for totalized passage laws, so using it only as
a distributional bridge would not itself add its much larger orbit clock to
our witness.  However, its printed global reconstruction and the present
stopped target/profile energy are not literally the same theorem.  A valid
import therefore still needs:

* raw/shortcut and odd/all-integer source adapters;
* the outer-band-to-terminal iteration with no band-count factor;
* the transfer of the `q=3/2` correction moment to the common endpoint
  profile;
* the inclusion (HP.3) with the current first-passage clock and orbit ceiling.

This is a method-level fork, not a free citation.  If completed, it would use
the established phase mechanism only for the natural-counting distribution
and retain the present `c>2/log(4/3)` witness clock from the independent
first-passage schedule.

```text
NEW EXACT CLOSURE:
  HP.12 -> MS.PROFILE -> MS.RESET -> MS.23:       PROVED-PAPER implication.

AVAILABLE REUSABLE PRODUCER:
  subcritical correction-residue moments at q=3/2: PROVED-FORMAL in the
  frozen short-corridor development, not yet transferred into V3.

PROVED IN THIS AUDIT:
  periodic complete-block moment transfer HP.16:   PROVED-PAPER.

STILL OPEN / LOAD-BEARING:
  first-passage reconstruction of HP.ENERGY;
  uniform common-profile error epsilon_S->0 for the V3 totalized law;
  all map, source-law, and clock-preserving adapters.

VERDICT:
  CONDITIONAL BREAKTHROUGH IN ASSEMBLY, NOT A CLOSED HEADLINE.  The former
  moving-scale power estimate is stronger than necessary.  The live theorem
  is now convergence to a polynomial-q=3/2 common profile at terminal rank
  S, with any o(1) phase error.
```

## 27. Fixed-rank diagonalization and labelled-profile audit

This section audits the proposed fixed-`S` common-profile programme against
the literal V3 high-phase interface and the frozen fixed-total theorem.  Two
reductions are valid, one reference measure must be corrected, and two
claimed implications require additional hypotheses.

### 27.1 Exact fixed-rank diagonal lemma

Let `e_(M,S)>=0` be defined for `M>S`.  Assume only

\[
 \forall S\ge1,
 \qquad
 e_{M,S}\longrightarrow0
 \quad(M\to\infty).
\tag{FD.1}
\]

Let `F_M->infinity`, fix `0<lambda<1`, and let `h(S)->0`.  There is an
integer sequence `S_M` such that

\[
 S_M\longrightarrow\infty,
 \qquad
 S_M=o(M),
 \qquad
 \lambda S_M\le\log_2F_M,
 \qquad
 e_{M,S_M}\le\frac1{S_M}.
\tag{FD.2}
\]

Indeed, choose increasing integers `M_j` so large that, for every `M>=M_j`,

\[
 e_{M,j}\le j^{-1},
 \qquad
 \log_2F_M\ge\lambda j,
 \qquad
 M\ge j^2.
\tag{FD.3}
\]

After replacing `M_j` by a strictly increasing majorant, set `S_M=j` on
`[M_j,M_(j+1))`.  All four assertions in (FD.2) follow immediately.  With
`L_M=floor(lambda S_M)`, any estimate

\[
 b_M
 \le
 h(S_M)
 +(S_M+1)^{2B/3}e^{-\kappa L_M/3}
 +e_{M,S_M}
\tag{FD.4}
\]

therefore gives `b_M->0`.  The standard dyadic shell-to-prefix summation then
gives natural density zero.

This proves that **fixed-rank convergence is enough for the scalar moving
endpoint assembly**.  It does not prove that the current physical schedule
supplies the first term `h(S_M)`.

### 27.2 High-phase interface: not discharged by the current theorem

The proved shrinking-barrier theorem uses

\[
 S_M=\lceil C_{\rm sw}\log(M+2)\rceil
\tag{FD.5}
\]

and the inequality

\[
 m\ge S_M\ge C_{\rm sw}\log(M+2)
\tag{FD.6}
\]

to make the cap in the high-rank tolerance inactive.  This is the step that
turns every high-rank bad target into a fixed negative power of `M`.  If
`S_M` is selected arbitrarily slowly, (FD.6) is false.  Proposition 6.2 and
Theorem 6.3 of the present manuscript therefore do **not** imply a
shell-independent envelope

\[
 \operatorname{HighFail}(M,S)/2^M\le h(S),
 \qquad h(S)\to0.
\tag{FD.HIGH}
\]

This is not a constants issue: the current transported union contains the
outer feasible-time factor and was closed by a power of `M`.  Replacing that
power by `e^{-cS}` before reassembly is invalid when `S` may grow more slowly
than every multiple of `log M`.

Consequently `CP.HIGH-INTERFACE` remains load-bearing.  It must be proved by
one of the following mechanism-distinct routes:

1. a new source-weighted high-phase argument giving (FD.HIGH);
2. incorporation of the high-phase path event into the fixed-rank common
   profile, with its reference mass tending to zero;
3. a two-switch construction that retains the proved logarithmic switch and
   proves regeneration from its generated landing law.

The fixed-`S` diagonal lemma does not choose among these routes.

### 27.3 Exact centered harmonic increment

Let `m=m_X(Phi)`.  Apply (HP.8) both to `Phi` and to the constant function
one, and subtract `m` times the latter identity.  The first shell term
vanishes because

\[
 \mathcal H_X(\Phi-m)=0.
\]

Therefore

\[
\boxed{
 Z_{X+1}\bigl(m_{X+1}(\Phi)-m_X(\Phi)\bigr)
 =
 \frac32\sum_{u\in I_X}
 \frac{\Phi(3u+2)-m_X(\Phi)}{3u+2}
 +\mathcal R_X(\Phi)-m_X(\Phi)\mathcal R_X(1).
}
\tag{FD.7}
\]

Since `0<=Phi<=1`, the last two terms have absolute value at most
`R_X(1)<=1/(12*2^X)`.  Thus a summable bound on the centered affine term
does imply convergence of `m_X(Phi)`.

There is, however, a source-carrier mismatch in the proposed flat conversion.
Equation (FD.7) is an identity on the full dyadic shell `I_X`.  Partitioning
`I_X` into narrow multiplicative bands requires convergence for each band
position (or a uniform band theorem); convergence of the whole-shell average
does not imply convergence of its pieces.  The correct fixed-rank phase target
must therefore be stated on the literal band carriers used in the convex
mixture.

### 27.4 Correct labelled Hölder reference

Retaining reconstruction labels before taking the `3/2` moment is a genuine
burden reduction.  The safest reference weights are the **nominal pre-filter
label weights**, not automatically the actual post-filter profile marginal.

Let `b_lambda>=0`, `sum b_lambda<=1`, be nominal regenerative weights and let
`Pi_tilde` be a labelled submeasure satisfying

\[
 \Pi_{\lambda}(J_S)\le b_\lambda.
\tag{FD.8}
\]

Use

\[
 \widetilde U_S
 =\sum_\lambda b_\lambda\,\delta_\lambda\otimes U_S.
\tag{FD.9}
\]

Deleting first-passage atoms then decreases the unnormalized density with
respect to this fixed reference; it does not renormalize a small surviving
label.  If

\[
 \widetilde P_S
 =\int
 \left(\frac{d\widetilde\Pi_S}{d\widetilde U_S}\right)^{3/2}
 d\widetilde U_S,
\tag{FD.10}
\]

then the lifted endpoint target has reference mass

\[
 \widetilde U_S(\mathcal L_S\times C)
 =\delta\sum_\lambda b_\lambda
 \le\delta.
\tag{FD.11}
\]

Holder gives exactly

\[
 \Pi_S(C)
 \le\widetilde P_S^{2/3}\delta^{1/3}.
\tag{FD.12}
\]

Using the actual label marginal is also possible, but then every deletion and
conditional renormalization must be priced explicitly.  The nominal reference
in (FD.9) makes the claimed monotonicity literal.

### 27.5 Fixed truncation: exact spectral-gap certificate

The proposed irrationality argument becomes rigorous only after an exact
finite-state reconstruction.  The reusable finite lemma is the following.

Let `P=(p_ij)` be an irreducible stochastic matrix on a finite state space,
and let

\[
 Q_{ij}=p_{ij}\zeta_{ij},
 \qquad |\zeta_{ij}|=1
\tag{FD.13}
\]

on every positive edge.  Then `rho(Q)<=1`.  If `rho(Q)=1`, equality in the
triangle inequality for a peripheral eigenvector forces phases `v_i` and a
unit scalar `omega` satisfying

\[
 \zeta_{ij}v_j=\omega v_i
\tag{FD.14}
\]

on every positive edge.  Hence any two positive paths of the same length and
with the same initial and terminal states have equal phase product.  Therefore:

\[
 \boxed{
 \text{two such paths with unequal phase products imply }\rho(Q)<1.
 }
\tag{FD.TWIST}
\]

Proof: choose an eigenvector for a peripheral eigenvalue and an index where
its modulus is maximal.  The stochastic row sum gives a chain of two
triangle inequalities bounded by that maximum.  Equality propagates through
irreducibility, forces equal modulus on all states and common phase on every
outgoing term, which is (FD.14).  Multiplying (FD.14) along two equal-length
paths proves the contrapositive.

This proves the **abstract** spectral certificate.  The physical application
still has to prove that, after retaining the invariant sectors:

* the truncated reconstruction is a finite closed Markov state;
* every recurrent noninvariant class is irreducible;
* two admissible equal-length paths with distinct phase products actually
  exist in each such class.

Irrationality of `log_2 3` proves the two products differ once the two paths
have been constructed.  It does not construct the paths or prove closure of
the state space.

### 27.6 The full untruncated phase estimate is stronger than necessary

A bound of the form

\[
 \left|\mathcal A_{X,S,C}\right|
 \le C_{S,C}2^{-d_SX}
\tag{FD.15}
\]

for the full physical operator would certainly close fixed-`S` convergence,
but it need not follow from fixed truncations: their spectral gaps may tend
to zero as the truncation is removed.

The weaker sufficient theorem is the ordered two-limit statement:

\[
 \forall S,C,\epsilon>0\ \exists R\ \exists X_0\ \forall X\ge X_0,
 \qquad
 \left|m_X(\Phi_{S,C})-\Pi_{S,R}(C)\right|
 \le\epsilon+\operatorname{Tail}_S(R),
\tag{FD.PHASE-S}
\]

with `Tail_S(R)->0`.  For fixed `R`, (FD.TWIST) may supply an arbitrarily bad
but positive spectral gap.  One first takes `X->infinity`, then `R->infinity`.
No single `d_S` for the untruncated operator is consumed by the diagonal
assembly.

The same theorem must hold on the finite family of narrow relative band
positions used to compare flat and harmonic measures.  Since `S` and the
band ratio are fixed before `X->infinity`, all constants may depend on them.

### 27.7 Fixed-total status correction

The scalar estimate

\[
 B_N(1/2)\le\frac94N
\tag{FD.16}
\]

has a complete paper derivation in the frozen stretched-log manuscript.  The
matching declaration located in the frozen Lean API is not (FD.16):
`fixedCriticalAverage_le` exports the conservative bound `8*N`, and the
global endpoint-information declaration later pays an additional mixture
loss.  Accordingly:

```text
FD.16:                 PROVED-PAPER in the frozen manuscript;
exact FD.16 formal API: NOT IDENTIFIED in this audit;
weaker critical moment: PROVED-FORMAL;
transfer to labelled profile energy: OPEN.
```

The constant is immaterial for qualitative closure, but its theorem status
must not be upgraded during the transfer.

### 27.8 Corrected proof programme and closeout

```text
STRONGEST PROVED BASELINE:
  natural-density fixed-polylog descent for every A>9.991113... with the
  frozen shortcut clock and same-witness orbit ceiling.

LITERAL NEW TARGET:
  for every f(n)->infinity, construct a shellwise diagonal schedule giving
  the same leading shortcut clock, a moving endpoint below f(n), and natural
  density one.

TARGET-SANITY:
  UNKNOWN-BUT-INTENDED.  Fixed-S diagonal capacity is proved; the physical
  high-phase and common-profile inputs remain open.

GENUINE BURDENS REMOVED:
  no moving-S quantitative phase exponent;
  no full total variation;
  no unlabelled endpoint moment;
  no uniform spectral gap as truncation R->infinity.

NEW EXACT RESULTS:
  fixed-rank diagonal lemma FD.1--FD.4:          PROVED-PAPER;
  centered harmonic increment FD.7:             PROVED-PAPER;
  nominal-labelled Holder FD.8--FD.12:           PROVED-PAPER;
  finite twisted-kernel certificate FD.TWIST:    PROVED-PAPER;

OPEN / LOAD-BEARING:
  CP.HIGH-INTERFACE, since current S=C_sw log M is not slowly movable;
  exact truncated first-passage reconstruction on narrow bands;
  physical path-pair certificate in every noninvariant recurrent class;
  uniform-in-outer-scale reconstruction tail at fixed S;
  stationary nominal label-weight moment;
  suffix recurrence including primitive and word-exhaustion boundaries.

ONE KILL TEST:
  in one fixed S and truncation R, construct the exact recurrent classes of
  the physical twisted operator.  Kill the proposed spectral mechanism if a
  noninvariant recurrent class has no unequal-phase equal-length path pair,
  or if the reconstruction tail is not uniform in the outer band.

ROUTE DECISION:
  ALIVE / NARROWED.  This is a valid qualitative diagonal architecture, not
  yet a proof of the arbitrary-diverging endpoint.

NEXT EXACT TARGET:
  CP.HIGH-INTERFACE first, because failure there blocks the headline even if
  the profile phase and energy theorems are proved.  In parallel notation,
  specify whether high failure is bounded separately, absorbed into the
  labelled profile, or handled by a proved two-switch regeneration theorem.
```

## 28. Two-switch joint discharge of the high interface

The third option in Section 27.2 gives a coherent coupled theorem in place of
a new standalone estimate (FD.HIGH).  It retains the proved logarithmic high
switch and asks the fixed-rank profile to erase the generated landing law
during the continuation from that switch to the terminal rank.  This removes
one assembly interface but strengthens the admitted source class; it is a
mechanism-distinct joint discharge, not uniformly an easier theorem.

### 28.1 Available first-switch inputs

Fix a terminal rank `S` and a reconstruction truncation `R`.  For a constant
`C_sw=C_(S,R)` to be chosen, put

\[
 Q_M=\left\lceil C_{S,R}\log(M+2)\right\rceil.
\tag{TS.1}
\]

For each fixed choice of `C_(S,R)`, the existing shrinking-barrier theorem
applies once `M` exceeds its parameter-dependent startup.  By enlarging
`C_(S,R)` and choosing `D_hi` within

\[
 D_{\rm hi}/\sqrt{C_{S,R}}\le\tau,
\tag{TS.2}
\]

the high exponent in (6.9) can be made larger than the polynomial
time-support cost in (6.10).  Hence the first switch reaches rank `Q_M` with
failure `o_(S,R)(1)`.

The same tagged-fibre and compressed-time estimates give the normalized
generated landing density `f_(M,Q_M)` the available cap

\[
 \|f_{M,Q_M}\|_\infty
 \le M^{1/2+o_{S,R}(1)}.
\tag{TS.3}
\]

This cap is not a mixing theorem.  It is only the initial norm to be consumed
by the second switch.

### 28.2 Exact regeneration theorem sufficient for the continuation

Let `K_(Q,S,R)` be the labelled, truncated, first-passage continuation
operator from rank `Q` to terminal rank `S`, and let `Pi_(S,R)` be its labelled
zero-mode profile.  The sufficient physical theorem is:

\[
\boxed{
 \left\|
 \nu K_{Q,S,R}-\Pi_{S,R}
 \right\|_{\rm TV}
 \le
 A_{S,R}\rho_{S,R}^{\,Q-S}
 \left\|\frac{d\nu}{dU_Q}\right\|_\infty
 +\operatorname{Tail}_S(R),
 \qquad 0<\rho_{S,R}<1.
}
\tag{TS.REGEN}
\]

The consumer needs this only for the actual class of schedule-generated
landing submeasures.  Section 29.3 proves that the displayed all-density
formulation is false in its exact, nonvacuous form for a nondegenerate
deterministic continuation;
until (TS.REGEN) is restricted to the actual generated family, it is only a
conditional algebraic socket.  Every label and the nominal reference from
(FD.9) are part of the operator type.

Insert (TS.1) and (TS.3).  Since

\[
 \rho_{S,R}^{Q_M}
 =M^{C_{S,R}\log\rho_{S,R}+o(1)},
\tag{TS.4}
\]

choosing

\[
 C_{S,R}>
 \frac{1/2+\epsilon}{-\log\rho_{S,R}}
\tag{TS.5}
\]

makes the first term in (TS.REGEN) tend to zero.  No uniform lower bound on
the spectral gap as `S,R` vary is needed.

If the labelled profile has energy `P_(S,R)`, then for the stopped target of
density `delta_(S,L)`, (FD.12) yields

\[
 \nu K_{Q_M,S,R}(C^{\rm st}_{S,L})
 \le
 P_{S,R}^{2/3}\delta_{S,L}^{1/3}
 +o_{S,R}(1)
 +\operatorname{Tail}_S(R).
\tag{TS.6}
\]

Thus (TS.REGEN), the labelled energy bound, and tail removal jointly discharge
both the generated-input problem and `CP.HIGH-INTERFACE`.

### 28.3 Diagonalization with parameter-dependent switch constants

For the qualitative theorem, choose in order:

1. terminal rank `S=j`;
2. truncation `R_j` with `Tail_j(R_j)<=1/j`;
3. a finite spectral gap `rho_(j,R_j)<1`;
4. a switch constant `C_j` satisfying (TS.2), (TS.5), and the high-density
   exponent requirement;
5. a startup `M_j` after which every fixed-`j` error is at most `1/j`.

Increase `M_j` further so that

\[
 \frac{C_j\log(M+2)}M\le\frac1j
 \qquad(M\ge M_j)
\tag{TS.7}
\]

and so that `lambda*j<=log_2 F_M`.  Set the diagonal terminal rank equal to
`j` on `[M_j,M_(j+1))`.

Although `C_j` may grow arbitrarily fast, (TS.7) makes the entire second-phase
rank and clock cost `o(M)` along the diagonal.  The leading shortcut clock is
therefore unchanged.  The low phase begins below

\[
 2^{Q_M+1}=(M+2)^{C_j+o(1)}=2^{o(M)},
\]

so the same fixed-tolerance continuation also preserves the `n^(1+beta)`
same-witness ceiling after increasing the startup.

This is a valid use of parameter-dependent constants: for each diagonal
level they are fixed before the outer-shell limit is taken, and every later
level receives its own startup threshold.

### 28.4 Anti-circularity and revised frontier

```text
OLD COUPLED BURDEN:
  a slowly moving switch S_M together with an unproved standalone high-phase
  envelope h(S_M), plus common-profile control of the outer landing law.

NEW JOINT-DISCHARGE THEOREM:
  TS.REGEN for each fixed (S,R), labelled profile energy, and a uniform
  reconstruction tail.

PROOF THAT THE NEW BUNDLE CLOSES THE OLD CONSUMER:
  current high theorem -> generated cap TS.3;
  choose C_(S,R) by TS.5 -> regeneration error o(1);
  labelled Holder -> TS.6;
  diagonal choices TS.7 -> endpoint, density, clock, and orbit ceiling.

STRICT BURDEN REMOVED:
  no standalone FD.HIGH at an arbitrarily slow physical switch;
  no independence assumption on the generated landing law;
  no spectral gap uniform in S or truncation R.

NEW INGREDIENT:
  contraction of the literal labelled continuation operator acting on the
  generated switch law.

FAILURE MODE:
  the truncated physical operator has a noninvariant recurrent class with
  spectral radius one, or its tail is not uniform for generated inputs with
  the cap TS.3.

STATUS:
  scalar two-switch assembly TS.1--TS.7:       PROVED-PAPER implication;
  first-switch high estimate and cap TS.3:     AVAILABLE from current proof;
  abstract finite gap certificate FD.TWIST:    PROVED-PAPER;
  exact/nonvacuous all-density TS.REGEN:       FALSE by Section 29.3;
  generated-source TS.GEN:                     OPEN;
  labelled profile energy and tail:            OPEN;
  arbitrary-diverging headline:                NOT PROVED.

NEXT EXACT TARGET:
  construct K_(Q,S,R) for one fixed small (S,R), list its recurrent classes,
  and verify the equal-length unequal-phase path-pair condition of FD.TWIST.
  This is the smallest decisive test of the proposed physical regeneration
  mechanism.
```

## 29. Bounded two-switch prove-or-kill cycle

This cycle closes the scalar parameter selection, audits the source class in
(TS.REGEN), and then pushes the finite-gap mechanism to the first physical
interface that is not yet available.  It produces two new paper lemmas and
one exact obstruction.  It does not prove the arbitrary-diverging endpoint.

### 29.1 Cycle card

The strongest proved baseline remains natural-density fixed-polylogarithmic
descent for every strict

\[
 A>9.991113\ldots
\]

with shortcut clock

\[
 c>\frac2{\log(4/3)}
\]

and the same-witness orbit ceiling.  The literal new target is the
arbitrary-diverging endpoint under the same leading clock.  The target is
UNKNOWN-BUT-INTENDED.

The two-switch consumer needs only the actual first-switch landing law.  It
does not need contraction for every density on the intermediate shell.  The
kill test in this cycle is whether the displayed all-density version of
(TS.REGEN) is compatible with deterministic continuation.

### 29.2 Simultaneous high-phase and mixing parameter lemma

Fix terminal data \(S,R\), a proposed contraction
\(0<\rho=\rho_{S,R}<1\), and numbers
\(\epsilon_{\rm mix}>0\), \(\tau>0\), and \(c_0>0\).  Put

\[
 a_\tau
 =
 \min\left\{\log2,\frac{c_0\tau^2}{4}\right\}>0.
\tag{TS.P1}
\]

For any \(p_*>5/2\), choose

\[
 C>
 \max\left\{
 \frac{p_*}{a_\tau},
 \frac{1/2+\epsilon_{\rm mix}}{-\log\rho}
 \right\},
 \qquad
 D=\frac{\tau\sqrt C}{2},
\tag{TS.P2}
\]

and set \(Q_M=\lceil C\log(M+2)\rceil\).  Then

\[
 \frac D{\sqrt C}=\frac\tau2\le\tau
\tag{TS.P3}
\]

and the high-phase exponent from (6.9) is

\[
\begin{aligned}
 p_{\rm hi}
 &=
 \min\{C\log2,c_0D^2\}\\
 &=
 C\min\left\{\log2,\frac{c_0\tau^2}{4}\right\}
 =
 Ca_\tau
 >
 p_*.
\end{aligned}
\tag{TS.P4}
\]

Consequently the high contribution in (6.10) satisfies

\[
 d_{\rm hi}(M)
 +
 \sqrt{M\log(M+2)}\,M^2d_{\rm hi}(M)
 =
 o(1).
\tag{TS.P5}
\]

Indeed its second term is
\(O(M^{5/2-p_{\rm hi}}\sqrt{\log M})\).

If the generated first-switch density obeys (TS.3), then

\[
\begin{aligned}
 \rho^{Q_M-S}
 \|f_{M,Q_M}\|_\infty
 &\le
 \rho^{-S}
 (M+2)^{C\log\rho}
 M^{1/2+o(1)}\\
 &=
 O_{S,R}\left(M^{-\epsilon_{\rm mix}+o(1)}\right)
 =
 o_{S,R}(1).
\end{aligned}
\tag{TS.P6}
\]

Thus one fixed \(C=C_{S,R}\) simultaneously pays the full
\(M^{5/2}\)-scale high transport cost and any genuine fixed spectral gap.
There is no conflict between the upper and lower requirements on \(C\).
For fixed \(S,R,C\), the second-phase clock is \(O(C\log M)=o(M)\).

This proves the parameter part of the two-switch assembly.  It also corrects
the logarithm base in the former (TS.4)--(TS.5): because (TS.1) uses the
natural logarithm, the mixing denominator is \(-\log\rho\), not
\(-\log_2\rho\).

### 29.3 Deterministic-kernel obstruction to all-density regeneration

The convenient all-density formulation of (TS.REGEN) is false for an exact
deterministic continuation, except in a degenerate one-point profile.

Let \(X_Q\) be a finite source space with probability \(U_Q\), let \(Y\) be
fixed and finite, and let \(F_Q:X_Q\to Y\) be deterministic.  Write
\(\pi_Q=(F_Q)_*U_Q\).  Suppose

\[
 \|\pi_Q-\Pi\|_{\rm TV}\longrightarrow0
\tag{TS.D1}
\]

for a probability \(\Pi\) on \(Y\).  Choose a set \(B\subset Y\) with
\(0<\Pi(B)<1\).  Then

\[
 a_Q
 =
 U_Q(F_Q^{-1}B)
 =
 \pi_Q(B)
 \longrightarrow
 \Pi(B)>0.
\tag{TS.D2}
\]

Define the adversarial input

\[
 \nu_Q
 =
 U_Q(\,\cdot\mid F_Q^{-1}B).
\tag{TS.D3}
\]

It has uniformly bounded density,

\[
 \left\|\frac{d\nu_Q}{dU_Q}\right\|_\infty
 =
 a_Q^{-1}
 =
 O_B(1),
\tag{TS.D4}
\]

but its deterministic pushforward is supported on \(B\).  Hence

\[
 \|(F_Q)_*\nu_Q-\Pi\|_{\rm TV}
 \ge
 1-\Pi(B)>0.
\tag{TS.D5}
\]

It follows that no estimate

\[
 \|(F_Q)_*\nu-\Pi\|_{\rm TV}
 \le
 A\rho^{Q-S}
 \left\|\frac{d\nu}{dU_Q}\right\|_\infty
 +t_R,
 \qquad 0<\rho<1,
\tag{TS.D6}
\]

can hold for every absolutely continuous \(\nu\) once
\(t_R<1-\Pi(B)\).

The proof is exactly (TS.D2)--(TS.D5).  Apply (TS.D6) to \(\nu_Q\) and let
\(Q\to\infty\); the right side tends to \(t_R\), contradicting (TS.D5).

The physical first-passage continuation is deterministic at the integer
level.  Therefore (TS.REGEN) cannot be retained as an all-density theorem.
If a finite quotient replaces unresolved digits by stochastic averaging,
that quotient is not an exact operator for arbitrary source densities:
conditioning on \(F_Q^{-1}B\) changes the unresolved-digit law.  Exactness
can be recovered only by retaining enough source labels, or by restricting
the theorem to the actual generated first-switch family.

The corrected source-specific target is

\[
\boxed{
 \left\|
 (\nu^{\rm gen}_{M,Q_M})K_{Q_M,S,R}
 -
 \Pi_{S,R}
 \right\|_{\rm TV}
 \longrightarrow0
 \quad(M\to\infty)
 }
\tag{TS.GEN}
\]

for each fixed \(S,R\), with the nominal reconstruction labels retained.
This is strictly weaker than the false all-density socket and is exactly
what (TS.P1)--(TS.P6) consume.

### 29.4 Exact nested-passage composition

The source-specific continuation has an exact direct form.  Let
\(0<Z<Y<n\), and write

\[
 \tau_Y(n)=\min\{h:T^h(n)\le Y\},
 \qquad
 L_Y(n)=T^{\tau_Y(n)}(n)
\tag{TS.C1}
\]

whenever the passage exists.  If the passage below \(Z\) exists, then

\[
\boxed{
 \tau_Z(n)
 =
 \tau_Y(n)+\tau_Z(L_Y(n)),
 \qquad
 L_Z(n)=L_Z(L_Y(n)).
 }
\tag{TS.C2}
\]

Indeed, no time before \(\tau_Y(n)\) can lie below \(Z<Y\).  After
\(\tau_Y(n)\), the first time below \(Z\) is by definition the first
passage of the landed point.  This also covers \(L_Y(n)\le Z\), when the
second stopping time is zero.

Consequently, restrict \(G_{M,Q}\) to sources for which the lower passage
exists (or give nonpassage the same cemetery label on both sides).  If
\(G_{M,Q}\) is the resulting retained high-success source set and

\[
 \nu^{\rm gen}_{M,Q}
 =
 (L_{2^Q})_*
 \left(U_M\!\restriction G_{M,Q}\right),
\tag{TS.C3}
\]

then

\[
\boxed{
 (L_{2^S})_*\nu^{\rm gen}_{M,Q}
 =
 (L_{2^S})_*
 \left(U_M\!\restriction G_{M,Q}\right).
 }
\tag{TS.C4}
\]

Thus the second switch creates no new probabilistic independence.  It is an
exact factorization of the original direct passage.  A quotient operator
can prove (TS.GEN) only if it retains enough information about the outer
producer for (TS.C4) to commute with that quotient.  Otherwise the proposed
regeneration is merely an unproved replacement of the conditional hidden
digits by their average.

This does not kill source-specific phase convergence.  It identifies its
honest form: either prove a producer-aware finite-mode recurrence, or prove
the same convergence directly from the outer-shell harmonic/sibling
recurrence.  The intermediate density cap alone cannot supply it.

### 29.5 What a finite spectral gap would still have to prove

The abstract certificate (FD.TWIST) gives a contraction per application of
one finite twisted transition.  It does not by itself give an exponential
factor in the rank gap.

Precisely, suppose a retained physical path from rank \(Q\) to \(S\)
contains \(N(Q,S)\) applications of an operator whose nonzero-mode norm is
at most \(0<\theta<1\).  If

\[
 N(Q,S)\ge c(Q-S)-C_0
\tag{TS.N1}
\]

for fixed \(c>0,C_0\), then

\[
 \theta^{N(Q,S)}
 \le
 \theta^{-C_0}
 \left(\theta^c\right)^{Q-S}.
\tag{TS.N2}
\]

Thus (TS.REGEN)-type decay follows with
\(\rho=\theta^c<1\), up to a fixed prefactor.  This elementary
renewal-count bridge is necessary: a finite gap with only
\(o(Q-S)\) effective updates need not beat the generated
\(M^{1/2}\) cap.

The current physical reconstruction has not yet supplied:

1. a finite state closed under every retained first-passage transition;
2. a decomposition of the actual generated law through that state without
   replacing hidden digits by an independent conditional law;
3. the linear update-count bound (TS.N1);
4. unequal-phase equal-length path pairs in every noninvariant recurrent
   class;
5. a reconstruction tail uniform for the actual generated source family.

These are construction obligations, not consequences of irrationality.
The equality of two phase products is refuted by irrationality only after
the two admissible physical paths have been constructed.

### 29.6 Exact \(q=3/2\) renewal payoff

The energy side has one complete scalar closure.  At \(q=3/2\), the
common-suffix reproduction factor is

\[
 K_{3/2}
 =
 \frac{\sqrt3}{2^{3/2}-1}
 =
 0.9472900418\ldots
 <1.
\tag{TS.E1}
\]

Therefore any exact labelled reconstruction recurrence of the form

\[
 E_R\le B_S+K_{3/2}E_{R-1}
\tag{TS.E2}
\]

implies

\[
\boxed{
 E_R
 \le
 K_{3/2}^R E_0
 +\frac{B_S}{1-K_{3/2}},
 \qquad
 \frac1{1-K_{3/2}}
 =
 18.97174719\ldots .
 }
\tag{TS.E3}
\]

This proves that the suffix interior is genuinely subcritical at the
required moment.  The missing work is no longer the scalar renewal sum; it
is the exact derivation of (TS.E2) with primitive-suffix, word-exhaustion,
first-passage deletion, and nominal-label boundary terms all charged to
\(B_S\).

One part of that boundary charge is already available from the frozen
fixed-total proof.  Its theorem
realReverseMajorant_le_nonterminal_add_two proves, under
\(3^s\le2^N\), that the last exposed reverse prefix and the remaining
word-exhaustion tail cost at most one each.  Thus the combined terminal
boundary is at most \(2\) per composition.

This constant survives nominal labelled aggregation without a label-count
loss.  If \(b_\lambda\ge0\) and
\(\sum_\lambda b_\lambda\le1\), then

\[
 \sum_\lambda b_\lambda\,2\le2.
\tag{TS.E4}
\]

More generally, if child nominal weights satisfy

\[
 \sum_{\lambda:\,p(\lambda)=\mu}b_\lambda\le b_\mu
\tag{TS.E5}
\]

and local energies obey

\[
 e_\lambda\le K e_{p(\lambda)}+B_\lambda,
\tag{TS.E6}
\]

then summing before renormalization gives

\[
 \sum_\lambda b_\lambda e_\lambda
 \le
 K\sum_\mu b_\mu e_\mu
 +\sum_\lambda b_\lambda B_\lambda.
\tag{TS.E7}
\]

Equations (TS.E4)--(TS.E7) prove that neither deletion nor the number of
nominal labels forces a new polynomial factor.  What is still missing is
the adapter proving that the physical first-passage reconstruction labels
obey (TS.E5), and that their local \(3/2\)-energies are the fixed-total
objects to which the frozen reverse-spend estimate applies.  The exact
\(2\)-unit terminal charge is PROVED-FORMAL in the frozen development; this
adapter is OPEN.

### 29.7 Closeout

The bounded cycle proves:

* the corrected natural-logarithm mixing threshold;
* simultaneous choice of the high-barrier and mixing parameters;
* disappearance of both scalar errors while preserving the leading clock;
* the deterministic conditioning obstruction to all-density regeneration;
* the exact nested-passage composition (TS.C2)--(TS.C4);
* the exact rank-update bridge required by a finite spectral gap;
* the scalar \(q=3/2\) renewal resolvent;
* the two-unit fixed-total terminal boundary and its loss-free nominal-label
  aggregation.

It strictly narrows the physical proof to two coupled tasks:

\[
\boxed{
\text{source-specific phase regeneration (TS.GEN)}
\quad+\quad
\text{the labelled boundary recurrence (TS.E2).}
}
\]

What remains equally hard is the arithmetic correlation of the generated
first-switch law with the hidden digits that determine its later stopped
landing.  Generic Markov mixing, total variation for all inputs, and the
finite twisted-gap lemma alone cannot control that correlation.

The next proof may resume only with one of two equivalent physical objects
for fixed \(S,R\): an exact producer-aware state whose transition includes
the first-switch generation labels and commutes with (TS.C4), or a direct
outer-shell harmonic/sibling recurrence for the same labelled observable.
It must either prove (TS.GEN) or exhibit a generated conditioning family
that keeps a positive nondecaying mode.  Until such an object is
constructed, further spectral-radius calculations would be computations on
an unproved quotient.

## 30. Audit of the projective-profile and progression-bundle proposal

The proposed bundle supplies useful exact algebra, but its claimed local
energy adapter is too strong for a general arithmetic-progression interval,
and its scalar loss mark is not closed.  This section records the exact
survivors, the smallest counterexample, and a corrected nominal-weight
target.

### 30.1 Target and status gate

The strongest proved headline is unchanged.  The literal target of this
cycle is not arbitrary-density mixing.  It is a polynomial labelled
\(3/2\)-energy bound, or the one stopped-target pairing, for the actual
generated first-switch family.

The target remains UNKNOWN-BUT-INTENDED.  The capacity warning is that after
bit exhaustion an individual producer word can contain one source of mass
\(2^{-M}\), while its formal parity-cylinder weight is \(2^{-h}\) with
\(h>M\).  Any label theorem that silently uses the latter weight fails the
normalization gate.

### 30.2 Projective transport is exact but conditional

Let \(K_{Q,S,R}\) be an exact Markov kernel on fully marked states and suppose

\[
 \Pi_{Q,R}K_{Q,S,R}=\Pi_{S,R}.
\tag{PA.P1}
\]

Then total-variation contraction gives

\[
\begin{aligned}
 \|\nu K_{Q,S,R}-\Pi_{S,R}\|_{\rm TV}
 &=
 \|(\nu-\Pi_{Q,R})K_{Q,S,R}\|_{\rm TV}\\
 &\le
 \|\nu-\Pi_{Q,R}\|_{\rm TV}.
\end{aligned}
\tag{PA.P2}
\]

For one bounded target observable \(G\), the exact dual identity is

\[
 \langle\nu K_{Q,S,R}-\Pi_{S,R},G\rangle
 =
 \langle\nu-\Pi_{Q,R},K_{Q,S,R}G\rangle.
\tag{PA.P3}
\]

These statements are PROVED-PAPER.  They transport producer regularity; they
do not create it.

There are two quantifier cautions.  First, the physical switch is
\(Q=C_{S,R}\log M\), so the required producer comparison is a moving-\(Q\)
theorem, not fixed-rank convergence.  Second, absolute elapsed time and
accumulated loss move with the outer shell.  Total variation on a fully
marked state therefore requires a recentered reference or an
\(M\)-dependent reference with a proved projective law.  The target-specific
pairing (PA.P3) avoids demanding convergence of irrelevant marks.

### 30.3 Exact arithmetic-progression branch

For

\[
 \mathcal P(a,r;I)=\{a+3^rk:k\in I\},
\tag{PA.B1}
\]

fix \(v\ge0\).  Since \(3^r\) is odd, there is one
\(\kappa_v\bmod 2^{v+1}\) such that

\[
 a+3^r\kappa_v\equiv2^v\pmod{2^{v+1}}.
\tag{PA.B2}
\]

Writing

\[
 a+3^r\kappa_v=2^v(2b_v+1),
\qquad
 I_v=\{t:\kappa_v+2^{v+1}t\in I\},
\tag{PA.B3}
\]

gives, for \(k=\kappa_v+2^{v+1}t\),

\[
\boxed{
 T^{v+1}(a+3^rk)
 =
 (3b_v+2)+3^{r+1}t.
}
\tag{PA.B4}
\]

Thus the unmarked affine coordinate is closed exactly.  Elapsed time updates
by \(v+1\); killing during the initial halvings can be sent to a cemetery
child without approximation.

The valuation branches also partition the physical parameter interval.
For positive sources, every \(k\in I\) has one finite
\(v=v_2(a+3^rk)\), and the map
\(t\mapsto\kappa_v+2^{v+1}t\) is injective.  Therefore

\[
\boxed{
 \sum_{v\ge0}|I_v|=|I|
}
\tag{PA.B5}
\]

when cemetery branches are retained, and the left side is at most
\(|I|\) after deletion.  Hence the actual cardinality weights

\[
 b^{\rm act}_{a,r,I}=\frac{|I|}{2^M}
\tag{PA.B6}
\]

satisfy an exact child-submass relation.  This proves submass for actual
source weights, not yet for the canonical nominal weights needed by the
fixed-total renewal.

### 30.4 Two corrections to the claimed closed label class

The accumulated reverse loss is not a scalar constant on a general child
progression.  In (PA.B4), the odd step ends at

\[
 z(t)=(3b_v+2)+3^{r+1}t
\]

and adds

\[
 \frac{Y}{2z(t)}.
\tag{PA.B7}
\]

This varies with \(t\).  For the smallest example
\(\mathcal P(0,0;\{1,2,3\})\), the \(v=0\) branch has
\(t=0,1\), endpoints \(2,5\), and loss increments
\(Y/4,Y/10\).  Thus a label carrying one scalar loss value is not closed.
An exact label must retain the loss as a function of the progression
parameter, or split until it is constant.  The former proposal
\((a,r,I;h_0,\ell_0,\mathrm{status})\) is FALSE as an exact closed class
unless \(I\) is a singleton or \(\ell_0\) denotes the full function.

The same example refutes the unrestricted deletion claim for correction
fibers.  At suffix length \(N=1\), the sources \(1\) and \(3\) have the same
odd parity word.  The canonical length-one odd cohort contains that word
once, while the progression interval contains it twice.  Its selected
correction multiplicity is therefore \(2\), not at most \(1\), and

\[
 2^{3/2}>1^{3/2}.
\tag{PA.B8}
\]

Consequently the proposed pointwise inequality (A.3), and hence (A.4), is
FALSE for arbitrary \(I\).

The corrected theorem retains the incomplete-block factor.  Let
\(L=|I|\) and

\[
 q_I=\left\lceil\frac{L}{2^N}\right\rceil.
\tag{PA.B9}
\]

Because multiplication by \(3^r\) permutes residues modulo \(2^N\), each
length-\(N\) parity word occurs at most \(q_I\) times in the progression.
For one fixed suffix cohort \((N,s,u)\), after the harmless unit permutation
of correction residues,

\[
 c_\lambda(a)
 \le
 q_I\,c_{N,s}(a)
\tag{PA.B10}
\]

and therefore

\[
\boxed{
 \sum_a c_\lambda(a)^{3/2}
 \le
 q_I^{3/2}
 \sum_a c_{N,s}(a)^{3/2}.
}
\tag{PA.B11}
\]

The deletion-only estimate is recovered exactly when \(L\le2^N\), because
then \(q_I=1\).  For a general progression, the block multiplicity must be
priced; it cannot be omitted.

### 30.5 What survives from prefix--suffix compatibility

If a producer prefix \(w\) has length \(m\) and correction \(c_w\), while a
suffix \(v\) has length \(N\), odd count \(s\), and correction \(c_v\), then
affine composition gives

\[
\boxed{
 c_{wv}=3^sc_w+2^mc_v.
}
\tag{PA.A1}
\]

If \(v\) has first odd position \(u\) and canonical numerator
\(\mathscr A_{\mathbf k}\), then

\[
 c_{wv}
 \equiv
 2^{m+u}\mathscr A_{\mathbf k}
 \pmod{3^s}.
\tag{PA.A2}
\]

Thus a fixed producer prefix changes the suffix correction coordinate only
by a unit permutation modulo \(3^s\).  Equality of full physical endpoints
at common total odd count implies correction congruence modulo the larger
full modulus, hence also modulo \(3^s\).  The endpoint partition therefore
refines this coarse suffix-correction partition.

Equations (PA.A1)--(PA.A2) are exact.  Their valid energy consequence is
(PA.B11), after fixing \((N,s,u)\) and pricing progression blocks.  They do
not merge varying suffix lengths, odd counts, first-odd positions, or
producer labels for free.

### 30.6 Why actual submass is not yet the energy adapter

Let a labelled endpoint submeasure have mass \(w_\lambda\), conditional
density \(p_\lambda\) relative to the terminal uniform law, and

\[
 E_\lambda=\int p_\lambda^{3/2}\,dU.
\tag{PA.W1}
\]

Using nominal reference weight \(b_\lambda\), its contribution to the
labelled \(3/2\)-energy is

\[
 w_\lambda^{3/2}b_\lambda^{-1/2}E_\lambda.
\tag{PA.W2}
\]

Among all \(b_\lambda>0\) with \(\sum b_\lambda\le1\), Holder gives the exact
optimum

\[
\boxed{
 \inf_b
 \sum_\lambda
 w_\lambda^{3/2}b_\lambda^{-1/2}E_\lambda
 =
 \left(
 \sum_\lambda w_\lambda E_\lambda^{2/3}
 \right)^{3/2}.
}
\tag{PA.W3}
\]

Indeed

\[
 \sum_\lambda w_\lambda E_\lambda^{2/3}
 \le
 \left(
 \sum_\lambda
 w_\lambda^{3/2}b_\lambda^{-1/2}E_\lambda
 \right)^{2/3}
 \left(\sum_\lambda b_\lambda\right)^{1/3},
\]

and equality is obtained by
\(b_\lambda\propto w_\lambda E_\lambda^{2/3}\).

This formula explains why (PA.B5) alone does not close the proof.  If every
physical label is a singleton on a terminal set of size \(H\), then
\(E_\lambda=H^{1/2}\), so the minimum in (PA.W3) is still \(H^{1/2}\).
Actual-mass subadditivity is exact, but excessively fine labels retain the
full atomic energy.

The weakest useful energy target is therefore the generated grouping bound

\[
\boxed{
 \sum_{\lambda\in\mathcal G_{M,Q,S,R}}
 w_\lambda E_\lambda^{2/3}
 \le
 (S+1)^{O(1)},
}
\tag{LABEL.CAP}
\]

for a grouping that is closed under the exact progression/loss/cemetery
updates.  By (PA.W3), LABEL.CAP supplies polynomial labelled
\(3/2\)-energy.  It is strictly more informative than child-submass alone
and strictly weaker than a uniform bound on every label.

### 30.7 Spectral object status

The circle identity

\[
 \{\log_2(A^j(u)+1)\}
 =
 \{\log_2(u+1)+j\log_2 3\}
\tag{PA.F1}
\]

is exact for \(A(u)=3u+2\).  It identifies a legitimate phase coordinate.
For suffix depth \(a\ge1\), the producer length may be reduced modulo
\(\operatorname{ord}_{3^a}(2)=2\cdot3^{a-1}\); depth \(a=0\) must be treated
as the trivial modulus separately.

No finite cocycle has yet been shown to commute with the full
progression-valued loss function, first-passage deletion, and source-band
grouping.  The circle-times-finite-state description is therefore a
candidate representation, not a proved physical operator.  Equal-phase
path pairs and Diophantine estimates become relevant only after that closure
theorem.

### 30.8 Closeout

PROVED-PAPER in this audit:

* projective transport (PA.P1)--(PA.P3), conditional on a consistent profile;
* exact unmarked progression update (PA.B1)--(PA.B4);
* actual-cardinality branch partition and submass (PA.B5)--(PA.B6);
* corrected progression-block energy bound (PA.B9)--(PA.B11);
* prefix--suffix correction identities (PA.A1)--(PA.A2);
* optimal nominal-reference formula (PA.W3).

FALSE as originally stated:

* one scalar accumulated-loss mark is closed on a nontrivial progression;
* arbitrary progression selection is pointwise dominated by one canonical
  correction histogram without a block factor;
* the local fixed-total energy adapter is already complete.

OPEN / load-bearing:

* LABEL.CAP, or an equivalent nominal-capacity grouping theorem;
* target-specific moving-\(Q\) producer comparison through (PA.P3);
* exact closure of any finite phase quotient under the physical marked law.

The strongest proved Phase-3 headline remains unchanged.  The next bounded
proof attempt should attack LABEL.CAP for the actual generated progression
family.  A successful proof closes the energy adapter.  A kill certificate
is a generated family for which every update-closed grouping keeps
\(\sum_\lambda w_\lambda E_\lambda^{2/3}\) superpolynomial in \(S\).

## 31. Exact functional-loss progression bundle

The scalar-loss label rejected in Section 30 has an exact finite-description
replacement.  This closes the physical progression recurrence under the
first-passage and additive-loss filters, although it does not prove
LABEL.CAP.

### 31.1 Reciprocal-affine loss profiles

On an integer interval \(I\), define a loss profile

\[
 \mathcal L(t)
 =
 \ell_0+
 \sum_{j=1}^{J}
 \frac{Y}{2(\alpha_j+\beta_jt)},
\tag{FL.1}
\]

where every denominator is positive on \(I\) and every
\(\beta_j>0\).  The empty sum is allowed.  Such a profile is decreasing on
\(I\).

An exact physical label is

\[
 \Lambda=(a,r,I,h,\mathcal L,\sigma),
\tag{FL.2}
\]

representing the sources \(a+3^rk\), with elapsed time \(h\), accumulated
loss \(\mathcal L(k)\), and live/cemetery status \(\sigma\).

### 31.2 Closure under one valuation branch

Use the branch data from (PA.B2)--(PA.B4).  Substituting

\[
 k=\kappa_v+2^{v+1}t
\]

into (FL.1) gives

\[
 \mathcal L(\kappa_v+2^{v+1}t)
 =
 \ell_0+
 \sum_{j=1}^{J}
 \frac{Y}{
 2\bigl(
  (\alpha_j+\beta_j\kappa_v)
  +2^{v+1}\beta_jt
 \bigr)}.
\tag{FL.3}
\]

After the odd step, the endpoint is

\[
 z_v(t)=(3b_v+2)+3^{r+1}t
\tag{FL.4}
\]

and its exact new loss contribution is \(Y/(2z_v(t))\).  Hence the child
profile is

\[
\boxed{
 \mathcal L_v'(t)
 =
 \mathcal L(\kappa_v+2^{v+1}t)
 +
 \frac{Y}{2z_v(t)}.
}
\tag{FL.5}
\]

Every denominator in (FL.5) is again positive affine with positive slope.
Thus \(\mathcal L_v'\) is another reciprocal-affine decreasing profile.
The child label is exactly

\[
 \left(
 3b_v+2,\ r+1,\ I_v,\ h+v+1,\ \mathcal L_v',\ \sigma'
 \right).
\tag{FL.6}
\]

No loss value has been averaged or replaced by a representative point.

### 31.3 First-passage and loss-cap cuts preserve intervals

Along a fixed parity prefix, every orbit value is an increasing affine
function of the progression parameter.  Indeed the affine iterate formula
has positive leading coefficient.  Consequently:

* requiring all pre-hit values to exceed \(Y\) is an intersection of upper
  integer subintervals;
* requiring the declared landing to be at most \(Y\) is a lower integer
  subinterval;
* their intersection is an integer interval, possibly empty;
* because \(\mathcal L_v'\) is decreasing, the accepted loss-cap set
  \(\{t:\mathcal L_v'(t)\le D\}\) is an upper integer subinterval.

Therefore the live child, the boundary-hit child, and the loss-rejected child
can each be represented by interval restrictions of (FL.6).  Retaining all
cemetery pieces makes the branch partition exact; deleting them gives the
submass inequality (PA.B5).

Time-support membership is also exact because \(h+v+1\) is constant on one
branch label.  This proves:

\[
\boxed{
\text{functional-loss progression labels are closed under the exact
first-passage/time/loss recurrence.}
}
\tag{FUNCTIONAL.BUNDLE}
\]

The theorem is limited to the physical marks named above.  A later corridor
or stopped-target indicator may be pulled back as an observable; no
unproved claim that every nonlinear corridor cut is an interval is used.

### 31.4 Remaining boundary

FUNCTIONAL.BUNDLE supplies the exact growing physical label fibre that was
missing from the proposed circle-times-finite-state construction.  It does
not make that fibre finite, does not merge bit-exhausted singleton labels,
and does not prove polynomial energy.

The remaining energy theorem is now literally LABEL.CAP for groupings of
the functional labels (FL.2) that preserve their pulled-back stopped-target
observable.  The finite phase quotient is legitimate only after proving
that this grouping is respected by (FL.5).

Status:

* reciprocal-affine loss closure (FL.3)--(FL.6): PROVED-PAPER;
* interval closure of first-passage and loss-cap cuts: PROVED-PAPER;
* exact marked functional bundle: PROVED-PAPER;
* polynomial nominal capacity LABEL.CAP: OPEN;
* autonomous finite quotient and twisted gap: OPEN.

## 32. LABEL.CAP cycle: exact grouped-energy dictionary and routed attack

**Date:** 2026-08-10.  **Headline status:** unchanged.  **Formalization:**
none authorized.

**Later audit:** Section 33 restores the missing first-odd coordinate in
(GE.DOM) and proves that the full-canonical sufficient inequality (GE.6) is
false on the central bit-exhausted scale.  The historical cycle record below
is retained, but those two status lines are superseded by Section 33.

### 32.1 Cycle card

```text
STRONGEST PROVED BASELINE:
  fixed-polylog descent for every A > 9.9911133419...; FUNCTIONAL.BUNDLE;
  corrected block-factor theorem (PA.B9)--(PA.B11); optimal nominal
  reference (PA.W3); subcritical scalar renewal (TS.E1)--(TS.E3); frozen
  2-unit terminal charge (realReverseMajorant_le_nonterminal_add_two);
  feasible cumulative-time support of size O(sqrt(M log M)).

TARGET (literal):
  LABEL.CAP: one grouping G_(M,Q,S,R) of the functional labels (FL.2),
  closed under the exact progression/loss/cemetery updates and preserving
  the pulled-back stopped-target observable, with
  sum_(lambda in G) w_lambda E_lambda^(2/3) <= (S+1)^O(1).

NOT THE TARGET:
  a uniform bound on every label; arbitrary-target equidistribution; an
  autonomous finite phase quotient; the moving-Q producer comparison
  (separate open item); any headline or paper change.

CONSUMES:
  LABEL.CAP + (PA.W3) close the energy adapter for (TS.E2); with
  (TS.E3) and the moving-Q comparison this feeds UFP.TARGET_(d,lambda)
  and the first threshold improvement A > 9.791291... via (TC.4)--(TC.6).

FREE BASELINE (typed):
  DIFFERENCE: singleton grouping gives sum = H^(1/3) (superpolynomial);
  RATIO: any admissible grouping must beat singletons by H^(1/3)/poly;
  EXPONENT: flat single-group calibration attains (2^M H^(-1/3))-scaling;
  SCOPE: fixed S,R, schedule-weighted shell law;
  QUANTIFIER: one grouping suffices; no per-label uniformity required.

DOMINANT LOSS:
  cross-label endpoint collisions inside one statistics class, priced by
  the grouped 3/2-histogram moment.

KNOWN FALSE OR PAUSED ROUTES:
  scalar-loss label closure (Section 30.4, FALSE); pointwise (A.3)--(A.4)
  (FALSE); autonomous finite quotient before closure proof (PAUSED);
  interval pullback of the stopped target at live stages (FALSE in
  general -- Section 31.3 caveat).

ONE KILL TEST:
  exact-arithmetic generated-family diagnostic at two or three scales
  against the (2^M H^(-1/3)) grouped-histogram budget (32.7).
```

### 32.2 Exact grouped-energy dictionary

Fix one stage with reference uniform law \(U\) on a value set of size
\(H\), and a family of functional labels in which every source carries
one common mass \(m_g\) inside each group \(g\) of a grouping
\(\mathcal G\).  Write \(|g|\) for the number of sources in \(g\) and

\[
 c_g(a)=\#\{\text{sources in }g\text{ whose current value is }a\}.
\tag{GE.1}
\]

Within one functional label the current value is affine in the
progression parameter with slope a positive power of \(3\) (PA.B4, FL.4),
hence injective; collisions occur only across labels.  The group
submeasure has mass \(w_g=m_g|g|\) and conditional density
\(p_g(a)=H\,c_g(a)/|g|\) relative to \(U\).  Therefore

\[
 E_g=\int p_g^{3/2}\,dU
 =H^{1/2}\,|g|^{-3/2}\sum_a c_g(a)^{3/2},
\tag{GE.2}
\]

and the group size cancels exactly from the capacity summand:

\[
\boxed{
 w_g\,E_g^{2/3}
 =
 m_g\,H^{1/3}
 \Bigl(\sum_a c_g(a)^{3/2}\Bigr)^{2/3}.
}
\tag{GE.3}
\]

With the progression normalization \(m_g=2^{-M}\) of (PA.B6), LABEL.CAP is
therefore **equivalent** to the grouped collision-histogram bound

\[
\boxed{
 \sum_{g\in\mathcal G}
 \Bigl(\sum_a c_g(a)^{3/2}\Bigr)^{2/3}
 \le
 (S+1)^{O(1)}\,2^{M}\,H^{-1/3}.
}
\tag{GE.4}
\]

Calibrations.  (i) All-singleton grouping: \(c\equiv1\) on \(2^M\)
labels gives left side \(2^M\), failing (GE.4) by exactly \(H^{1/3}\);
this reproduces the Section 30.6 pathology, so the dictionary prices the
known negative case correctly.  (ii) One flat group with all-distinct
endpoints: left side \(2^{2M/3}\le 2^MH^{-1/3}\) whenever \(H\ge2^M\);
the flat transport case passes.  Both checks are exact.

Normalization-gate remark.  (GE.1)--(GE.4) use actual source masses only.
The optimal nominal weights in (PA.W3) are free parameters with
\(\sum b_\lambda\le1\) automatically satisfiable, so the Section 30.1
warning about formal parity-cylinder weights \(2^{-h}\) with \(h>M\) does
not apply to this route.  It resurfaces only if a proof reintroduces
cylinder-weight references.

Status: (GE.1)--(GE.4) PROVED-PAPER (elementary, complete above).

### 32.3 Statistics-cohort grouping: the primary candidate

Group the functional labels by the coordinates

\[
 g=(h,\ r,\ \sigma)
\tag{GE.STAT}
\]

(elapsed time, odd count, live/cemetery status), i.e. one group per
statistics class.  Three exact structural facts:

1. **Update congruence.**  By (FL.6), the child of any label in class
   \((h,r,\sigma)\) under valuation branch \(v\) and status split
   \(\sigma'\) lies in class \((h+v+1,\,r+1,\,\sigma')\), uniformly over
   the class.  The partition is a congruence for the exact
   progression/loss/cemetery update; closure is not the obstacle.
   (Multiple parent classes feed one child class; the renewal must be run
   in the linear (TS.E7) form, not the tree-submass form.)
   Status: PROVED-PAPER (one line from (FL.6)).

2. **Schedule diagonalization.**  The schedule weight of a source depends
   only on its cumulative time \(h\), which is constant on each class, so
   the constant-mass hypothesis of (GE.3) holds classwise with
   \(m_g=2^{-M}\times(\text{schedule coefficient at }h)\).
   Status: PROVED-PAPER (definition of the schedule law).

3. **Reverse domination.**  The dynamics is deterministic, so each source
   carries exactly one parity word, and given an endpoint \(a\) and a
   word \(w\) the reverse orbit determines the source uniquely.  Hence

\[
 c_g(a)\le c^{\rm can}_{N,s}(a)
\tag{GE.DOM}
\]

   pointwise: the generated first-switch family's classwise histogram is
   dominated by the canonical cohort correction histogram, the fixed-total
   object bounded by the frozen reverse-spend chain with the 2-unit
   terminal charge.  Deletion and generation filters only decrease
   \(c_g\).  Status: PROVED-PAPER (determinism + reverse uniqueness).

By the feasible cumulative-time support theorem the number of classes
carrying mass is polynomial.  Route A therefore reduces LABEL.CAP for
(GE.STAT) to one scalar payoff inequality on the feasible support:

\[
\boxed{
 \sum_a c^{\rm can}_{N,s}(a)^{3/2}
 \le
 (S+1)^{O(1)}\,2^{3M/2}\,H^{-1/2}
 \quad\text{for every feasible }(h,s).
}
\tag{GE.6}
\]

OPEN: whether the frozen fixed-total exponent satisfies (GE.6) on the
whole feasible support, or only after interpolating extreme classes
against their trivial mass bound \(w_gE_g^{2/3}\ge w_g\),
\(E_g\ge1\) (Jensen).  This is a finite computation against known frozen
constants and is the first bounded task of the next cycle.

### 32.4 The terminal observable refinement is cheap

At the stopped leaves the pulled-back stopped-target indicator is an
interval cut of each leaf label (Section 31.3, PROVED).  Refine each
terminal statistics class \(g\) into the two \(G\)-constant groups
\(g_0,g_1\) (each leaf contributes at most three subintervals, but all
\(G=0\) pieces join \(g_0\)).  Then \(c_{g_i}(a)\le c_g(a)\) pointwise,
so

\[
\boxed{
 \sum_{i=0,1}
 \Bigl(\sum_a c_{g_i}(a)^{3/2}\Bigr)^{2/3}
 \le
 2\Bigl(\sum_a c_g(a)^{3/2}\Bigr)^{2/3}.
}
\tag{GE.5}
\]

Hence LABEL.CAP for the terminal observable-preserving refinement follows
from LABEL.CAP for the statistics grouping at the cost of a factor
\(2\).  Status: PROVED-PAPER (monotonicity of \(x^{3/2}\)).

Boundary of validity: at **live** stages the pullback of the stopped
target is a union over future valuation branches of intervals, not one
interval; the Section 31.3 caveat stands, and no live-stage interval
claim is made or needed by (GE.5).  What remains OPEN on this route is
only that the renewal recurrence (TS.E2) may be run on statistics-grouped
energies at live stages and refined once at absorption; the required
adapter lemma is the (TS.E7)-form bookkeeping across the stage
references.

### 32.5 Route B: observable split (fallback)

Inside the target-specific pairing (PA.P3) decompose exactly

\[
 K G
 =\mathbb E[KG\mid\mathcal G_{\rm stat}]
 +\bigl(KG-\mathbb E[KG\mid\mathcal G_{\rm stat}]\bigr).
\tag{GE.SPLIT}
\]

The conditional-mean term pairs only against class masses and is
controlled by the scalar renewal; the centered term is bounded by grouped
Holder with the (FD.9) statistics reference, which requires **no**
observable preservation, times the within-class oscillation of \(KG\).
The deterministic-conditioning obstruction (Section 29.3) reappears as
that oscillation bound; the route's advantage is that the oscillation is
finitely testable and may decay in \(Q\).  Status: identity exact;
both consequences OPEN.

### 32.6 Named failure configuration

If Route A fails, it fails where surviving parity words outnumber
sources, i.e. in the bit-exhausted regime \(h>M\): there (GE.DOM) is
weak because the canonical histogram counts words while only \(2^M\)
sources exist, and the trivial mass interpolation must carry those
classes.  The refutation-ladder coordinates are the class coordinates
\((h,s)\) with \(h>M\); a genuine kill exhibits mass concentration on
such classes with per-class histograms saturating (GE.DOM).

### 32.7 Finite kill diagnostic (specification, exact arithmetic)

Theorem tested: (GE.4) for the grouping (GE.STAT) with terminal
refinement (GE.5).  Normalization: actual masses, schedule weights at the
declared support.  Positive calibration: flat transport family (must
pass).  Negative calibration: all-singleton grouping (must fail by
\(H^{1/3}\)).  Procedure: generate the actual first-switch family at two
or three consecutive scales, compute classwise \(\sum_a c_g(a)^{3/2}\) in
exact integer arithmetic, and fit the scale exponent of the left side of
(GE.4).  Kill threshold: exponent excess over \(2^MH^{-1/3}\) persisting
across scales kills the (GE.STAT) recurrence (only); it does not kill the
all-depth LABEL.CAP statement (harness F4 gate).  For Route B, the
diagnostic is the within-class variance of the stopped-target conditional
expectation as a function of \(Q\).

### 32.8 Closeout

New exact results this cycle:

* grouped-energy dictionary and size cancellation (GE.1)--(GE.3):
  PROVED-PAPER;
* equivalence of LABEL.CAP with the grouped histogram bound (GE.4),
  with both calibrations: PROVED-PAPER;
* statistics-class update congruence, schedule diagonalization, and
  reverse domination (GE.STAT), (GE.DOM): PROVED-PAPER;
* terminal observable refinement at cost \(2\) (GE.5): PROVED-PAPER.

What was strictly narrowed: the observable-preservation requirement of
LABEL.CAP is discharged at the terminal stage for a factor \(2\); the
open content of LABEL.CAP on the primary route is exactly the scalar
payoff inequality (GE.6) on the feasible support plus the live-stage
(TS.E7) bookkeeping adapter.

What remains equally hard: the bit-exhausted classes \(h>M\), where the
canonical-word bound decouples from the source count; and, independently
of LABEL.CAP, the moving-\(Q\) producer comparison through (PA.P3).

Scalar payoff: a proof of (GE.6) plus the adapter closes the energy side
of (TS.E2); with (TS.E3) and the moving-\(Q\) comparison this reaches the
first benchmark \(A>9.791291\ldots\) through (TC.4)--(TC.6).

Status and source of truth: this section; headline and paper unchanged;
no Lean work authorized.

Route decision: attack (GE.6) first (finite computation against frozen
constants on the feasible support, with mass interpolation for extreme
classes); run the 32.7 diagnostic in parallel; hold Route B until either
(GE.6) fails or the live-stage adapter blocks.

Resume only with: the exact frozen reverse-spend exponent evaluated
against (GE.6) on the feasible \((h,s)\) support, or the 32.7 diagnostic
verdict, or a proof/kill of the live-stage (TS.E7) adapter for
(GE.STAT).

## 33. Scalar audit of (GE.6): the full-canonical domination route fails

**Date:** 2026-08-10.  **Scope:** Route A's use of one full canonical
fixed-total histogram.  **Headline status:** unchanged.  **Formalization:**
none.

### 33.1 Target and normalization

The bounded target requested in Section 32.8 was to substitute the frozen
`realReverseMajorant` estimate into (GE.6).  Write

\[
 W_{N,s}=\#\operatorname{fixedSet}(N,s)
 =\binom{N-1}{s-1},
 \qquad
 C_{N,s}(a)=c^{\rm can}_{N,s}(a).
\]

At \(\theta=1/2\), the formal definition of `fixedRenyiMoment` is exactly

\[
 3^{s/2}\frac{\sum_a C_{N,s}(a)^{3/2}}{W_{N,s}^{3/2}}.
\tag{GE.A1}
\]

The terminal reference set in this project is
\(J_S=(2^{S-1},2^S]\), so

\[
 H=|J_S|=2^{S-1}.
\tag{GE.A2}
\]

For the Phase-3 schedule \(S=O(\log M)\).  Hence the right side of
(GE.6), including every fixed power of \(S+1\), has binary exponential
rate

\[
 (S+1)^{O(1)}2^{3M/2}H^{-1/2}
 =2^{(3/2+o(1))M}.
\tag{GE.A3}
\]

Target-sanity status: `FEASIBLE` as a proposed sufficient inequality, but
subject to the central-cohort capacity test below.  Positive calibration:
\(N=O(S)\), where all polynomial factors are terminal-scale.  Negative
calibration: the bit-exhausted central class
\(N\asymp M/(1-a_0)\), \(s/N\to1/2\).  Kill threshold: any lower bound
\(2^{(3/2+c)M}\), \(c>0\), for its canonical moment.

### 33.2 Exact exponent supplied by the frozen theorem

Specializing `fixedRenyiMoment_central_le` to \(\theta=1/2\) and undoing
the normalization (GE.A1) gives

\[
\boxed{
 \sum_a C_{N,s}(a)^{3/2}
 \le
 4W_{N,s}\,2^{N/2}3^{-s/2}
 \left(
  \frac{N/\sqrt3}{1-R_{N,s}}+2
 \right),
}
\tag{GE.A4}
\]

where

\[
 R_{N,s}
 =\operatorname{centralRenyiRatio}
 \left(\frac12,\frac{s-1}{N-1}\right).
\]

This is an exact algebraic consequence of the frozen formal theorem; the
two terminal terms are the `+2` in (GE.A4).  In every fixed interior
central window, \(1-R_{N,s}\) is bounded below by a positive constant.
Writing \(p=s/N\) and using
\(\log_2W_{N,s}=NH_2(p)+O(\log N)\), the frozen upper exponent is

\[
 \Phi_{\rm rev}(p)
 =H_2(p)+\frac12-\frac p2\log_2 3.
\tag{GE.A5}
\]

At the central point,

\[
 \Phi_{\rm rev}\left(\frac12\right)
 =\frac32-\frac14\log_2 3.
\tag{GE.A6}
\]

This exponent is not merely an artefact of the upper bound.  Since the
\(W_{N,s}\) sources occupy at most \(3^s\) residue cells, convexity gives

\[
\boxed{
 \sum_a C_{N,s}(a)^{3/2}
 \ge \frac{W_{N,s}^{3/2}}{3^{s/2}}.
}
\tag{GE.A7}
\]

When \(s/N\to1/2\), (GE.A7) has the same exponential rate as (GE.A4):

\[
 \frac32-\frac14\log_2 3.
\tag{GE.A8}
\]

Thus the frozen reverse-spend estimate is exponentially sharp on the
central fixed-total cohort.  No improvement of its polynomial prefactor
can change the verdict below.

### 33.3 Evaluation on the feasible first-passage scale

Put

\[
 a_0=\frac12\log_2 3,
 \qquad
 \Delta=1-a_0=0.207518749639\ldots.
\]

The already-proved feasible-time theorem gives, for \(S=O(\log M)\),

\[
 h=\frac{M+1-S}{\Delta}
   +O\!\left(\sqrt{M\log M}\right).
\tag{GE.A9}
\]

The main initial-valuation classes have first odd position
\(u=O(\log M)\); their omitted complement has polynomially small source
mass by the exact geometric initial-valuation decomposition.  For those
classes the fixed-total composition parameter is

\[
 N=h-u=\frac{M}{\Delta}+o(M),
 \qquad
 \frac{s}{N}=\frac12+o(1),
\tag{GE.A10}
\]

because the shrinking barrier is a central parity corridor.  This lies
strictly inside the frozen \(q=3/2\) window, since

\[
 \frac12<
 \operatorname{centralRenyiAlpha}\left(\frac12\right)
 =\frac{\sqrt2-1}{\sqrt3-1}
 =0.5658262487\ldots.
\]

Substitution of (GE.A10) into (GE.A8) yields the exact asymptotic rate

\[
\begin{aligned}
 \frac1M\log_2\sum_a C_{N,s}(a)^{3/2}
 &\longrightarrow
 \frac{\frac32-\frac14\log_2 3}{\Delta}\\
 &=\frac1\Delta+\frac12\\
 &=5.318841679306\ldots.
\end{aligned}
\tag{GE.A11}
\]

The budget (GE.A3) has rate \(1.5\).  The exponential excess is therefore

\[
 \left(\frac1\Delta+\frac12\right)-\frac32
 =\frac1\Delta-1
 =3.818841679306\ldots.
\tag{GE.A12}
\]

The failure is not confined to the single point \(u=o(M)\).  Put
\(x=u/M\).  Along the central physical time scale,

\[
 \frac NM=\frac1\Delta-x+o(1),
 \qquad
 p(x)=\frac{s}{N}=\frac1{2(1-\Delta x)}+o(1).
\tag{GE.A12a}
\]

The frozen \(q=3/2\) theorem applies up to
\(p(x)<\alpha_{3/2}\), where

\[
 \alpha_{3/2}=0.5658262487\ldots,
 \qquad
 x<x_*=0.5606072039\ldots.
\]

On this entire interval, the Jensen lower exponent is

\[
 \Psi(x)
 =\left(\frac1\Delta-x\right)
 \left(
  \frac32H_2(p(x))-\frac{p(x)}2\log_2 3
 \right).
\tag{GE.A12b}
\]

It decreases with \(x\): writing
\(c=1/(2\Delta)\), the only variable term is
\((3/2)N H_2(c/N)\), whose derivative in \(N\) is
\(-(3/2)\log_2(1-c/N)>0\).  At the far endpoint it still equals

\[
 \Psi(x_*)=4.3978396\ldots>1.5.
\tag{GE.A12c}
\]

Thus every first-odd class in the whole frozen central window violates the
full-canonical budget exponentially.  Classes beyond a logarithmic
first-odd cutoff may be charged by their geometric source mass, but that
does not affect the mass-carrying \(u=O(\log M)\) classes used in
(GE.A10)--(GE.A12).

Consequently:

\[
\boxed{
 \text{(GE.6) is false for the full canonical central cohorts occurring
 in the bit-exhausted first-passage scale.}
}
\tag{GE.A13}
\]

This is an analytic asymptotic contradiction, not a finite-data trend.
It kills the proposed use of full-canonical pointwise domination.  It does
not refute the actual selected physical histograms \(c_g\), LABEL.CAP, or
the signed Route B.

### 33.4 Typing correction to (GE.DOM)

There is also a missing coordinate in the literal statement of (GE.DOM).
The frozen fixed-total histogram is indexed by the first odd position
\(u\): the relevant composition total is \(N=h-u\), and the formal endpoint
map is `cohortEndpoint u`.  A class \((h,r,\sigma)\) generally mixes several
values of \(u\).  Determinism and reverse uniqueness therefore give either

\[
 c_g(a)
 \le
 \sum_u C_{h-u,r}(\pi_u a),
\tag{GE.A14}
\]

with the appropriate unit permutations \(\pi_u\), or a domination by the
already-defined global mixed-cohort histogram.  They do not give the
displayed domination by one unspecified fixed-total histogram in (GE.DOM).
Equivalently, Route A may refine the group by \(u\), but then the
source-weighted geometric valuation tail must be retained explicitly.

For completeness, the corrected inequality follows by sending a physical
source to its length-\(h\) parity word.  At fixed \(u\), that word is the
unique composition in `fixedSet (h-u) r`; endpoint equality forces equality
of its normalized correction residue after the \(u\)-dependent unit change.
Reverse uniqueness makes this map injective inside the endpoint fibre.
Summing the resulting fixed-\(u\) fibre bounds gives (GE.A14).

This correction does not rescue (GE.6): the classes
\(u=O(\log M)\) carry all but polynomially small source mass and obey
(GE.A10)--(GE.A13).

### 33.5 Why generic mass interpolation does not close the gap

For \(u=o(M)\), the canonical central cohort has

\[
 \frac{W_{N,s}}{3^s}
 =2^{(\Delta+o(1))N}
 =2^{(1+o(1))M}
\tag{GE.A15}
\]

sources per residue cell on average.  This is the same exponential size as
the entire physical source shell.  Hence the two black-box facts

\[
 0\le c_g\le C_{N,s},
 \qquad
 \sum_a c_g(a)\le2^M,
\]

permit essentially all physical mass to occupy only polynomially many
canonical cells.  They cannot supply the required factor \(H^{-1/3}\).
The missing statement is again arithmetic selection or signed
anti-alignment of the actual generated subset; it is not a scalar
interpolation between the canonical moment and total source mass.

### 33.6 Status-change and closeout

```text
STATUS-CHANGE CARD

Literal statement before:
  (GE.DOM) pointwise domination by one fixed-total histogram, and (GE.6)
  as the remaining scalar inequality for Route A.

Literal statement after:
  (GE.DOM) requires a first-odd refinement or the global mixed cohort;
  (GE.6) for the full canonical cohort is FALSE on the central
  bit-exhausted scale.

Exact logical difference:
  the first-odd coordinate is restored, and the full-canonical sufficient
  estimate is separated from the still-open actual selected-histogram
  estimate.

Paper proof location:
  (GE.A1)--(GE.A15) above.

Quantifier and parameter-dependence audit:
  S=O(log M), h is in the proved feasible interval, u=O(log M), and the
  central parity corridor gives s/(h-u)->1/2.  The contradiction is
  asymptotic and uniform over every fixed polynomial in S.

Formal declaration / rebuild / dependency scan:
  no new Lean work.  The frozen declarations inspected were
  fixedRenyiMoment_central_le, fixedRenyiMoment's definition,
  cohortEndpoint, and the first-odd global mixture interface.

Counterexample or missing inference justifying demotion:
  Jensen lower bound (GE.A7) plus the feasible-time scaling (GE.A9)
  yields exponent 5.31884...M against the 1.5M budget; (GE.DOM) also
  omitted u although the fixed-total object depends on N=h-u.

Public API and manuscript locations affected:
  none; Section 32 is a research-ledger route only.
```

Reusable results that survive:

* (GE.1)--(GE.3), the grouped-energy dictionary: `PROVED-PAPER`;
* (GE.4), for the literal equal per-source shell normalization:
  `PROVED-PAPER`;
* update congruence and terminal factor-two refinement (GE.5):
  `PROVED-PAPER`;
* the corrected first-odd/global-mixture domination (GE.A14):
  `PROVED-PAPER` at the dictionary level;
* the exact frozen scalar exponent (GE.A4)--(GE.A8): `PROVED-PAPER`;
* failure of full-canonical (GE.6) on the central bit-exhausted scale:
  `FALSE`, proved by (GE.A7)--(GE.A13).

What remains equally hard: LABEL.CAP for the actual generated selected
histograms, the statistics-grouping diagnostic (which concerns \(c_g\), not
\(C_{N,s}\)), the live-stage adapter if an actual capacity bound is found,
and the moving-\(Q\) producer comparison.

Route decision: close the full-canonical Route A scalar branch.  Per the
predeclared Section 32 decision, the next analytic branch is Route B's
source-weighted within-class oscillation, while the exact (GE.4) diagnostic
remains a bounded mechanism test.  Do not spend proof effort on polynomial
prefactor optimization of `realReverseMajorant`; the obstruction is an
exponential gap.

Resume only with: a direct bound for the actual selected histograms in
(GE.4), or a signed within-statistics-class oscillation estimate for
(GE.SPLIT), or an exact generated family killing either of those statements.

## 34. Actual-histogram LABEL.CAP: typed baseline and routed sketches

**Date:** 2026-08-10.  **Scope:** the Section 33 resume conditions.
**Headline status:** unchanged.  **Formalization:** none authorized.

**Later audit:** Sections 35--36 supersede the per-class framing in 34.3
and the diagnostic in 34.6.  Section 35 checks the frozen
rigidity/tagged-fibre declarations against (GE.PAIR): they recover exactly
the existing time-support loss and do not prove (GE.PAIR).  Section 36
removes the negligible diagonal contribution and replaces uniform
per-class control by the source-weighted off-diagonal tail target
(GE.WTAIL)/(GE.LEVEL).  The older statements are retained below only as
the historical route record.

### 34.1 Cycle card

```text
STRONGEST PROVED BASELINE:
  Sections 32--33 survivors: dictionary (GE.1)--(GE.4), terminal factor-two
  refinement (GE.5), first-odd-corrected domination (GE.A14), exact frozen
  central exponent (GE.A4)--(GE.A8), falsity of full-canonical (GE.6);
  V2/V3 frozen chain: odd-count rigidity, loss-filtered tagged fiber,
  feasible time support, subcritical scalar renewal (TS.E1)--(TS.E3).

TARGET (literal):
  LABEL.CAP for the u-refined statistics grouping of the ACTUAL generated
  family: sum over classes g of (sum_a c_g(a)^(3/2))^(2/3)
  <= (S+1)^O(1) 2^M H^(-1/3), with c_g the selected physical histogram.

NOT THE TARGET:
  any bound on the full canonical cohort (killed, GE.A13); arbitrary-target
  equidistribution; pointwise flat fibres for every endpoint; the moving-Q
  producer comparison; reopening the paused LC.28 branch-balance estimate.

CONSUMES:
  LABEL.CAP + (PA.W3) + the live-stage (TS.E7) adapter close the energy
  side of (TS.E2), feeding UFP.TARGET_(d,lambda) via (TC.4)--(TC.6).

FREE BASELINE (typed):
  DIFFERENCE: one factor H^(1/3)/(S+1)^O(1) = M^Theta(1) (see 34.2);
  RATIO: trivial capacity / budget = H^(1/3) up to polylog;
  EXPONENT: zero exponential gap -- the atomic bound already attains the
    budget rate 3/2; Section 33's 5.32 rate belonged to the canonical
    object only;
  SCOPE: only classes with n_g >= 2^M H^(-1/3) (S+1)^(-O(1)) are at issue;
  QUANTIFIER: per-class conditional 3/2-energy E_g <= (S+1)^O(1), not
    per-endpoint uniformity.

DOMINANT LOSS:
  possible positive correlation of the generated selection with
  canonically heavy correction-residue cells.

KNOWN FALSE OR PAUSED ROUTES:
  full-canonical domination (Section 33, FALSE); scalar-loss labels
  (Section 30.4, FALSE); LC.28 (PAUSED, resume conditions unmet and not
  triggered here).

ONE KILL TEST:
  the per-class energy/correlation diagnostic of 34.6.
```

### 34.2 Typed free baseline: the gap is one polynomial factor

Superadditivity of \(x^{3/2}\) on nonnegative reals gives, for every
class,

\[
 \Bigl(\sum_a c_g(a)^{3/2}\Bigr)^{2/3}
 \le\sum_a c_g(a)=n_g.
\tag{GE.B1}
\]

At the stopped stage the \(u\)-refined statistics classes partition the
sources, so the atomic capacity total is exactly

\[
 \sum_g\Bigl(\sum_a c_g(a)^{3/2}\Bigr)^{2/3}
 \le\sum_g n_g=2^M.
\tag{GE.B2}
\]

The (GE.4) budget is \((S+1)^{O(1)}2^MH^{-1/3}\).  Hence:

\[
\boxed{
\text{the actual-histogram LABEL.CAP is exactly a deficit of one factor }
H^{1/3}(S+1)^{-O(1)}=M^{\Theta(1)}.
}
\tag{GE.B3}
\]

There is no exponential obstruction for the actual object.  In
particular, no entropy-barrier computation can kill this target; only
the polynomial window structure can.  Status: PROVED-PAPER (elementary).

### 34.3 Equivalent per-class energy form

**SUPERSEDED by Sections 35.3 and 36.2--36.4.**  The equivalence claimed
in (GE.B4) is false; uniform class energy is only a stronger sufficient
condition.  The exact consumer is source-weighted.

Let \(w_g\) be the schedule-weighted class mass and
\(E_g=H^{1/2}n_g^{-3/2}\sum_ac_g(a)^{3/2}\) the class conditional
\(3/2\)-energy (GE.2).  Classes with
\(n_g\le2^MH^{-1/3}(S+1)^{-c}\) contribute at most
\((S+1)^{O(1)}2^MH^{-1/3}\) to (GE.B2) after multiplying by the
polynomial class count (feasible support times the \(u=O(\log M)\)
main classes; the geometric \(u\)-tail is charged by its source mass,
per (GE.A14)).  For the remaining mass-carrying classes,
\(w_g\ge(S+1)^{-O(1)}\) up to schedule normalization, and

\[
\boxed{
\text{LABEL.CAP for the grouping}
\iff
E_g\le(S+1)^{O(1)}
\text{ on every mass-carrying class.}
}
\tag{GE.B4}
\]

The forward implication is termwise; the reverse is
\(\sum_gw_gE_g^{2/3}\le\max_gE_g^{2/3}\).  Interpretation: the actual
stopped landing law of one statistics class must be polylog-flat in
\(L^{3/2}\) on the \(O(\log M)\)-bit terminal window, versus the trivial
\(E_g\le H^{1/2}\).  Status: PROVED-PAPER (bookkeeping above).

### 34.4 Sketch S1: exact pair-collision second moment

Cauchy--Schwarz with splitting \(c^{3/2}=c^{1/2}\cdot c\) gives

\[
 \sum_a c_g(a)^{3/2}
 \le n_g^{1/2}
 \Bigl(\sum_a c_g(a)^2\Bigr)^{1/2},
\tag{GE.B5}
\]

so (GE.B4) follows from the class-conditional pair bound

\[
\boxed{
 \sum_a c_g(a)^2
 \le
 (S+1)^{O(1)}\frac{n_g^2}{H}.
}
\tag{GE.PAIR}
\]

The second moment is an exact Diophantine count:
\(\sum_ac_g(a)^2=n_g+2\mathcal P_g^\circ\), where
\(\mathcal P_g^\circ\) counts unordered distinct source pairs
\(n<n'\) in one \((h,r,u)\)-class with equal stopped iterate, and
equality of stopped iterates within one class is literally

\[
 A_{w(n')}-A_{w(n)}=3^s(n-n'),
\tag{GE.B6}
\]

both sides with the same modulus data because the class fixes
\((h,s,u)\).  Bounded first task: check whether the frozen odd-count
rigidity and loss-filtered tagged-fiber theorems already bound the
number of solutions of (GE.B6) inside one class before any new
derivation is attempted.  Boundary note: (GE.B6) is a pair-coincidence
count, not the centered branch-balance estimate; the LC.28 pause and its
resume conditions are not touched.  Fallback within S1: dyadic level
decomposition of \(c_g\) if (GE.PAIR) fails only on heavy levels.
Status: (GE.B5)--(GE.B6) PROVED-PAPER; (GE.PAIR) OPEN.

### 34.5 Sketch S2: signed target--load compensation (Route B)

In (GE.SPLIT) the surviving burden is the signed within-class pairing of
the selection excess against canonically heavy residue cells.  The
needed statement is one-sided: absence of **positive** correlation
between the generated selection and the canonical fibre weight; by the
refutation-ladder orientation, alignment is the coincidence, so the
generic configuration favors the estimate.  Machinery already exact:
run the 3-adic martingale identity (PH.2) class-conditionally, apply the
centered two-scale Haar reduction (Section 16), and use the frozen
moment only on the finitely many live depths permitted by the
feasible-time-support theorem.  OPEN: the class-conditional depth
truncation and the quantitative decay in \(Q\) of the truncated
increments (twisted-gap certificate (FD.TWIST) applies only after the
finite truncation is exhibited as a closed chain).  Status: identity
exact; both estimates OPEN.

### 34.6 Kill diagnostic (specification, exact arithmetic)

**SUPERSEDED by Section 36.6.**  A single class with large \(E_g\) is not
a kill signal once its literal source weight is restored.  The diagnostic
below is retained only as the historical specification; the live
diagnostic is the weighted off-diagonal pressure tail (GE.D14).

Theorem tested: (GE.B4) and the correlation orientation of 34.5.
Procedure: generate the actual family at two or three consecutive
scales; per mass-carrying class compute \(E_g\) and the covariance of
the selection indicator with the canonical cell weight, in exact
integer arithmetic.  Positive calibration: a uniformly random word
selection of the same cardinality (must give \(E_g\le\) polylog with
high probability).  Negative calibration: an adversarial selection
loading the heaviest canonical cells (must exhibit
\(E_g\gg\) polylog).  Kill thresholds: \(E_g\ge H^{1/2-\epsilon}\)
persisting across scales kills (GE.B4) for this grouping; persistent
positive selection--weight covariance kills the S2 orientation.
Neither kills the all-depth LABEL.CAP statement (harness F4 gate).

### 34.7 Closeout

New this cycle: the typed zero-exponential-gap baseline (GE.B1)--(GE.B3),
the per-class energy equivalence (GE.B4), the exact pair-collision
reduction (GE.B5)--(GE.B6): all PROVED-PAPER at the elementary level
stated.  OPEN: (GE.PAIR); the S2 truncation and decay estimates; the
live-stage (TS.E7) adapter; the moving-\(Q\) comparison.

What was strictly narrowed: LABEL.CAP for the actual family is now a
single polynomial-factor flatness question with two named sufficient
statements ((GE.PAIR), or S2's one-sided correlation), each finitely
testable.

What remains equally hard: the arithmetic of the selection --- (GE.B6)
solution counting is the same hidden-digit correlation, now in its
sharpest coordinates.

Route decision: attack (GE.PAIR) first through the frozen rigidity and
tagged-fiber theorems; run the 34.6 diagnostic in parallel; hold S2
until (GE.PAIR) is proved, killed, or blocked.

Resume only with: a rigidity-based bound for (GE.B6) inside one class,
the 34.6 diagnostic verdict, or an exact generated family violating
(GE.PAIR) on a mass-carrying class.

## 35. Frozen-rigidity reuse audit: exact recovery of the old loss

**Date:** 2026-08-10.  **Scope:** the predeclared reuse-before-derivation
task in Section 34.4.  **Headline status:** unchanged.  **Formalization:**
none.

### 35.1 Quantifier-by-quantifier interface check

The two frozen declarations inspected are:

```text
lossFiltered_oddCount_rigidity
  n1,n2 in lossFilteredTaggedFiber M Y h y D
  -> oddCount n1 h = oddCount n2 h;

lossFilteredTaggedFiber_bound
  card (lossFilteredTaggedFiber M Y h y D)
  <= 1 + 3 D 2^M / Y.
```

Their hypotheses are \(Y>0\), \(D\ge0\), and \(D/Y\le1/3\).  The fibre
itself fixes:

* the original dyadic source shell \(I_M\);
* the exact first-passage threshold \(Y\);
* the actual first-passage time \(h\);
* the exact landing value \(y\);
* the sourcewise scaled-loss cap \(D\).

At the Phase-3 stopped landing, take

\[
 Y=2^S=2H,
 \qquad
 D=D_S=\frac{S+2}{r_*}.
\tag{GE.C1}
\]

The existing startup condition gives \(D_S/Y\le1/3\).  A generated
\((h,s,u)\)-class is a subset of this tagged fibre at each endpoint \(y\):
it adds the already fixed odd count \(s\) and first-odd position \(u\).
Thus all terminal hypotheses match.  The theorem does **not** cover the
live functional labels before first passage; the (TS.E7) live-stage adapter
remains separate.

The rigidity theorem is not an additional multiplicative gain after the
cardinality theorem.  The formal proof of
`lossFilteredTaggedFiber_bound` invokes
`lossFiltered_oddCount_rigidity` internally to obtain one common reverse
scale.  Reusing both declarations therefore supplies one bound, not two
independent savings.

### 35.2 The exact pair estimate actually supplied

Put

\[
 K_{M,S}
 =1+3D_S\frac{2^M}{Y}
 =1+\frac{3D_S}{2}\frac{2^M}{H}.
\tag{GE.C2}
\]

For a stopped class \(g\), write

\[
 n_g=\sum_yc_g(y),
 \qquad
 \mathcal C_g=\sum_yc_g(y)^2.
\]

The frozen theorem gives \(c_g(y)\le K_{M,S}\) pointwise.  Therefore

\[
\boxed{
 \mathcal C_g
 \le K_{M,S}n_g
 \le (S+1)^{O(1)}\frac{2^M}{H}n_g.
}
\tag{GE.C3}
\]

This is a genuine all-scale paper consequence of the frozen formal
declaration; no empirical input is used.

The desired (GE.PAIR) bound is

\[
 \mathcal C_g
 \le (S+1)^{O(1)}\frac{n_g^2}{H}.
\tag{GE.C4}
\]

Comparing (GE.C3) and (GE.C4), the frozen theorem closes the class only
when

\[
 n_g\ge\frac{2^M}{(S+1)^{O(1)}}.
\tag{GE.C5}
\]

It does not close a typical time-sliced class of mass
\(n_g\asymp2^M/\#\mathcal H_{M,S}\), nor the Section 34 threshold
\(n_g\asymp2^MH^{-1/3}(S+1)^{-O(1)}\).  At the latter threshold the
unrecovered factor can still be \(H^{1/3}\) up to polylogarithms.

Equivalently, the exact extra statement needed beyond the frozen theorem
is the selection-density factor

\[
\boxed{
 \mathcal C_g
 \le (S+1)^{O(1)}
 \frac{n_g}{2^M}\,K_{M,S}n_g.
}
\tag{GE.C6}
\]

Since \(K_{M,S}\asymp(S+1)^{O(1)}2^M/H\), (GE.C6) is precisely
(GE.C4).  It says that conditioning on the generated time/first-odd class
does not select the worst endpoint fibres more than its source density
allows.  Neither frozen declaration contains such a conditioning estimate.

### 35.3 Scale-consistency correction to (GE.B4)

The exact weighted identity behind LABEL.CAP is

\[
\boxed{
 \text{LABEL.CAP}
 \iff
 \sum_g w_gE_g^{2/3}\le(S+1)^{O(1)},
 \qquad
 w_g=\frac{n_g}{2^M}
}
\tag{GE.C7}
\]

for the literal equal per-source shell normalization.  A uniform estimate
\(E_g\le(S+1)^{O(1)}\) is sufficient for (GE.C7), but (GE.C7) does not
imply that uniform estimate.

Indeed the Section 34 definition of a mass-carrying class gives only

\[
 w_g
 \ge H^{-1/3}(S+1)^{-O(1)},
\tag{GE.C8}
\]

not \(w_g\ge(S+1)^{-O(1)}\).  Since
\(H=2^{S-1}=M^{\Theta(1)}\), the missing \(H^{-1/3}\) cannot be absorbed
by a fixed power of \(S+1\).  Likewise, the feasible-time class count is
only bounded by \(M^{1/2+o(1)}\), not by a proved polynomial in
\(S=O(\log M)\); using the available bound to multiply a per-class
small-mass threshold is not a polylogarithmic cost.

The failure of the claimed implication has an exact abstract calibration.
Take one class of weight \(w_1=H^{-1/3}\) concentrated at one endpoint, so
\(E_1=H^{1/2}\), and put the remaining weight in a flat class with energy
one.  Then

\[
 \sum_gw_gE_g^{2/3}
 =H^{-1/3}H^{1/3}+(1-H^{-1/3})
 <2,
\]

while the declared mass-carrying class has non-polylogarithmic energy
\(H^{1/2}\).  This is a calibration of the bookkeeping implication, not a
claim that the generated Collatz family realizes the extremizer.

Consequently (GE.B4) is FALSE as an equivalence.  Its valid part is:

\[
 \left[E_g\le(S+1)^{O(1)}\text{ for every carrying class, with the
 remaining total mass charged at the LABEL.CAP scale}\right]
 \Longrightarrow\text{LABEL.CAP}.
\tag{GE.C9}
\]

The bracketed tail condition is essential and was not proved in Section
34.3.

### 35.4 Aggregating the frozen estimate recovers exactly the baseline

Let

\[
 A_g=\left(\sum_yc_g(y)^{3/2}\right)^{2/3}.
\]

From (GE.B5) and (GE.C3),

\[
 A_g
 \le n_g^{1/3}\mathcal C_g^{1/3}
 \le K_{M,S}^{1/3}n_g^{2/3}.
\tag{GE.C10}
\]

If \(G\) classes carry mass, Hölder and \(\sum_gn_g\le2^M\) give

\[
\begin{aligned}
 \sum_gA_g
 &\le K_{M,S}^{1/3}
       G^{1/3}\left(\sum_gn_g\right)^{2/3}\\
 &\le (S+1)^{O(1)}G^{1/3}2^MH^{-1/3}.
\end{aligned}
\tag{GE.C11}
\]

Thus the reuse chain misses LABEL.CAP by exactly \(G^{1/3}\).  Even in
the most favorable bookkeeping where the only non-polylogarithmic class
multiplicity is the feasible-time support
\(T=\#\mathcal H_{M,S}\), (GE.C11) costs \(T^{1/3}\).  Passing through
the optimal nominal-reference formula (PA.W3), which raises capacity to
the \(3/2\) power, turns this into \(T^{1/2}\): the already proved
square-root time-support loss.  The proposed reuse therefore reconstructs
the current theorem exactly and yields no Phase-3 exponent improvement.

If the literal \((h,s,u)\) grouping carries additional non-polylogarithmic
class multiplicity, (GE.C11) is only weaker; this does not affect the
negative reuse verdict.

### 35.5 Correct source-weighted pair target

The weakest pair statement naturally produced by (GE.B5) keeps the class
weights.  For \(n_g>0\), define the collision probability

\[
 q_g=\frac{\mathcal C_g}{n_g^2}.
\]

Then (GE.B5) gives \(A_g\le n_gq_g^{1/3}\).  Hence the direct
source-weighted sufficient theorem is

\[
\boxed{
 \sum_{g:n_g>0}
 w_g\left(Hq_g\right)^{1/3}
 \le(S+1)^{O(1)}.
}
\tag{GE.WPAIR}
\]

Unlike (GE.PAIR), (GE.WPAIR) permits small or rare classes to have large
conditional energy when their actual source weight pays for it.  It is
therefore closer to LABEL.CAP and preserves the cancellation discipline of
the project.  The frozen estimate gives only

\[
 \sum_gw_g(Hq_g)^{1/3}
 \le(S+1)^{O(1)}\sum_gw_g^{2/3}
 \le(S+1)^{O(1)}G^{1/3},
\tag{GE.C12}
\]

again reproducing (GE.C11).

### 35.6 Status-change and closeout

```text
STATUS-CHANGE CARD

Literal statement before:
  (GE.B4) claimed equivalence of LABEL.CAP with uniform polylogarithmic
  energy on mass-carrying classes; the frozen rigidity/tagged-fibre chain
  was a candidate proof of per-class (GE.PAIR).

Literal statement after:
  uniform class energy is only sufficient, with a separately charged
  tail; the exact weighted target is (GE.C7), and the weakest pair
  sufficient target is (GE.WPAIR).  The frozen chain proves only (GE.C3)
  and the aggregate baseline (GE.C11).

Exact logical difference:
  the source weights and the non-polylogarithmic feasible-time class count
  are retained instead of being replaced by a per-class maximum.

Paper proof location:
  (GE.C1)--(GE.C12) above.

Quantifier and parameter-dependence audit:
  the frozen declarations match fixed M,Y,h,y,D terminal fibres; odd count
  is derived, u-refinement is a subset, and no live-stage conclusion is
  supplied.  S=O(log M), H=2^(S-1), and #H_(M,S)=M^(1/2+o(1)) are kept in
  distinct scales.

Formal declaration / rebuild / dependency scan:
  declarations read directly in LossTransport.lean.  The proof of
  lossFilteredTaggedFiber_bound visibly consumes
  lossFiltered_oddCount_rigidity.  No Lean source changed and no theorem
  status was newly promoted, so no rebuild was required for this interface
  audit.

Counterexample or missing inference justifying demotion:
  (GE.C8) is H^(-1/3) times a polylog, not a polylogarithmic lower mass;
  the explicit atomic-plus-flat calibration above satisfies the weighted
  LABEL.CAP bound while its declared mass-carrying class has energy
  H^(1/2).  The available class-count bound is polynomial in M, not in S.

Public API and manuscript locations affected:
  none; Sections 34--35 are research-ledger material only.
```

Surviving results:

* (GE.B1)--(GE.B3): `PROVED-PAPER`;
* (GE.B5)--(GE.B6): `PROVED-PAPER`;
* (GE.B4) as an equivalence: `FALSE`; its sufficient direction survives
  only with the explicit tail condition (GE.C9);
* frozen terminal fibre consequence (GE.C3): `PROVED-PAPER` from the
  inspected `PROVED-FORMAL` declarations;
* per-class (GE.PAIR): `OPEN`, not implied by the frozen chain;
* weighted pair target (GE.WPAIR): exact sufficient reduction, `OPEN`.

What was strictly narrowed: the frozen reuse attempt is complete.  It does
not merely fall slightly short; after aggregation and (PA.W3) it reproduces
the existing square-root time-support loss exactly.  The missing gain is the
selection-density factor (GE.C6), or its weaker source-weighted aggregate
(GE.WPAIR).

What remains equally hard: arithmetic anti-alignment between the generated
time/first-odd selection and the endpoint fibres; the live-stage adapter;
and the moving-Q comparison.

Route decision: close the frozen-rigidity reuse shortcut.  A new proof of
(GE.PAIR) would require an additional arithmetic selection theorem not
present in the frozen chain.  Under the predeclared Section 34 order, Route
S2 may now be activated, with (GE.WPAIR) retained as the exact pair-side
alternative.  This route instruction is superseded by Section 36: the
diagnostic must measure the source-weighted off-diagonal pressure tail, not
the largest class energy.

Resume only with: (GE.LEVEL)/(GE.WTAIL) for the actual family, the corrected
Section 36.6 diagnostic, or a class-conditional signed estimate that
implies the same weighted tail.

## 36. Source-weighted off-diagonal collision pressure

**Date:** 2026-08-10.  **Scope:** correction and strict narrowing of
Sections 34--35.  **Headline status:** unchanged.  **Formalization:** none
authorized.

This section supersedes the per-class target in 34.3 and the diagnostic in
34.6.  The target is not uniform flatness of every generated class.  It is
a source-weighted tail estimate for the off-diagonal collision pressure.

### 36.1 Cycle card

```text
STRONGEST PROVED BASELINE:
  the actual-histogram dictionary (GE.1)--(GE.4); atomic capacity
  (GE.B1)--(GE.B3); exact weighted identity (GE.C7); frozen terminal
  endpoint-fibre cap (GE.C3); feasible statistics-class support.

TARGET (literal):
  for the one fixed Phase-3 schedule, there exist fixed C and M_0 such
  that for every M >= M_0 and every integer
  0 <= j <= ceil(log_2 H),

    sum_{g: 2^j <= 2 H P_circ(g) / n_g^2 < 2^(j+1)} n_g
      <= 2^M (S+1)^C 2^(-j/3).

  Here P_circ(g) is the number of unordered DISTINCT source pairs in class
  g with the same stopped endpoint.

NOT THE TARGET:
  uniform E_g control; per-class (GE.PAIR); maximum-fibre control;
  suppression of singleton or bit-exhausted classes; arbitrary schedules.

FREE BASELINE:
  the diagonal/singleton pressure is exponentially negligible after
  literal source weighting; the frozen cap controls each class but not
  the total source weight of all high-pressure classes.

DOMINANT LOSS:
  possible concentration of generated source mass on many classes with
  large off-diagonal conditional collision probability.

ONE KILL TEST:
  an all-depth generated scale family for which
    sup_R R^(1/3) sum_{g: H q_g^off >= R} n_g/2^M
  grows faster than every fixed power of S.  A single heavy class is not
  a kill.
```

Target sanity: the theorem is strictly weaker than (GE.PAIR), permits the
atomic calibration $w_g=H^{-1/3}$, $Hq_g^\circ=H$, and is neither
implied nor contradicted by the frozen endpoint-fibre cap.  Status:
`UNKNOWN-BUT-INTENDED`.

### 36.2 Collision notation and the exact weighted identity

Sections 34 and 35 used $P_g$ for two different objects.  Fix

\[
 \mathcal C_g:=\sum_yc_g(y)^2,
 \qquad
 \mathcal P_g^\circ:=\sum_y\binom{c_g(y)}2.
\]

Then

\[
\boxed{
 \mathcal C_g=n_g+2\mathcal P_g^\circ.
}
\tag{GE.D1}
\]

The exact equation (GE.B6) counts the distinct unordered pairs in
\(\mathcal P_g^\circ\); the frozen tagged-fibre theorem bounds
\(\mathcal C_g\).

Put

\[
 A_g=\left(\sum_yc_g(y)^{3/2}\right)^{2/3},
 \qquad
 w_g=\frac{n_g}{2^M},
 \qquad
 E_g=H^{1/2}n_g^{-3/2}\sum_yc_g(y)^{3/2}.
\]

Directly from the definitions,

\[
 E_g^{2/3}=H^{1/3}n_g^{-1}A_g,
 \qquad
\boxed{
 w_gE_g^{2/3}=\frac{H^{1/3}}{2^M}A_g.
}
\tag{GE.D2}
\]

Consequently LABEL.CAP is exactly equivalent, in the literal equal
per-source shell normalization, to

\[
\boxed{
 \sum_gw_gE_g^{2/3}\le(S+1)^{O(1)}.
}
\tag{GE.D3}
\]

This proves again, now term for term, why no uniform conclusion about every
\(E_g\) follows.  Status: (GE.D1)--(GE.D3) `PROVED-PAPER`.

### 36.3 The correctly weighted pair consumer

Cauchy--Schwarz gives

\[
 \sum_yc_g(y)^{3/2}
 \le n_g^{1/2}\mathcal C_g^{1/2},
 \qquad
 A_g\le n_g^{1/3}\mathcal C_g^{1/3}.
\]

For $n_g>0$, define

\[
 q_g:=\frac{\mathcal C_g}{n_g^2}.
\]

Then

\[
\boxed{A_g\le n_gq_g^{1/3}}
\tag{GE.D4}
\]

and therefore

\[
\boxed{
 \sum_gA_g
 \le2^MH^{-1/3}\sum_gw_g(Hq_g)^{1/3}.
}
\tag{GE.D5}
\]

Thus the canonical pair-side sufficient theorem is

\[
\boxed{
 \sum_gw_g(Hq_g)^{1/3}\le(S+1)^{O(1)}.
}
\tag{GE.WPAIR}
\]

This preserves the source weights and is strictly weaker than uniform
(GE.PAIR).  Status: reduction `PROVED-PAPER`; (GE.WPAIR) `OPEN`.

### 36.4 The diagonal is negligible

Define the off-diagonal conditional collision probability

\[
 q_g^\circ:=\frac{2\mathcal P_g^\circ}{n_g^2}.
\]

By (GE.D1), $q_g=n_g^{-1}+q_g^\circ$.  Since the cube root is
subadditive,

\[
 (Hq_g)^{1/3}
 \le\left(\frac H{n_g}\right)^{1/3}
      +(Hq_g^\circ)^{1/3}.
\tag{GE.D6}
\]

Let $G_M$ be the number of nonempty $u$-refined statistics classes.
For the declared grouping $G_M=M^{O(1)}$: the feasible arrival-time
support is $M^{1/2+o(1)}$, and all remaining integer labels have
polynomial ranges.  Since \(\sum_gn_g\le2^M\), Hölder gives

\[
\begin{aligned}
 \sum_gw_g\left(\frac H{n_g}\right)^{1/3}
 &=\frac{H^{1/3}}{2^M}\sum_gn_g^{2/3}\\
 &\le\frac{H^{1/3}}{2^M}G_M^{1/3}
       \left(\sum_gn_g\right)^{2/3}\\
 &\le\left(\frac{HG_M}{2^M}\right)^{1/3}.
\end{aligned}
\tag{GE.D7}
\]

Here $H=2^{S-1}=M^{O(1)}$, so

\[
\boxed{
 \sum_gw_g\left(\frac H{n_g}\right)^{1/3}=o(M^{-B})
 \quad\text{for every fixed }B.
}
\tag{GE.D8}
\]

Hence singleton and bit-exhausted diagonal collisions are not the live
obstruction.  Up to the negligible term (GE.D8), (GE.WPAIR) reduces to

\[
\boxed{
 \sum_gw_g(Hq_g^\circ)^{1/3}\le(S+1)^{O(1)}.
}
\tag{GE.OFFPAIR}
\]

Status: diagonal removal `PROVED-PAPER`; (GE.OFFPAIR) `OPEN`.

### 36.5 Equivalent weighted-tail formulation

Put

\[
 X_g:=Hq_g^\circ\in[0,H],
 \qquad
 \mathcal W_M(R):=\sum_{g:X_g\ge R}w_g
 \quad(1\le R\le H).
\tag{GE.D9}
\]

The moment target (GE.OFFPAIR) implies, by Markov,

\[
 \mathcal W_M(R)
 \le R^{-1/3}\sum_gw_gX_g^{1/3}.
\tag{GE.D10}
\]

Conversely let $J=\lceil\log_2H\rceil=O(S)$.  Pointwise,

\[
 X_g^{1/3}
 \le1+\sum_{j=0}^{J}2^{(j+1)/3}
          \mathbf1_{\{X_g\ge2^j\}}.
\]

Therefore a polynomial bound for the weighted tails gives

\[
\begin{aligned}
 \sum_gw_gX_g^{1/3}
 &\le1+\sum_{j=0}^{J}2^{(j+1)/3}\mathcal W_M(2^j)\\
 &\le1+2^{1/3}(J+1)(S+1)^{O(1)}
  =(S+1)^{O(1)}.
\end{aligned}
\tag{GE.D11}
\]

Thus, up to the harmless $O(S)$ dyadic-layer factor, the preferred
formulation is

\[
\boxed{
 \sup_{1\le R\le H}R^{1/3}\mathcal W_M(R)
 \le(S+1)^{O(1)}.
}
\tag{GE.WTAIL}
\]

This permits the critical calibration $w_g=H^{-1/3}$, $X_g=H$: its
entire contribution is one.  Status: equivalence of polynomial
(GE.OFFPAIR) and (GE.WTAIL) bounds `PROVED-PAPER`; (GE.WTAIL) itself
`OPEN`.

### 36.6 Exact limit of the frozen fibre theorem and corrected diagnostic

The frozen endpoint-fibre cap gives

\[
 c_g(y)\le K_{M,S},
 \qquad
 K_{M,S}\asymp(S+1)^{O(1)}\frac{2^M}{H}.
\]

Consequently

\[
 \mathcal C_g\le K_{M,S}n_g,
 \qquad
 X_g\le Hq_g\le\frac{HK_{M,S}}{n_g}
       \le\frac{(S+1)^{O(1)}}{w_g}.
\tag{GE.D12}
\]

Thus $X_g\ge R$ forces only the individual estimate

\[
 w_g\le\frac{(S+1)^{O(1)}}R.
\tag{GE.D13}
\]

It does not bound the total source weight of all such classes.  Summing
this pointwise cap over the class count recreates the old time-support
loss.  The missing theorem is exactly that high conditional collision
pressure cannot occur on too much generated source mass.

The corrected exact-arithmetic diagnostic is therefore: for every
nonempty class compute

\[
 X_g^\circ=\frac{2H\mathcal P_g^\circ}{n_g^2},
 \qquad
\boxed{
 \mathfrak T_M(R)=R^{1/3}
 \sum_{g:X_g^\circ\ge R}\frac{n_g}{2^M}
}
\tag{GE.D14}
\]

at all dyadic $R=2^j$.  The controls are:

* random same-cardinality selection after diagonal removal, for which
  $Hq_g^\circ\asymp1$ is the reference scale;
* heaviest-cell adversarial selection, which must create a visible
  high-$R$ tail;
* the actual generated family, for which the whole weighted tail curve,
  not \(\max_gE_g\), is the object tested.

A finite trend is only `EMPIRICAL`.  The theorem-level kill requires an
explicit all-depth generated family with
\(\sup_R\mathfrak T_M(R)\) growing faster than every fixed power of
$S$.  One heavy class does not kill the route.

### 36.7 Next bounded proof theorem

The exact next target is the dyadic level estimate: there exist fixed
$C$ and $M_0$ such that for every $M\ge M_0$ and every integer
$0\le j\le\lceil\log_2H\rceil$,

\[
\boxed{
 \sum_{\substack{g:n_g>0\\
  2^j\le 2H\mathcal P_g^\circ/n_g^2<2^{j+1}}}n_g
 \le2^M(S+1)^C2^{-j/3}.
}
\tag{GE.LEVEL}
\]

Summing (GE.LEVEL) geometrically over all levels at or above a prescribed
dyadic threshold proves (GE.WTAIL).  Conversely (GE.WTAIL) bounds every
single level.  Hence (GE.LEVEL) and (GE.WTAIL) are equivalent up to fixed
constants at the declared polynomial precision.

The counted pairs are exactly the distinct unordered solutions of

\[
 A_{w(n')}-A_{w(n)}=3^s(n-n')
\]

inside one statistics class.  What differs from (GE.PAIR) is the final
aggregation: no classwise flatness is demanded; only the source-weighted
mass of each pressure level is bounded.

Status: implication/equivalence chain `PROVED-PAPER`; (GE.LEVEL) `OPEN`.

### 36.8 Closeout

```text
PROVED-PAPER:
  notation identity (GE.D1);
  exact weighted identity (GE.D2)--(GE.D3);
  weighted pair reduction (GE.D4)--(GE.D5);
  diagonal negligibility (GE.D6)--(GE.D8);
  polynomial equivalence of GE.OFFPAIR, GE.WTAIL, and GE.LEVEL;
  exact limit of the frozen cap (GE.D12)--(GE.D13).

SUPERSEDED / PARKED:
  GE.B4 as an equivalence: FALSE;
  Section 34.6 max-class diagnostic: SUPERSEDED;
  per-class GE.PAIR: PARKED as a stronger producer.

OPEN:
  GE.LEVEL for the actual generated family;
  equivalently GE.WTAIL / GE.OFFPAIR;
  hence actual-histogram LABEL.CAP and the Phase-3 improvement.

NEXT PROOF:
  establish the source-weighted R^(-1/3) heavy-pressure tail through the
  exact pair equation (GE.B6), without replacing source weights by a
  maximum over classes.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged.
```

## 36.9 Later audit of the proposed finite terminal-suffix reduction

**Date:** 2026-08-10.  **Scope:** exact kill test for the proposed
`TSUFF` proof plan.  **Headline status:** unchanged.  **Formalization:**
none.

This later audit is placed here with the source-weighted pair target that it
tests; Section 37 below records the block localization which motivated the
proposal.

The proposal conditions on one free prefix \(v\), then claims that two
different source blocks cannot collide while the remaining suffix length
is at least \(S-1\).  The claimed divisibility uses one common suffix word.
A statistics class fixes the suffix length and suffix odd count, but not the
suffix parity word.  Unequal suffix words have different affine correction
terms, and those terms can merge different blocks at arbitrarily longer
suffix lengths.

### 36.9.1 The exact algebraic defect

After the common free prefix, write

\[
 x_i=3^r(H+b_i)+\beta_v.
\]

If the two suffix words are \(w_1,w_2\), have common length \(t\), common
odd count \(a\), and correction terms \(A_{w_1},A_{w_2}\), then

\[
 T^t(x_i)=\frac{3^a x_i+A_{w_i}}{2^t}.
\]

Equal endpoints therefore satisfy

\[
\boxed{
 3^{r+a}(b_2-b_1)=A_{w_1}-A_{w_2}.
}
\tag{GE.K1}
\]

There is no conclusion

\[
 2^t\mid b_2-b_1.
\]

That divisibility only expresses compatibility with one fixed parity branch.
Moreover, if \(w_1=w_2\), endpoint equality forces \(b_1=b_2\) for every
\(t\), not merely for \(t>S-1\).  Thus the same-word case is harmless at
all depths; the unequal-word correction in (GE.K1) is the entire live
collision mechanism.

### 36.9.2 Exact stopped fixed-prefix counterexample

Take

\[
 M=12,\qquad S=5,\qquad Y=32,\qquad H=16,\qquad k=M-S+1=8.
\]

Fix \(v=159\), and take block indices \(b_1=13\), \(b_2=14\).  The two
sources are

\[
 n_1=2^8(16+13)+159=7583,
 \qquad
 n_2=2^8(16+14)+159=7839.
\tag{GE.K2}
\]

Both have the same first eight parity bits

\[
 11111011,
\]

whose odd count is \(r=7\).  Exact iteration gives

\[
 T^8(n_1)=64790,\qquad T^8(n_2)=66977,\qquad
 T^8(n_2)-T^8(n_1)=2187=3^7.
\tag{GE.K3}
\]

Their complete parity words up to first passage below \(Y\) are

```text
11111011 01101001100000101010011010001101010
11111011 10101101010010100101100111010000000
```

Direct shortcut iteration gives, for both sources,

\[
 \tau_{32}=43,\qquad
 \#\{\text{odd steps}\}=22,\qquad
 u=0,\qquad
 T^{43}(n_i)=28.
\tag{GE.K4}
\]

Every earlier iterate is greater than \(32\), so these are literal stopped
first passages.  The common prefix consumes eight steps; the unequal suffix
has length

\[
 t=43-8=35>S-1=4.
\]

The two exact scaled reverse losses satisfy

\[
 E_{32}(n_1)<2,qquad E_{32}(n_2)<2.
\tag{GE.K5}
\]

Hence both pass the Phase-3 terminal loss cap
\(D_S=(S+2)/r_*>7\).  Nevertheless \(b_2-b_1=1\), so

\[
 2^{35}\nmid b_2-b_1.
\]

This is a paper-checkable stopped counterexample to the proposed
long-suffix collision-free lemma.  It refutes the local algebraic producer;
it does not by itself refute the schedule-restricted weighted-tail theorem,
whose feasible-time selection is an additional restriction.

### 36.9.3 The fixed-\(v\) consumer is also mismatched

For fixed \(v\), there is exactly one source in each source block \(b\).
Consequently the off-diagonal probability that two distinct fixed-\(v\)
sources have the same block is identically zero.  If
\(q_g^{\rm off}(v)\) denotes block collision, the proposed TSUFF quantity
is therefore vacuous.  If it denotes endpoint collision instead, it is not
the source-block pressure in \(\mathrm{GE.BLOCKTAIL}\).

More explicitly,

\[
 a_g(b)=\sum_v\mathbf1_{\{(v,b)\in g\}},
\]

so

\[
\boxed{
 \sum_ba_g(b)^2
 =\sum_b\sum_{v_1,v_2}
 \mathbf1_{\{(v_1,b)\in g\}}
 \mathbf1_{\{(v_2,b)\in g\}}.
}
\tag{GE.K6}
\]

A theorem conditioned on one \(v\) controls only the diagonal
\(v_1=v_2\).  It does not control the cross-prefix terms \(v_1\ne v_2\),
which are part of \(\mathrm{GE.BLOCKTAIL}\).  The proposed Case A estimate for those
terms was only asserted.  Importing the full fixed-total \(3/2\)-moment
dictionary there recreates the exponentially misnormalized canonical route
already rejected in Section 33.

### 36.9.4 Closeout

```text
PROVED-PAPER:
  unequal-word collision identity (GE.K1);
  exact stopped fixed-prefix counterexample (GE.K2)--(GE.K5);
  cross-prefix expansion (GE.K6).

FALSE:
  t >= S-1 implies collision-free source blocks;
  same stopping length and odd count imply 2^t | (b_2-b_1);
  reduction of the collision problem to the final S suffix bits.

OPEN:
  the schedule-restricted GE.BLOCKTAIL / GE.WTAIL theorem itself.

INSUFFICIENT AS STATED:
  fixed-v TSUFF: block-off-diagonal interpretation is vacuous; endpoint
  interpretation omits the cross-v block-pressure terms.

SURVIVING EXACT STRUCTURE:
  Section 37 block localization and the free-prefix identities;
  same-suffix branches are injective;
  every collision is generated by unequal-word correction alignment.

ROUTE DECISION:
  do not build the proposed finite terminal operator.  Resume only with an
  estimate that retains both unequal suffix corrections and cross-prefix
  pairs, or with a schedule-specific theorem proving those pairs absent.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged.
```

The conceptual correction is:

\[
\boxed{
\text{The problem is not to flatten every generated class.  It is to show
that highly collisional classes carry at most the critical
source-weighted }R^{-1/3}\text{ tail.}
}
\]

## 37. Weighted-pressure attempt: exact block localization and the live channel

**Date:** 2026-08-10.  **Scope:** bounded prove-or-kill attempt on
(GE.LEVEL).  **Headline status:** unchanged.  **Formalization:** none.

This cycle attacks the literal source-weighted pressure theorem rather than
replacing it by a classwise maximum.  It proves two additional reductions:
the existing fibre cap already closes the low- and high-pressure ranges, and
the loss-filtered reverse geometry transfers the remaining endpoint pressure
to concentration on equal source blocks with only a polynomial-in-\(S\)
cost.  The resulting source-block tail is empirically favorable, but its
all-depth proof is exactly a prefix/suffix channel estimate which is not in
the frozen package.

### 37.1 Cycle card

```text
STRONGEST PROVED BASELINE:
  Section 36, including the equivalence GE.LEVEL <-> GE.WTAIL and the
  pointwise frozen cap X_g <= P_S / w_g, with P_S=(S+1)^O(1).

TARGET (literal):
  GE.LEVEL for the actual generated, loss-filtered, u-refined statistics
  classes of the one fixed Phase-3 schedule.

NOT THE TARGET:
  an unrestricted direct first-passage theorem; uniform class flatness;
  a maximum-fibre theorem; an arbitrary source partition.

STOPPING CONDITION:
  either prove GE.LEVEL from the source-block channel, or identify the
  exact unproved conditional suffix estimate and stop rather than rename it.

CALIBRATIONS:
  flat conditional transport has pressure about one; G equal block-aligned
  classes have pressure about G on all source mass and fail by G^(1/3).
```

### 37.2 Two pressure ranges are already closed

Write

\[
 P_S=(S+1)^B,
 \qquad
 G_M=\#\{g:n_g>0\},
\]

where \(B\) is a fixed exponent large enough for the frozen fibre cap.
Equation (GE.D13), summed over at most \(G_M\) classes, gives the exact
baseline

\[
\boxed{
 \mathcal W_M(R)
 \le \min\left\{1,\frac{P_SG_M}{R}\right\}.
}
\tag{GE.R1}
\]

Let \(Q_S=(S+1)^C\), with \(C\) fixed.  The desired estimate
\(\mathcal W_M(R)\le Q_SR^{-1/3}\) follows from the first term in
(GE.R1) whenever

\[
 R\le Q_S^3,
\tag{GE.R2}
\]

and from the second term whenever

\[
 R\ge\left(\frac{P_SG_M}{Q_S}\right)^{3/2}.
\tag{GE.R3}
\]

Thus the live pressure range is confined to

\[
\boxed{
 Q_S^3<R<\left(\frac{P_SG_M}{Q_S}\right)^{3/2}.
}
\tag{GE.R4}
\]

The upper interval may be empty for particular parameter choices; the
statement is only a range reduction.  Since \(G_M\) is polynomial in the
outer rank rather than in \(S\), it cannot be absorbed into \(Q_S\).
Status: (GE.R1)--(GE.R4) `PROVED-PAPER`.

This loss is attainable by the current black-box interfaces.  Suppose for
calibration that \(G\mid H\) and \(H\mid2^M\).  Split the sources into
\(G\) equal classes; give each class \(H/G\) disjoint endpoint cells, with
constant fibre \(2^M/H\) on those cells.  Then every class obeys the frozen
fibre scale and has

\[
 X_g=G\left(1-\frac H{2^M}\right).
\tag{GE.R5}
\]

All source mass lies at this pressure, so the weighted tail is asymptotic
to \(G^{1/3}\).  Hence global mass, class count, and the pointwise fibre cap
alone cannot prove (GE.WTAIL).  This is an abstract interface calibration,
not a Collatz counterexample.

### 37.3 Exact source-block localization lemma

Put

\[
 N=2^M,\qquad Y=2^S=2H,\qquad
 \ell=\frac NH=2^{M-S+1},\qquad
 \epsilon=\frac DY\le\frac13.
\]

Partition the source shell \(I_M=[N,2N)\) into the \(H\) consecutive
half-open blocks \(B_b\) of length \(\ell\).  Fix one generated statistics
class \(g\).  It fixes the first-passage time \(h\) and odd count \(s\), so
put

\[
 a=\frac{2^h}{3^s}.
\]

For every source in the loss-filtered fibre over endpoint \(y\), Lemma 4.2
of the manuscript gives

\[
 n\in I_y:=[(1-\epsilon)ay,ay].
\tag{GE.BL1}
\]

If this fibre is nonempty, \(n\ge N\), \(y\le Y\), \(n<2N\),
\(y>Y/2\), and \(1-\epsilon\ge2/3\) imply

\[
\boxed{
 \frac\ell2\le a<3\ell.
}
\tag{GE.BL2}
\]

The interval in (GE.BL1) has length at most \(Da<3D\ell\).  It therefore
meets at most

\[
 L_1:=\lceil3D\rceil+2
\tag{GE.BL3}
\]

source blocks.  Conversely fix a source block \(B=[x,x+\ell)\).  If
\(I_y\cap B\ne\varnothing\), then

\[
 \frac xa\le y<\frac{x+\ell}{(1-\epsilon)a}.
\]

Using \(x<2N\), (GE.BL2), and \(1-\epsilon\ge2/3\), this interval has
length at most \(3D+3\).  Hence at most

\[
 L_2:=\lceil3D\rceil+5
\tag{GE.BL4}
\]

integer endpoint values have reverse intervals meeting one fixed source
block.

Let

\[
 a_g(b)=\#(g\cap B_b),
 \qquad c_g(y)=\#\{n\in g:T^h(n)=y\}.
\]

If \({\cal B}(y)\) is the set of blocks met by \(I_y\), then

\[
 c_g(y)\le\sum_{b\in{\cal B}(y)}a_g(b).
\]

Cauchy--Schwarz inside \({\cal B}(y)\), followed by the two overlap bounds,
proves

\[
\boxed{
 \sum_yc_g(y)^2
 \le C_D\sum_ba_g(b)^2,
 \qquad C_D:=L_1L_2=O((D+1)^2).
}
\tag{GE.BL5}
\]

At the Phase-3 terminal landing \(D=D_S=O(S)\), so \(C_D=(S+1)^{O(1)}\).
This is an exact deterministic consequence of the already-proved reverse
interval, with no progression averaging and no independence assumption.
Status: (GE.BL1)--(GE.BL5) `PROVED-PAPER`.

### 37.4 A sufficient source-block pressure theorem

Define the full conditional source-block pressure

\[
 Z_g:=\frac{H}{n_g^2}\sum_ba_g(b)^2.
\tag{GE.BL6}
\]

Since the endpoint off-diagonal count is at most \(\sum_yc_g(y)^2\),
(GE.BL5) gives

\[
\boxed{X_g\le C_DZ_g.}
\tag{GE.BL7}
\]

Consequently the source-block tail theorem

\[
\boxed{
 \sup_{1\le R\le H}R^{1/3}
 \sum_{g:Z_g\ge R}w_g\le(S+1)^{O(1)}
}
\tag{GE.BLOCKTAIL}
\]

implies (GE.WTAIL), losing only \(C_D^{1/3}=(S+1)^{O(1)}\).  For
thresholds below \(C_D\), the trivial total-mass bound absorbs the same
factor.

The diagonal term \(H/n_g\) inside \(Z_g\) is harmless after source
weighting by the same calculation as (GE.D7)--(GE.D8), because the number
of statistics classes is polynomial in \(M\), while \(2^M\) is
exponential.  Thus (GE.BLOCKTAIL) may equivalently be posed with the
ordered distinct-pair block count, at polynomial precision.

Status: implication (GE.BLOCKTAIL) \(\Rightarrow\) (GE.WTAIL)
`PROVED-PAPER`; (GE.BLOCKTAIL) `OPEN`.  It is a stronger producer, not a
reformulation of the target.

### 37.5 Exact conditional free window

The block coordinate exposes one further exact fact.  Put

\[
 k=M-S+1,
\]

so that \(\ell=2^k\).  Every block \(B_b\) is a complete residue system
modulo \(2^k\).  By the parity-vector bijection, its first \(k\) parity
bits are therefore exactly uniform.  More precisely, in every block the
number of prefixes whose first odd position is \(u<k\) and whose prefix
odd count is \(r\) equals

\[
 \binom{k-u-1}{r-1},
\tag{GE.FW1}
\]

with one all-even prefix.  Hence neither the first-odd label nor the prefix
odd count can by itself create source-block concentration.

There is also an exact conditional continuation formula.  Write a source
as

\[
 n=2^k(H+b)+v,
 \qquad0\le b<H,\quad0\le v<2^k.
\]

For fixed \(v\), let \(r(v)\) be the odd count in its first \(k\) parity
bits.  The affine iterate gives an integer \(\beta_v\) such that

\[
\boxed{
 T^k(n)=3^{r(v)}(H+b)+\beta_v.
}
\tag{GE.FW2}
\]

Since \(3^{r(v)}\) is odd, as \(b\) runs through \([0,H)\), the residues
of \(T^k(n)\) modulo \(H=2^{S-1}\) form a complete residue system.
Applying the parity-vector bijection again shows:

\[
\boxed{
 \text{conditional on any fixed first }k\text{-bit prefix, the next }
 S-1\text{ parity bits are exactly uniform over the source blocks.}
}
\tag{GE.FW3}
\]

Equations (GE.FW1)--(GE.FW3) are exact and cost no error term.  They expose
all \(M\) free source bits.  The first-passage statistics class, however,
continues to times of order \((M-S)/(1-a_0)>M\); after those \(M\) bits the
remaining parity suffix is generated deterministically.  No theorem in the
frozen package bounds the dependence of that generated suffix on the block
coordinate.

Status: (GE.FW1)--(GE.FW3) `PROVED-PAPER`; generated suffix channel
`OPEN`.

### 37.6 Finite pressure diagnostic

The project script
`research/audit_weighted_collision_pressure.py` computes the literal
weighted off-diagonal tail for the unrestricted direct first-passage law,
grouped by \((h,s,u)\), and the analogous source-block pressure.  It is a
control law, not the schedule-filtered Phase-3 family, so every row is
labelled `EMPIRICAL`.

For fixed \(S=10\), the summary is:

| \(M\) | endpoint moment | endpoint tail sup | block moment | block tail sup |
|---:|---:|---:|---:|---:|
| 16 | 1.6250 | 0.9745 | 1.5457 | 0.9671 |
| 18 | 1.7726 | 1.1233 | 1.6703 | 1.0990 |
| 20 | 1.8128 | 1.1957 | 1.6941 | 1.1673 |
| 22 | 1.8171 | 1.2127 | 1.6890 | 1.1807 |

At \((M,S)=(22,10)\), individual endpoint pressures reach
\(426.67\), but the weighted tail is maximized at \(R=2\).  The endpoint
tail masses at \(R=2,4,8,16,32,64,128,256\) are approximately

\[
 .9625,.6064,.2558,.0950,.02389,.00559,.000774,.000101.
\]

The corresponding scaled values \(R^{1/3}\mathcal W_M(R)\) decrease after
\(R=2\).  The source-block tail is smaller in this row.  This is the
correct favorable pattern: very heavy classes exist, but carry little
source mass.  It is not an inheritance theorem and proves no asymptotic
claim.

### 37.7 Prove-or-kill verdict

The attempt does not prove (GE.LEVEL).  It proves the deterministic socket

\[
 \text{endpoint pressure}
 \ \le\ (S+1)^{O(1)}\times\text{source-block pressure},
\]

and exact conditional uniformity through all free source bits.  The sole
remaining theorem on this route is:

\[
\boxed{
 \text{the generated post-bit-exhaustion first-passage suffix cannot reveal
 the source block on more than an }R^{-1/3}\text{ weighted tail.}
}
\tag{GE.CHANNEL}
\]

This is the same burden signature as the prefix/suffix decorrelation input
isolated in `phase3_l2_time_slice_socket_2026_08_09.md`: exact prefix
equidistribution is free, but the deterministic continuation after the
available dyadic bits is not controlled.  Rephrasing (GE.CHANNEL) as
mixing, mutual information, a martingale, or a block moment without a new
arithmetic estimate would be another reduction only.

The abstract block-aligned calibration (GE.R5) shows that (GE.CHANNEL)
cannot follow from the present fibre cap, time-support size, and prefix
uniformity alone.  The finite diagnostic supports the theorem and shows no
kill family, but it does not supply the missing all-depth implication.

```text
PROVED-PAPER:
  existing-cap low/high pressure ranges (GE.R1)--(GE.R4);
  exact block localization (GE.BL1)--(GE.BL5);
  BLOCKTAIL => WTAIL (GE.BL6)--(GE.BL7);
  first-window and conditional second-window uniformity (GE.FW1)--(GE.FW3).

EMPIRICAL:
  unrestricted first-passage endpoint and block tails remain O(1) through
  the enumerated M<=22 rows, including fixed S=10.

OPEN:
  GE.BLOCKTAIL / GE.CHANNEL for the actual schedule-filtered family;
  therefore GE.WTAIL, GE.LEVEL, LABEL.CAP, and the Phase-3 exponent gain.

KILLED AS SUFFICIENT INPUTS:
  fibre cap + class count + prefix uniformity alone; the abstract
  block-aligned family satisfies them and fails the weighted tail.

ROUTE DECISION:
  pause further representation changes.  Resume only with a genuine
  generated-suffix channel estimate, a schedule-filtered all-depth
  counterfamily, or a new recurrence that proves GE.BLOCKTAIL directly.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged.
```


## 38. Retained-marginal profile-rank ceiling

### 38.1 Cycle card

The bounded goal of this cycle is to determine the strongest consequence
of the proved reverse-incidence localization, the actual retained source
partition, and the feasible-time support, without importing a new
Collatz-specific decorrelation theorem.  The target is the literal stopped
bad set \(C\subseteq J_S\).  The predeclared failure signal is an abstract
joint class--block law satisfying exactly the inequalities used in the
argument while retaining order-one positive target covariance.

The cycle succeeds as a ceiling calculation.  It proves a second route to
the frozen exponent \(A>9.9911133419\ldots\), and proves that the reduced
degree/rank interfaces alone cannot yield a strict improvement.  It is not
the optimized proof of the frozen theorem.  The canonical headline proof is
the support-sensitive first-bad transport of manuscript Theorem 6.3, whose
low-rank term is \(M^{1/2+o(1)}\delta\).  Once this term is small, it is
strictly sharper than the present \(M^{1/4+o(1)}\delta^{1/2}\) estimate.
The abstract extremizer below also does not prove that the full affine
Collatz incidence family realizes the reduced-interface ceiling.

### 38.2 Exact retained-marginal centering

Let \({\cal R}_M\) be the retained source family, let

\[
 N_{\rm ret}=|{\cal R}_M|,
 \qquad
 A_{\rm ret}(b)=|{\cal R}_M\cap B_b|,
 \qquad
 p_b=\frac{A_{\rm ret}(b)}{N_{\rm ret}}.
\]

If \(N_{\rm ret}=0\), the target count is zero.  Otherwise, because every
source block has size \(\ell=2^M/H\),

\[
 p_b\le\frac\ell{N_{\rm ret}}.
\tag{GE.TB1}
\]

For each generated class \(g\), write

\[
 a_g(b)=|g\cap B_b|,
 \qquad n_g=\sum_ba_g(b),
 \qquad d_g(b)=a_g(b)-n_gp_b.
\]

Since the classes partition the retained family,

\[
 \sum_bd_g(b)=0\quad\hbox{for every }g,
 \qquad
 \boxed{\sum_gd_g(b)=0\quad\hbox{for every }b.}
\tag{GE.TB2}
\]

Thus the block-marginal residual produced by centering at \(1/H\) was not
a new theorem burden.  It disappears identically when the classes are
centered at their actual retained block law.

For the reverse-incidence profile

\[
 \psi_{g,C}(b)=\#\{y\in C:I_{g,y}\cap B_b\ne\varnothing\},
\]

the proved degree bounds give

\[
 0\le\psi_{g,C}(b)\le L_2,
 \qquad
 \sum_b\psi_{g,C}(b)\le L_1|C|=L_1\delta H.
\]

The target count is at most

\[
 \sum_{g,b}a_g(b)\psi_{g,C}(b).
\]

Using (GE.TB1), summing the neutral terms over \(g\), and putting

\[
 {\mathfrak D}_{\rm ret}(C)
 =\sum_{g,b}d_g(b)\psi_{g,C}(b),
\]

gives the exact target-specific socket

\[
 \boxed{
 \frac1{2^M}\sum_g\sum_{y\in C}c_g(y)
 \le L_1\delta+
 \frac{[{\mathfrak D}_{\rm ret}(C)]_+}{2^M}.}
\tag{GE.TBRET}
\]

Moreover, (GE.TB2) implies for every common block profile \(\psi_*\),

\[
 {\mathfrak D}_{\rm ret}(C)
 =\sum_{g,b}d_g(b)(\psi_{g,C}(b)-\psi_*(b)).
\tag{GE.TB3}
\]

Status: (GE.TB1)--(GE.TB3) and (GE.TBRET) `PROVED-PAPER`.

### 38.3 Collapse to the physical incidence profiles

The reverse-incidence profile depends on \((h,s)\), the common loss cap, and
the target; it does not depend on the first-odd label \(u\).  Sum over
\(u\), write \(\gamma=(h,s)\), and denote the collapsed masses and profiles
by \(a_\gamma(b),n_\gamma,\psi_\gamma(b)\).  Equation (GE.TB3) is unchanged.

For every nonempty collapsed class, (GE.BL2) gives

\[
 \frac\ell2\le \frac{2^h}{3^s}<3\ell.
\tag{GE.TB4}
\]

For fixed \(h\), two odd counts differing by at least two change this
scale by a factor at least \(9\), whereas (GE.TB4) has multiplicative
width \(6\).  Hence at most two odd counts occur at one feasible time.  If
\(T_M\) is the feasible-time support and \(J_M\) is the number of distinct
physical incidence profiles, then

\[
 \boxed{J_M\le2T_M=M^{1/2+o(1)}.}
\tag{GE.TB5}
\]

Status: collapse over \(u\), the two-odd-count lemma, and (GE.TB5)
`PROVED-PAPER`.

### 38.4 Generic profile-rank theorem

Normalize the retained joint law by

\[
 P(\gamma,b)=\frac{a_\gamma(b)}{N_{\rm ret}},
 \qquad q_\gamma=\frac{n_\gamma}{N_{\rm ret}}.
\]

For any joint law with at most \(J_M\) class values,

\[
 \chi^2(P\|q\otimes p)\le J_M-1.
\tag{GE.TB6}
\]

Indeed,

\[
 1+\chi^2
 =\sum_\gamma\frac1{q_\gamma}
   \sum_bp_bP(\gamma\mid b)^2
 \le\sum_\gamma\frac1{q_\gamma}
   \sum_bp_bP(\gamma\mid b)
 =J_M.
\]

Choose \(\psi_*(b)=\sum_\gamma q_\gamma\psi_\gamma(b)\).  Weighted
Cauchy--Schwarz, the degree bounds, and (GE.TB1) give

\[
 \boxed{
 \frac{[{\mathfrak D}_{\rm ret}(C)]_+}{2^M}
 \le\sqrt{J_ML_1L_2\delta}
 =M^{1/4+o(1)}\delta^{1/2}.}
\tag{GE.TB7}
\]

Combining (GE.TBRET) and (GE.TB7),

\[
 \Pr_M(\text{terminal failure})
 \le M^{o(1)}\delta+M^{1/4+o(1)}\delta^{1/2}.
\tag{GE.TB8}
\]

At \(L=A\log_2M\), where
\(\delta=M^{-A\kappa_*+o(1)}\), (GE.TB8) tends to zero exactly in the
strict range

\[
 \boxed{A>\frac1{2\kappa_*}=9.9911133419\ldots.}
\tag{GE.TB9}
\]

Thus the simple incidence/marginal assembly recovers the frozen theorem
but does not improve it.

The optimized established proof instead applies the support-sensitive
tagged-fibre theorem directly at every first-bad rank.  With
\(\#\mathcal H_{M,q}\ll\sqrt{M\log M}\), reverse loss
\(D_q=(q+2)/r_*\), and low-target density
\(e^{-\widetilde b_{\rm lo}q}+2^{-q}\), summation over
\(L\le q\le S_M\) gives

\[
 \Pr_M(\operatorname{Fail}_{M,L})
 \ll
 M^{-p_{\rm hi}+5/2+o(1)}
 M^{1/2+o(1)}
   \left(e^{-b_{\rm lo}L}+e^{-c_2L}\right).
\tag{GE.TB9a}
\]

At \(L=A\log_2(M+2)+O(1)\), optimizing
\(b_{\rm lo}\uparrow\kappa_*\log2\) and
\(c_2\uparrow\log2\) again gives \(A>1/(2\kappa_*)\).  This direct
support-sensitive chain is already PROVED-PAPER / PROVED-FORMAL /
PROMOTED; Section 38 is an explanatory alternate derivation and a negative
interface audit only.

### 38.5 Sharpness of the reduced interface

Let \(J=\delta^{-1}\) and partition the source blocks into \(J\) disjoint
sets \(E_\gamma\), each of size \(\delta H\).  Put every source in blocks
\(E_\gamma\) into class \(\gamma\), and set
\(\psi_\gamma=\mathbf1_{E_\gamma}\).  Then the source partition, uniform
block marginal, target density, degree-one incidence bounds, and
\(J\)-profile support all hold, while

\[
 \frac{{\mathfrak D}_{\rm ret}(C)}{2^M}=1-\delta,
 \qquad
 \chi^2(P\|q\otimes p)=J-1.
\tag{GE.TB10}
\]

For \(\delta=M^{-\alpha+o(1)}\) with \(\alpha<1/2\), this calibration fits
inside the available \(M^{1/2+o(1)}\) profile count.  Therefore no argument
using only the class count, the two degree bounds, and arbitrary joint
class--block marginals can prove the desired gain.

This calibration is not a Collatz counterexample and does not preserve the
full ordered affine-interval geometry of every physical profile.  Its
conclusion is exactly limited to sharpness of the reduced inequalities
used in (GE.TB7).  Exploiting the ordered interval shape or the generated
affine phases would be a genuinely new arithmetic input, not another
marginal rearrangement.

### 38.6 Empirical verification and closeout

`research/audit_target_specific_block_covariance.py` now checks:

* both retained-marginal cancellations;
* exact target-incidence reassembly;
* exact cancellation of every common profile;
* invariance of the covariance after collapsing \(u\);
* at most two odd counts per feasible time;
* the reverse-scale window (GE.TB4);
* \(\chi^2\le J_M-1\) and the generic profile-rank bound.

On the nondegenerate sparse calibration \(S=12,L=9,\delta=253/2048\),
the collapsed covariance equals the original covariance on every row to
floating error below \(10^{-10}\).  The maximum odd-count multiplicity is
two, and the observed normalized reverse scales lie between \(0.5\) and
approximately \(1.9731\).  The generic profile-rank bound exceeds the
observed signed covariance by factors in the hundreds; it is valid but
not a promising quantitative producer.  These rows are mechanism-only
finite evidence because their parameters lie outside the final theorem
range.

```text
PROVED-PAPER:
  retained-marginal centering and exact residual elimination;
  target-specific transport socket GE.TBRET;
  collapse from (h,s,u) to (h,s);
  at most two odd counts per time;
  generic profile-rank theorem GE.TB7;
  recovery of A>9.9911133419... from the simple interfaces.

ALREADY-PROMOTED OPTIMIZED PROOF:
  direct support-sensitive first-bad transport;
  failure profile M^(1/2+o(1)) times the terminal target density;
  A>9.9911133419... with the manuscript clock, ceiling, and rate.

KILLED AS A SUFFICIENT METHOD:
  further marginal recentering, class counting, and degree-only
  Cauchy--Schwarz cannot yield a strict exponent improvement.

OPEN:
  any Collatz-specific signed saving over GE.TB7;
  in particular the physical two-scale/common-profile or 3-adic Haar
  recurrence for the one literal stopped target.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged.
```
## 39. Critical fixed-polylogarithmic endpoint with a log-log correction

### 39.1 Cycle card and exact target

This cycle does not change the Phase-3 signed-covariance frontier.  It
optimizes the already-promoted support-sensitive first-passage proof at its
scalar endpoint.  Put

\[
 \kappa_*:=1-H_2(\log_3 2),
 \qquad
 A_{\rm FP}:=\frac1{2\kappa_*}.
\tag{CE.1}
\]

The exact target is: for every fixed

\[
 B>\frac1{\kappa_*}=2A_{\rm FP}
   =19.9822266839\ldots,
\tag{CE.2}
\]

prove natural-density-one descent to

\[
 C_{\rm tar}(\log n)^{A_{\rm FP}}(\log\log n)^B
\tag{CE.3}
\]

within the existing logarithmic clock and under the existing same-witness
orbit ceiling.  The manuscript, theorem registry, proof-state, and Lean tree
remain frozen until the later synchronized integration.

### 39.2 Entropy-sharp maximal-barrier prefactor

Let \(Y_j\) be a simple symmetric walk and
\(H_m=\frac12\max_{j\le m}|Y_j|\).  If \(t\) ranges in a fixed compact
subinterval of \((0,1/2)\), then

\[
 2^{-m}\#\{w:H_m(w)>tm\}
 \ll m^{-1/2}\exp\{-m\mathcal I(t)\}.
\tag{CE.4}
\]

Indeed, with \(a=\lfloor2tm\rfloor+1\), reflection and symmetry bound the
maximal event by a fixed multiple of \(\Pr(Y_m\ge a-1)\).  In the stated
compact range, consecutive binomial-tail summands have ratio uniformly below
one, so the tail is a fixed multiple of its first summand.  Uniform Stirling
then gives \(m^{-1/2}\exp\{-mD(p\|1/2)\}\), where
\(p=1/2+t+O(m^{-1})\).  Since
\(D(p\|1/2)=\mathcal I(t)+O(m^{-1})\), (CE.4) follows.  Compactness is
load-bearing; the prefactor is not asserted uniformly as \(t\to0\).

### 39.3 Moving low parameters

Let \(\eta_*=1-a_0\), let \(L=L_M\), and choose fixed sufficiently large
\(K_0,K_1\).  Define

\[
 \eta_M=\eta_*-\frac{K_0}{L},\qquad
 r_M=1-\frac{K_0}{2L},\qquad
 \lambda_M=1-\frac{K_1}{L}.
\tag{CE.5}
\]

For every low parent rank \(m\ge L\),

\[
 (r_M-a_0-\eta_M)m=\frac{K_0m}{2L}\ge\frac{K_0}{2}.
\tag{CE.6}
\]

Thus a fixed choice of \(K_0\) absorbs all floor and affine-startup constants
in the certified first-passage inequality.  The unused multiplicative margin
satisfies

\[
 (1-\lambda_M)\eta_Mm\ge K_1\eta_M,
\tag{CE.7}
\]

and the additive-correction exponent converges to
\(a_0-\eta_*=2a_0-1>0\).  Hence the deterministic low-block envelope remains
uniformly valid.

Put

\[
 b_M=\mathcal I\!\left(\frac{\lambda_M\eta_M}{\log_2 3}\right),
 \qquad
 b_*=\kappa_*\log2.
\tag{CE.8}
\]

Continuous differentiability of \(\mathcal I\) near the limiting point gives

\[
 b_M\ge b_*-\frac{C}{L}.
\tag{CE.9}
\]

Since the low ranks obey \(L\le q\le S_M=O(\log M)\) and
\(L\asymp\log M\), the factor \(\exp(Cq/L)\) is bounded.  Combining
(CE.4) and (CE.9) therefore yields the uniform critical target density

\[
 \frac{|B_{M,q}|}{2^q}
 \ll q^{-1/2}2^{-\kappa_*q}+2^{-q}.
\tag{CE.10}
\]

### 39.4 Time support, loss, and the optimized scalar budget

The high-phase cumulative-time support remains
\(O(\sqrt{M\log M})\).  Although \(r_M\to1\), strict integer rank descent
gives at most \(O(S_M)\) low blocks, each with duration-window width
\(O(S_M)\).  Their total contribution is therefore
\(O(S_M^2)=O((\log M)^2)\), negligible beside the high-phase width.
Eventually \(r_M>r_{\rm hi}\), so the fixed rank-scaled loss denominator
remains \(r_{\rm hi}\).

The promoted support-sensitive transport socket now gives

\[
 \Pr_M(\text{low failure})
 \ll \sqrt{M\log M}
 \left(L^{1/2}2^{-\kappa_*L}+L2^{-L}\right).
\tag{CE.11}
\]

If \(2^{L_M}\asymp C_MM^a\), with \(C_M=M^{o(1)}\), then

\[
 \Pr_M(\operatorname{Fail})
 \ll
 M^{1/2-a\kappa_*}C_M^{-\kappa_*}\log M
 +M^{-\varepsilon}.
\tag{CE.12}
\]

Consequently the exact sufficient scalar condition is

\[
 \frac{C_M^{\kappa_*}M^{a\kappa_*-1/2}}{\log M}\longrightarrow\infty.
\tag{CE.13}
\]

At \(a=A_{\rm FP}\), take \(C_M=(\log M)^B\).  Then (CE.13) is exactly
\(B\kappa_*>1\), and

\[
 \Pr_M(\operatorname{Fail})
 \ll(\log M)^{1-B\kappa_*}+M^{-\varepsilon}.
\tag{CE.14}
\]

Dyadic shell summation gives, for every
\(0<\gamma<B\kappa_*-1\),

\[
 \#\mathcal E(X)\ll\frac{X}{(\log\log X)^\gamma}.
\tag{CE.15}
\]

The low phase costs \(O((\log M)^2)=o(M)\) orbit steps and begins at a
polylogarithmic height, so both the existing logarithmic clock and the
same-witness ceiling \(n^{1+\beta}\) survive unchanged.

### 39.5 The derived theorem and its strict improvement

For every fixed \(B>1/\kappa_*\), every
\(c>2/\log(4/3)\), and every \(\beta>0\), there are constants
\(C_{\rm tar}>0\) and \(\gamma>0\) such that all but
\(O(X/(\log\log X)^\gamma)\) integers \(n\le X\) admit a
\(k<c\log n\) satisfying

\[
 T^k(n)\le
 C_{\rm tar}(\log n)^{A_{\rm FP}}(\log\log n)^B,
 \qquad
 \max_{0\le j\le k}T^j(n)\le n^{1+\beta}.
\tag{CE.16}
\]

Because \((\log\log n)^B=o((\log n)^\epsilon)\) for every fixed
\(\epsilon>0\), (CE.16) is strictly stronger than every fixed-exponent
statement with \(A>A_{\rm FP}\).  It does not prove an arbitrary slowly
diverging multiplier: at the endpoint the present proof still requires
\(C_M^{\kappa_*}/\log M\to\infty\).

### 39.6 Exact finite audit and status

The script research/audit_critical_endpoint_loglog.py evaluates the exact
symmetric-walk maximal event by integer dynamic programming.  Its positive
control uses (CE.5), its negative control takes \(t=1/m\), and its scalar
control checks (CE.12) after division by
\((\log M)^{1-B\kappa_*}\).  For \(M=10^3,10^4,10^5,10^6\), the moving
normalized barrier ratio stays between approximately 6.57 and 7.21, while
the boundary-control ratio grows from approximately 12.73 to 16.79.  The
scalar normalized proxy stays between approximately 4.44 and 4.66.  The
audit returns PASS.

```text
PROVED-PAPER IN THE RESEARCH LEDGER:
  entropy-sharp maximal-barrier prefactor in the required compact regime;
  uniform moving low-parameter envelope;
  critical target density CE.10;
  optimized failure profile CE.12;
  critical endpoint theorem CE.16.

EMPIRICAL-SUPPORT:
  exact finite symmetric-walk and scalar-budget audit.

NOT PROVED:
  arbitrary slowly diverging endpoint multiplier;
  removal of the remaining logarithmic budget;
  any Phase-3 exponent below A_FP.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged pending synchronized integration and formalization.
```

## 40. Secondary endpoint and arbitrary third-order divergence

### 40.1 Exact consequence of the optimized budget

Section 39 proved the scalar condition

\[
 \frac{C_M^{\kappa_*}M^{a\kappa_*-1/2}}{\log M}
 \longrightarrow\infty.
\tag{CE2.1}
\]

At \(a=A_{\rm FP}=1/(2\kappa_*)\), this becomes

\[
 \frac{C_M^{\kappa_*}}{\log M}\longrightarrow\infty.
\tag{CE2.2}
\]

No new probabilistic or transport estimate is required for the following
secondary diagonalization.  Let \(\Omega_M\to\infty\), with
\(\Omega_M=(\log M)^{o(1)}\), and put

\[
 C_M=(\log M)^{1/\kappa_*}\Omega_M.
\tag{CE2.3}
\]

Then the left side of (CE2.2) is exactly \(\Omega_M^{\kappa_*}\).
Substitution in (CE.12) gives

\[
 \Pr_M(\operatorname{Fail})
 \ll \Omega_M^{-\kappa_*}+M^{-\varepsilon}.
\tag{CE2.4}
\]

Thus the strict secondary range \(B>1/\kappa_*\) from Section 39 reaches
its own endpoint \(B=1/\kappa_*\), provided one retains any prescribed
diverging third-order multiplier.

### 40.2 Concrete triple-log theorem

For every fixed \(D>0\), take

\[
 \Omega_M=(\log\log M)^D.
\tag{CE2.5}
\]

The terminal rank may be chosen as

\[
 L_M=\left\lceil
 A_{\rm FP}\log_2(M+2)
 +\frac1{\kappa_*}\log_2\log(M+3)
 +D\log_2\log\log(M+3)
 \right\rceil,
\tag{CE2.6}
\]

after harmless startup totalization of the iterated logarithms.  Since
\(1/\kappa_*=2A_{\rm FP}\), the resulting natural-density-one target is

\[
 \boxed{
 T_{\min}(n)\le
 C_{\rm tar}(\log n)^{A_{\rm FP}}
 (\log\log n)^{2A_{\rm FP}}
 (\log\log\log n)^D.}
\tag{CE2.7}
\]

The same witness obeys the existing logarithmic clock and orbit ceiling.
Moreover, (CE2.4) becomes

\[
 \Pr_M(\operatorname{Fail})
 \ll(\log\log M)^{-D\kappa_*}+M^{-\varepsilon}.
\tag{CE2.8}
\]

Dyadic shell summation therefore gives, for every
\(0<\gamma<D\kappa_*\),

\[
 \#\mathcal E(X)
 \ll \frac{X}{(\log\log\log X)^\gamma}.
\tag{CE2.9}
\]

More generally, an eventually nondecreasing arbitrarily slowly diverging
\(\Omega\) may replace the fixed triple-log power, with the shellwise
multiplier written as \(\Omega_M\).

### 40.3 Strictness and method ceiling

For every fixed \(\epsilon>0\),

\[
 (\log\log\log n)^D=o((\log\log n)^\epsilon).
\tag{CE2.10}
\]

Hence (CE2.7) is strictly stronger in terminal descent scale than every
theorem in Section 39 with fixed \(B>2A_{\rm FP}\).  This comparison does
not include the exceptional-set rate.  A fixed \(B\) gives a power of
\(\log\log X\), whereas (CE2.7) gives only a power of
\(\log\log\log X\) for fixed \(D\).  The new target is smaller, but its
displayed density-convergence rate is generally weaker; the two theorem
products must be compared separately.

The negative boundary is exact.  If \(\Omega_M=O(1)\), then (CE2.4)
supplies only an order-one upper bound and does not prove density
convergence.  If the secondary exponent is strictly below
\(1/\kappa_*\) and the remaining multiplier is subpower in \(\log M\),
then (CE2.2) fails.  Thus the present scalar inequalities have the endpoint

\[
 (A,B)=\left(A_{\rm FP},2A_{\rm FP}\right)
\tag{CE2.11}
\]

with an unavoidable diverging third-order multiplier.

A tempting retuning of the high tolerance does not lower this ceiling.
Replacing \(\log M\) in the shrinking barrier by \(u_M\to\infty\)
would change the support width to \(O(\sqrt{Mu_M})\) and the high bad
density to \(\exp(-cu_M)\).  The current high-rank transport term contains

\[
 \sqrt{Mu_M}\,M^2e^{-cu_M}.
\tag{CE2.12}
\]

Its convergence still forces \(u_M\ge(5/(2c)+o(1))\log M\).  Even replacing
the crude rank sum by the deterministic geometric rank sequence only changes
\(M^2\) to \(M\), and still forces \(u_M\asymp\log M\).  Therefore
further improvement requires a new transport input, not more parameter
tuning.  The two named possibilities remain: remove the rank-loss factor
\(q\) in a source-weighted form, or replace hard time-support cardinality by
a weighted-time estimate.

### 40.4 Exact audit and closeout

The extended script research/audit_critical_endpoint_loglog.py checks both
the strict \(B>1/\kappa_*\) normalization and the secondary endpoint
(CE2.6).  With \(D=1\) over \(M=10^3,10^4,10^5,10^6\), the secondary
proxy divided by its predicted factor
\((\log\log M)^{-D\kappa_*}\) stays between approximately 4.36 and 4.65.
The \(D=0\) boundary proxy stays above 4.43 rather than tending toward
zero.  Together with the original maximal-walk controls, the audit returns
PASS.

```text
DERIVED FROM THE PROVED SECTION-39 BUDGET:
  arbitrary third-order divergence at the secondary endpoint;
  concrete triple-log theorem CE2.7;
  exceptional profile CE2.8 and shellwise consequence CE2.9.

EMPIRICAL-SUPPORT:
  exact finite scalar normalization and boundary control.

METHOD CEILING OF CURRENT ASSEMBLY:
  A = A_FP, B = 2*A_FP, with an arbitrarily slow divergent multiplier.

NOT PROVED:
  removal of the final divergent multiplier;
  B < 2*A_FP at A = A_FP;
  any principal exponent below A_FP.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged; this remains a research-ledger endpoint refinement.
```

## 41. Moving-endpoint formulation

### 41.1 Rank-buffer theorem

The log-log and triple-log statements are special coordinates of one moving
terminal rank.  Let \(\ell_M\ge0\) satisfy

\[
 \ell_M\longrightarrow\infty,
 \qquad
 \ell_M=o(\log M).
\tag{ME.1}
\]

This is the principal moving-endpoint range.  When the result is described
as attaining the secondary exponent \(1/\kappa_*\), use the sharper
condition

\[
 \ell_M=o(\log\log M),
\tag{ME.1a}
\]

equivalently \(2^{\ell_M}=(\log M)^{o(1)}\).  Without (ME.1a), the theorem
still has principal exponent \(A_{\rm FP}+o(1)\), but the moving multiplier
may dominate a fixed power of \(\log M\) and should not be advertised as the
sharp secondary endpoint.

For either range, define

\[
 L_M=\left\lceil
 A_{\rm FP}\log_2(M+2)
 +\frac1{\kappa_*}\log_2\log(M+3)
 +\ell_M
 \right\rceil.
\tag{ME.2}
\]

Then

\[
 2^{L_M}
 \ll
 M^{A_{\rm FP}}(\log M)^{1/\kappa_*}2^{\ell_M}.
\tag{ME.3}
\]

Substitution in the proved failure profile (CE.12) gives the exact moving
endpoint estimate

\[
 \boxed{
 \Pr_M(\operatorname{Fail})
 \ll 2^{-\kappa_*\ell_M}+M^{-\varepsilon}.}
\tag{ME.4}
\]

Indeed, \(A_{\rm FP}\kappa_*=1/2\), the secondary coefficient
\((1/\kappa_*)\kappa_*=1\), and
\(L_M^{1/2}\asymp(\log M)^{1/2}\).  These cancel respectively the
\(M^{1/2}\) and the two square-root logarithmic costs in (CE.11), leaving
exactly \(2^{-\kappa_*\ell_M}\).  Condition (ME.1) makes this tend to
zero while preserving \(L_M\asymp\log M\) and every schedule interface.

Thus, on a natural-density-one set, the existing logarithmic witness and
orbit ceiling hold together with

\[
 \boxed{
 T_{\min}(n)
 \le
 C_{\rm tar}(\log n)^{A_{\rm FP}}
 (\log\log n)^{2A_{\rm FP}}
 2^{\ell_{\lfloor\log_2 n\rfloor}}.}
\tag{ME.5}
\]

The multiplier \(2^{\ell_M}\) may diverge arbitrarily slowly.  Choosing
\(\ell_M=D\log_2\log\log M\) recovers Section 40.  Choosing
\(2^{\ell_M}=\log^{(j)}M\), \(\log^*M\), or any other prescribed
divergent function satisfying (ME.1a) gives the corresponding deeper
iterated-log secondary endpoint without another proof.  The wider range
(ME.1) remains valid as a principal moving-exponent theorem.

### 41.2 Equivalent moving-exponent inequality

Write the target as \(M^{A_M}\).  Equivalently, put

\[
 A_M
 =A_{\rm FP}
 +\frac{
   \kappa_*^{-1}\log\log M
   +(\log2)\ell_M
 }{\log M}.
\tag{ME.6}
\]

Then \(A_M\to A_{\rm FP}\), and (ME.5) becomes the moving-power
inequality

\[
 \boxed{
 T_{\min}(n)
 \le C_{\rm tar}(\log n)^{A_{\lfloor\log_2 n\rfloor}}.}
\tag{ME.7}
\]

The coordinate-free admissibility condition for an arbitrary shellwise
sequence \(A_M\to A_{\rm FP}\) is

\[
 \boxed{
 \kappa_*(A_M-A_{\rm FP})\log M
 -\log\log M
 \longrightarrow+\infty.}
\tag{ME.8}
\]

In terms of \(n\), suppressing harmless fixed changes of logarithm base,
the critical approach profile is

\[
 A_{\rm mov}(n)
 =A_{\rm FP}
 +\frac{
   2A_{\rm FP}\log\log\log n+\omega(n)
 }{\log\log n},
 \qquad
 \omega(n)\longrightarrow\infty,
\tag{ME.9}
\]

where \(\omega(n)=o(\log\log n)\) preserves
\(A_{\rm mov}(n)\to A_{\rm FP}\).  Formula (ME.9), rather than an
infinite list of iterated-log corollaries, is the canonical moving-endpoint
statement.

### 41.3 Boundary calibration and exact scope

The boundary is visible directly in (ME.4):

* if \(\ell_M\to\infty\), the shell failure tends to zero;
* if \(\ell_M=O(1)\), the proved upper bound stays of constant order;
* if the coefficient of \(\log\log M/\log M\) in
  \(A_M-A_{\rm FP}\) is strictly below \(1/\kappa_*\), the scalar
  budget loses a positive power of \(\log M\).

Therefore the moving theorem does not assert descent for every arbitrary
sequence \(A_M\downarrow A_{\rm FP}\).  It proves exactly the approach
region (ME.8).  Nor does it lower the principal method ceiling
\(A_{\rm FP}\); doing that still requires a new source-weighted loss or
weighted-time transport theorem.

```text
DERIVED:
  rank-buffer estimate ME.4;
  moving target ME.5;
  moving-exponent criterion ME.8;
  canonical exponent profile ME.9.

POSITIVE CALIBRATION:
  every ell_M -> infinity gives density convergence.

SECONDARY-ENDPOINT QUALIFIER:
  ell_M = o(log log M); the wider ell_M = o(log M) range preserves only the
  principal moving exponent A_FP + o(1).

NEGATIVE / BOUNDARY CALIBRATION:
  bounded ell_M gives only an order-one failure bound;
  a secondary coefficient below 1/kappa_* fails the present budget.

STRICTLY NARROWED:
  all fixed iterated-log endpoint corollaries are unified into one exact
  admissible moving-exponent region.

EQUALLY HARD:
  removing the final moving buffer or lowering A_FP.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged; research-ledger derived theorem only.
```

## 42. First-crossing ballot proposal: exact kill

### 42.1 Literal target and geometry

The proposed gain was

\[
 \Pr(H_q>tq)
 \stackrel{?}{\ll}
 q^{-3/2}e^{-q\mathcal I(t)}
\tag{FC.1}
\]

for fixed \(t\) in the entropy regime, replacing the proved sharp-prefactor
scale \(q^{-1/2}e^{-q\mathcal I(t)}\).  Its intended consumer was removal
of one factor \(q\) from the low-rank budget.

The literal barrier is horizontal over a word of length \(q\): in walk
coordinates it is first crossing of

\[
 a_q=\lfloor2tq\rfloor+1.
\tag{FC.2}
\]

It is not first crossing of a fixed-height boundary as \(q\to\infty\),
and it is not the sloped boundary \(tj\) at depth \(j\).  This distinction
decides the proposal.

### 42.2 Exact first-crossing reassembly

Stop every bad word at its unique first depth \(j\) with
\(|Y_j|\ge a_q\).  If \(N_j^{\rm pre}\) is the number of such first-crossing
prefixes, then all remaining bits are free and

\[
 \boxed{
 N_{\max}(q)
 =\sum_{j=1}^q 2^{q-j}N_j^{\rm pre}.}
\tag{FC.3}
\]

Thus the completed first-crossing cylinders partition the maximal event
exactly.  The proposed diagnostic
\(N_{\rm first}\ll q^{-1}N_{\max}\) cannot hold when
\(N_{\rm first}\) counts the same completed words: the two quantities are
identical.

The classical ballot formula exposes the missing factor.  For the one-sided
walk and a parity-compatible depth \(j\),

\[
 \Pr(\tau_a=j)=\frac{a}{j}\Pr(Y_j=a).
\tag{FC.4}
\]

Here \(a=a_q\asymp q\), and at \(j=q\) the ratio \(a/q\) tends to the
nonzero constant \(2t\).  Stirling therefore gives, along the compatible
subsequence,

\[
 \Pr(\tau_{a_q}=q)
 \asymp q^{-1/2}e^{-q\mathcal I(t)},
\tag{FC.5}
\]

already from the final first-crossing layer.  The often quoted
\(q^{-3/2}\) law applies when the boundary height is fixed; its numerator
\(a\) cannot be discarded when \(a\asymp q\).  Hence (FC.1) is false
before affine corrections or nested Collatz certification enter.

### 42.3 Exact diagnostic

The script research/audit_first_crossing_barrier_gain.py performs integer
dynamic programming on the literal two-sided walk.  For
\(q=60,100,160,240,360\) at the critical limiting value of \(t\):

* the completed first-crossing cylinders reassemble the maximal event with
  exact error zero;
* the ratio between the proved \(q^{-1/2}\) reference and the proposed
  \(q^{-3/2}\) reference is exactly \(q\);
* the maximal-event ratio against the proved reference stays between
  approximately 4.26 and 5.71;
* the ratio against the proposed reference grows from approximately 295 to
  1725.

The script returns audit=KILL.  This finite computation illustrates the
all-depth identity (FC.3); the analytic refutation is (FC.4)--(FC.5).

### 42.4 Other parts of the split-rank proposal

Moving \(\eta_q=\eta_*-K/q\) changes
\(q\mathcal I(t_q)\) only by a bounded amount and therefore changes only
constants.  Splitting the terminal sum into near and far ranks also gives no
asymptotic gain, because for fixed \(0<r=2^{-\kappa_*}<1\),

\[
 \sum_{q\ge L}q^{1/2}r^q
 \asymp L^{1/2}r^L.
\tag{FC.6}
\]

The near part already has the order of the whole sum, while the far part is
geometrically smaller.  Therefore parameter movement, first-crossing tags,
and near/far splitting do not remove the secondary logarithm.

### 42.5 Surviving quantitative frontier

The remaining explicit loss is the rank-scaled reverse-loss factor
\(D_q\asymp q\) in the support-sensitive transport socket.  If a
target-specific source-weighted theorem replaced it by
\(D_q^{\rm eff}\ll q^\theta\), then the critical low-failure profile would
be

\[
 \Pr_M(\operatorname{Fail})
 \ll
 \sqrt{M\log M}\,L^{\theta-1/2}2^{-\kappa_*L}.
\tag{FC.7}
\]

For
\(L=A_{\rm FP}\log_2M+B\log_2\log M\), this has scalar order

\[
 (\log M)^{\theta-B\kappa_*}.
\tag{FC.8}
\]

Consequently:

* the current \(\theta=1\) gives \(B>1/\kappa_*=2A_{\rm FP}\);
* \(\theta=1/2\) would give \(B>A_{\rm FP}\);
* \(\theta=0\) would give every fixed \(B>0\), and more generally any
  divergent critical multiplier.

Thus the payoff advertised by the ballot proposal is real only if one proves
an effective \(O(1)\) source-weighted reverse-loss theorem for the literal
first-bad targets.  First-crossing decomposition does not supply it.

The next exact bounded target is therefore a target-specific replacement of
the transport factor: for some \(\theta<1\), and ideally \(\theta=0\),
prove the existing loss-filtered first-passage count with \(q^\theta\) in
place of the worst-case \(q+2\), after summing the actual first-bad target
and allowed time tags.  This is an arithmetic transport question, not a
Boolean ballot question.

```text
FALSE:
  q^(-3/2) maximal-barrier bound FC.1;
  a q^(-1) gain from merely tagging the first crossing.

PROVED:
  exact first-crossing cylinder identity FC.3;
  ballot normalization obstruction FC.4--FC.5;
  geometric-tail equivalence FC.6;
  payoff ladder FC.7--FC.8.

EMPIRICAL / EXACT FINITE SUPPORT:
  integer-DP audit with exact reassembly and predeclared kill.

SURVIVING NEXT TARGET:
  target-specific source-weighted reduction of the rank-loss factor q.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged.
```

## 43. Target-weighted reverse-loss moment

### 43.1 Cycle card

Section 42 leaves one explicit secondary loss: the deterministic cap
\(E_{2^q}\ll q\) is inserted before the literal first-bad target is summed.
The bounded goal of this cycle is to retain the loss sourcewise and determine
the weakest moment statement that replaces the resulting factor \(q\).

The predeclared success signal is an exact consumer inequality whose only
open input is a target-weighted loss moment. The predeclared pause signal is
that the frozen deterministic inputs recover only the old \(q\)-loss. Both
occur: the consumer closes exactly, while its new moment remains open.

### 43.2 Exact loss-truncation inequality

Fix a first-bad rank \(q\), put \(Y=2^q\), and let
\(B_q\subseteq J_q\) be the literal bad landing target. Write

\[
 d_q=\frac{|B_q|}{Y}.
\]

Let \({\cal F}_{M,q}\) be the generated sources whose first certification
failure occurs at this rank, and let \({\cal H}_{M,q}\) be any allowed set
of direct first-passage times containing their time tags. Put

\[
 H_{M,q}=|{\cal H}_{M,q}|,
 \qquad
 f_{M,q}=\frac{|{\cal F}_{M,q}|}{2^M}.
\]

For \(R>0\), define the high-loss tail and target-weighted first moment

\[
 \begin{aligned}
  {\cal T}_{M,q}(R)
  &:=2^{-M}\#\{n\in{\cal F}_{M,q}:E_Y(n)>R\},\\
 {\cal L}_{M,q}
  &:=2^{-M}\sum_{n\in{\cal F}_{M,q}}E_Y(n).
 \end{aligned}
\tag{TL.1}
\]

Split the family at loss \(R\). Proposition 4.3 of the manuscript, applied
only to the declared time tags and the target \(B_q\), gives whenever
\(R/Y\le1/3\)

\[
 \boxed{
 f_{M,q}
 \le
 H_{M,q}d_q\left(\frac{Y}{2^M}+3R\right)
 +{\cal T}_{M,q}(R).}
\tag{TL.2}
\]

This is exact: the first term is the loss-filtered tagged-fibre count and
the second term restores every discarded source. No distributional
assumption has been inserted. Markov's inequality gives

\[
 {\cal T}_{M,q}(R)\le\frac{{\cal L}_{M,q}}R.
\tag{TL.3}
\]

When \(H_{M,q}d_q>0\), define the dimensionless target-weighted loss
pressure

\[
 \boxed{
 \Lambda_{M,q}
 :=\frac{{\cal L}_{M,q}}{H_{M,q}d_q}.}
\tag{TL.4}
\]

Optimizing (TL.2)--(TL.3) at
\(R=\sqrt{\Lambda_{M,q}/3}\) proves, provided
\(\Lambda_{M,q}\le Y^2/3\),

\[
 \boxed{
 f_{M,q}
 \le
 H_{M,q}d_q
 \left(
  \frac{Y}{2^M}+2\sqrt{3\Lambda_{M,q}}
 \right).}
\tag{TL.5}
\]

The zero-mass cases follow by taking the evident limit. Thus the effective
transport loss is the square root of one source-weighted first moment; no
uniform bound on every trajectory is required.

Status: (TL.1)--(TL.5) are PROVED-PAPER consequences of the frozen
loss-filtered transport theorem.

### 43.3 Literal remaining theorem and payoff

For a fixed \(0\le\theta<1\), the clean target is

\[
 \boxed{
 \Lambda_{M,q}\le Cq^{2\theta}}
 \qquad
 \text{for the actual generated first-bad families.}
\tag{TL.MOM\(_\theta\)}
\]

Uniformity is needed only over the low ranks used by the one prescribed
schedule. Equation (TL.5) then replaces the old factor \(q\) by
\(q^\theta\). With the entropy-sharp target density and compressed time
support, summation gives

\[
 \Pr_M(\operatorname{Fail})
 \ll
 \sqrt{M\log M}\,
 L^{\theta-1/2}2^{-\kappa_*L}
 +M^{-\varepsilon}.
\tag{TL.6}
\]

At

\[
 L=A_{\rm FP}\log_2M+B\log_2\log M,
\]

the sufficient secondary condition is

\[
 \boxed{B>\theta/\kappa_*.}
\tag{TL.7}
\]

Hence \(\theta=1/2\) gives \(B>A_{\rm FP}\), while \(\theta=0\) permits
every fixed \(B>0\) and, by the same moving-buffer argument as Section 41,
an arbitrarily slowly divergent critical multiplier.

This does not lower the principal exponent \(A_{\rm FP}\). Since
\(q=O(\log M)\), it removes only secondary logarithmic losses. A principal
improvement below \(A_{\rm FP}\) still requires a saving in the
\(M^{1/2}\)-scale time/transport factor or a different signed spatial
mechanism.

### 43.4 Ceiling of the frozen inputs

The current deterministic chain gives both

\[
 E_Y(n)\ll q
 \quad(n\in{\cal F}_{M,q})
\]

and

\[
 f_{M,q}\ll H_{M,q}d_qq.
\]

Multiplying these proved bounds yields

\[
 {\cal L}_{M,q}\ll H_{M,q}d_qq^2,
 \qquad
 \boxed{\Lambda_{M,q}\ll q^2.}
\tag{TL.8}
\]

Inserted into (TL.5), this is exactly \(\theta=1\), the frozen result.
Thus loss truncation is not by itself an improvement. It identifies the
missing input without hiding it: high reverse loss must carry less mass on
the actual first-bad target than the product of the two independent
worst-case bounds permits.

Equivalently, writing

\[
 N_d(n)=\#\{j<\tau_Y(n):T^j(n)\text{ odd},
                 \ 2^dY<T^{j+1}(n)\le2^{d+1}Y\},
\]

one has the deterministic occupation bound

\[
 E_Y(n)\le\frac12\sum_{d\ge0}2^{-d}N_d(n).
\tag{TL.9}
\]

The genuine proof burden is therefore a target-weighted occupation estimate
for the near-threshold shells. Prefix counting, endpoint cardinality, and
the pointwise loss cap alone do not supply it.

### 43.5 Exact finite diagnostic

The script "research/audit_first_bad_reverse_loss.py" measures (TL.4) on
the literal switch-composite target. It retains the recursively certified
sources, constructs the stopped low bad target independently, and compares
the actual target with random and top-loss same-cardinality controls. It
also checks (TL.2) at several truncation levels.

On the nondegenerate mechanism calibration

\[
 M\in\{18,20,22\},\qquad S=12,\qquad L=9,
 \qquad r=9/10,\qquad\eta=2/5,
\]

the observed actual loss enrichments

\[
 \frac{{\cal L}_{M,S}}{d_S}
\]

are approximately \(0.4082,0.6478,0.4078\), while the top-loss adversarial
targets give \(3.3562,3.6520,3.3459\). The corresponding values of
\(\Lambda_{M,S}\) are below \(0.003\). The actual mean loss stays between
approximately \(0.74\) and \(0.81\); the proportion above \(4\) is zero,
about \(0.0051\), and zero in the three rows.

These parameters deliberately create a visible sparse finite target and do
not satisfy the manuscript inequality \(\eta<r-a_0\). The result is only a
mechanism diagnostic. Proof-compatible small-rank rows have a nearly full
bad target and are not asymptotically informative. The exact counts support
the orientation of (TL.MOM\(_0\)), but cannot prove or refute it all-depth.

### 43.6 Closeout

~~~text
PROVED-PAPER:
  exact loss truncation TL.2;
  target-weighted Markov optimization TL.5;
  frozen-interface ceiling TL.8;
  occupation decomposition TL.9.

DERIVED-CONDITIONAL:
  TL.MOM_theta implies payoff TL.6--TL.7.

EMPIRICAL:
  literal switch-composite audit is favorable against random and
  adversarial same-cardinality controls;
  finite mechanism parameters are not in the final theorem regime.

OPEN:
  TL.MOM_theta for any theta<1;
  in particular bounded target-weighted loss pressure TL.MOM_0.

NARROWED OBJECT:
  target-weighted near-threshold occupation, not a uniform reverse-loss cap.

PAYOFF:
  improves the secondary iterated-log correction only;
  does not lower the principal exponent A_FP.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged pending integration decision.
~~~
