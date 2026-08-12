# V3.1 moving-endpoint promotion audit

**Review date:** 2026-08-11
**Mode:** `MATH-TEXT + SCALAR + EMPIRICAL + FORMAL-BOUNDARY + RENDER`
**Reviewer context:** `AUTHOR-AUDIT` (internal; not independent verification)
**Branch:** `v3-fixed-polylog`
**Baseline:** fixed-exponent V3 theorem at commit `e382a241`
**Verdict:** `ACCEPT PAPER UPGRADE / MOVING PRODUCER FORMALIZED / PUBLIC EXTENSION PENDING`

## 1. Promoted statement

Put

\[
\kappa_*=1-H_2(\log_3 2),
\qquad
A_{\rm FP}=\frac1{2\kappa_*}=9.9911133419\ldots .
\]

For a bounded real profile \(A_M\), define

\[
L_M=\lceil A_M\log_2(M+2)\rceil,
\qquad
\Delta_M=\kappa_*L_M-\frac12\log_2(M+2)-\log_2\log(M+3).
\]

The new manuscript theorem assumes only \(\Delta_M\to+\infty\).  It gives a
shell failure ratio

\[
O(2^{-\Delta_M}+M^{-\varepsilon})
\]

and hence natural-density-one descent to \(C(\log n)^{A_M}\), before every
fixed shortcut clock \(c>2/\log(4/3)\), with the same-witness ceiling
\(n^{1+\beta}\).

The explicit secondary endpoint is

\[
C(\log n)^{A_{\rm FP}}
 (\log\log n)^{2A_{\rm FP}}
 (\log\log\log n)^D
\]

for every fixed \(D>0\).  The last factor may be replaced qualitatively by
an arbitrary prescribed divergent function of \(\log\log n\).  The pure
endpoint with a bounded final multiplier is not claimed.

## 2. Backward cut-vertex audit

The promotion has four new load-bearing vertices.

### CV1. Sharp maximal-walk prefactor

For \(t\) in a fixed compact subinterval of \((0,1/2)\), reflection reduces
the maximal two-sided walk event to a constant multiple of a terminal
binomial tail.  The ratio of consecutive tail coefficients is uniformly
below one, so the tail is a constant multiple of its first coefficient.
Uniform Stirling inequalities give

\[
\Pr(H_m>tm)\ll m^{-1/2}e^{-m\mathcal I(t)}.
\]

The compactness restriction is essential.  The proof does not assert this
prefactor uniformly as \(t\downarrow0\).

**Status:** `PROVED-PAPER`.

### CV2. Moving low-parameter envelope

With \(\eta_*=1-a_0\), choose

\[
\eta_M=\eta_*-K_0/L,
\quad
r_M=1-K_0/(2L),
\quad
\lambda_M=1-K_1/L.
\]

For every low parent rank \(m\ge L\), the first-passage margin is at least
\(K_0/2\), the unused multiplicative-envelope slack is uniformly positive,
and the additive-correction exponent tends to

\[
a_0-\eta_*=2a_0-1>0.
\]

After increasing the fixed startup and choosing \(K_0,K_1\), the existing
all-prefix certification and first-passage proof therefore holds uniformly
over the moving low schedule.

**Status:** `PROVED-PAPER`.

### CV3. Critical low-target density

The moving walk height remains in a fixed compact subset of \((0,1/2)\).
Since the entropy rate differs from its endpoint by \(O(1/L)\), and every low
rank satisfies \(L\le q\le S_M=O(\log M)\), the exponential correction
\(e^{O(q/L)}\) is bounded.  CV1 therefore yields

\[
\frac{|B^{\rm crit}_{M,q}|}{2^q}
\ll q^{-1/2}2^{-\kappa_*q}+2^{-q}.
\]

The stopped bad target is defined literally in the manuscript before use;
the single endpoint \(2^q\) is retained separately.

**Status:** `PROVED-PAPER`.

### CV4. Moving support and scalar reassembly

