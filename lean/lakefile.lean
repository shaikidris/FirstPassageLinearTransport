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
  /- Keep this list equal to the canonical `Main` import closure plus the
  three audit roots. An omitted dependency makes a clean build fail; an
  alternate module here would make the canonical/alternate split fail. -/
  globs := #[
    .one `FirstPassageLinearTransport.AdjustableBarrierDensity,
    .one `FirstPassageLinearTransport.AdjustableEntropyRate,
    .one `FirstPassageLinearTransport.AdjustableEnvelope,
    .one `FirstPassageLinearTransport.AsymptoticBounds,
    .one `FirstPassageLinearTransport.Barrier,
    .one `FirstPassageLinearTransport.BarrierDensity,
    .one `FirstPassageLinearTransport.Basic,
    .one `FirstPassageLinearTransport.Bootstrap,
    .one `FirstPassageLinearTransport.BootstrapSchedule,
    .one `FirstPassageLinearTransport.ClockBudget,
    .one `FirstPassageLinearTransport.Constants,
    .one `FirstPassageLinearTransport.Density,
    .one `FirstPassageLinearTransport.EntropyBarrier,
    .one `FirstPassageLinearTransport.Envelope,
    .one `FirstPassageLinearTransport.FiniteStartup,
    .one `FirstPassageLinearTransport.FirstBadEnvelope,
    .one `FirstPassageLinearTransport.FirstPassage,
    .one `FirstPassageLinearTransport.FirstPassageLandingShell,
    .one `FirstPassageLinearTransport.FixedPolylogParameters,
    .one `FirstPassageLinearTransport.GlobalAssembly,
    .one `FirstPassageLinearTransport.GradedClock,
    .one `FirstPassageLinearTransport.GradedPowerDescent,
    .one `FirstPassageLinearTransport.HeadlineParameters,
    .one `FirstPassageLinearTransport.HeightSensitiveClock,
    .one `FirstPassageLinearTransport.LossTransport,
    .one `FirstPassageLinearTransport.Main,
    .one `FirstPassageLinearTransport.MovingEndpointAssembly,
    .one `FirstPassageLinearTransport.MovingEndpointAsymptotics,
    .one `FirstPassageLinearTransport.MovingEndpointParameters,
    .one `FirstPassageLinearTransport.MovingEndpointScalars,
    .one `FirstPassageLinearTransport.MovingLowParameters,
    .one `FirstPassageLinearTransport.MovingSharpTail,
    .one `FirstPassageLinearTransport.NaturalDensityDescent,
    .one `FirstPassageLinearTransport.NestedRecertification,
    .one `FirstPassageLinearTransport.OrbitCeiling,
    .one `FirstPassageLinearTransport.Parameters,
    .one `FirstPassageLinearTransport.Parity,
    .one `FirstPassageLinearTransport.PolylogExceptionalCount,
    .one `FirstPassageLinearTransport.PolylogTerminalSchedule,
    .one `FirstPassageLinearTransport.PolylogTarget,
    .one `FirstPassageLinearTransport.PowerDescent,
    .one `FirstPassageLinearTransport.Pullback,
    .one `FirstPassageLinearTransport.QuantitativeNaturalDensityDescent,
    .one `FirstPassageLinearTransport.RankScaledLoss,
    .one `FirstPassageLinearTransport.RankTransportAsymptotics,
    .one `FirstPassageLinearTransport.RawClockBudget,
    .one `FirstPassageLinearTransport.RawDynamics,
    .one `FirstPassageLinearTransport.RawNaturalDensityDescent,
    .one `FirstPassageLinearTransport.RecertificationRun,
    .one `FirstPassageLinearTransport.RecertificationStep,
    .one `FirstPassageLinearTransport.Scalar,
    .one `FirstPassageLinearTransport.SharpEntropyBarrier,
    .one `FirstPassageLinearTransport.ShrinkingBarrierCore,
    .one `FirstPassageLinearTransport.ShrinkingBarrierRun,
    .one `FirstPassageLinearTransport.ShrinkingExecution,
    .one `FirstPassageLinearTransport.ShrinkingFirstBad,
    .one `FirstPassageLinearTransport.ShrinkingHighDensity,
    .one `FirstPassageLinearTransport.ShrinkingNaturalDensityDescent,
    .one `FirstPassageLinearTransport.ShrinkingOrbitCeiling,
    .one `FirstPassageLinearTransport.ShrinkingParameters,
    .one `FirstPassageLinearTransport.ShrinkingPolylogProfile,
    .one `FirstPassageLinearTransport.ShrinkingProfile,
    .one `FirstPassageLinearTransport.ShrinkingSchedules,
    .one `FirstPassageLinearTransport.ShrinkingTailAsymptotics,
    .one `FirstPassageLinearTransport.ShrinkingTimeSupport,
    .one `FirstPassageLinearTransport.StretchedExceptionalCount,
    .one `FirstPassageLinearTransport.StretchedLogLanding,
    .one `FirstPassageLinearTransport.TerminalProfile,
    .one `FirstPassageLinearTransport.TerminalTail,
    .one `FirstPassageLinearTransport.TerminalTailAsymptotics,
    .one `FirstPassageLinearTransport.TimeSupportScalars,
    .one `FirstPassageLinearTransport.TimeSupportTransport,
    .one `FirstPassageLinearTransport.TimeoutCore,
    .one `FirstPassageLinearTransport.TimeoutDensity,
    .one `FirstPassageLinearTransport.TimeoutEndpointAsymptotics,
    .one `FirstPassageLinearTransport.TimeoutEndpointNaturalDensity,
    .one `FirstPassageLinearTransport.TimeoutEndpointProfile,
    .one `FirstPassageLinearTransport.TimeoutEndpointWitness,
    .one `FirstPassageLinearTransport.TimeoutEnvelope,
    .one `FirstPassageLinearTransport.TimeoutExecution,
    .one `FirstPassageLinearTransport.TimeoutFirstBad,
    .one `FirstPassageLinearTransport.TimeoutOrbitCeiling,
    .one `FirstPassageLinearTransport.TimeoutProfile,
    .one `FirstPassageLinearTransport.TimeoutRun,
    .one `FirstPassageLinearTransport.TimeoutTimeSupport,
    .one `FirstPassageLinearTransport.Transport,
    .one `FirstPassageLinearTransport.TwoRegimeClock,
    .one `FirstPassageLinearTransport.TwoRegimeRun,
    .one `FirstPassageLinearTransport.VaryingDensity,
    .one `FirstPassageLinearTransport.PaperAudit,
    .one `FirstPassageLinearTransport.PaperDependencyAudit,
    .one `FirstPassageLinearTransport.TimeoutEndpointAudit
  ]


