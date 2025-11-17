# Function: test_allocateLQTY_fuzz_deltaLQTYVotes(uint256)

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_allocateLQTY_fuzz_deltaLQTYVotes(uint256)`
- **Visibility**: public
- **Source Range**: 51767:905:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_allocateLQTY_fuzz_deltaLQTYVotes(uint256 _deltaLQTYVotes) public {
    _deltaLQTYVotes = bound(_deltaLQTYVotes, 1, 100e6 ether);
    vm.startPrank(user);
    address userProxy = governance.deployUserProxy();
    deal(address(lqty), user, _deltaLQTYVotes);
    lqty.approve(address(userProxy), _deltaLQTYVotes);
    governance.depositLQTY(_deltaLQTYVotes);
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](1);
    initiatives[0] = baseInitiative1;
    int256[] memory deltaLQTYVotes = new int256[](1);
    deltaLQTYVotes[0] = int256(_deltaLQTYVotes);
    int256[] memory deltaLQTYVetos = new int256[](1);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    vm.stopPrank();
}
```

## Related Implementations

### bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2915:199:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:bound(uint256,uint256,uint256)`

```solidity
function bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    result = _bound(x, min, max);
    console2_log_StdUtils("Bound result", result);
}
```

### _bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1646:1263:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_bound(uint256,uint256,uint256)`

```solidity
function _bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    require(min <= max, "StdUtils bound(uint256,uint256,uint256): Max is less than min.");
    if ((x >= min) && (x <= max)) return x;
    uint256 size = (max - min) + 1;
    if ((x <= 3) && (size > x)) return min + x;
    if ((x >= (UINT256_MAX - 3)) && (size > (UINT256_MAX - x))) return max - (UINT256_MAX - x);
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = (min + rem) - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = (max - rem) + 1;
    }
}
```

### console2_log_StdUtils(string,uint256)

- **Kind**: internal
- **Source**: 10318:162:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:console2_log_StdUtils(string,uint256)`

```solidity
function console2_log_StdUtils(string memory p0, uint256 p1) private pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 9648:133:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 9407:235:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
}
```

### deal(address,address,uint256)

- **Kind**: internal
- **Source**: 26950:117:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256)`

```solidity
function deal(address token, address to, uint256 give) virtual internal {
    deal(token, to, give, false);
}
```

### deal(address,address,uint256,bool)

- **Kind**: internal
- **Source**: 27346:837:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,address,uint256,bool)`

```solidity
function deal(address token, address to, uint256 give, bool adjust) virtual internal {
    (, bytes memory balData) = token.staticcall(abi.encodeWithSelector(0x70a08231, to));
    uint256 prevBal = abi.decode(balData, (uint256));
    stdstore.target(token).sig(0x70a08231).with_key(to).checked_write(give);
    if (adjust) {
        (, bytes memory totSupData) = token.staticcall(abi.encodeWithSelector(0x18160ddd));
        uint256 totSup = abi.decode(totSupData, (uint256));
        if (give < prevBal) {
            totSup -= (prevBal - give);
        } else {
            totSup += (give - prevBal);
        }
        stdstore.target(token).sig(0x18160ddd).checked_write(totSup);
    }
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13258:156:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    return stdStorageSafe.target(self, _target);
}
```

### target(struct StdStorage,address)

- **Kind**: internal
- **Source**: 6747:156:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:target(struct StdStorage,address)`

```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage) {
    self._target = _target;
    return self;
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 13420:143:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    return stdStorageSafe.sig(self, _sig);
}
```

### sig(struct StdStorage,bytes4)

- **Kind**: internal
- **Source**: 6909:143:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:sig(struct StdStorage,bytes4)`

```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage) {
    self._sig = _sig;
    return self;
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 13725:152:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    return stdStorageSafe.with_key(self, who);
}
```

### with_key(struct StdStorage,address)

- **Kind**: internal
- **Source**: 7400:179:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:with_key(struct StdStorage,address)`

```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage) {
    self._keys.push(bytes32(uint256(uint160(who))));
    return self;
}
```

### checked_write(struct StdStorage,uint256)

- **Kind**: internal
- **Source**: 14946:120:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,uint256)`

```solidity
function checked_write(StdStorage storage self, uint256 amt) internal {
    checked_write(self, bytes32(amt));
}
```

### checked_write(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 15438:1484:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:checked_write(struct StdStorage,bytes32)`