The high phase and its \(O(\sqrt{M\log M})\) cumulative-time support are
unchanged.  Because \(r_M\to1\), the old geometric low-phase estimate is not
reused.  Strict integer rank descent gives at most \(S_M\) low blocks, each
of duration and corridor width at most \(O(S_M)\), so the full low cost is

\[
O(S_M^2)=O((\log M)^2)=o(\sqrt{M\log M}).
\]

The support-sensitive transport estimate and CV3 give

\[
\Pr_M(\operatorname{Fail})
\ll
\sqrt{M\log M}
\left(L^{1/2}2^{-\kappa_*L}+L2^{-L}\right)
+M^{-\varepsilon}.
\]

Substituting the definition of \(\Delta_M\) yields

\[
\Pr_M(\operatorname{Fail})
\ll2^{-\Delta_M}+M^{-\varepsilon}.
\]

The qualitative clause of Lemma 2.1 then converts shellwise convergence to
ordinary natural density one.

**Status:** `PROVED-PAPER`.

## 3. Consumer calibration

The general rank buffer specializes as follows.

1. Fixed \(A>A_{\rm FP}\):
   \(2^{-\Delta_M}\ll
   M^{-\kappa_*(A-A_{\rm FP})}\log M\).
2. \(L=A_{\rm FP}\log_2M+B\log_2\log M\):
   convergence holds precisely for \(B\kappa_*>1\) in this estimate.
3. At \(B=1/\kappa_*=2A_{\rm FP}\), adding
   \(D\log_2\log\log M\) gives
   \(2^{-\Delta_M}\ll(\log\log M)^{-D\kappa_*}\).
4. Replacing that last term by the logarithm of any divergent subpower
   minorant gives the functional density-one statement.

The moving target is strictly smaller in terminal scale than every fixed
\((\log n)^{A_{\rm FP}+\epsilon}\), but its displayed exceptional rate is
weaker.  The manuscript states these as separate comparison axes.

## 4. Negative controls and excluded shortcuts

- A bounded final multiplier leaves \(\Delta_M=O(1)\) and does not prove
  density convergence.
- Lowering the coefficient of \(\log\log M\) below \(1/\kappa_*\) loses a
  positive logarithmic power.
- The first-crossing decomposition does not provide an additional factor
  \(q^{-1}\); its stopped cylinders reassemble the original maximal event.
- No finite diagnostic, independence assumption, Fourier estimate, or
  generated-target equidistribution theorem enters the proof.

## 5. Exact finite diagnostic

Command:

```text
python3 -B research/audit_critical_endpoint_loglog.py
```

The script computes the symmetric-walk maximal event by exact integer dynamic
programming.  On outer ranks \(10^3,10^4,10^5,10^6\):

- the compact-regime ratio against
  \(m^{-1/2}e^{-m\mathcal I(t)}\) stays between approximately 6.57 and 7.21;
- the \(t=1/m\) negative-control ratio increases from approximately 12.73 to
  16.79;
- the critical scalar normalization stays bounded;
- the secondary-endpoint normalization stays between approximately 4.36 and
  4.65;
- the bounded-tertiary boundary proxy remains above 4.43 rather than tending
  to zero.

The script returns `audit=PASS`.  These computations support the proof and
its boundary calibration; they are not premises of the theorem.

## 6. Manuscript and render audit

- The moving theorem is Theorem 1.1.
- Fixed, log-log, triple-log, and functional profiles are grouped in
  Corollary 1.2 rather than expanded into separate headline theorems.
- The stretched-log theorem is renumbered Theorem 1.3; raw and fixed-power
  companions are Corollaries 1.4 and 1.5.
- The moving stopped target is defined before its first estimate.
- Section 7, Scope, Appendix A, and all internal display references were
  updated.
- The V3 PDF renders as 25 A4 pages with no observed clipping, overlap, or
  broken display.

## 7. Formal boundary

