# Contract: BribeInitiative

## Metadata

- **Name**: BribeInitiative
- **Type**: Contract
- **Path**: src/BribeInitiative.sol

## Implements Interfaces

- **IBribeInitiative** [src/interfaces/IBribeInitiative.sol/interface_IBribeInitiative.md]
- **IInitiative** [src/interfaces/IInitiative.sol/interface_IInitiative.md]

## State Variables

### EPOCH_START

```solidity
uint256 internal immutable EPOCH_START
```

### EPOCH_DURATION

```solidity
uint256 internal immutable EPOCH_DURATION
```

### governance

```solidity
/// @inheritdoc IBribeInitiative
IGovernance public immutable governance
```

**IGovernance**: [src/interfaces/IGovernance.sol/interface_IGovernance.md]

### bold

```solidity
/// @inheritdoc IBribeInitiative
IERC20 public immutable bold
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### bribeToken

```solidity
/// @inheritdoc IBribeInitiative
IERC20 public immutable bribeToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### bribeByEpoch

```solidity
/// @inheritdoc IBribeInitiative
mapping(uint256 => Bribe) public bribeByEpoch
```

### claimedBribeAtEpoch

```solidity
/// @inheritdoc IBribeInitiative
mapping(address => mapping(uint256 => bool)) public claimedBribeAtEpoch
```

### totalLQTYAllocationByEpoch

```solidity
/// Double linked list of the total LQTY allocated at a given epoch
DoubleLinkedList.List internal totalLQTYAllocationByEpoch
```

### lqtyAllocationByUserAtEpoch

```solidity
/// Double linked list of LQTY allocated by a user at a given epoch
mapping(address => DoubleLinkedList.List) internal lqtyAllocationByUserAtEpoch
```

## Structs

### Bribe (inherited from IBribeInitiative)

```solidity
struct Bribe {
    uint256 remainingBoldAmount;
    uint256 remainingBribeTokenAmount;
    uint256 claimedVotes;
}
```

### ClaimData (inherited from IBribeInitiative)

```solidity
struct ClaimData {
    uint256 epoch;
    uint256 prevLQTYAllocationEpoch;
    uint256 prevTotalLQTYAllocationEpoch;
}
```

## Events

### DepositBribe (inherited from IBribeInitiative)

```solidity
event DepositBribe(address depositor, uint256 boldAmount, uint256 bribeTokenAmount, uint256 epoch);
```

### ModifyLQTYAllocation (inherited from IBribeInitiative)

```solidity
event ModifyLQTYAllocation(address user, uint256 epoch, uint256 lqtyAllocated, uint256 offset);
```

### ModifyTotalLQTYAllocation (inherited from IBribeInitiative)

```solidity
event ModifyTotalLQTYAllocation(uint256 epoch, uint256 totalLQTYAllocated, uint256 offset);
```

### ClaimBribe (inherited from IBribeInitiative)

```solidity
event ClaimBribe(address user, uint256 epoch, uint256 boldAmount, uint256 bribeTokenAmount);
```

## Public/External Functions

### constructor(address,address,address)

- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 1506:385:65
- **Details**: [function_constructor_address_address_address.md](./function_constructor_address_address_address.md)

**Signature:**
```solidity
constructor(address _governance, address _bold, address _bribeToken);
```

### totalLQTYAllocatedByEpoch(uint256)

- **Signature**: `totalLQTYAllocatedByEpoch(uint256)`
- **Visibility**: external
- **Source Range**: 2071:382:65
- **Details**: [function_totalLQTYAllocatedByEpoch_uint256.md](./function_totalLQTYAllocatedByEpoch_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function totalLQTYAllocatedByEpoch(uint256 _epoch) external view returns (uint256, uint256, uint256, uint256);
```

### lqtyAllocatedByUserAtEpoch(address,uint256)

- **Signature**: `lqtyAllocatedByUserAtEpoch(address,uint256)`
- **Visibility**: external
- **Source Range**: 2496:458:65
- **Details**: [function_lqtyAllocatedByUserAtEpoch_address_uint256.md](./function_lqtyAllocatedByUserAtEpoch_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function lqtyAllocatedByUserAtEpoch(address _user, uint256 _epoch) external view returns (uint256, uint256, uint256, uint256);
```

### depositBribe(uint256,uint256,uint256)

- **Signature**: `depositBribe(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2997:599:65
- **Details**: [function_depositBribe_uint256_uint256_uint256.md](./function_depositBribe_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) external;
```

### claimBribes(struct IBribeInitiative.ClaimData[])

- **Signature**: `claimBribes(struct IBribeInitiative.ClaimData[])`
- **Visibility**: external
- **Source Range**: 6303:732:65
- **Details**: [function_claimBribes_struct_IBribeInitiative.ClaimData[].md](./function_claimBribes_struct_IBribeInitiative.ClaimData[].md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function claimBribes(ClaimData[] calldata _claimData) external returns (uint256 boldAmount, uint256 bribeTokenAmount);
```

### onRegisterInitiative(uint256)

- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 7073:82:65
- **Details**: [function_onRegisterInitiative_uint256.md](./function_onRegisterInitiative_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onRegisterInitiative(uint256) virtual override external onlyGovernance();
```

### onUnregisterInitiative(uint256)

- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 7193:84:65
- **Details**: [function_onUnregisterInitiative_uint256.md](./function_onUnregisterInitiative_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onUnregisterInitiative(uint256) virtual override external onlyGovernance();
```

### getMostRecentUserEpoch(address)

- **Signature**: `getMostRecentUserEpoch(address)`
- **Visibility**: external
- **Source Range**: 8306:207:65
- **Details**: [function_getMostRecentUserEpoch_address.md](./function_getMostRecentUserEpoch_address.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function getMostRecentUserEpoch(address _user) external view returns (uint256);
```

### getMostRecentTotalEpoch()

- **Signature**: `getMostRecentTotalEpoch()`
- **Visibility**: external
- **Source Range**: 8556:189:65
- **Details**: [function_getMostRecentTotalEpoch.md](./function_getMostRecentTotalEpoch.md)

**Signature:**
```solidity
/// @inheritdoc IBribeInitiative
function getMostRecentTotalEpoch() external view returns (uint256);
```

### onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 8751:937:65
- **Details**: [function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md](./function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md)

**Signature:**
```solidity
function onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState calldata, IGovernance.Allocation calldata _allocation, IGovernance.InitiativeState calldata _initiativeState) virtual external onlyGovernance();
```

### onClaimForInitiative(uint256,uint256)

- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 9726:91:65
- **Details**: [function_onClaimForInitiative_uint256_uint256.md](./function_onClaimForInitiative_uint256_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IInitiative
function onClaimForInitiative(uint256, uint256) virtual override external onlyGovernance();
```
