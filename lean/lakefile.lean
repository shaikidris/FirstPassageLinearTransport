import Lake
open Lake DSL

package FirstPassageLinearTransport where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.15.0"

@[default_target]
lean_lib FirstPassageLinearTransport where
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
  globs := #[
    .one `FirstPassageLinearTransport.Main,
    .one `FirstPassageLinearTransport.PaperAudit,
    .one `FirstPassageLinearTransport.PaperDependencyAudit,
    .one `FirstPassageLinearTransport.TimeoutEndpointAudit
  ]

/-- Optional retained V3.1 route. It is compiled only when this library or one
of its modules is requested explicitly. -/
lean_lib FirstPassageLinearTransportAlternates where
  roots := #[`FirstPassageLinearTransport.Alternates]
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
  globs := #[.submodules `FirstPassageLinearTransport.Alternates]
