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
  globs := #[.submodules `FirstPassageLinearTransport]
