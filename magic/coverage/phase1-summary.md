# Phase 1 Summary: Contract Coverage Identification

## Objective
Identify all contracts in the current repository that must always be fully covered by the fuzzer.

## Completion Status
Phase 1 is COMPLETE.

## Deliverables

### 1. contracts-to-cover.md
Location: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/magic/coverage/contracts-to-cover.md`

This file contains an exhaustive list of 13 contracts that need to be covered by the fuzzer:

#### Core System Contracts (4):
1. `Governance.sol` - Main governance contract
2. `BribeInitiative.sol` - Bribe initiative implementation
3. `UserProxy.sol` - User proxy for V1 staking
4. `UserProxyFactory.sol` - Factory for UserProxy deployment

#### Utility Contracts (7):
5. `utils/MultiDelegateCall.sol`
6. `utils/Ownable.sol`
7. `utils/DoubleLinkedList.sol`
8. `utils/VotingPower.sol`
9. `utils/Math.sol`
10. `utils/UniqueArray.sol`
11. `utils/SafeCallMinGas.sol`

#### Additional Initiatives (2):
12. `CurveV2GaugeRewards.sol`
13. `UniV4MerklRewards.sol`

### 2. coverage-prep.md
Location: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/magic/coverage/coverage-prep.md`

This file contains detailed context information including:
- Inheritance chains for each core contract
- Direct dependencies and external calls
- Analysis of touched contracts
- Classification of external vs internal dependencies

## Methodology

### Step 1: Identify Initial Contracts from Setup
Analyzed the Setup contract at `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/test/recon/Setup.sol` to identify core contracts:
- Governance (includes UserProxyFactory via inheritance)
- BribeInitiative (2 instances deployed)
- UserProxy (deployed via factory)

### Step 2: Build Project
Successfully built the project with build info:
```
forge clean && forge build --build-info
```
Build info location: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/out/build-info/6034cb0f0a66a712.json`

### Step 3: Manual Contract Analysis
Since sol-expand tool had memory issues, performed manual analysis by:
- Reading source files directly
- Analyzing import statements
- Tracking inheritance chains
- Identifying external calls and library usage
- Using grep to find contract interactions

### Step 4: Identify Touched Contracts
Analyzed each core contract to determine which utility contracts and libraries are touched:
- Governance touches: MultiDelegateCall, Ownable, VotingPower, Math, UniqueArray, SafeCallMinGas
- BribeInitiative touches: DoubleLinkedList, VotingPower
- UserProxyFactory touches: UserProxy (for cloning)

### Step 5: Include Additional Initiatives
Identified additional initiative implementations that are part of the codebase:
- CurveV2GaugeRewards (extends BribeInitiative)
- UniV4MerklRewards (implements IInitiative)

## Exclusions

The following were explicitly excluded from coverage requirements:
- Mock contracts (MockERC20Tester, MockStakingV1)
- OpenZeppelin standard library contracts (IERC20, SafeERC20, ReentrancyGuard, Clones)
- External protocol interfaces (ILQTYStaking, ICurveStableswapNG, IDistributionCreator, ILiquidityGauge)
- Pure type definition files (utils/Types.sol)

## Bug Fix

During the build process, fixed a compilation error in `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/test/recon/targets/BribeInitiativeTargets.sol`:
- Issue: Incorrect parameter handling for `IGovernance.UserState` struct
- Fix: Changed from string placeholder to proper struct parameter passing

## Next Steps

Phase 1 is complete. The next phase should involve:
1. Setting up coverage tracking for the 13 identified contracts
2. Implementing coverage instrumentation in the fuzzing harness
3. Creating coverage reports to track which contracts/functions are being exercised
4. Ensuring the target functions from Phase 0 adequately cover these contracts

## References

- Setup contract: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/test/recon/Setup.sol`
- Testing priority list: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/magic/testing_priority.md`
- Build info: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/out/build-info/6034cb0f0a66a712.json`
