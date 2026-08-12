# Phase 3 timeout and four-route cycle — 2026-08-12

## 0. Scope and declared consumer

This is post-freeze strengthening research.  It does not alter the manuscript,
`proof-state.md`, the public main theorem, or the Lean formalization.

The bounded-buffer consumer remains the one identified in Sections 44--49 of
`phase3_switch_3adic_common_profile_cycle_2026_08_09.md`: remove the final
little divergence in the critical rank buffer.  The cycle tests one structural
replacement and four possible producers:

1. schedule-restricted untagged \(L^2\);
2. timeout-target averaged Green loss;
3. source-weighted stratified barrier width;
4. a high-endpoint/terminal-timeout hybrid.

The predeclared rule is unchanged: a favorable finite trend is
`EMPIRICAL` only.  A route is promoted only after its all-depth paper
inequality is proved and reassembled into the declared consumer.

## 1. Structural result: the moving low maximal barrier can be replaced by a timeout tail

Let
\[
T(n)=\begin{cases}
n/2,&2\mid n,\\
(3n+1)/2,&2\nmid n,
\end{cases}
\qquad
I_m=[2^m,2^{m+1})\cap\mathbb N.
\]
Fix a terminal rank \(L\), put
\[
r_L=1-\frac{K_0}{2L},
\qquad
q_L(m)=\lfloor r_Lm\rfloor,
\]
and define the low-stage timeout set
\[
\mathcal T_{L,m}
=
\{x\in I_m:\tau_{2^{q_L(m)}}(x)>m\}.
\tag{TO.1}
\]

The proposed low schedule declares a stage successful exactly when the first
passage occurs by time \(m\).  It does not ask for an all-prefix corridor at
low ranks.

### Lemma TO.1 (exact timeout-to-odd-count containment)

Let \(s_m(x)\) be the number of odd shortcut steps among the first \(m\)
iterates.  Then
\[
x\in\mathcal T_{L,m}
\quad\Longrightarrow\quad
3^{s_m(x)+1}>2^{q_L(m)}.
\tag{TO.2}
\]

#### Proof

For the parity word \(w=(p_0,\ldots,p_{m-1})\), the exact affine iterate is
\[
2^mT^m(x)=3^{s_m(x)}x+A_w,
\qquad
A_w=\sum_{i=0}^{m-1}p_i2^i3^{s_m-s_{i+1}}.
\]
Every summand is at most \(2^i3^{s_m}\), so
\[
0\le A_w<(2^m-1)3^{s_m}<2^m3^{s_m}.
\]
Since \(x<2^{m+1}\),
\[
T^m(x)<3^{s_m}\left(\frac{x}{2^m}+1\right)<3^{s_m+1}.
\]
A timeout has \(T^m(x)>2^{q_L(m)}\), which proves (TO.2). \(\square\)

### Lemma TO.2 (sharp timeout density)

Uniformly for \(L\le m\le C_{\rm sw}\log(M+2)\),
\[
\frac{|\mathcal T_{L,m}|}{2^m}
\ll
m^{-1/2}2^{-\kappa_*m},
\qquad
\kappa_*=1-H_2(\log_3 2),
\tag{TO.3}
\]
after one fixed startup depending on \(K_0,C_{\rm sw}\).

#### Proof

The length-\(m\) parity map is a bijection on \(I_m\).  Hence \(s_m\) has
the exact \(\operatorname{Bin}(m,1/2)\) counting law.  By TO.1 a timeout lies
in the tail
\[
s_m>q_L(m)\log_3 2-1.
\]
Here
\[
\frac{q_L(m)\log_3 2-1}{m}
=\log_3 2+O(L^{-1})
\]
uniformly in the declared low range, because \(m/L=O(1)\).  The threshold
stays in a compact subinterval of \((1/2,1)\).  The ratio of consecutive
binomial summands is therefore bounded below one, so the tail is a constant
multiple of its first summand.  Stirling gives
\[
2^{-m}\sum_{j\ge pm}\binom mj
\ll m^{-1/2}\exp(-mD(p\|1/2)).
\]
Since
\[
D(\log_3 2\|1/2)=\kappa_*\log2
\]
and \(D(p\|1/2)=\kappa_*\log2+O(L^{-1})\), the extra exponential factor is
\(\exp(O(m/L))=O(1)\).  This proves (TO.3). \(\square\)

