# Contract: MockInitiative

## Metadata

- **Name**: MockInitiative
- **Type**: Contract
- **Path**: test/mocks/MockInitiative.sol

## Implements Interfaces

- **IInitiative** [src/interfaces/IInitiative.sol/interface_IInitiative.md]

## State Variables

### governance

```solidity
IGovernance public immutable governance
```

**IGovernance**: [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 282:87:112
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address _governance);
```

### onRegisterInitiative(uint256)

- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 407:123:112
- **Details**: [function_onRegisterInitiative_uint256.md](./function_onRegisterInitiative_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onRegisterInitiative(uint256) virtual override external;
```

### onUnregisterInitiative(uint256)

- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 568:127:112
- **Details**: [function_onUnregisterInitiative_uint256.md](./function_onUnregisterInitiative_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onUnregisterInitiative(uint256) virtual override external;
```

### onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 733:484:112
- **Details**: [function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md](./function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onAfterAllocateLQTY(uint256, address, IGovernance.UserState calldata, IGovernance.Allocation calldata, IGovernance.InitiativeState calldata) virtual external;
```

### onClaimForInitiative(uint256,uint256)

- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1255:132:112
- **Details**: [function_onClaimForInitiative_uint256_uint256.md](./function_onClaimForInitiative_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onClaimForInitiative(uint256, uint256) virtual override external;
```