```solidity
function checked_write(StdStorage storage self, bytes32 set) internal {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = stdStorageSafe.getCallParams(self);
    if (!self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        find(self, false);
    }
    FindData storage data = self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    if ((data.offsetLeft + data.offsetRight) > 0) {
        uint256 maxVal = 2 ** (256 - (data.offsetLeft + data.offsetRight));
        require(uint256(set) < maxVal, string(abi.encodePacked("stdStorage find(StdStorage): Packed slot. We can't fit value greater than ", vm.toString(maxVal))));
    }
    bytes32 curVal = vm.load(who, bytes32(data.slot));
    bytes32 valToSet = stdStorageSafe.getUpdatedSlotValue(curVal, uint256(set), data.offsetLeft, data.offsetRight);
    vm.store(who, bytes32(data.slot), valToSet);
    (bool success, bytes32 callResult) = stdStorageSafe.callTarget(self);
    if ((!success) || (callResult != set)) {
        vm.store(who, bytes32(data.slot), curVal);
        revert("stdStorage find(StdStorage): Failed to write value.");
    }
    clear(self);
}
```

### getCallParams(struct StdStorage)

- **Kind**: internal
- **Source**: 953:236:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getCallParams(struct StdStorage)`

```solidity
function getCallParams(StdStorage storage self) internal view returns (bytes memory) {
    if (self._calldata.length == 0) {
        return flatten(self._keys);
    } else {
        return self._calldata;
    }
}
```

### flatten(bytes32[])

- **Kind**: internal
- **Source**: 11186:393:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:flatten(bytes32[])`

```solidity
function flatten(bytes32[] memory b) private pure returns (bytes memory) {
    bytes memory result = new bytes(b.length * 32);
    for (uint256 i = 0; i < b.length; i++) {
        bytes32 k = b[i];
        /// @solidity memory-safe-assembly
        assembly {
            mstore(add(result, add(32, mul(32, i))), k)
        }
    }
    return result;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 13111:141:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:find(struct StdStorage,bool)`

```solidity
function find(StdStorage storage self, bool _clear) internal returns (uint256) {
    return stdStorageSafe.find(self, _clear).slot;
}
```

### find(struct StdStorage,bool)

- **Kind**: internal
- **Source**: 4249:2492:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:find(struct StdStorage,bool)`

```solidity
/// @notice find an arbitrary storage slot given a function sig, input data, address of the contract and a value to check against
function find(StdStorage storage self, bool _clear) internal returns (FindData storage) {
    address who = self._target;
    bytes4 fsig = self._sig;
    uint256 field_depth = self._depth;
    bytes memory params = getCallParams(self);
    if (self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found) {
        if (_clear) {
            clear(self);
        }
        return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
    }
    vm.record();
    (, bytes32 callResult) = callTarget(self);
    (bytes32[] memory reads, ) = vm.accesses(address(who));
    if (reads.length == 0) {
        revert("stdStorage find(StdStorage): No storage use detected for target.");
    } else {
        for (uint256 i = reads.length; (--i) >= 0; ) {
            bytes32 prev = vm.load(who, reads[i]);
            if (prev == bytes32(0)) {
                emit WARNING_UninitedSlot(who, uint256(reads[i]));
            }
            if (!checkSlotMutatesCall(self, reads[i])) {
                continue;
            }
            (uint256 offsetLeft, uint256 offsetRight) = (0, 0);
            if (self._enable_packed_slots) {
                bool found;
                (found, offsetLeft, offsetRight) = findOffsets(self, reads[i]);
                if (!found) {
                    continue;
                }
            }
            uint256 curVal = (uint256(prev) & getMaskByOffsets(offsetLeft, offsetRight)) >> offsetRight;
            if (uint256(callResult) != curVal) {
                continue;
            }
            emit SlotFound(who, fsig, keccak256(abi.encodePacked(params, field_depth)), uint256(reads[i]));
            self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))] = FindData(uint256(reads[i]), offsetLeft, offsetRight, true);
            break;
        }
    }
    require(self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))].found, "stdStorage find(StdStorage): Slot(s) not found.");
    if (_clear) {
        clear(self);
    }
    return self.finds[who][fsig][keccak256(abi.encodePacked(params, field_depth))];
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 11585:239:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    delete self._target;
    delete self._sig;
    delete self._keys;
    delete self._depth;
    delete self._enable_packed_slots;
    delete self._calldata;
}
```

### callTarget(struct StdStorage)

- **Kind**: internal
- **Source**: 1251:343:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:callTarget(struct StdStorage)`

