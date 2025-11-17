# Function: unstake(uint256)

**Contract**: [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]

## Metadata

- **Contract**: MockStakingV1
- **Signature**: `unstake(uint256)`
- **Visibility**: external
- **Source Range**: 2012:536:113

## Implementation

```solidity
function unstake(uint256 amount) override external {
    require(stakes[msg.sender] > 0, "LQTYStaking: User must have a non-zero stake");
    (uint256 lusdGain, uint256 ethGain) = _resetGains();
    if (amount > 0) {
        uint256 withdrawn = Math.min(amount, stakes[msg.sender]);
        if ((stakes[msg.sender] -= withdrawn) == 0) _stakers.remove(msg.sender);
        totalLQTYStaked -= withdrawn;
        _lqty.transfer(msg.sender, withdrawn);
    }
    _payoutGains(lusdGain, ethGain);
}
```

## Related Implementations

### _resetGains()

- **Kind**: internal
- **Source**: 984:263:113
- **Link**: `test/mocks/MockStakingV1.sol:MockStakingV1:_resetGains()`

```solidity
function _resetGains() internal returns (uint256 lusdGain, uint256 ethGain) {
    lusdGain = _pendingLUSDGain[msg.sender];
    ethGain = _pendingETHGain[msg.sender];
    _pendingLUSDGain[msg.sender] = 0;
    _pendingETHGain[msg.sender] = 0;
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 2557:104:52
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
}
```

### remove(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8634:156:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:remove(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function remove(AddressSet storage set, address value) internal returns (bool) {
    return _remove(set._inner, bytes32(uint256(uint160(value))));
}
```

### _remove(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2815:1368:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_remove(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Removes a value from a set. O(1).
///  Returns true if the value was removed from the set, that is if it was
///  present.
function _remove(Set storage set, bytes32 value) private returns (bool) {
    uint256 position = set._positions[value];
    if (position != 0) {
        uint256 valueIndex = position - 1;
        uint256 lastIndex = set._values.length - 1;
        if (valueIndex != lastIndex) {
            bytes32 lastValue = set._values[lastIndex];
            set._values[valueIndex] = lastValue;
            set._positions[lastValue] = position;
        }
        set._values.pop();
        delete set._positions[value];
        return true;
    } else {
        return false;
    }
}
```

### _payoutGains(uint256,uint256)

- **Kind**: internal
- **Source**: 1253:259:113
- **Link**: `test/mocks/MockStakingV1.sol:MockStakingV1:_payoutGains(uint256,uint256)`

```solidity
function _payoutGains(uint256 lusdGain, uint256 ethGain) internal {
    _lusd.transfer(msg.sender, lusdGain);
    (bool success, ) = msg.sender.call{value: ethGain}("");
    require(success, "LQTYStaking: Failed to send accumulated ETHGain");
}
```

## External Calls

- **IERC20::transfer(address,uint256)**

## Native Transfers

- **_lqty** (state variable) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Reads

- **stakes** (`mapping(address => uint256)`)
- **_lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_pendingLUSDGain** (`mapping(address => uint256)`)
- **_pendingETHGain** (`mapping(address => uint256)`)
- **_lusd** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **stakes** (`mapping(address => uint256)`)
- **_stakers** (`struct EnumerableSet.AddressSet`)
- **totalLQTYStaked** (`uint256`)
- **_pendingLUSDGain** (`mapping(address => uint256)`)
- **_pendingETHGain** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStakingV1.unstake(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MockStakingV1._resetGains() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 2)
  │   💬 Args: [amount, stakes[msg.sender]]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.remove(struct EnumerableSet.AddressSet,address) (NodeID: 3)
  │   💬 Args: [_stakers, msg.sender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._remove(struct EnumerableSet.Set,bytes32) (NodeID: 4)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: MockStakingV1._payoutGains(uint256,uint256) (NodeID: 5)
      💬 Args: [lusdGain, ethGain]
      👁️  Def: internal
```
