# Fuzzing Setup Documentation

This directory contains documentation and artifacts for the fuzzing setup process for the Liquity V2 Governance system.

## Directory Structure

```
magic/
├── README.md                    # This file
├── setup-notes.md              # Initial setup notes
├── testing_priority.md         # Phase 0: Testing priority list (16 functions)
└── coverage/
    ├── contracts-to-cover.md   # Phase 1: Exhaustive list of contracts to cover
    ├── coverage-prep.md        # Phase 1: Detailed contract analysis
    └── phase1-summary.md       # Phase 1: Completion summary
```

## Phase Completion Status

### Phase 0: Testing Priority List - COMPLETE
**File:** `testing_priority.md`

Identified 16 main functions from GovernanceTargets and BribeInitiativeTargets contracts, ranked by testing priority with dependency information.

Key functions identified:
1. governance_deployUserProxy
2. governance_calculateVotingThreshold
3. governance_getInitiativeState
4. governance_depositLQTY
5. governance_allocateLQTY
6. governance_registerInitiative
7. bribeInitiative_depositBribe
8. bribeInitiative_claimBribes
... and 8 more

### Phase 1: Contract Coverage Identification - COMPLETE
**Directory:** `coverage/`

**Key Deliverables:**

1. **contracts-to-cover.md** - Exhaustive list of 13 contracts that need coverage:
   - 4 Core contracts (Governance, BribeInitiative, UserProxy, UserProxyFactory)
   - 7 Utility contracts (MultiDelegateCall, Ownable, DoubleLinkedList, etc.)
   - 2 Additional initiatives (CurveV2GaugeRewards, UniV4MerklRewards)

2. **coverage-prep.md** - Detailed analysis including:
   - Inheritance chains
   - Direct dependencies
   - External call patterns
   - Classification of internal vs external contracts

3. **phase1-summary.md** - Complete methodology and results

## Contract Coverage Summary

### Core System Contracts (4)
- `Governance.sol` - Main governance contract
- `BribeInitiative.sol` - Bribe initiative implementation
- `UserProxy.sol` - User proxy for V1 staking
- `UserProxyFactory.sol` - Factory for UserProxy deployment

### Utility Contracts (7)
- `utils/MultiDelegateCall.sol` - Batched contract calls
- `utils/Ownable.sol` - Ownership management
- `utils/DoubleLinkedList.sol` - Data structure library
- `utils/VotingPower.sol` - Voting power calculations
- `utils/Math.sol` - Mathematical operations
- `utils/UniqueArray.sol` - Array validation
- `utils/SafeCallMinGas.sol` - Safe external calls

### Additional Initiatives (2)
- `CurveV2GaugeRewards.sol` - Curve V2 gauge rewards
- `UniV4MerklRewards.sol` - Uniswap V4 Merkl rewards

**Total: 13 contracts to cover**

## Next Steps

### Phase 2: Coverage Implementation (Planned)
- Set up coverage tracking infrastructure
- Instrument contracts for coverage measurement
- Integrate with fuzzing harness

### Phase 3: Coverage Reporting (Planned)
- Generate coverage reports
- Identify coverage gaps
- Optimize target functions for better coverage

### Phase 4: Coverage Improvement (Planned)
- Add targeted test cases for uncovered branches
- Enhance fuzzing strategies
- Achieve target coverage thresholds

## Testing Approach

The fuzzing setup follows a structured approach:

1. **Function Priority** (Phase 0) - Identify which functions to test and in what order
2. **Contract Coverage** (Phase 1) - Identify which contracts must be covered
3. **Implementation** (Phase 2) - Set up coverage tracking
4. **Measurement** (Phase 3) - Track and report coverage
5. **Improvement** (Phase 4) - Optimize for complete coverage

## Build Information

- **Compiler:** Solc 0.8.24
- **Build Command:** `forge clean && forge build --build-info`
- **Build Info Location:** `out/build-info/6034cb0f0a66a712.json`
- **Test Framework:** Foundry with Recon (Chimera-based fuzzing)

## References

- **Setup Contract:** `test/recon/Setup.sol`
- **Target Functions:** `test/recon/targets/`
- **Source Contracts:** `src/`
- **Documentation:** `magic/`

## Notes

- Mock contracts and external dependencies are excluded from coverage requirements
- OpenZeppelin standard library contracts are not included in coverage tracking
- Focus is on core protocol logic and utility contracts that implement custom business logic