```solidity
function callTarget(StdStorage storage self) internal view returns (bool, bytes32) {
    bytes memory cald = abi.encodePacked(self._sig, getCallParams(self));
    (bool success, bytes memory rdat) = self._target.staticcall(cald);
    bytes32 result = bytesToBytes32(rdat, 32 * self._depth);
    return (success, result);
}
```

### bytesToBytes32(bytes,uint256)

- **Kind**: internal
- **Source**: 10876:304:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:bytesToBytes32(bytes,uint256)`

```solidity
function bytesToBytes32(bytes memory b, uint256 offset) private pure returns (bytes32) {
    bytes32 out;
    uint256 max = (b.length > 32) ? 32 : b.length;
    for (uint256 i = 0; i < max; i++) {
        out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
}
```

### checkSlotMutatesCall(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 1851:546:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:checkSlotMutatesCall(struct StdStorage,bytes32)`

```solidity
function checkSlotMutatesCall(StdStorage storage self, bytes32 slot) internal returns (bool) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool success, bytes32 prevReturnValue) = callTarget(self);
    bytes32 testVal = (prevReturnValue == bytes32(0)) ? bytes32(UINT256_MAX) : bytes32(0);
    vm.store(self._target, slot, testVal);
    (, bytes32 newReturnValue) = callTarget(self);
    vm.store(self._target, slot, prevSlotValue);
    return (success && (prevReturnValue != newReturnValue));
}
```

### findOffsets(struct StdStorage,bytes32)

- **Kind**: internal
- **Source**: 3080:534:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffsets(struct StdStorage,bytes32)`

```solidity
function findOffsets(StdStorage storage self, bytes32 slot) internal returns (bool, uint256, uint256) {
    bytes32 prevSlotValue = vm.load(self._target, slot);
    (bool foundLeft, uint256 offsetLeft) = findOffset(self, slot, true);
    (bool foundRight, uint256 offsetRight) = findOffset(self, slot, false);
    vm.store(self._target, slot, prevSlotValue);
    return (foundLeft && foundRight, offsetLeft, offsetRight);
}
```

### findOffset(struct StdStorage,bytes32,bool)

- **Kind**: internal
- **Source**: 2560:514:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:findOffset(struct StdStorage,bytes32,bool)`

```solidity
function findOffset(StdStorage storage self, bytes32 slot, bool left) internal returns (bool, uint256) {
    for (uint256 offset = 0; offset < 256; offset++) {
        uint256 valueToPut = left ? (1 << (255 - offset)) : (1 << offset);
        vm.store(self._target, slot, bytes32(valueToPut));
        (bool success, bytes32 data) = callTarget(self);
        if (success && (uint256(data) > 0)) {
            return (true, offset);
        }
    }
    return (false, 0);
}
```

### getMaskByOffsets(uint256,uint256)

- **Kind**: internal
- **Source**: 12017:376:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getMaskByOffsets(uint256,uint256)`

```solidity
function getMaskByOffsets(uint256 offsetLeft, uint256 offsetRight) internal pure returns (uint256 mask) {
    assembly {
        mask := shl(offsetRight, sub(shl(sub(256, add(offsetRight, offsetLeft)), 1), 1))
    }
}
```

### getUpdatedSlotValue(bytes32,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 12455:300:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorageSafe:getUpdatedSlotValue(bytes32,uint256,uint256,uint256)`

```solidity
function getUpdatedSlotValue(bytes32 curValue, uint256 varValue, uint256 offsetLeft, uint256 offsetRight) internal pure returns (bytes32 newValue) {
    return bytes32((uint256(curValue) & (~getMaskByOffsets(offsetLeft, offsetRight))) | (varValue << offsetRight));
}
```

### clear(struct StdStorage)

- **Kind**: internal
- **Source**: 14704:92:16
- **Link**: `lib/forge-std/src/StdStorage.sol:stdStorage:clear(struct StdStorage)`

```solidity
function clear(StdStorage storage self) internal {
    stdStorageSafe.clear(self);
}
```

## External Calls

- **Vm::startPrank(address)**
- **GovernanceTester::deployUserProxy()**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **baseInitiative1** (`address`)
- **UINT256_MAX** (`uint256`)
- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_allocateLQTY_fuzz_deltaLQTYVotes(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [_deltaLQTYVotes, 1, 100e6 ether]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 3)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 6)
      💬 Args: [address(lqty), user, _deltaLQTYVotes]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 7)
        💬 Args: [token, to, give, false]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 8)
      │   💬 Args: [stdstore, token]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 9)
      │     💬 Args: [self, _target]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 10)
      │   💬 Args: [stdstore.target(token), 0x70a08231]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 11)
      │     💬 Args: [self, _sig]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 12)
      │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 13)
      │     💬 Args: [self, who]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 14)
      │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 15)
      │     💬 Args: [self, bytes32(amt)]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 16)
      │   │   💬 Args: [self]
      │   │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 17)
      │   │     💬 Args: [self._keys]
      │   │     👁️  Def: private
      │   ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 18)
      │   │   💬 Args: [self, false]
      │   │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 19)
      │   │     💬 Args: [self, _clear]
      │   │     👁️  Def: internal
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 20)
      │   │   │   💬 Args: [self]
      │   │   │   👁️  Def: internal
      │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 21)
      │   │   │     💬 Args: [self._keys]
      │   │   │     👁️  Def: private
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 22)
      │   │   │   💬 Args: [self]
      │   │   │   👁️  Def: internal
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 23)
      │   │   │   💬 Args: [self]
      │   │   │   👁️  Def: internal
      │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 24)
      │   │   │ │   💬 Args: [self]
      │   │   │ │   👁️  Def: internal
      │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 25)
      │   │   │ │     💬 Args: [self._keys]
      │   │   │ │     👁️  Def: private
      │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 26)
      │   │   │     💬 Args: [rdat, 32 * self._depth]
      │   │   │     👁️  Def: private
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 27)
      │   │   │   💬 Args: [self, reads[i]]
      │   │   │   👁️  Def: internal
      │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 28)
      │   │   │ │   💬 Args: [self]
      │   │   │ │   👁️  Def: internal
      │   │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 29)
      │   │   │ │ │   💬 Args: [self]
      │   │   │ │ │   👁️  Def: internal
      │   │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 30)
      │   │   │ │ │     💬 Args: [self._keys]
      │   │   │ │ │     👁️  Def: private
      │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 31)
      │   │   │ │     💬 Args: [rdat, 32 * self._depth]
      │   │   │ │     👁️  Def: private
      │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 32)
      │   │   │     💬 Args: [self]
      │   │   │     👁️  Def: internal
      │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 33)
      │   │   │   │   💬 Args: [self]
      │   │   │   │   👁️  Def: internal
      │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 34)
      │   │   │   │     💬 Args: [self._keys]
      │   │   │   │     👁️  Def: private
      │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 35)
      │   │   │       💬 Args: [rdat, 32 * self._depth]
      │   │   │       👁️  Def: private
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 36)
      │   │   │   💬 Args: [self, reads[i]]
      │   │   │   👁️  Def: internal
      │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 37)
      │   │   │ │   💬 Args: [self, slot, true]
      │   │   │ │   👁️  Def: internal
      │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 38)
      │   │   │ │     💬 Args: [self]
      │   │   │ │     👁️  Def: internal
      │   │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 39)
      │   │   │ │   │   💬 Args: [self]
      │   │   │ │   │   👁️  Def: internal
      │   │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 40)
      │   │   │ │   │     💬 Args: [self._keys]
      │   │   │ │   │     👁️  Def: private
      │   │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 41)
      │   │   │ │       💬 Args: [rdat, 32 * self._depth]
      │   │   │ │       👁️  Def: private
      │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 42)
      │   │   │     💬 Args: [self, slot, false]
      │   │   │     👁️  Def: internal
      │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 43)
      │   │   │       💬 Args: [self]
      │   │   │       👁️  Def: internal
      │   │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 44)
      │   │   │     │   💬 Args: [self]
      │   │   │     │   👁️  Def: internal
      │   │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 45)
      │   │   │     │     💬 Args: [self._keys]
      │   │   │     │     👁️  Def: private
      │   │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 46)
      │   │   │         💬 Args: [rdat, 32 * self._depth]
      │   │   │         👁️  Def: private
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 47)
      │   │   │   💬 Args: [offsetLeft, offsetRight]
      │   │   │   👁️  Def: internal
      │   │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 48)
      │   │       💬 Args: [self]
      │   │       👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 49)
      │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
      │   │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 50)
      │   │     💬 Args: [offsetLeft, offsetRight]
      │   │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 51)
      │   │   💬 Args: [self]
      │   │   👁️  Def: internal
      │   │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 52)
      │   │ │   💬 Args: [self]
      │   │ │   👁️  Def: internal
      │   │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 53)
      │   │ │     💬 Args: [self._keys]
      │   │ │     👁️  Def: private
      │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 54)
      │   │     💬 Args: [rdat, 32 * self._depth]
      │   │     👁️  Def: private
      │   └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 55)
      │       💬 Args: [self]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 56)
      │         💬 Args: [self]
      │         👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 57)
      │   💬 Args: [stdstore, token]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 58)
      │     💬 Args: [self, _target]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 59)
      │   💬 Args: [stdstore.target(token), 0x18160ddd]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 60)
      │     💬 Args: [self, _sig]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 61)
          💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 62)
            💬 Args: [self, bytes32(amt)]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 63)
          │   💬 Args: [self]
          │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 64)
          │     💬 Args: [self._keys]
          │     👁️  Def: private
          ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 65)
          │   💬 Args: [self, false]
          │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 66)
          │     💬 Args: [self, _clear]
          │     👁️  Def: internal
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 67)
          │   │   💬 Args: [self]
          │   │   👁️  Def: internal
          │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 68)
          │   │     💬 Args: [self._keys]
          │   │     👁️  Def: private
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 69)
          │   │   💬 Args: [self]
          │   │   👁️  Def: internal
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 70)
          │   │   💬 Args: [self]
          │   │   👁️  Def: internal
          │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 71)
          │   │ │   💬 Args: [self]
          │   │ │   👁️  Def: internal
          │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 72)
          │   │ │     💬 Args: [self._keys]
          │   │ │     👁️  Def: private
          │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 73)
          │   │     💬 Args: [rdat, 32 * self._depth]
          │   │     👁️  Def: private
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 74)
          │   │   💬 Args: [self, reads[i]]
          │   │   👁️  Def: internal
          │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 75)
          │   │ │   💬 Args: [self]
          │   │ │   👁️  Def: internal
          │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 76)
          │   │ │ │   💬 Args: [self]
          │   │ │ │   👁️  Def: internal
          │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 77)
          │   │ │ │     💬 Args: [self._keys]
          │   │ │ │     👁️  Def: private
          │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 78)
          │   │ │     💬 Args: [rdat, 32 * self._depth]
          │   │ │     👁️  Def: private
          │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 79)
          │   │     💬 Args: [self]
          │   │     👁️  Def: internal
          │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 80)
          │   │   │   💬 Args: [self]
          │   │   │   👁️  Def: internal
          │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 81)
          │   │   │     💬 Args: [self._keys]
          │   │   │     👁️  Def: private
          │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 82)
          │   │       💬 Args: [rdat, 32 * self._depth]
          │   │       👁️  Def: private
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 83)
          │   │   💬 Args: [self, reads[i]]
          │   │   👁️  Def: internal
          │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 84)
          │   │ │   💬 Args: [self, slot, true]
          │   │ │   👁️  Def: internal
          │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 85)
          │   │ │     💬 Args: [self]
          │   │ │     👁️  Def: internal
          │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 86)
          │   │ │   │   💬 Args: [self]
          │   │ │   │   👁️  Def: internal
          │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 87)
          │   │ │   │     💬 Args: [self._keys]
          │   │ │   │     👁️  Def: private
          │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 88)
          │   │ │       💬 Args: [rdat, 32 * self._depth]
          │   │ │       👁️  Def: private
          │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 89)
          │   │     💬 Args: [self, slot, false]
          │   │     👁️  Def: internal
          │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 90)
          │   │       💬 Args: [self]
          │   │       👁️  Def: internal
          │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 91)
          │   │     │   💬 Args: [self]
          │   │     │   👁️  Def: internal
          │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 92)
          │   │     │     💬 Args: [self._keys]
          │   │     │     👁️  Def: private
          │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 93)
          │   │         💬 Args: [rdat, 32 * self._depth]
          │   │         👁️  Def: private
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 94)
          │   │   💬 Args: [offsetLeft, offsetRight]
          │   │   👁️  Def: internal
          │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 95)
          │       💬 Args: [self]
          │       👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 96)
          │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
          │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 97)
          │     💬 Args: [offsetLeft, offsetRight]
          │     👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 98)
          │   💬 Args: [self]
          │   👁️  Def: internal
          │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 99)
          │ │   💬 Args: [self]
          │ │   👁️  Def: internal
          │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 100)
          │ │     💬 Args: [self._keys]
          │ │     👁️  Def: private
          │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 101)
          │     💬 Args: [rdat, 32 * self._depth]
          │     👁️  Def: private
          └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 102)
              💬 Args: [self]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 103)
                💬 Args: [self]
                👁️  Def: internal
```
