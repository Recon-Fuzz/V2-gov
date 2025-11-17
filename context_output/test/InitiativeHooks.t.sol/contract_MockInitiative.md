# Contract: MockInitiative

## Metadata

- **Name**: MockInitiative
- **Type**: Contract
- **Path**: test/InitiativeHooks.t.sol

## Implements Interfaces

- **IInitiative** [src/interfaces/IInitiative.sol/interface_IInitiative.md]

## State Variables

### onAfterAllocateLQTYCalls

```solidity
OnAfterAllocateLQTYParams[] public onAfterAllocateLQTYCalls
```

## Structs

### OnAfterAllocateLQTYParams

```solidity
struct OnAfterAllocateLQTYParams {
    uint256 currentEpoch;
    address user;
    IGovernance.UserState userState;
    IGovernance.Allocation allocation;
    IGovernance.InitiativeState initiativeStat;
}
```

## Public/External Functions

### numOnAfterAllocateLQTYCalls()

- **Signature**: `numOnAfterAllocateLQTYCalls()`
- **Visibility**: external
- **Source Range**: 771:126:101
- **Details**: [function_numOnAfterAllocateLQTYCalls.md](./function_numOnAfterAllocateLQTYCalls.md)

**Signature:**
```solidity
function numOnAfterAllocateLQTYCalls() external view returns (uint256);
```

### onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 903:434:101
- **Details**: [function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md](./function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md)

**Signature:**
```solidity
function onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState calldata _userState, IGovernance.Allocation calldata _allocation, IGovernance.InitiativeState calldata _initiativeState) override external;
```

### onRegisterInitiative(uint256)

- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 1343:59:101
- **Details**: [function_onRegisterInitiative_uint256.md](./function_onRegisterInitiative_uint256.md)

**Signature:**
```solidity
function onRegisterInitiative(uint256) override external;
```

### onUnregisterInitiative(uint256)

- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 1407:61:101
- **Details**: [function_onUnregisterInitiative_uint256.md](./function_onUnregisterInitiative_uint256.md)

**Signature:**
```solidity
function onUnregisterInitiative(uint256) override external;
```

### onClaimForInitiative(uint256,uint256)

- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1473:68:101
- **Details**: [function_onClaimForInitiative_uint256_uint256.md](./function_onClaimForInitiative_uint256_uint256.md)

**Signature:**
```solidity
function onClaimForInitiative(uint256, uint256) override external;
```
