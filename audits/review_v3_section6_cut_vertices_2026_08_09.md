# V3 Section-6 cut-vertex audit

**Mode:** `MATH-TEXT / EXTERNAL-REFEREE SIMULATION`

**Review date:** 2026-08-09

**Manuscript SHA-256:**
`af9bc44ddd97463e17d9b44d49c85c35d29367af397bca0144e51aae3242953f`

**Rendered PDF SHA-256:**
`63853e18e9edcaad317a61b6cbb60178efd6a3f69e09fd5a896f0c428d3f8a01`

## Scope and verdict

This audit tests only the four vertices requested by the V3 adversarial
review:

1. Proposition 6.2, the shrinking high-rank density bound;
2. Lemma 6.1, deterministic rank collapse and cumulative-time support;
3. Theorem 6.3, the support-sensitive first-bad profile;
4. the parameter selection proving Theorem 1.1.

No external theorem is used in this audit.  Sections 2--5 are treated only
through their displayed interfaces.  The result is:

`PASS: COMPLETE COVERAGE OF THE DECLARED CUT VERTICES; NO CIRCULAR DEPENDENCY
OR MISSING RATE MARGIN FOUND.`

## 1. Shrinking high-rank density

At the high schedule,

```text
eta_(M,m) = D_hi sqrt(log(M+2)/m),
m >= S_M >= C_sw log(M+2),
D_hi / sqrt(C_sw) <= tau.
```

Hence the cap is inactive and `eta_(M,m)^2 m = D_hi^2 log(M+2)` exactly.
For the uniform estimate (6.8d), take the Boolean barrier height
`h = t m /(2 log_2 3)`.  Lemma 3.1 and
`I(u) >= 2u^2` give the exponent

```text
m I(t/(2 log_2 3)) >= t^2 m /(2(log_2 3)^2) = c_0 t^2 m.
```

When `m >= 4` and `tm >= 2`, the unused upper-envelope factor is at least
`1/2`, while the affine correction is smaller by the fixed exponent
`a_0 m`; the same main term dominates the lower envelope.  In the remaining
startup region, `t^2m <= 4`, so `C_0 = 2 exp(4c_0)` absorbs the trivial shell
bound.  Thus the estimate is genuinely uniform in the varying `t` used by
Section 6 and does not invoke the fixed-parameter startup of Proposition 3.3.

For a landing threshold `2^q`, the open part of the band is the shell
`I_(q-1)` and the only omitted point is `2^q`.  Applying the uniform estimate
at `m=q-1` and adding that singleton gives (6.8c).  Since
`q >= S_M+1`, the endpoint contribution is at most
`(M+2)^(-C_sw log 2)`.  This verifies (6.9).

## 2. Deterministic rank and time telescope

Every active tolerance is smaller than `a_0`.  If an intermediate certified
landing were `2^q`, certification at time `q` would require

```text
2^((a_0-t)q) <= T^q(2^q) = 1,
```

which is impossible.  Thus every certified intermediate landing lies in the
single shell `I_(q_i-1)` and

```text
m_(i+1) = q_i - 1.
```

Consequently

```text
sum_(i=0)^j (m_i-q_i) = M-q_j-j.
```

Summing the one-block corridor and moving its center to `(M+1)-q_j` costs
exactly one additional unit per block, yielding (6.7d).  The high-rank
contribution is a geometric square-root sum
`O(sqrt(M log(M+2)))`; the low-rank contribution is `O(S_M)`, and the number
of additive constants is `O(log M)`.  For fixed final `q`, every feasible
integer time therefore lies in one interval of the claimed length.  There is
no residual union over intermediate rank histories.

## 3. Support-sensitive terminal profile

The first-bad definition uses only certified blocks before the failed
landing.  Lemma 5.1 therefore identifies that landing with a direct first
passage from the original shell, and Lemma 5.2 supplies the loss cutoff
`D_q=(q+2)/r_*`.  The fixed rank `L_0` makes `D_q/2^q <= 1/3`, so the
support-sensitive transport theorem applies literally.

After division by `2^M`, its two terms are bounded by

```text
#H_(M,q) (q+1) |B_(M,q)| / 2^q,
```

because `q<M` and `D_q` is linear in `q`.  Lemma 6.1 gives the common
square-root support factor.  The split is exhaustive:

- `q >= S_M+1` selects the shrinking tolerance at landing shell `q-1` and
  costs `sum(q+1)d_hi(M) = O(M^2 d_hi(M))`;
- `L <= q <= S_M` selects the fixed low tolerance; strict decreases from
  the available entropy and dyadic rates absorb the factor `q+1` into the
  two displayed tails.

The initial failure is exactly (6.8b).  The failed landing itself is never
re-certified.  The geometric clock and orbit ceiling use only the already
certified blocks.  This proves (6.10) with the stated startup quantifiers.

## 4. Headline parameter selection

The high-clock interval in (6.12) is nonempty precisely because

```text
c > 2/log(4/3)
  = 1 / ((1-a_0) log 2).
```

The low-rate interval in (6.13) is nonempty because

```text
sup_(eta<1-a_0) b_ent(eta)
  = (1-H_2(log_3 2)) log 2
```

and `A > 1/(2(1-H_2(log_3 2)))`.  Choosing `D_hi` first and `C_sw` second
simultaneously makes the cap inactive, places `L_M` below `S_M`, and gives
`p_hi>3`.

With `L_M = ceil(A log_2(M+2))`, the high contribution in (6.10) is

```text
M^(5/2-p_hi) times a logarithmic factor,
```

while either low tail is

```text
M^(1/2-A b/log 2) times a logarithmic factor.
```

These are exactly the two positive margins in (6.15).  Equation (6.16)
converts terminal rank to the fixed-polylog target, (6.17) converts the
geometric high-phase clock to `c log n`, and the final dyadic summation
preserves the shell power.  The endpoint is correctly left unattained.

## Anti-circularity result

The proof consumes only:

- exact parity coding and the maximal Boolean barrier;
- deterministic all-prefix envelopes;
- first-passage reversal and loss-filtered fibers;
- nested direct re-certification and rank-scaled loss;
- the new schedule, support, and parameter estimates above.

It does not consume Theorem 1.1, Theorem 1.2, a generated-target mixing
hypothesis, a moment estimate, or any finite diagnostic.  The revised
Section 6 is therefore closed at paper level within its declared dependency
cone.
