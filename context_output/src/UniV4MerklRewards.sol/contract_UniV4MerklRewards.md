# Contract: UniV4MerklRewards

## Metadata

- **Name**: UniV4MerklRewards
- **Type**: Contract
- **Path**: src/UniV4MerklRewards.sol

## Implements Interfaces

- **IInitiative** [src/interfaces/IInitiative.sol/interface_IInitiative.md]

## State Variables

### LIQUITY_FUNDS_SAFE

```solidity
address public constant LIQUITY_FUNDS_SAFE = address(0xF06016D822943C42e3Cb7FC3a6A3B1889C1045f8)
```

### CAMPAIGN_TYPE

```solidity
uint32 public constant CAMPAIGN_TYPE = 13
```

### merklDistributionCreator

```solidity
IDistributionCreator internal constant merklDistributionCreator = IDistributionCreator(0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd)
```

**IDistributionCreator**: [src/interfaces/IDistributionCreator.sol/interface_IDistributionCreator.md]

### governance

```solidity
IGovernance public immutable governance
```

**IGovernance**: [src/interfaces/IGovernance.sol/interface_IGovernance.md]

### boldToken

```solidity
IERC20 public immutable boldToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### CAMPAIGN_BOLD_AMOUNT_THRESHOLD

```solidity
uint256 public immutable CAMPAIGN_BOLD_AMOUNT_THRESHOLD
```

### IS_OUT_OF_RANGE_INCENTIVIZED

```solidity
bool internal constant IS_OUT_OF_RANGE_INCENTIVIZED = false
```

### UNIV4_POOL_ID

```solidity
bytes32 public immutable UNIV4_POOL_ID
```

### WEIGHT_FEES

```solidity
uint32 public immutable WEIGHT_FEES
```

### WEIGHT_TOKEN_0

```solidity
uint32 public immutable WEIGHT_TOKEN_0
```

### WEIGHT_TOKEN_1

```solidity
uint32 public immutable WEIGHT_TOKEN_1
```

### EPOCH_START

```solidity
uint256 internal immutable EPOCH_START
```

### EPOCH_DURATION

```solidity
uint256 internal immutable EPOCH_DURATION
```

## Events

### NewMerklCampaign

```solidity
event NewMerklCampaign(uint256 indexed claimEpoch, uint256 boldAmount, bytes32 campaingId);
```

## Public/External Functions

### constructor(address,address,uint256,bytes32,uint32,uint32,uint32)

- **Signature**: `constructor(address,address,uint256,bytes32,uint32,uint32,uint32)`
- **Visibility**: public
- **Source Range**: 1525:1026:68
- **Details**: [function_constructor_address_address_uint256_bytes32_uint32_uint32_uint32.md](./function_constructor_address_address_uint256_bytes32_uint32_uint32_uint32.md)

**Signature:**
```solidity
constructor(address _governanceAddress, address _boldTokenAddress, uint256 _campaignBoldAmountThreshold, bytes32 _uniV4PoolId, uint32 _weightFees, uint32 _weightToken0, uint32 _weightToken1);
```

### getCampaignData()

- **Signature**: `getCampaignData()`
- **Visibility**: public
- **Source Range**: 2557:1071:68
- **Details**: [function_getCampaignData.md](./function_getCampaignData.md)

**Signature:**
```solidity
function getCampaignData() public view returns (bytes memory);
```

### onRegisterInitiative(uint256)

- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 3634:68:68
- **Details**: [function_onRegisterInitiative_uint256.md](./function_onRegisterInitiative_uint256.md)

**Signature:**
```solidity
function onRegisterInitiative(uint256 _atEpoch) override external;
```

### onUnregisterInitiative(uint256)

- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 3875:70:68
- **Details**: [function_onUnregisterInitiative_uint256.md](./function_onUnregisterInitiative_uint256.md)

**Signature:**
```solidity
/// @notice Callback hook that is called by Governance after the initiative was unregistered
///  @param _atEpoch Epoch at which the initiative is unregistered
function onUnregisterInitiative(uint256 _atEpoch) override external;
```

### onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 4362:276:68
- **Details**: [function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md](./function_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md)

**Signature:**
```solidity
/// @notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
///  @param _currentEpoch Epoch at which the LQTY allocation is updated
///  @param _user Address of the user that updated their LQTY allocation
///  @param _userState User state
///  @param _allocation Allocation state from user to initiative
///  @param _initiativeState Initiative state
function onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState calldata _userState, IGovernance.Allocation calldata _allocation, IGovernance.InitiativeState calldata _initiativeState) override external;
```

### onClaimForInitiative(uint256,uint256)

- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4905:101:68
- **Details**: [function_onClaimForInitiative_uint256_uint256.md](./function_onClaimForInitiative_uint256_uint256.md)

**Signature:**
```solidity
/// @notice Callback hook that is called by Governance after the claim for the last epoch was distributed
///  to the initiative
///  @param _claimEpoch Epoch at which the claim was distributed
///  @param _bold Amount of BOLD that was distributed
function onClaimForInitiative(uint256 _claimEpoch, uint256 _bold) override external onlyGovernance();
```

### claimForInitiative()

- **Signature**: `claimForInitiative()`
- **Visibility**: external
- **Source Range**: 6030:340:68
- **Details**: [function_claimForInitiative.md](./function_claimForInitiative.md)

**Signature:**
```solidity
function claimForInitiative() external;
```
