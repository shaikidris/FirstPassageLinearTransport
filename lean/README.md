# Lean supplementary development

This directory is a standalone Lean 4 package for the formalization
accompanying *Polylogarithmic Descent for Almost All Collatz Orbits in Natural
Density*.

## Canonical interface

`FirstPassageLinearTransport/Main.lean` exposes eleven referee-facing
theorems about the literal shortcut and raw Collatz maps. The two headline
declarations are:

- `collatz_first_passage_moving_polylogarithmic_natural_density_descent`;
- `collatz_first_passage_fixed_polylogarithmic_natural_density_descent`.

They record natural-density-one descent, the relevant moving or fixed
polylogarithmic target, a logarithmic shortcut clock, quantitative exceptional
control, and the orbit ceiling through the same witness. The remaining public
declarations give the stretched-logarithmic, raw-clock, fixed-power, and
graded-clock companions.

The principal implementation passes through the timeout, compressed
feasible-time-support, loss-filtered transport, orbit-ceiling, and dyadic
natural-density modules. In particular, the formal chain includes the
square-root feasible-time-support estimate used to avoid a linear union over
cumulative passage times.

## Build and audit

The package uses Lean `v4.15.0`; `lake-manifest.json` pins Mathlib and every
transitive dependency.

```bash
# Canonical Main cone plus the three audit roots
lake build

# Public theorem and manuscript cut-vertex axiom report
lake build FirstPassageLinearTransport.PaperAudit

# Canonical timeout-chain axiom report
lake build FirstPassageLinearTransport.TimeoutEndpointAudit
```

For the detailed declaration/source dependency report:

```bash
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
  -DmaxHeartbeats=20000000 \
  FirstPassageLinearTransport/PaperDependencyAudit.lean
```

The audited public roots have no admitted obligations or project-specific
axioms. Their axiom reports contain only Lean/Mathlib's standard foundational
principles `propext`, `Classical.choice`, and `Quot.sound`.

## Package boundary

The default `FirstPassageLinearTransport` library contains the import-closed
canonical `Main` cone and its audits. Retained alternate and historical
implementations are available as the explicitly requested
`FirstPassageLinearTransportAlternates` and
`FirstPassageLinearTransportLegacy` libraries; neither enters the default
build or the public theorem dependency cone.

See [`FORMALIZATION.md`](FORMALIZATION.md) for the exact public theorem map.
