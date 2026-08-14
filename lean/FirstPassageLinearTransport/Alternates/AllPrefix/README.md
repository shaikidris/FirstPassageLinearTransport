# All-prefix moving-endpoint alternate

This directory retains the former V3.1 low-rank all-prefix proof as an
independent comparison library.  It is deliberately outside the canonical
`FirstPassageLinearTransport.Main` import closure and outside the default Lake
target.

Build and audit it explicitly from `lean/`:

```text
lake build FirstPassageLinearTransportAlternates
```

The public alternate theorem is exposed by `Main.lean` in the namespace
`FirstPassageLinearTransport.Alternates.AllPrefix`.  `Audit.lean` is its direct
axiom audit.  The canonical V3.2 theorem continues to use the timeout route and
is audited by `FirstPassageLinearTransport.TimeoutEndpointAudit`.
