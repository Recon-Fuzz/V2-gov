# Function: mock_addLUSDGain(uint256)

**Contract**: [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]

## Metadata

- **Contract**: MockStakingV1
- **Signature**: `mock_addLUSDGain(uint256)`
- **Visibility**: external
- **Source Range**: 3030:466:113

## Implementation

```solidity
function mock_addLUSDGain(uint256 amount) external onlyOwner() {
    uint256 numStakers = _stakers.length();
    assert((numStakers == 0) || (totalLQTYStaked > 0));
    for (uint256 i = 0; i < numStakers; ++i) {
        address staker = _stakers.at(i);
        assert(stakes[staker] > 0);
        _pendingLUSDGain[staker] += (amount * stakes[staker]) / totalLQTYStaked;
    }
    _lusd.transferFrom(msg.sender, address(this), amount);
}
```

## Related Implementations

### length(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 9117:115:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:length(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Returns the number of values in the set. O(1).
function length(AddressSet storage set) internal view returns (uint256) {
    return _length(set._inner);
}
```

### _length(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 4474:107:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_length(struct EnumerableSet.Set)`

```solidity
///  @dev Returns the number of values on the set. O(1).
function _length(Set storage set) private view returns (uint256) {
    return set._values.length;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 9574:156:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 4923:118:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
}
```

### onlyOwner()

- **Kind**: modifier
- **Source**: 1500:62:31
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:onlyOwner()`

```solidity
///  @dev Throws if called by any account other than the owner.
modifier onlyOwner() {
    _checkOwner();
    _;
}
```

### _checkOwner()

- **Kind**: internal
- **Source**: 1796:162:31
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_checkOwner()`

```solidity
///  @dev Throws if the sender is not the owner.
function _checkOwner() virtual internal view {
    if (owner() != _msgSender()) {
        revert OwnableUnauthorizedAccount(_msgSender());
    }
}
```

### _msgSender()

- **Kind**: internal
- **Source**: 656:96:43
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Context.sol:Context:_msgSender()`

```solidity
function _msgSender() virtual internal view returns (address) {
    return msg.sender;
}
```

### owner()

- **Kind**: internal
- **Source**: 1638:85:31
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:owner()`

```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address) {
    return _owner;
}
```

## External Calls

- **IERC20::transferFrom(address,address,uint256)**

## State Variable Reads

- **_stakers** (`struct EnumerableSet.AddressSet`)
- **totalLQTYStaked** (`uint256`)
- **stakes** (`mapping(address => uint256)`)
- **_lusd** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_owner** (`address`)

## State Variable Writes

- **_pendingLUSDGain** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStakingV1.mock_addLUSDGain(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.length(struct EnumerableSet.AddressSet) (NodeID: 1)
  │   💬 Args: [_stakers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._length(struct EnumerableSet.Set) (NodeID: 2)
  │     💬 Args: [set._inner]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 3)
  │   💬 Args: [_stakers, i]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 4)
  │     💬 Args: [set._inner, index]
  │     👁️  Def: private
  └─ [1] 🔒 MODIFIER: Ownable.onlyOwner() (NodeID: 5)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: Ownable._checkOwner() (NodeID: 6)
        💬 Args: [no args]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 7)
      │   💬 Args: [no args]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Ownable.owner() (NodeID: 8)
      │   💬 Args: [no args]
      │   👁️  Def: public
      └─ [3] ⚙️ FUNCTION: Context._msgSender() (NodeID: 9)
          💬 Args: [no args]
          👁️  Def: internal
```
