# Contracts to Cover

This file lists all contracts that must be fully covered by the fuzzer, excluding mock contracts.

## Core System Contracts (from Setup.sol)

- `Governance.sol` - Main governance contract with voting, allocation, and initiative management
- `BribeInitiative.sol` - Initiative implementation for bribe-based incentives
- `UserProxy.sol` - Proxy contract for user interactions with V1 staking
- `UserProxyFactory.sol` - Factory for deploying UserProxy instances (inherited by Governance)

## Utility Contracts (Touched by Core Contracts)

These contracts are directly used by the core contracts and must be covered:

- `utils/MultiDelegateCall.sol` - Enables batched contract calls (inherited by Governance)
- `utils/Ownable.sol` - Ownership management (inherited by Governance)
- `utils/DoubleLinkedList.sol` - Data structure library (used by BribeInitiative)
- `utils/VotingPower.sol` - Voting power calculations (used by Governance and BribeInitiative)
- `utils/Math.sol` - Mathematical operations library (used by Governance)
- `utils/UniqueArray.sol` - Array validation utilities (used by Governance)
- `utils/SafeCallMinGas.sol` - Safe external call wrapper (used by Governance)

## Additional Initiative Implementations

While not deployed in Setup.sol, these are part of the system and should be covered:

- `CurveV2GaugeRewards.sol` - Initiative for Curve V2 gauge rewards (extends BribeInitiative)
- `UniV4MerklRewards.sol` - Initiative for Uniswap V4 Merkl rewards (implements IInitiative)

## Summary

**Total Contracts to Cover: 13**

### Breakdown:
- Core contracts: 4
- Utility contracts: 7
- Additional initiatives: 2

## Notes

- Mock contracts (MockERC20Tester, MockStakingV1) are excluded from coverage requirements
- OpenZeppelin contracts (IERC20, SafeERC20, ReentrancyGuard, Clones) are excluded as they are standard library code
- External protocol interfaces (ILQTYStaking, ICurveStableswapNG, etc.) are excluded as they represent external systems
- Type definition files (utils/Types.sol) contain only struct/constant definitions and may not require active coverage tracking