### Proposition TO.3 (low-schedule replacement; derived assembly contract)

Keep the manuscript's high phase unchanged and use (TO.1) in the low phase.
Then the moving low all-prefix barrier, its moving tolerance, its auxiliary
\(\lambda_M\), and the low-stage additive-correction startup are unnecessary.
The resulting schedule retains:

* strict low-rank descent;
* the direct nested first-passage identity;
* the rank-scaled reverse-loss bound;
* feasible cumulative-time support
  \(O(\sqrt{M\log M})\);
* the logarithmic witness clock and same-witness orbit ceiling;
* the critical low profile
  \[
  \sqrt{M\log M}
  \left(L^{1/2}2^{-\kappa_*L}+L2^{-L}\right).
  \tag{TO.4}
  \]

#### Proof

A successful low stage supplies exactly the hypotheses used by nested
recertification and reverse loss: a first passage to a strictly smaller
threshold with duration at most its parent rank.  A failed low stage is
charged at its current parent.  That parent is already the landing of the
preceding successful stage, hence is a direct first-passage landing of the
original source.  Therefore \(\mathcal T_{L,m}\), viewed in the parent shell,
fits the existing support-sensitive transport socket; no fictitious endpoint
after the failed block is introduced.

There are at most \(O(S_M)\) strict low-rank drops and every successful low
duration is at most \(S_M\), so the entire low elapsed-time width is
\(O(S_M^2)=O((\log M)^2)\).  Adding this interval width to the unchanged high
common-center corridor preserves \(O(\sqrt{M\log M})\) feasible support.

For the orbit ceiling, \(T(z)<2z\) for \(z\ge2\).  Every low block begins
below \(2^{S_M+1}\) and lasts at most \(S_M\), so its maximum is
\(2^{O(S_M)}=M^{O(1)}=n^{o(1)}\).  The high ceiling is unchanged.

Finally insert TO.2 into the existing loss-filtered rankwise transport bound.
Its rank factor is \(O(m)\); multiplying by the \(m^{-1/2}\) in TO.2 and
summing the geometric tail from \(L\) gives (TO.4). \(\square\)

The argument above identifies every required existing socket, but this note
does not yet define the complete modified run and prove its initial-failure /
first-timeout partition with all public theorem quantifiers.  TO.3 is
therefore a derived assembly contract, not yet a submission-ready promoted
theorem.

### Structural status

```text
TO.1 exact affine containment:             PROVED
TO.2 sharp timeout density:                PROVED
TO.3 schedule/reassembly replacement:      DERIVED / full run assembly pending
manuscript integration:                    NOT STARTED
Lean formalization:                        NOT STARTED
headline improvement from timeout alone:   NONE (same scalar profile)
```

The replacement is valuable because the bad target is now a terminal
odd-count/timeout event rather than an all-prefix maximal-barrier failure.
It simplifies the existing theorem and, unlike the old target, can be sampled
at genuinely sparse large ranks.  It does not by itself remove the critical
buffer.

The exact finite certificate is
`research/audit_timeout_tail.py`.  On complete shells \(m=12,14,\ldots,24\)
with \(q=m-4\), it found no violation of TO.1 and reproduced the binomial
odd-count histogram exactly.

## 2. Route 1: schedule-restricted untagged \(L^2\)

The tested observable is the normalized collision energy of the generated
landing histogram after summing all feasible times before squaring.  A
mechanism-visible parameter choice gave
\[
\|\phi_{\rm sch}\|_2^2
=2.03,1.85,2.26,1.82,2.12
\quad(M=14,16,18,20,22),
\]
while the number of time tags grew from \(105\) to \(274\).  A log--log fit
gave power \(0.058\), far below the proved square-root ceiling.

This is supportive but not a paper proof.  The asymptotically admissible
small-tolerance parameters retain no sources at these tiny shells, whereas
the visible run uses a mechanism-only tolerance.  Algebraically, the missing
step is still the off-diagonal, different-time collision count after bit
exhaustion.  Separate time-slice bounds or Cauchy--Schwarz restore the lost
square-root factor.

```text
exact schedule observable:                 IMPLEMENTED
finite mechanism signal:                   SUPPORTIVE_ONLY
paper-compatible finite resolution:        INACCESSIBLE at tested M
all-depth off-diagonal collision theorem:   OPEN
route decision:                             HOLD, not the first proof target
```