The public Lean theorem proves the fixed-\(A\) landing, clock, same-witness
ceiling, natural-density-one conclusion, and a positive logarithmic
exceptional exponent.  The internal moving modules now additionally prove:

- the compact-regime \(m^{-1/2}\) binomial prefactor;
- the moving low parameters and their endpoint-rate loss;
- exact real-to-lattice barrier rounding;
- the literal moving landing-density producer;
- the moving stopped run and direct nested first-passage identity;
- the exact certified landing shell and common-center cumulative corridor;
- the decreasing low-rank potential and uniform
  \(O(\sqrt{M\log M})\) moving feasible-time support;
- the scalar natural-density assembly from a completed moving shell profile.

These internal results are audited by `MovingEndpointAudit.lean`.  The public
theorem still does not expose:

- Proposition 6.5 or Theorem 1.1;
- the exact fixed-\(A\) exceptional range;
- the exact stretched-log exceptional endpoint \(1-\delta\).

The manuscript, `README.md`, `proof-state.md`, `lean/FORMALIZATION.md`, and
the strings in `PaperDependencyAudit.lean` now state this narrower boundary.
The direct moving first-bad transport and conditional terminal-profile socket
are formalized in `MovingFirstBad.lean` and `MovingProfile.lean`. The remaining
cut vertex is an eventual shell-density and same-witness producer that
discharges the socket. Until it is connected to the conditional moving
assembly, the public Lean build must not be described as a formal proof of
the V3.1 moving headline.

### Internal moving-time-support closure

The moving time-support argument is now formalized without altering the
fixed-parameter statement or implementation of Lemma 6.1.  The new
`MovingTimeSupport.lean` module proves the literal moving stopped run, direct
nested first passage, the exact certified rank identity
\(m_{i+1}=q_i-1\), and the common center \((M+1)-q\).

The formal potential uses the correct orientation.  Below the switch it is
\((S+4)q\), so every strict integer rank drop releases at least \(S+4\), which
pays the entire one-block duration error.  Above the switch the unchanged
high-phase square-root potential carries the reserve \((S+4)S\).  This gives
an exact pre-asymptotic support-cardinality bound and then, for
\(S_M=O(\log M)\), the uniform \(O(\sqrt{M\log M})\) result stated as
Lemma 6.4.  No factor \(1/(1-r_M)\) is introduced.

The updated `MovingEndpointAudit.lean` report lists only Lean's standard
`propext`, `Classical.choice`, and `Quot.sound` axioms for every new root.

**Status:** `PROVED-FORMAL / AXIOM AUDIT PASS`.

## 8. Closeout

```text
MOVING ENDPOINT:                  PROVED-PAPER
MOVING ANALYTIC PRODUCER:         PROVED-FORMAL / AXIOM AUDIT PASS
MOVING FEASIBLE-TIME SUPPORT:     PROVED-FORMAL / AXIOM AUDIT PASS
MOVING FIRST-BAD/PROFILE SOCKET: PROVED-FORMAL / AXIOM AUDIT PASS
FIXED-A SPECIALIZATION:          PROVED-PAPER / PROVED-FORMAL (partial rate API)
LOG-LOG AND TRIPLE-LOG PROFILES: PROVED-PAPER
FUNCTIONAL DIVERGENT MULTIPLIER: PROVED-PAPER / QUALITATIVE
PURE CRITICAL ENDPOINT:          NOT PROVED
EMPIRICAL CONTROLS:              PASS
PDF RENDER:                      PASS / 25 A4 PAGES
FULL MOVING LEAN HEADLINE:       NOT YET PROVED-FORMAL
REPOSITORY MILESTONE:            COMMITTED / PUSHED PRIVATE AT dc7b544
PUBLIC MOVING PROMOTION:         PENDING PROFILE ADAPTER
```

The paper upgrade is mathematically coherent and substantially stronger in
terminal scale. Its analytic producer, time support, and conditional
first-bad profile are formally verified, while the full paper/Lean promotion
remains pending at the eventual shell-density and witness producer.
