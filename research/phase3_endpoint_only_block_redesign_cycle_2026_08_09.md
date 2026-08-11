# Phase 3 endpoint-only block redesign

## 0. Cycle card

```text
STRONGEST PROVED BASELINE:
  fixed-polylogarithmic descent for every A>9.9911133419..., with shortcut
  clock constant every c>2/log(4/3).

LITERAL REDESIGN TARGET:
  replace the all-prefix high-block certificate by a fixed-endpoint block;
  retain a rank-adaptive recursive schedule and prove that its generated
  sources avoid the literal endpoint-bad sets until rank
  L_M=ceil(A log_2(M+2)).

NOT THE TARGET:
  a uniform orbit ceiling at every intermediate step;
  arbitrary-target fixed-time transport;
  independence of parity bits beyond the source-shell bit budget;
  a finite-depth numerical certificate promoted to all depth.

TARGET-SANITY STATUS:
  UNKNOWN-BUT-INTENDED.  A single block and the scalar clock close exactly.
  Continuation requires a new generated-law theorem after bit exhaustion.

PRIMARY PAYOFF:
  if the complete endpoint schedule has o(1) failure, fixed-polylogarithmic
  descent follows without the sqrt(M log M) feasible-time enumeration.

NEGATIVE CALIBRATION:
  the fixed-time endpoint map has exponential average fiber multiplicity on
  its good image; maximum-fiber or arbitrary-target linear transport cannot
  close the redesign.

ONE KILL TEST:
  an inherited family whose two-step endpoint-bad enrichment stays bounded
  away from zero after the uniform reference density tends to zero.
```

This cycle concerns only the post-freeze Phase-3 research branch.  No V3
manuscript or Lean theorem status changes unless the generated continuation
estimate below is proved and reassembled.

## 1. Exact fixed-endpoint certificate

Let

\[
 I_m=[2^m,2^{m+1})\cap\mathbb N,
 \qquad
 s_m(n)=\sum_{j=0}^{m-1}p_j(n),
\]

and fix

\[
 a_0<r<1,
 \qquad
 p_r=\frac{r}{\log_2 3}>\frac12.
\tag{EO.1}
\]

The exact affine iterate gives

\[
 T^m(n)
 =\frac{3^{s_m(n)}}{2^m}n
 +\sum_{i=0}^{m-1}
  \frac{p_i(n)3^{s_m(n)-s_{i+1}(n)}}{2^{m-i}}.
\tag{EO.2}
\]

The correction is bounded without a maximal-prefix condition:

\[
 0\le
 \sum_{i=0}^{m-1}
  \frac{p_i(n)3^{s_m-s_{i+1}}}{2^{m-i}}
 <3^{s_m}\sum_{j\ge1}2^{-j}
 =3^{s_m}.
\tag{EO.3}
\]

Since `n/2^m<2`,

\[
 \boxed{T^m(n)<3^{s_m(n)+1}.}
\tag{EO.4}
\]

Consequently the final-count condition

\[
 s_m(n)+1\le p_r m
\tag{EO.5}
\]

implies

\[
 \boxed{T^m(n)<2^{rm}.}
\tag{EO.6}
\]

No intermediate iterate is constrained.

The parity-vector bijection identifies `I_m` with the complete Boolean cube
of length `m`.  Hence, for every fixed

\[
 0<b<D(p_r\|1/2),
\]

there is `C_(r,b)` such that, for all sufficiently large `m`,

\[
 \boxed{
 2^{-m}\#\{n\in I_m:s_m(n)+1>p_rm\}
 \le C_{r,b}e^{-bm}.
 }
\tag{EO.7}
\]

Thus a single endpoint-only block has exponentially small uniform-shell
failure.  This is stronger than the shrinking maximal-barrier estimate for
that one task.  It proves endpoint contraction only; it does not prove the
pathwise orbit ceiling supplied by the existing barrier theorem.

## 2. The scalar recursive schedule and its clock

Define the rank-adaptive endpoint schedule by

\[
 x_0=n,
 \qquad
 m_j=\lfloor\log_2x_j\rfloor,
 \qquad
 x_{j+1}=T^{m_j}(x_j).
\tag{EO.8}
\]

Call stage `j` good when (EO.5) holds for `x_j`.  Then

\[
 m_{j+1}<rm_j.
\tag{EO.9}
\]

If every attempted stage is good until `m_R<L`, then

\[
 \sum_{j<R}m_j
 \le\frac{M}{1-r},
 \qquad
 x_R<2^L.
\tag{EO.10}
\]

For `n in I_M`, conversion to the natural logarithmic clock gives

