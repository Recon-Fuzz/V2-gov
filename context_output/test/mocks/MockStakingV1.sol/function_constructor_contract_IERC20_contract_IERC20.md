# Function: constructor(contract IERC20,contract IERC20)

**Contract**: [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]

## Metadata

- **Contract**: MockStakingV1
- **Signature**: `constructor(contract IERC20,contract IERC20)`
- **Visibility**: public
- **Source Range**: 869:109:113

## Implementation

```solidity
constructor(IERC20 lqty, IERC20 lusd) Ownable(msg.sender) {
    _lqty = lqty;
    _lusd = lusd;
}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 1225:187:31
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting the address provided by the deployer as the initial owner.
constructor(address initialOwner) {
    if (initialOwner == address(0)) {
        revert OwnableInvalidOwner(address(0));
    }
    _transferOwnership(initialOwner);
}
```

### _transferOwnership(address)

- **Kind**: internal
- **Source**: 2912:187:31
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_transferOwnership(address)`

```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Internal function without access restriction.
function _transferOwnership(address newOwner) virtual internal {
    address oldOwner = _owner;
    _owner = newOwner;
    emit OwnershipTransferred(oldOwner, newOwner);
}
```

## State Variable Reads

- **_owner** (`address`)

## State Variable Writes

- **_lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_lusd** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockStakingV1.constructor(contract IERC20,contract IERC20) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockStakingV1
  └─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 1)
      💬 Args: [msg.sender]
      🏗️  Contract: Ownable
    └─ [2] ⚙️ FUNCTION: Ownable._transferOwnership(address) (NodeID: 2)
        💬 Args: [initialOwner]
        👁️  Def: internal
```
