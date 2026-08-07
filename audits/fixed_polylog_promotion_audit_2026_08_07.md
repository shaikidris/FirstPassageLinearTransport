# Fixed-Polylogarithmic Promotion Audit

**Date:** 2026-08-07

**Review modes:** `MATH-TEXT` now; `FORMAL` and `RENDER` after manuscript
integration

**Reviewer context:** `AUTHOR-AUDIT` with a fresh dependency reconstruction

**Promotion target:** the private standalone V2 repository
`/Users/shaik.i/research/collatz/FirstPassageLinearTransport`

**Frozen baseline commit:** `2816871`

**Frozen manuscript SHA-256:**
`8ee564516cace4c061504f4f95817b829ce6f980eb04568a3c1a71b31fc440ee`

## 1. Literal target card

### Headline product FP-POLY

For every fixed

\[
A>A_{\rm FP}:=\frac1{1-H_2(\log_3 2)},
\qquad
c>c_*:=\frac2{\log(4/3)},
\qquad
\beta>0,
\]

there are constants \(C,\kappa,X_0>0\), depending only on the displayed
fixed parameters, such that for every \(X\ge X_0\),

\[
\#\left\{n\le X:
\begin{array}{l}
\text{there is no }k<c\log n\text{ with}\\
T^k(n)\le C(\log n)^A\text{ and }
\max_{0\le j\le k}T^j(n)\le n^{1+\beta}
\end{array}
\right\}
\le C\frac{X}{(\log X)^\kappa}.
\tag{PA.1}
\]

The endpoint \(A=A_{\rm FP}\) is not claimed. Numerically,

\[
A_{\rm FP}=19.9822266839190\ldots,
\qquad
c_*=6.9521189935644\ldots.
\tag{PA.2}
\]

### Quantitative companion FP-STRETCH

For every fixed \(0<\delta<1\), there are
\(C_\delta,c_\delta,X_\delta>0\) such that

\[
\#\{n\le X:T_{\min}(n)>
\exp((\log n)^{1-\delta})\}
\le C_\delta X
\exp(-c_\delta(\log X)^{1-\delta})
\tag{PA.3}
\]

for all \(X\ge X_\delta\).

### Structural product FP-MASTER

For fixed admissible certification parameters and all sufficiently large
integers \(M\ge L\),

