# Lean reachability partition

The module graph is recursive from the declared canonical, alternate,
and legacy roots. Declaration rows come from compiled kernel and `.ilean`
source-reference reachability, not textual name matching.

## Module closures

- `canonical`: 89 modules
- `alternate`: 111 modules
- `legacy`: 101 modules

These closure sizes overlap: the optional libraries reuse the canonical
foundation.  The disjoint physical source classification is:

- `alternate_only`: 15 source modules
- `archive`: 22 source modules
- `audit`: 5 source modules
- `canonical`: 89 source modules
- `legacy_only`: 11 source modules

## Planned physical module moves

- none

## Mixed canonical declaration queue

- none

## Environment-registered canonical declarations

- `FirstPassageLinearTransport.StageSetup.lowerTolerance_M0` (theorem)
- `FirstPassageLinearTransport.shortcut_zero` (theorem)
- `FirstPassageLinearTransport.stageOrbit_zero` (theorem)
- `FirstPassageLinearTransport.shrinkingHighSetup_M0` (theorem)
- `FirstPassageLinearTransport.boolWalkStep_true` (theorem)
- `FirstPassageLinearTransport.stageClock_zero` (theorem)
- `FirstPassageLinearTransport.bootstrapSet_zero` (theorem)
- `FirstPassageLinearTransport.parityBit_zero` (theorem)
- `FirstPassageLinearTransport.boolWalkStep_false` (theorem)
- `FirstPassageLinearTransport.bootstrapC_zero` (theorem)
