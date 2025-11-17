# Contract: MockStakingV1

## Metadata

- **Name**: MockStakingV1
- **Type**: Contract
- **Path**: test/mocks/MockStakingV1.sol

## Implements Interfaces

- **ILQTYStaking** [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]

## State Variables

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### _lqty

```solidity
IERC20 internal immutable _lqty
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### _lusd

```solidity
IERC20 internal immutable _lusd
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### totalLQTYStaked

```solidity
uint256 public totalLQTYStaked
```

### _stakers

```solidity
EnumerableSet.AddressSet internal _stakers
```

### stakes

```solidity
mapping(address => uint256) public stakes
```

### _pendingLUSDGain

```solidity
mapping(address => uint256) internal _pendingLUSDGain
```

### _pendingETHGain

```solidity
mapping(address => uint256) internal _pendingETHGain
```

## Errors

### OwnableUnauthorizedAccount (inherited from Ownable)

```solidity
///  @dev The caller account is not authorized to perform an operation.
error OwnableUnauthorizedAccount(address account);
```

### OwnableInvalidOwner (inherited from Ownable)

```solidity
///  @dev The owner is not a valid owner account. (eg. `address(0)`)
error OwnableInvalidOwner(address owner);
```

## Events

### LQTYTokenAddressSet (inherited from ILQTYStaking)

```solidity
event LQTYTokenAddressSet(address _lqtyTokenAddress);
```

### LUSDTokenAddressSet (inherited from ILQTYStaking)

```solidity
event LUSDTokenAddressSet(address _lusdTokenAddress);
```

### TroveManagerAddressSet (inherited from ILQTYStaking)

```solidity
event TroveManagerAddressSet(address _troveManager);
```

### BorrowerOperationsAddressSet (inherited from ILQTYStaking)

```solidity
event BorrowerOperationsAddressSet(address _borrowerOperationsAddress);
```

### ActivePoolAddressSet (inherited from ILQTYStaking)

```solidity
event ActivePoolAddressSet(address _activePoolAddress);
```

### StakeChanged (inherited from ILQTYStaking)

```solidity
event StakeChanged(address indexed staker, uint256 newStake);
```

### StakingGainsWithdrawn (inherited from ILQTYStaking)

```solidity
event StakingGainsWithdrawn(address indexed staker, uint256 LUSDGain, uint256 ETHGain);
```

### F_ETHUpdated (inherited from ILQTYStaking)

```solidity
event F_ETHUpdated(uint256 _F_ETH);
```

### F_LUSDUpdated (inherited from ILQTYStaking)

```solidity
event F_LUSDUpdated(uint256 _F_LUSD);
```

### TotalLQTYStakedUpdated (inherited from ILQTYStaking)

```solidity
event TotalLQTYStakedUpdated(uint256 _totalLQTYStaked);
```

### EtherSent (inherited from ILQTYStaking)

```solidity
event EtherSent(address _account, uint256 _amount);
```

### StakerSnapshotsUpdated (inherited from ILQTYStaking)

```solidity
event StakerSnapshotsUpdated(address _staker, uint256 _F_ETH, uint256 _F_LUSD);
```

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

## Public/External Functions

### constructor(contract IERC20,contract IERC20)

- **Signature**: `constructor(contract IERC20,contract IERC20)`
- **Visibility**: public
- **Source Range**: 869:109:113
- **Details**: [function_constructor_contract_IERC20_contract_IERC20.md](./function_constructor_contract_IERC20_contract_IERC20.md)

**Signature:**
```solidity
constructor(IERC20 lqty, IERC20 lusd) Ownable(msg.sender);
```

### stake(uint256)

- **Signature**: `stake(uint256)`
- **Visibility**: external
- **Source Range**: 1518:488:113
- **Details**: [function_stake_uint256.md](./function_stake_uint256.md)

**Signature:**
```solidity
function stake(uint256 amount) override external;
```

### unstake(uint256)

- **Signature**: `unstake(uint256)`
- **Visibility**: external
- **Source Range**: 2012:536:113
- **Details**: [function_unstake_uint256.md](./function_unstake_uint256.md)

**Signature:**
```solidity
function unstake(uint256 amount) override external;
```

### getPendingLUSDGain(address)

- **Signature**: `getPendingLUSDGain(address)`
- **Visibility**: external
- **Source Range**: 2554:129:113
- **Details**: [function_getPendingLUSDGain_address.md](./function_getPendingLUSDGain_address.md)

**Signature:**
```solidity
function getPendingLUSDGain(address user) override external view returns (uint256);
```

### getPendingETHGain(address)

- **Signature**: `getPendingETHGain(address)`
- **Visibility**: external
- **Source Range**: 2689:127:113
- **Details**: [function_getPendingETHGain_address.md](./function_getPendingETHGain_address.md)

**Signature:**
```solidity
function getPendingETHGain(address user) override external view returns (uint256);
```

### setAddresses(address,address,address,address,address)

- **Signature**: `setAddresses(address,address,address,address,address)`
- **Visibility**: external
- **Source Range**: 2822:87:113
- **Details**: [function_setAddresses_address_address_address_address_address.md](./function_setAddresses_address_address_address_address_address.md)

**Signature:**
```solidity
function setAddresses(address, address, address, address, address) override external;
```

### increaseF_ETH(uint256)

- **Signature**: `increaseF_ETH(uint256)`
- **Visibility**: external
- **Source Range**: 2914:52:113
- **Details**: [function_increaseF_ETH_uint256.md](./function_increaseF_ETH_uint256.md)

**Signature:**
```solidity
function increaseF_ETH(uint256) override external;
```

### increaseF_LUSD(uint256)

- **Signature**: `increaseF_LUSD(uint256)`
- **Visibility**: external
- **Source Range**: 2971:53:113
- **Details**: [function_increaseF_LUSD_uint256.md](./function_increaseF_LUSD_uint256.md)

**Signature:**
```solidity
function increaseF_LUSD(uint256) override external;
```

### mock_addLUSDGain(uint256)

- **Signature**: `mock_addLUSDGain(uint256)`
- **Visibility**: external
- **Source Range**: 3030:466:113
- **Details**: [function_mock_addLUSDGain_uint256.md](./function_mock_addLUSDGain_uint256.md)

**Signature:**
```solidity
function mock_addLUSDGain(uint256 amount) external onlyOwner();
```

### mock_addETHGain()

- **Signature**: `mock_addETHGain()`
- **Visibility**: external
- **Source Range**: 3502:397:113
- **Details**: [function_mock_addETHGain.md](./function_mock_addETHGain.md)

**Signature:**
```solidity
function mock_addETHGain() external payable onlyOwner();
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1638:85:31
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address);
```

### renounceOwnership() (inherited from Ownable)

- **Signature**: `renounceOwnership()`
- **Visibility**: public
- **Source Range**: 2293:101:31
- **Details**: [function_renounceOwnership.md](./function_renounceOwnership.md)

**Signature:**
```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions. Can only be called by the current owner.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby disabling any functionality that is only available to the owner.
function renounceOwnership() virtual public onlyOwner();
```

### transferOwnership(address) (inherited from Ownable)

- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 2543:215:31
- **Details**: [function_transferOwnership_address.md](./function_transferOwnership_address.md)

**Signature:**
```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Can only be called by the current owner.
function transferOwnership(address newOwner) virtual public onlyOwner();
```