Runner: `research/audit_l2_schedule_restricted.py`.

## 3. Route 2: timeout-target averaged Green loss

For a bounded-gap first passage from \(I_{q+4}\) to \(J_q\), let \(B_q^{\rm
to}\) be the next-stage timeout target and let \(E_q\) be the exact reverse
loss.  The literal desired estimate is
\[
\sum_{x\in I_{q+4}}
E_q(x)\,\mathbf1_{\{T^{\tau_{2^q}(x)}(x)\in B_q^{\rm to}\}}
\ll
2^{q+4}\frac{|B_q^{\rm to}|}{|J_q|}.
\tag{TG.1}
\]
An aggregated schedule version of (TG.1) closes the bounded-buffer loss
consumer.

The corrected sampled diagnostic gives:

| \(q\) | uniform target density | mass enrichment | conditional-loss enrichment | product | aligned-loss control |
|---:|---:|---:|---:|---:|---:|
| 72 | 0.0291225 | 1.00798 | 0.99431 | 1.00225 | 4.20 |
| 96 | 0.0096425 | 0.98678 | 1.02324 | 1.00971 | 5.15 |
| 120 | 0.0033150 | 1.01810 | 1.01039 | 1.02868 | 6.10 |
| 144 | 0.0010925 | 1.01602 | 0.95446 | 0.96975 | 7.17 |

Each row uses 200,000 sampled sources and 400,000 independently sampled
uniform endpoints.  Orbit and target decisions use exact integer arithmetic.
The intentionally aligned control grows strongly, so the test is sensitive
to the obstruction it is meant to detect.

The first version of the script tested one extra timeout iterate and inferred
the parent rank from `bit_length`; that off-by-one was corrected before the
table above was accepted.  The power-of-two endpoint is now separated and a
landing in \(J_q\) is tested for exactly \(q-1\) parent steps.

The data are the first evidence in this project at a genuinely sparse literal
target (about \(0.1\%\) in the last row).  They strongly reject the prediction
that the old maximum single-endpoint Green growth is typical of the timeout
failure set.

They do not prove (TG.1).  After the first \(m\) parity bits are exhausted,
the future timeout word is a deterministic affine continuation of the source;
bounding that continuation is the same hidden-digit correlation called
`GE.CHANNEL` in the main ledger.  A finite-delay truncation explains the data
but does not give a relative error on the exponentially sparse target without
an all-depth continuation estimate.

```text
literal sparse diagnostic:                  PASSED / EMPIRICAL
positive and adversarial controls:          PASSED
TG.1 or its schedule aggregate:             OPEN
route decision:                             PRIMARY NEXT PROOF ATTEMPT
```

Runner: `research/audit_timeout_target_averaged_green.py`.

## 4. Route 3: source-weighted stratified high barrier

For a source, let
\[
W(n)=\sum_{\text{executed parent blocks}}
\max_{k\le m}|2s_k-k|.
\]
The tested consumer asks whether the literal timeout target selects an
abnormally large \(W\).

On complete shells \(M=14,16,18,20,22\), the unconditional
\(\mathbb EW/\sqrt M\) remained between \(2.13\) and \(3.98\).  The corrected
timeout-target weighted enrichment was
\[
0.955,0.963,0.980,0.963,0.972,
\]
whereas the top-width aligned control was \(1.08\)--\(1.09\).  At \(M=22\),
the source mass with \(W/\sqrt M\ge8\) was \(0.00408\), and the mass above
\(16\) was \(2.6\times10^{-6}\).

The tail behavior is favorable.  However the generated stage inputs are not
fresh uniform shells.  A proof of the unconditional source-weighted estimate
already needs a generated-prefix recurrence after bit exhaustion, and the
target-weighted estimate again needs the same continuation decorrelation as
(TG.1).  Thus this is not an independent escape from the Green problem; it is
an alternate positive-moment producer for it.

```text
finite weighted-tail behavior:              SUPPORTIVE_ONLY
generated all-stage expectation theorem:    OPEN
target-weighted stratified theorem:          OPEN / same GE.CHANNEL core
route decision:                             FOLD INTO ROUTE 2
```

Runner: `research/audit_stratified_high_barrier.py`.

## 5. Route 4: high-endpoint / terminal-timeout hybrid