\[
\frac{\#\operatorname{Fail}_{M,L}}{2^M}
\ll
e^{-cM}+M(L+1)(e^{-cL}+2^{-L}),
\tag{PA.4}
\]

and every source outside the failure set reaches \(<2^L\) along an actual
shortcut orbit with the stated clock and path ceiling.

### Not the target

- descent below every diverging function;
- bounded or trivial-basin capture;
- the open \(q\)-only checkpoint-congestion estimate;
- promotion of finite diagnostics or the paused suffix-renewal route;
- deletion of the valid graded-clock and raw-clock companion mathematics.

## 2. Typed content above the frozen baseline

The frozen V2.3.1 headline reaches
\(\exp((\log n)^{1-\delta})\) for each fixed \(\delta<1\). That does not
imply a fixed polylogarithmic target: for every fixed \(\varepsilon>0\),
\(\exp((\log n)^\varepsilon)\) eventually exceeds every fixed power of
\(\log n\). Thus (PA.1) is a genuine **TARGET-SCALE** improvement.

The exceptional exponent in (PA.3) improves the frozen strict range
\(\sigma<1-\delta\) to the endpoint power \(1-\delta\). This is a
separate **RATE** improvement at a weaker target than (PA.1).

The architectural content is **ASSEMBLY/QUANTIFIER**: later certification
failures are transported from the original shell after exact nested
first-passage collapse. No fresh-distribution assumption is imposed on a
generated landing law.

## 3. Reconstructed dependency graph

```text
parity bijection + affine iterate
        |
        v
adjustable maximal barrier and shell entropy rate              CUT 1
        |
        +--> certified first-passage block and path envelope
        |
first-passage reverse product
        |
        v
loss-filtered arbitrary-target transport                       CUT 2
        |
strict threshold nesting --> direct first-passage collapse     CUT 3
        |
rank-scaled reverse loss + first-bad restriction               CUT 4
        |
        v
M(L+1) master profile                                           ROOT A
        |
        +--> two-regime decoupling                              CUT 5
        |       |
        |       +--> entropy optimization --> A_FP              ROOT B
        |
        +--> L ~ M^(1-delta) --> endpoint-rate stretched log    ROOT C
```

The old dense-set pullback bootstrap is not on this dependency chain. It
remains a valid companion architecture because it supplies the smooth graded
fixed-power clock.

## 4. Cut-vertex reconstruction

### CUT 1: adjustable entropy barrier — REPRODUCED

For fixed \(0<\lambda<1\), take

\[
h=\frac{\lambda\eta M}{\log_2 3}.
\]

On \(H_M\le h\), the multiplicative affine term uses only the fraction
\(2^{-(1-\lambda)\eta M}\) of the allowed upper envelope. The additive
term is \(O(2^{2\lambda\eta M})\), while the available upper-envelope
scale is \(\gg2^{(a_0+\eta)M}\). The exponent gap is at least
\(a_0-\eta>0\). Thus the barrier event implies the full orbit envelope for
all sufficiently large \(M\).

Optimizing the exact stopped-tree bound gives

\[
\Pr(H_M>h)
\le2\exp\left[-M D\!\left(
\frac12+\frac{\lambda\eta}{\log_2 3}
\middle\|\frac12\right)\right].
\]

Every fixed exponent below the \(\lambda\uparrow1\) supremum is therefore
available. The supremum is not attained by a fixed \(\lambda\).

### CUT 2: loss-filtered transport — REPRODUCED

The exact reverse product writes a tagged source as

\[
n=\frac{2^hy}{3^s}\prod_{j<h}(1-u_j(n)).
\]

When \(Y\sum_{j<h}u_j(n)\le D\) and \(D/Y\le1/3\), the product bound
\(\prod(1-u_j)\ge1-\sum u_j\) shows that two different odd counts would
force the ratio of two sources in one half-open dyadic shell to be at least
two. Hence the odd count is fixed. The remaining source interval has length
at most \(3D2^M/Y\), so summing the tagged fibers gives

\[
N^{\le D}_{M,Y,H}(B)
\le H(1+3D)\frac{2^M}{Y}|B|.
\]

### CUT 3: nested direct collapse — REPRODUCED

For every active regime, \(q_i=\lfloor r_i m_i\rfloor\le m_i-1\), while
the landing band gives \(m_{i+1}\le q_i\). Therefore
\(q_{i+1}\le q_i-1\), even when the regime changes. Induction then shows
that each cumulative landing is the original source's direct first passage
below its current threshold.

### CUT 4: rank-scaled reverse loss and first bad landing — REPRODUCED

Before the first failed certification, every completed block is certified.
After rescaling its odd-step corrections to the final threshold,

\[
E_{2^{q_i}}(n)
<\frac12\sum_{j\le i}m_j2^{q_i-q_j}
\le\frac{q_i+2}{r_*},
\qquad
r_*:=\min_j r_j.
\]

The bad landing itself is never assumed certified. Exact direct collapse
places the first-bad event inside the loss-filtered transport event from
the original shell. Summing the geometric bad-band tail proves (PA.4).

### CUT 5: two-regime decoupling — REPRODUCED WITH ONE REQUIRED REPAIR

Use the high pair above the switch
\(S_M=\lceil(\log(M+2))^2\rceil\), and the low pair below it. The time is

\[
H_M^{(2)}\le\frac{M}{1-r_{\rm hi}}
+\frac{S_M}{1-r_{\rm lo}}.
\]

The second term is \(o(M)\). The low phase determines the terminal
polylogarithmic exponent, while the high phase determines the leading clock.

**Required boundary repair.** At \(q=S_M\), the landing target is the union
of the two certification complements. Therefore the switch-band tail is
controlled by

\[
c_{\rm sw}:=\min\{c_{\rm hi},c_{\rm lo}\},
\]

or by displaying both exponential tails. A formula containing only
\(e^{-c_{\rm hi}S_M}\) is not literally justified. Replacing it by
\(e^{-c_{\rm sw}S_M}\) leaves the term superpolynomially small and changes
none of (PA.1)--(PA.3), \(A_{\rm FP}\), or the clock.

## 5. Constant and parameter ledger

Let \(p_*=\log_3 2\). Direct high-precision reconstruction gives

```text
p_*                         0.63092975357145743710...
H_2(p_*)                    0.94995552718833063481...
D(p_* || 1/2)              0.034688185232017459384...
(1-H_2(p_*))*log 2         0.034688185232017459384...
A_FP                        19.982226683919030107...
c_*                         6.9521189935644138208...
```

The identity

\[
D(p_*\|1/2)=(1-H_2(p_*))\log2
\]

is exact. The range \(A>A_{\rm FP}\) is strict. For every such \(A\), one
first fixes \(\eta_{\rm lo}<1-a_0\), then
\(r_{\rm lo}>a_0+\eta_{\rm lo}\), and finally
\(c_{\rm lo}<b_{\rm ent}(\eta_{\rm lo})\). No endpoint parameter is
silently attained.

The switch condition \(L_M<S_M\), both regime startup ranks, and the
loss condition \((q+2)/(r_*2^q)\le1/3\) all hold after one
finite startup enlargement.

## 6. Promotion classification

```text
HEADLINE_REQUIRED
  adjustable entropy barrier;
  loss-filtered transport;
  nested direct collapse;
  rank-scaled first-bad transport;
  two-regime master profile;
  A_FP optimization.

QUANTITATIVE COMPANION
  endpoint-rate stretched-log theorem;
  fixed-power exceptional corollaries;
  raw-clock conversion.

COMPANION_ONLY
  dense-set pullback theorem;
  smooth graded fixed-power clock.

LEGACY ASSEMBLY FOR THE NEW HEADLINE
  repeated dense-set bootstrap;
  old M^2 terminal profile;
  strict sigma < 1-delta exceptional-rate assembly.

CONDITIONAL FRONTIER
  summable q-only first-bad overload;
  arbitrary-diverging descent derived from it;
  signed AP/Fourier producer;
  centered LC.28 branch-balance defect (PA.5) below.

EXCLUDED FROM THE MANUSCRIPT DEPENDENCY CHAIN
  finite diagnostic tables;
  Hellinger/GW merger attempts;
  checkpoint primitive/suffix research history.
```

`LEGACY ASSEMBLY` means removal from the new headline dependency graph, not
deletion of valid mathematics. The graded-clock consumer prevents wholesale
removal of the dense-set pullback machinery.

### Exact parked LC.28 boundary

For the live/absorbed suffix bundle, put

\[
a_{u,d}=\left(\frac{2^u}{|J_{u,d}|}\right)^{1/2},
\qquad
p_{u,d}=\frac{I_{u,d}}{A_{u,d}}.
\]

The canonical reference probability of the first common terminal part is
\(2^{-d}\), and the affine support size gives

\[
\Pi_u^{\rm inh}-K_{3/2}
=\sum_{d\ge1}a_{u,d}(p_{u,d}-2^{-d})+O(2^{-u}).
\]

The sole positive resume target is therefore the aggregate one-sided balance

\[
\boxed{
\sum_{d\ge1}
\left(\frac{2^u}{|J_{u,d}|}\right)^{1/2}
\left(\frac{I_{u,d}}{A_{u,d}}-2^{-d}\right)
\le\frac{C}{u}.}
\tag{PA.5}
\]

This permits signed compensation across terminal classes; no pointwise
near-independence in each \(d\) is required. The exact negative resume target
is an inheritable prior-good family with pressure at least \(1+c\). Neither
target is used by (PA.1)--(PA.4). More finite pressure scans, injectivity
alone, unrestricted moments, and primitive immigration before inherited
closure remain excluded by the locked parking record.

## 7. Status-change card

**Before.** V2.3.1 headlines stretched-log descent for every fixed
\(\delta<1\), with every strict exceptional exponent
\(\sigma<1-\delta\).

**After.** The next explicit paper version headlines (PA.1), retains (PA.3),
and states (PA.4) as the reusable structural theorem.

**Exact logical gain.** Fixed polylogarithmic target; endpoint exceptional
power; arbitrary clock constant above \(c_*\); independent low-rank/high-rank
parameter selection.

**No status change.** The arbitrary-diverging theorem remains conditional,
and the paused congestion frontier remains open.

**Formalization triage.** `CLOSURE`.  The integrated proof has now been
reconstructed through all five cut vertices. Lean should formalize the exact
new structural chain and public statements, not the paused frontier.

**Current V3 formal checkpoint.** The following new declarations compile:

- exact additive reverse loss and its product lower bound;
- loss-filtered odd-count rigidity and the tagged-fiber bound
  \(1+3D2^M/Y\);
- exact and uniform arbitrary-target loss-filtered transport;
- nested direct first-passage composition;
- reverse-loss shift covariance, concatenation, threshold rescaling, and the
  local scaled-loss bound \(E_Y\le h/2\).
- the semantic finite-chain theorem giving direct first passage and the full
  rank-scaled budget \(E_{2^q}\le(q+2)/r\);
- the exact cosh-potential optimizer and its identity with
  \(\log2-H(1/2+t)\);
- the adjustable barrier's exact exponent identities, main-term phase bounds,
  affine-correction absorption under its explicit finite-startup inequality,
  and complete deterministic orbit-envelope socket;
- eventual discharge of both startup inequalities and the entropy-sharp shell
  count for actual orbit-envelope failures;
- the exact finite first-bad rank union, upper-endpoint boundary accounting,
  and target-by-target loss-filtered transport estimate;
- the exact rational floor-target budget and adapters by which literal
  stopped-map blocks initialize and extend the certified rank chain;
- inclusion of every generated finite-chain first-bad witness in the direct
  loss-filtered envelope;
- the whole-run recursive induction from certified stopped-map blocks and the
  exact landing-band classification of a failed endpoint.
- absorption of the linear rank factor into any strict entropy/dyadic rate
  margin and exact finite geometric-tail summation;
- the generated first-bad terminal profile, including the eventual adapter
  that supplies the landing-cardinality estimate simultaneously on every
  finite rank interval above the startup threshold.
- the canonical two-regime natural-number horizon and its literal execution
  theorem;
- the fixed polylogarithmic terminal schedule and quadratic-logarithmic
  switch schedule, including eventual
  \(1\le L_M<S_M<M\);
- the eventual rescaled-distortion startup on every terminal interval;
- the asymptotic clock socket: whenever
  \((1-r_{\rm hi})^{-1}<c\log2\), the canonical two-regime horizon is
  eventually below \(cM\log2\).
- the initial entropy tail is smaller than every fixed shell-rank power;
- the complete canonical five-piece profile is
  \(O((M+2)^{-\kappa})\) for every strict
  \(\kappa<A\min(b'_{\rm lo},c')/\log2-1\);
- the literal first-bad source set obeys that shellwise bound;
- the corresponding canonical shell good sets assemble into one
  natural-density-one set;
- the exact early/late dyadic-prefix split converts the shell profile into a
  quantitative global exceptional count at the explicit scale
  `(((Nat.log 2 X) / 2 : Nat) : Real) + 2`;
- the explicit comparison with the natural logarithm gives the manuscript
  form (O(X(\log X)^{-\kappa})), with the change-of-base constant retained;
- the endpoint rate is identified exactly with
  \((1-H_2(\log_3 2))\log2\), and every strict
  \(A>A_{\rm FP}\), \(c>c_*\), \(\beta>0\) produces rational high/low
  stage parameters and a positive retained \(\kappa\).
- the literal terminal run is retained outside the counted failure set,
  converted to the target `C_A (log n)^A`, and placed below `c log n`;
- the high-rank envelope margin and the low-rank
  `(1+tLo) S_M = o(M)` estimate propagate the same-witness orbit ceiling;
- the assembled fixed-polylogarithmic theorem and referee-facing `Main`
  declaration compile with the paper's exact strict parameter ranges.

These close the semantic content of all five cut vertices and both public V3
roots. None of these declarations uses LC.28 or its parked branch-balance
estimate (PA.5).

**Current trust audit.** `V3CutVertexAudit.lean` compiles and reports only
Mathlib's standard logical axioms `propext`, `Classical.choice`, and
`Quot.sound` for every V3 cut vertex listed above. The audit target now also
includes the assembled and referee-facing headline declarations. A source
scan of all new V3 modules finds no `sorry`, `admit`, or project `axiom`
declaration.

The full `lake build` subsequently completed successfully.  It rebuilt
`Main`, `V3CutVertexAudit`, `PaperDependencyAudit`, and `PaperAudit`; the
public headline reports only `propext`, `Classical.choice`, and `Quot.sound`.
The precise source scan found no `sorry`, `admit`, or project `axiom`.

## 8. Required release sequence

1. **Complete:** correct the switch-band exponent and freeze the literal
   theorem text.
2. **Complete:** integrate the new logical chain into a distinct V3
   manuscript without changing the frozen V2 PDF.
3. **Complete:** retain the graded clock and dense pullback as companion
   mathematics while removing the repeated bootstrap from the new headline
   proof path.
4. **Complete:** rebuild the full package and run the theorem-map,
   placeholder, dependency, and public-root axiom audits.
5. **Complete:** manuscript-only and source-reference audit.
6. **Complete:** distinct V3 render and visual inspection.
7. **In progress:** freeze source/PDF hashes and review the final semantic
   diff before any commit or push.

## 9. Current verdict

The optimized fixed-polylogarithmic promotion is mathematically and formally
assembled after the local switch-band correction. The unconditional headline
does not consume the open checkpoint-congestion theorem. Paper and formal
promotion are complete in the worktree. The public theorem now counts the
literal no-witness set after a formally proved finite-startup absorption; its
strict landing inequality is stronger than the manuscript's weak one. Clean
reconstruction, manuscript reference checks, and rendered-artifact inspection
pass. Hash freeze and the final semantic diff remain before any commit or
push.