\[
 \sum_{j<R}m_j
 \le
 \frac{\log n}{(1-r)\log2}+O(1).
\tag{EO.11}
\]

Letting `r` decrease to `a_0` recovers

\[
 \frac1{(1-a_0)\log2}
 =\frac2{\log(4/3)}
 =6.952118\ldots.
\tag{EO.12}
\]

Therefore the endpoint schedule has the same optimal leading shortcut clock
as the first-passage schedule.  The scalar redesign is valid.

For

\[
 L_M=\lceil A\log_2(M+2)\rceil,
\tag{EO.13}
\]

one also has `2^L_M<=2(M+2)^A`.  Thus the only missing statement is that a
density-one set of original sources follows good endpoint stages until this
rank.

## 3. Literal all-stage theorem

Let `G_(m,r)` be the endpoint-good subset of `I_m` defined by (EO.5), and let
`BadEO_(M,L,r)` be the set of `n in I_M` whose adaptive endpoint schedule
first enters `I_m\G_(m,r)` at some rank `m>=L`.  The exact all-stage target is

\[
 \boxed{
 2^{-M}\#\operatorname{BadEO}_{M,L_M,r}=o(1).
 }
\tag{EO.SCHED}
\]

A power-rate version would give a quantitative logarithmic exceptional set.
Equation (EO.SCHED), together with (EO.10)--(EO.13), would prove the desired
endpoint headline without controlling every intermediate orbit prefix.

The one-shell estimate (EO.7) does not imply (EO.SCHED), because the inputs
to later blocks are generated endpoints rather than uniform points in their
dyadic shells.

## 4. Exact bit-budget obstruction to the naive iteration

The first `H` parity bits depend on the source modulo `2^H`.  Since `I_M` is
one complete residue system modulo `2^M`, parity words are uniformly counted
only while

\[
 H\le M.
\tag{EO.14}
\]

The first endpoint block in (EO.8) already uses `H=M`.  The parity bits needed
to certify the second block lie beyond this complete-residue budget.  Treating
them as fresh or independent would be an invalid lifting step.

Using shorter endpoint blocks does not remove the global obstruction.  A
central shortcut step decreases binary rank by

\[
 \Delta_{\rm dr}=1-a_0.
\]

After a total of at most `M` uniformly exposed parity bits, the central rank
is still approximately

\[
 M-\Delta_{\rm dr}M=a_0M.
\tag{EO.15}
\]

Reaching `O(log M)` at the central drift requires approximately

\[
 \frac{M-O(\log M)}{\Delta_{\rm dr}}
 =4.8188\ldots M+o(M)
\tag{EO.16}
\]

shortcut bits.  Thus any proof based only on the complete dyadic parity
budget can certify at most the first constant-factor descent.  A generated
continuation theorem beyond bit exhaustion is unavoidable.

This is a method-capacity obstruction, not a counterexample to
(EO.SCHED).

## 5. Fixed-time congestion is exponential

The good set in (EO.7) has cardinality `(1-o(1))2^m`, while its endpoint
image under `n -> T^m(n)` lies in `[1,2^(rm))`.  Pigeonhole therefore gives

\[
 \boxed{
 \text{average endpoint fiber on the good image}
 \ge (1-o(1))2^{(1-r)m}.
 }
\tag{EO.17}
\]

For `r` near `a_0`, this is approximately `2^(Delta_dr m)`.  Hence the
endpoint-only schedule cannot reuse the first-passage proof by replacing its
tagged fibers with a polynomial maximum-fiber estimate.  Arbitrary-target
linear fixed-time transport is unavailable at the pointwise level.

This does not kill target-specific transport: exponentially large fibers may
still be spread proportionally across the literal next-stage bad set.

## 6. Exact generated endpoint dictionary

Let `w in {0,1}^m` be a parity word, let `a_w in [0,2^m)` be its unique
parity residue, and let `s(w)` be its number of odd letters.  Extend the
shortcut map to zero in the evident way and put

\[
 b_w=T^m(a_w).
\tag{EO.18}
\]

The affine-cylinder identity gives, for the unique shell representative
`n_w=a_w+2^m`,

\[
 \boxed{T^m(n_w)=b_w+3^{s(w)}.}
\tag{EO.19}
\]

This is the exact generated endpoint family that replaces an iid second
parity block.

It has an append recurrence.  For `e in {0,1}`, let `k in {0,1}` be the
unique value satisfying

\[
 b_w+3^{s(w)}k\equiv e\pmod2.
\tag{EO.20}
\]

Then