/-- Source-preserving archive of declarations outside the referee-facing roots.
Generated by `audits/partition_lean_reachability.py`; excluded from the default
canonical build. -/
lean_lib FirstPassageLinearTransportExtras where
  roots := #[`FirstPassageLinearTransport.Extras.Unreachable]
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
  globs := #[.submodules `FirstPassageLinearTransport.Extras]

/-- Optional retained V3.1 route. It is compiled only when this library or one
of its modules is requested explicitly. -/
lean_lib FirstPassageLinearTransportAlternates where
  roots := #[`FirstPassageLinearTransport.Alternates]
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
  globs := #[
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingEndpointProfile,
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingExecution,
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingFirstBad,
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingLowDensity,
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingLowSetup,
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingOrbitCeiling,
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingProfile,
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingSharpProfile,
    .one `FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingTimeSupport,
    .submodules `FirstPassageLinearTransport.Alternates
  ]

/-- Historical two-regime fixed-polylog route.  It remains available for
comparison and regression checks, but is not part of the canonical `Main`
library or its default build. -/
lean_lib FirstPassageLinearTransportLegacy where
  roots := #[`FirstPassageLinearTransport.Legacy]
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
  globs := #[
    .one `FirstPassageLinearTransport.Legacy,
    .one `FirstPassageLinearTransport.Legacy.FixedPolylogParameterPackage,
    .one `FirstPassageLinearTransport.Legacy.TimeoutRunProjections,
    .one `FirstPassageLinearTransport.Legacy.TwoRegimeRecertificationRun,
    .one `FirstPassageLinearTransport.Legacy.Implementation.TwoRegimeExecution,
    .one `FirstPassageLinearTransport.Legacy.Implementation.TwoRegimeOrbitCeiling,
    .one `FirstPassageLinearTransport.Legacy.Implementation.TwoRegimePolylogExecution,
    .one `FirstPassageLinearTransport.Legacy.Implementation.TwoRegimePolylogProfile,
    .one `FirstPassageLinearTransport.Legacy.Implementation.TwoRegimeProfile,
    .one `FirstPassageLinearTransport.Legacy.Implementation.TwoRegimeSchedules,
    .one `FirstPassageLinearTransport.Legacy.Implementation.TwoRegimeTailAsymptotics
  ]

/-- Exact Corollary 1.2(1) packaging for Palomar: separate `C_tar`/`C_exc` and
every `γ < κ_*(A - A_FP)`. Built separately from the canonical `Main` root. -/
lean_lib FirstPassageLinearTransportPaperCor12 where
  roots := #[`FirstPassageLinearTransport.PaperCor12Item1]
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
