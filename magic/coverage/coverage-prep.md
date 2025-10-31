# Coverage Preparation Analysis

This document contains context information for the smart contract system to determine which contracts are touched by the core contracts.

## Build Information

- Build Info File: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/out/build-info/6034cb0f0a66a712.json`
- Compiler: Solc 0.8.24
- Build Date: 2025-10-30

## Core Contracts Analysis

### 1. Governance.sol

**Inheritance Chain:**
- MultiDelegateCall
- UserProxyFactory
- ReentrancyGuard (OpenZeppelin)
- Ownable (custom)
- IGovernance

**Direct Dependencies:**
- `UserProxy.sol` - Deployed via UserProxyFactory
- `UserProxyFactory.sol` - Inherited
- `IInitiative.sol` - Interface for calling initiative hooks
- `ILQTYStaking.sol` - Interface for V1 staking interaction
- `utils/Math.sol` - Math operations library
- `utils/UniqueArray.sol` - Array validation functions
- `utils/MultiDelegateCall.sol` - Multi-call functionality
- `utils/Types.sol` - Type definitions
- `utils/SafeCallMinGas.sol` - Safe external call wrapper
- `utils/Ownable.sol` - Ownership management
- `utils/VotingPower.sol` - Voting power calculation

**External Calls:**
- Calls to ERC20 tokens (LQTY, LUSD, BOLD) via SafeERC20
- Calls to IInitiative implementations via hooks:
  - `onRegisterInitiative()`
  - `onUnregisterInitiative()`
  - `onAfterAllocateLQTY()`
  - `onClaimForInitiative()`
- Calls to UserProxy contracts for V1 staking operations
- Self delegatecalls via MultiDelegateCall

### 2. BribeInitiative.sol

**Inheritance Chain:**
- IInitiative
- IBribeInitiative

**Direct Dependencies:**
- `IGovernance.sol` - Interface for governance interaction
- `IInitiative.sol` - Initiative interface implementation
- `IBribeInitiative.sol` - Bribe-specific interface
- `utils/DoubleLinkedList.sol` - Data structure for tracking bribes
- `utils/VotingPower.sol` - Voting power calculation

**External Calls:**
- Calls to ERC20 tokens (BOLD, bribe token) via SafeERC20
- Calls to Governance contract to verify state

### 3. UserProxy.sol

**Direct Dependencies:**
- `IUserProxy.sol` - Interface definition
- `ILQTYStaking.sol` - V1 staking interface
- `utils/Types.sol` - Type definitions

**External Calls:**
- Calls to ERC20 tokens (LQTY, LUSD) via transfers
- Calls to StakingV1 contract:
  - `stake()`
  - `unstake()`
- ERC20Permit calls for gasless approvals

### 4. UserProxyFactory.sol

**Direct Dependencies:**
- `IUserProxyFactory.sol` - Interface definition
- `UserProxy.sol` - Implementation to clone
- `Clones.sol` (OpenZeppelin) - Minimal proxy pattern

**External Calls:**
- Deploys UserProxy clones via CREATE2

## Utility Contracts (Internal Libraries/Helpers)

These are touched by the core contracts and should be included in coverage:

### Internal Contract Dependencies:
- `utils/MultiDelegateCall.sol` - Used by Governance
- `utils/Ownable.sol` - Used by Governance
- `utils/DoubleLinkedList.sol` - Used by BribeInitiative
- `utils/VotingPower.sol` - Used by Governance and BribeInitiative
- `utils/Math.sol` - Used by Governance
- `utils/UniqueArray.sol` - Used by Governance
- `utils/SafeCallMinGas.sol` - Used by Governance
- `utils/Types.sol` - Used by multiple contracts

## Additional Initiative Implementations

While not in the Setup contract, these are also part of the system:

- `CurveV2GaugeRewards.sol` - Extends BribeInitiative
- `UniV4MerklRewards.sol` - Implements IInitiative

## External Contract Interactions (Interfaces Only)

These are external contracts that the system interacts with but are not part of the coverage requirements:

- IERC20 (OpenZeppelin) - Standard token interface
- IERC20Permit (OpenZeppelin) - Permit extension
- SafeERC20 (OpenZeppelin) - Safe transfer wrapper
- ReentrancyGuard (OpenZeppelin) - Reentrancy protection
- Clones (OpenZeppelin) - Minimal proxy implementation
- ILQTYStaking - V1 staking contract (external)
- ICurveStableswapFactoryNG - Curve integration (external)
- ICurveStableswapNG - Curve integration (external)
- IDistributionCreator - Merkl integration (external)
- ILiquidityGauge - Gauge integration (external)

## Summary of Contracts to Cover

Based on this analysis, the following contracts should be included in fuzzer coverage:

### Core System Contracts:
1. Governance.sol
2. BribeInitiative.sol
3. UserProxy.sol
4. UserProxyFactory.sol

### Utility Contracts (Libraries):
5. utils/MultiDelegateCall.sol
6. utils/Ownable.sol
7. utils/DoubleLinkedList.sol
8. utils/VotingPower.sol
9. utils/Math.sol
10. utils/UniqueArray.sol
11. utils/SafeCallMinGas.sol

### Additional Initiatives:
12. CurveV2GaugeRewards.sol
13. UniV4MerklRewards.sol
