# Contract: MaliciousInitiative

## Metadata

- **Name**: MaliciousInitiative
- **Type**: Contract
- **Path**: test/mocks/MaliciousInitiative.sol

## Implements Interfaces

- **IInitiative** [src/interfaces/IInitiative.sol/interface_IInitiative.md]

## State Variables

### revertBehaviours

```solidity
mapping(FunctionType => RevertType) internal revertBehaviours
```

## Enums

### FunctionType

```solidity
enum FunctionType {
    NONE,
    REGISTER,
    UNREGISTER,
    ALLOCATE,
    CLAIM
}
```

### RevertType

```solidity
enum RevertType {
    NONE,
    THROW,
    OOG,
    RETURN_BOMB,
    REVERT_BOMB
}
```

## Public/External Functions

### setRevertBehaviour(enum MaliciousInitiative.FunctionType,enum MaliciousInitiative.RevertType)

- **Signature**: `setRevertBehaviour(enum MaliciousInitiative.FunctionType,enum MaliciousInitiative.RevertType)`
- **Visibility**: external
- **Source Range**: 574:111:109
- **Details**: [function_setRevertBehaviour_enum_MaliciousInitiative.FunctionType_enum_MaliciousInitiative.RevertType.md](./function_setRevertBehaviour_enum_MaliciousInitiative.FunctionType_enum_MaliciousInitiative.RevertType.md)

**Signature:**
```solidity
/// @dev specify the revert behaviour on each function
function setRevertBehaviour(FunctionType ft, RevertType rt) external;
```

### onRegisterInitiative(uint256)

- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 720:143:109
- **Details**: [function_onRegisterInitiative_uint256.md](./function_onRegisterInitiative_uint256.md)

**Signature:**
```solidity
function onRegisterInitiative(uint256) override external view;
```

### onUnregisterInitiative(uint256)

- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 869:147:109
- **Details**: [function_onUnregisterInitiative_uint256.md](./function_onUnregisterInitiative_uint256.md)

**Signature:**
```solidity
function onUnregisterInitiative(uint256) override external view;
```

### onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 1022:300:109
- **Details**: [function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md](./function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md)

**Signature:**
```solidity
function onAfterAllocateLQTY(uint256, address, IGovernance.UserState calldata, IGovernance.Allocation calldata, IGovernance.InitiativeState calldata) override external view;
```

### onClaimForInitiative(uint256,uint256)

- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1328:149:109
- **Details**: [function_onClaimForInitiative_uint256_uint256.md](./function_onClaimForInitiative_uint256_uint256.md)

**Signature:**
```solidity
function onClaimForInitiative(uint256, uint256) override external view;
```