\[
\boxed{
\begin{aligned}
 a_{we}&=a_w+2^mk,\\
 b_{we}&=T\bigl(b_w+3^{s(w)}k\bigr),\\
 s(we)&=s(w)+e.
\end{aligned}}
\tag{EO.21}
\]

The second-stage parity word is therefore controlled by the dyadic residues
of the generated integers `b_w+3^s`, not by fresh independent bits.  This is
the exact arithmetic state for the next bounded proof attempt.

## 7. Smallest next theorem: two-stage target bias

For `z=T^M(n)` let `q(z)=floor(log_2 z)`.  Write

\[
 B^{\rm end}_{q,r}=I_q\setminus G_{q,r},
 \qquad
 \delta_{q,r}=\frac{|B^{\rm end}_{q,r}|}{2^q}.
\tag{EO.22}
\]

For a terminal rank `L`, define the exact centered two-stage discrepancy

\[
\boxed{
 \mathcal D^{(2)}_{M,L,r}
 =2^{-M}\!\sum_{\substack{n\in G_{M,r}\\q(T^M(n))\ge L}}
 \left(
  \mathbf1_{B^{\rm end}_{q(T^M(n)),r}}(T^M(n))
  -\delta_{q(T^M(n)),r}
 \right).
 }
\tag{EO.23}
\]

The first nontrivial theorem is

\[
 \boxed{[\mathcal D^{(2)}_{M,L_M,r}]_+=o(1).}
\tag{EO.TWO}
\]

The neutral contribution is exponentially small in `L_M` by (EO.7).
Therefore (EO.TWO) proves that the generated first endpoint does not
preferentially select the next endpoint-bad set.

This is only a two-stage theorem.  Promotion to (EO.SCHED) additionally
requires an inherited recurrence or renewal estimate for the same centered
quantity at every generated stage.  Separate finite certificates at each
depth do not supply that lifting.

## 8. Finite diagnostic, evidence only

Exact enumeration was run for complete shells `12<=M<=20`, with actual
endpoint goodness rather than the sufficient parity condition (EO.5), and a
small terminal cutoff `L=4`.  The diagnostic compared the actual second-
stage failure rate with the rank-weighted uniform-shell reference rate.

| `r` | `M` range | observed enrichment `actual/reference` |
|---:|---:|---:|
| `.85` | `12,14,16,18,20` | `.920` to `.984` |
| `.90` | `12,14,16,18,20` | `.952` to `.995` |

No positive enrichment was observed.  This is supportive of (EO.TWO), not a
proof.  The values `r=.85,.90` are calibration parameters, not the
headline-clock regime where `r` is extremely close to `a_0`.

The same finite endpoint maps are visibly noninjective:

| `M` | occupied-endpoint share | maximum fiber |
|---:|---:|---:|
| `10` | `.4277` | `10` |
| `14` | `.3311` | `29` |
| `18` | `.2626` | `83` |
| `20` | `.2355` | `140` |

Residue distributions modulo `2^floor(a_0M)` also had total-variation
distance roughly `.22`--`.30` from uniform over `8<=M<=20`.  Thus finite
data reject exact endpoint equidistribution and support using the centered,
target-specific discrepancy (EO.23) rather than an arbitrary-target norm.

```text
COMPUTATION STATUS:
  exact finite enumeration;
  scope M<=20 only;
  no asymptotic promotion;
  positive calibration: no observed target enrichment;
  negative calibration: noninjective and nonuniform endpoint law;
  kill threshold: none reached; an all-depth inherited enrichment family
  would be required to kill EO.TWO.
```

## 9. Closeout and route decision

```text
NEW PROVED-PAPER RESULTS:
  fixed-endpoint affine bound EO.4;
  exponential one-block endpoint certificate EO.7;
  scalar adaptive schedule and optimal clock EO.10--EO.12;
  bit-budget obstruction EO.14--EO.16;
  exponential average fixed-time congestion EO.17;
  exact generated endpoint dictionary EO.19--EO.21.

SCOPED KILLS:
  simply replace the maximal barrier by final-time concentration and then
  multiply independent block probabilities: INVALID after the first block;
  polynomial maximum-fiber fixed-time transport: FALSE by EO.17;
  exact endpoint equidistribution: FALSE at finite depth and not a valid
  theorem target.

STRICTLY NARROWED:
  every-prefix control is unnecessary for one endpoint block and for the
  scalar 6.953 clock;
  the first genuinely new issue occurs at the second generated endpoint;
  it is represented exactly by b_w+3^s and EO.TWO.

EQUALLY HARD:
  all-depth target-specific control after the original M parity bits are
  exhausted.

ROUTE DECISION:
  ALIVE / NARROWED.  Do not modify the manuscript or Lean package.

NEXT EXACT TARGET:
  prove or kill EO.TWO from the append recurrence EO.21, preserving the
  rank-weighted centering in EO.23.  If it succeeds, derive an inheritance
  recurrence before attempting EO.SCHED.

PHASE-3 HEADLINE IMPROVEMENT:
  NONE YET.
```

