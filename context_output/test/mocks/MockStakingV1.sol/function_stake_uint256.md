# Function: stake(uint256)

**Contract**: [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]

## Metadata

- **Contract**: MockStakingV1
- **Signature**: `stake(uint256)`
- **Visibility**: external
- **Source Range**: 1518:488:113

## Implementation

```solidity
function stake(uint256 amount) override external {
    require(amount > 0, "LQTYStaking: Amount must be non-zero");
    uint256 oldStake = stakes[msg.sender];
    (uint256 lusdGain, uint256 ethGain) = (oldStake > 0) ? _resetGains() : (0, 0);
    stakes[msg.sender] += amount;
    totalLQTYStaked += amount;
    _stakers.add(msg.sender);
    _lqty.transferFrom(msg.sender, address(this), amount);
    if (oldStake > 0) _payoutGains(lusdGain, ethGain);
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

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8316:150:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2241:406:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._positions[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4264:129:54
- **Link**: `lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._positions[value] != 0;
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

- **IERC20::transferFrom(address,address,uint256)**

## State Variable Reads

- **stakes** (`mapping(address => uint256)`)
- **_lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_pendingLUSDGain** (`mapping(address => uint256)`)
- **_pendingETHGain** (`mapping(address => uint256)`)
- **_lusd** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **stakes** (`mapping(address => uint256)`)
- **totalLQTYStaked** (`uint256`)
- **_stakers** (`struct EnumerableSet.AddressSet`)
- **_pendingLUSDGain** (`mapping(address => uint256)`)
- **_pendingETHGain** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStakingV1.stake(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MockStakingV1._resetGains() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 2)
  │   💬 Args: [_stakers, msg.sender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 3)
  │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 4)
  │       💬 Args: [set, value]
  │       👁️  Def: private
  └─ [1] ⚙️ FUNCTION: MockStakingV1._payoutGains(uint256,uint256) (NodeID: 5)
      💬 Args: [lusdGain, ethGain]
      👁️  Def: internal
```
