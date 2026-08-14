# Formalization record

## Release identity

- Manuscript: *Polylogarithmic Descent for Almost All Collatz Orbits in
  Natural Density*
- Author: Idris Ali Shaik
- Lean release: `lean-v3.2.0`
- Lean: `v4.15.0`
- Mathlib: `9837ca9d65d9de6fad1ef4381750ca688774e608`
- Preprint DOI: <https://doi.org/10.5281/zenodo.21931194>
- Software DOI: <https://doi.org/10.5281/zenodo.21930432>

The software archive kernel-checks the principal theorem chain. The
manuscript proof is self-contained and does not depend on the Lean
formalization.

## What `Main` proves

All declarations below are in the namespace
`FirstPassageLinearTransport.QuantitativeCollatzMain`.

1. `collatz_first_passage_moving_polylogarithmic_natural_density_descent`
   is the canonical moving-endpoint theorem. For a bounded exponent profile
   satisfying the displayed diverging entropy buffer, and for every shortcut
   clock coefficient `c > 2 / log(4/3)` and `beta > 0`, it supplies a
   natural-density-one same-witness landing/clock/orbit-ceiling statement and
   a quantitative dyadic-shell exceptional estimate.

2. `collatz_first_passage_timeout_moving_polylogarithmic_natural_density_descent`
   is an exact compatibility alias that makes the timeout implementation
   explicit.

3. `collatz_first_passage_fixed_polylogarithmic_natural_density_descent`
   specializes the headline to every fixed
   `A > 1 / (2 * (1 - H_2(log_3 2)))`, every
   `c > 2 / log(4/3)`, and every `beta > 0`. It includes a positive
   logarithmic exceptional-set exponent and the same-witness orbit ceiling.

4. `collatz_first_passage_stretched_log_natural_density_descent` and
   `collatz_first_passage_stretched_log_natural_density_descent_unclocked`
   give the timed and unclocked stretched-logarithmic companions.

5. `collatz_first_passage_fixed_power_natural_density_descent` gives the
   timed fixed-power consequence.

6. `collatz_first_passage_quantitative_stretched_exceptional_count` and
   `collatz_first_passage_quantitative_fixed_power_exceptional_count` give
   quantitative companion exceptional counts.

7. `collatz_first_passage_raw_stretched_log_natural_density_descent`
   converts the stretched-logarithmic witness to the unaccelerated Collatz
   clock.

8. `collatz_first_passage_stretched_log_descent_with_orbit_ceiling` combines
   the shortcut clock, landing, and intermediate-orbit ceiling at one witness.

9. `collatz_first_passage_graded_power_natural_density_descent` records the
   graded time--descent tradeoff for fixed-power targets.

The public types use the literal maps

```text
shortcut(n)   = n/2       if n is even, and (3n+1)/2 otherwise;
rawCollatz(n) = n/2       if n is even, and 3n+1 otherwise.
```

They use the package's explicit natural-density and exceptional-count
definitions, not an abstract stochastic surrogate.

## Principal checked chain

The dependency audit maps the manuscript's load-bearing steps to checked
declarations, including:

- the parity-vector bijection and exact affine iterate;
- maximal/adjustable barrier counts and deterministic orbit envelopes;
- first-passage reversal, tagged-fiber bounds, and loss-filtered transport;
- decreasing-rank direct-passage collapse and rank-scaled reverse-loss
  telescoping;
- the timeout tail and its endpoint-rate density estimate;
- the cumulative-time corridor and square-root feasible-time support;
- support-sensitive first-bad aggregation;
- logarithmic shortcut and raw clocks;
- same-witness orbit ceilings; and
- dyadic-shell exceptional estimates and natural-density assembly.

`PaperDependencyAudit.lean` records the exact declaration-level map and
reverse reachability. `PaperAudit.lean` and `TimeoutEndpointAudit.lean` print
the axiom surfaces for the public theorems and the canonical timeout chain.

## Reproduction commands

Run from this `lean/` directory:

```bash
lake build
lake build FirstPassageLinearTransport.PaperAudit
lake build FirstPassageLinearTransport.TimeoutEndpointAudit
```

For a direct public axiom report:

```bash
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
  -DmaxHeartbeats=20000000 \
  FirstPassageLinearTransport/PaperAudit.lean
```

For the dependency report:

```bash
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
  -DmaxHeartbeats=20000000 \
  FirstPassageLinearTransport/PaperDependencyAudit.lean
```

The checked roots contain no `sorry`, `admit`, or project-specific axiom.
Their axiom reports contain only `propext`, `Classical.choice`, and
`Quot.sound`.

## Scope

The formalization verifies almost-all results only. It does not prove the
pointwise Collatz conjecture and does not rule out exceptional cycles or
divergent trajectories.