## 10. Hybrid model: endpoint high phase, first-passage terminal phase

The two mechanisms can be combined without asking either one to prove the
whole theorem.  Fix

\[
 0<\lambda<1,
 \qquad
 K_M=\lceil M^\lambda\rceil,
 \qquad
 L_M=\lceil A\log_2(M+2)\rceil.
\tag{HY.1}
\]

Run the endpoint schedule (EO.8) only while its current rank exceeds
`K_M`.  At its first landing `y` of rank `q<=K_M`, stop using endpoint
blocks.  If `q<L_M`, the desired polylogarithmic descent has already
occurred.  Otherwise run the already proved first-passage terminal schedule
from the actual shell `I_q` down to `L_M`.

This is the useful order of the two mechanisms:

* the endpoint phase removes the outer-scale feasible-time enumeration;
* the first-passage phase supplies the rigorous generated continuation near
  the terminal scale.

### 10.1 Scalar clock

If the endpoint phase is good, its shortcut duration is at most

\[
 \sum_jm_j\le\frac{M}{1-r}.
\tag{HY.2}
\]

The terminal first-passage phase starts at rank at most `K_M`, so its clock
is `O(K_M)=o(M)`.  Consequently the total natural-logarithmic clock is

\[
 \frac{1}{(1-r)\log2}\log n+o(\log n).
\tag{HY.3}
\]

Letting `r` decrease to `a_0` therefore retains every strict clock constant

\[
 c>\frac{2}{\log(4/3)}=6.952118\ldots.
\tag{HY.4}
\]

This is only a scalar statement.  It does not prove that the generated
endpoint phase succeeds.

### 10.2 Exact source-weighted switch interface

Let `BadEO^hi_(M,K,r)` be the sources in `I_M` whose endpoint schedule has a
first bad block while the current rank is greater than `K`.  On its
complement, define the subprobability switch law

\[
 \nu^{\rm EO}_{M,K}(E)
 =2^{-M}\#\{n\in I_M:\text{the good endpoint phase first lands in }E
                   \text{ at rank at most }K\}.
\tag{HY.5}
\]

For `L<=q<=K`, let `C^{\rm FP}_{q,L}\subseteq I_q` be the literal failure set
of the proved first-passage terminal schedule, and put

\[
 \delta^{\rm FP}_{q,L}=\frac{|C^{\rm FP}_{q,L}|}{2^q}.
\tag{HY.6}
\]

After fixing any `0<kappa<kappa_*` and choosing the strict terminal-profile
parameters uniformly, the proved terminal profile, applied at outer rank
`q<=K`, has the reference scale

\[
 \max_{L\le q\le K}\delta^{\rm FP}_{q,L}
 \le K^{1/2+o(1)}2^{-\kappa L}
 =M^{\lambda/2-A\kappa+o(1)},
\qquad
 \kappa_* =1-H_2(\log_32).
\tag{HY.7}
\]

For ranks comparable with `L`, the older linear-support terminal profile is
only polylogarithmically more expensive and is absorbed by the right-hand
side.  The endpoint value `kappa=kappa_*` is not asserted; every strict
`kappa<kappa_*` suffices for the limiting threshold below.

The exact reset discrepancy is

\[
 \mathcal D^{\rm reset}_{M,K,L}
 =\sum_{q=L}^{K}
 \left(
   \nu^{\rm EO}_{M,K}(C^{\rm FP}_{q,L})
   -\nu^{\rm EO}_{M,K}(I_q)\delta^{\rm FP}_{q,L}
 \right).
\tag{HY.8}
\]

The positive part is taken only after all switch ranks have been combined.
The smallest joint theorem consumed by the hybrid is

\[
 \boxed{
  2^{-M}|\operatorname{BadEO}^{\rm hi}_{M,K_M,r}|
  +[\mathcal D^{\rm reset}_{M,K_M,L_M}]_+
  =o(1).
 }
\tag{HY.MIN}
\]

Under (HY.MIN), the total failure density is

\[
 o(1)+M^{\lambda/2-A\kappa+o(1)},
\tag{HY.9}
\]

and hence every strict

\[
 \boxed{A>\frac{\lambda}{2\kappa_*}}
\tag{HY.10}
\]

is conditionally admissible with the same leading clock (HY.4).