The tested hybrid quantity is
\[
\Pr(\text{high endpoint certificate fails})
+
\left[
\Pr_\nu(\text{terminal timeout})
-\sum_q\nu(q)d_q^{\rm unif}
\right]_+.
\tag{HY.1}
\]

Across \(M=14,\ldots,24\) and several cutoffs \(K=M^\lambda\), the terminal
reset discrepancy was always nonpositive; terminal enrichment was typically
between \(0.987\) and \(1.000\).  The adversarial aligned control stayed
positive.  Thus the reset half is favorable.

The crude exact sufficient high endpoint certificate used by the diagnostic
discarded \(40\%\)--\(85\%\) of the source shell and did not decrease on the
available range.  This does not kill the manuscript's proved high phase; it
shows only that this simplified endpoint producer is too wasteful to be the
hybrid's proof root.  Replacing it by the existing high barrier leaves the
terminal reset covariance open, and that covariance is again a version of
route 2.

```text
terminal reset sign:                        SUPPORTIVE_ONLY
tested crude high producer:                 REJECTED
hybrid using existing high theorem:         structurally valid
new bounded-buffer conclusion:              NOT PROVED
route decision:                             PARK AS ASSEMBLY VARIANT
```

Runner: `research/audit_hybrid_hy_min.py`.

## 6. Closeout and next exact theorem

The four routes did not produce four independent proof burdens.  They reduce
to two mathematical objects:

* an off-diagonal generated landing collision theorem (route 1);
* a target-weighted continuation theorem (routes 2--4).

The timeout replacement is proved on paper and makes the second object much
cleaner.  The most economical next theorem is the schedule-aggregated form of
TG.1:
\[
\boxed{
\sum_{\text{terminal low stages}}
\sum_x E_{q(x)}(x)\mathbf1_{\{\text{landing in }B_{q(x)}^{\rm to}\}}
\ll
\sum_{\text{terminal low stages}}
d_{q(x)}\sum_xE_{q(x)}(x).
}
\tag{TG.SCHED}
\]
The positive part is taken only after summing ranks and landing times.  A
constant on the right is enough for the bounded-buffer endpoint; no uniform
single-endpoint Green bound is requested.

```text
PROVED THIS CYCLE:
  timeout-to-odd-count containment;
  sharp timeout density at the critical entropy rate.

DERIVED THIS CYCLE:
  the exact socket-by-socket reassembly replacing the moving low maximal
  barrier by timeouts; the complete modified-run partition is not yet written.

NOT PROVED:
  schedule L2;
  timeout-target averaged Green / TG.SCHED;
  target-weighted stratified barrier;
  hybrid reset covariance;
  bounded-buffer critical endpoint.

PRIMARY ROUTE:
  TG.SCHED for the literal timeout target.

HEADLINE / MANUSCRIPT / PROOF-STATE / LEAN:
  unchanged.
```

## 7. Publication-product decision

There are two distinct possible products, and they must not be conflated.

### Product A: a timeout-first-passage alternate proof of the existing theorem

The proved TO.1--TO.2 lemmas plus the derived TO.3 assembly can support a new
draft proving the same moving endpoint theorem and the same exceptional
profile as the current manuscript.  To make that draft complete, it still
must write and audit:

1. the modified stopped run;
2. the disjoint initial-failure / first-timeout decomposition;
3. closure of every successful timeout landing under the next stage;
4. the direct first-passage target inclusion at a failed stage, including
   shell endpoint conventions;
5. the rankwise transport sum and final clock/ceiling assembly.

All five use already-proved interfaces, so this is a bounded closure project,
not a new analytic conjecture.  Its payoff is proof simplification, not a
stronger inequality or headline.

### Product B: a genuinely stronger bounded-buffer theorem

TG.SCHED would remove the remaining divergent critical buffer and materially
strengthen the landing scale.  It remains open.  None of the four diagnostics
proves it.

### Decision

Do not create a second claimed research paper from TO.1--TO.2 alone.  They are
too elementary and reproduce the current theorem only after reusing most of
the existing high-phase and transport architecture.  If pursued, Product A
should begin as a separate experimental timeout-proof draft or branch, with
the frozen main manuscript untouched.  After the five assembly items close,
compare proof length and dependency count.  Promote it as a replacement
version only if it materially simplifies the referee-facing proof.

Keep Product B in the research ledger.  It is the only route in this cycle
that would justify a genuinely stronger headline.