| `lambda` | conditional strict threshold for `A` |
|---:|---:|
| `.97` | `A>9.6913799417...` |
| `.75` | `A>7.4933350064...` |
| `.50` | `A>4.9955566709...` |
| `.25` | `A>2.4977783354...` |

These are scalar payoffs, not proved headline improvements.

### 10.3 What remains genuinely open

The high endpoint phase must reach `K_M=M^lambda`, not merely make one
endpoint block.  A single block leaves the rank at a constant multiple of
`M`, so the terminal first-passage support still has size
`M^(1/2+o(1))` and changes only a constant.  Reaching `M^lambda` requires a
generated sequence of endpoint blocks after the original `M` parity bits
are exhausted.

Thus the hybrid has two coupled obligations:

1. the truncated endpoint schedule has `o(1)` first-bad mass above `K_M`;
2. its actual switch law does not positively enrich the literal
   first-passage terminal failure family.

Neither follows from the exponentially small one-shell bad density.  The
fixed-time endpoint fibers are exponentially congested by (EO.17), so a
maximum-fiber or arbitrary-target estimate remains unavailable.  HY.MIN is
deliberately source-weighted and target-specific.

```text
ANTI-CIRCULARITY CARD

OLD TARGET:
  EO.SCHED from rank M all the way to L_M.

NEW JOINT TARGET:
  HY.MIN: endpoint continuation only to K_M=M^lambda, followed by one
  source-weighted reset comparison into the proved first-passage terminal
  schedule.

JOINT-DISCHARGE PRINCIPLE:
  HY.7 + HY.MIN imply HY.9 and therefore A>lambda/(2*kappa_*).

BURDEN REMOVED:
  no endpoint-only inheritance is required below K_M; the already proved
  first-passage machinery handles that entire terminal phase.

NEW BURDEN:
  the switch landing law must be paired with the one literal terminal
  failure family.  No arbitrary-target comparison is requested.

FAILURE MODE:
  a generated endpoint family with non-vanishing high-phase first-bad mass,
  or positive switch enrichment large enough to cancel HY.7.

FINITE KILL TEST:
  measure the two terms of HY.MIN separately for fixed lambda, preserving
  the switch-rank sum before the positive part.  Finite growth can pause the
  route but cannot kill the all-depth statement without an explicit family.
```

### 10.4 Reverse order: a scoped scalar ceiling

There is a cheaper-looking alternative: first use the proved first-passage
schedule to reach rank

\[
 S=B\log_2M,
\]

and then apply one endpoint-only block with contraction parameter `r`.  Its
output rank is at most `rS`, so the advertised polylog exponent would be
`A=rB`.  Put

\[
 \kappa(r)=1-H_2\!\left(\frac{r}{\log_23}\right).
\tag{HY.11}
\]

The endpoint-bad target has density `M^(-B kappa(r)+o(1))`.  Transporting
that target with the currently proved square-root first-passage loss requires

\[
 B\kappa(r)>\frac12,
 \qquad\text{hence}\qquad
 A>\frac{r}{2\kappa(r)}.
\tag{HY.12}
\]

This does **not** improve the present exponent.  In natural logarithms let
`D(p||1/2)` be the Bernoulli relative entropy.  For `p>1/2`,

\[
 \frac{d}{dp}\frac{D(p\|1/2)}p
 =\frac{-\log(2(1-p))}{p^2}>0.
\tag{HY.13}
\]

Since `p=r/log_2 3`, the ratio `kappa(r)/r` is increasing.  Therefore

\[
 \boxed{
  \frac{r}{2\kappa(r)}
  \ge\frac{1}{2\kappa(1)}
  =\frac{1}{2\kappa_*}
  =9.991113\ldots.
 }
\tag{HY.14}
\]

So “first passage, then one endpoint block” is exactly neutralized by the
rarity cost of the endpoint certificate when only the existing generic
square-root transport is used.  It can improve the headline only if a new
target-specific anti-alignment theorem beats that transport loss; in that
case the new theorem, rather than the scalar splice, is the breakthrough.

```text
HYBRID STATUS:
  scalar endpoint-high / first-passage-terminal payoff: DERIVED-CONDITIONAL;
  retained 6.953 leading clock: DERIVED-CONDITIONAL;
  HY.MIN: OPEN;
  first-passage then one endpoint block with generic transport: NO EXPONENT
    IMPROVEMENT, by HY.11--HY.14;
  Phase-3 headline improvement: NONE YET.

NEXT EXACT TARGET:
  HY.MIN for one fixed lambda, initially lambda=.97.  This is weaker than
  EO.SCHED because endpoint inheritance stops at M^.97 and only one literal
  first-passage failure family is tested at the switch.
```
