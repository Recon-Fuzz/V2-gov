# Function: test_unregisterWorksCorrectlyEvenAfterXEpochs_andCanBeSavedAtLast(uint8)

**Contract**: [test/E2E.t.sol/contract_ForkedE2ETests.md]

## Metadata

- **Contract**: ForkedE2ETests
- **Signature**: `test_unregisterWorksCorrectlyEvenAfterXEpochs_andCanBeSavedAtLast(uint8)`
- **Visibility**: public
- **Source Range**: 10894:2541:98

## Implementation

```solidity
function test_unregisterWorksCorrectlyEvenAfterXEpochs_andCanBeSavedAtLast(uint8 epochsInFuture) public {
    vm.warp(block.timestamp + ((uint32(1) + epochsInFuture) * EPOCH_DURATION));
    vm.startPrank(user);
    _deposit(1000e18);
    deal(address(lusd), address(user), REGISTRATION_FEE * 2);
    lusd.approve(address(governance), REGISTRATION_FEE * 2);
    address newInitiative = address(0x123123);
    address newInitiative2 = address(0x1231234);
    governance.registerInitiative(newInitiative);
    governance.registerInitiative(newInitiative2);
    assertEq(uint256(IGovernance.InitiativeStatus.WARM_UP), _getInitiativeStatus(newInitiative), "Cooldown");
    assertEq(uint256(IGovernance.InitiativeStatus.WARM_UP), _getInitiativeStatus(newInitiative2), "Cooldown");
    uint256 skipCount;
    vm.warp(block.timestamp + EPOCH_DURATION);
    ++skipCount;
    assertEq(uint256(IGovernance.InitiativeStatus.SKIP), _getInitiativeStatus(newInitiative), "SKIP");
    _allocate(newInitiative2, 1e18, 0);
    vm.warp(block.timestamp + EPOCH_DURATION);
    ++skipCount;
    assertEq(uint256(IGovernance.InitiativeStatus.SKIP), _getInitiativeStatus(newInitiative), "SKIP");
    vm.warp(block.timestamp + EPOCH_DURATION);
    ++skipCount;
    assertEq(uint256(IGovernance.InitiativeStatus.SKIP), _getInitiativeStatus(newInitiative), "SKIP");
    vm.warp(block.timestamp + EPOCH_DURATION);
    ++skipCount;
    assertEq(uint256(IGovernance.InitiativeStatus.SKIP), _getInitiativeStatus(newInitiative), "SKIP");
    _reset(newInitiative2);
    _allocate(newInitiative, 1e18, 0);
    vm.warp(block.timestamp + EPOCH_DURATION);
    ++skipCount;
    assertEq(uint256(IGovernance.InitiativeStatus.CLAIMABLE), _getInitiativeStatus(newInitiative), "UNREGISTERABLE");
}
```

## Related Implementations

### _deposit(uint256)

- **Kind**: internal
- **Source**: 13441:190:98
- **Link**: `test/E2E.t.sol:ForkedE2ETests:_deposit(uint256)`

```solidity
function _deposit(uint256 amt) internal {
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), amt);
    governance.depositLQTY(amt);
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### _getInitiativeStatus(address)

- **Kind**: internal
- **Source**: 14640:211:98
- **Link**: `test/E2E.t.sol:ForkedE2ETests:_getInitiativeStatus(address)`

```solidity
function _getInitiativeStatus(address _initiative) internal returns (uint256) {
    (IGovernance.InitiativeStatus status, , ) = governance.getInitiativeState(_initiative);
    return uint256(status);
}
```

### _allocate(address,int256,int256)

- **Kind**: internal
- **Source**: 13637:525:98
- **Link**: `test/E2E.t.sol:ForkedE2ETests:_allocate(address,int256,int256)`

```solidity
function _allocate(address initiative, int256 votes, int256 vetos) internal {
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](1);
    initiatives[0] = initiative;
    int256[] memory absoluteLQTYVotes = new int256[](1);
    absoluteLQTYVotes[0] = votes;
    int256[] memory absoluteLQTYVetos = new int256[](1);
    absoluteLQTYVetos[0] = vetos;
    governance.allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
}
```

### _reset(address)

- **Kind**: internal
- **Source**: 14410:224:98
- **Link**: `test/E2E.t.sol:ForkedE2ETests:_reset(address)`

```solidity
function _reset(address initiative) internal {
    address[] memory initiativesToReset = new address[](1);
    initiativesToReset[0] = initiative;
    governance.resetAllocations(initiativesToReset, false);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Vm::startPrank(address)**
- **IERC20::approve(address,uint256)**
- **Governance::registerInitiative(address)**

## State Variable Reads

- **EPOCH_DURATION** (`uint256`)
- **user** (`address`)
- **lusd** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **REGISTRATION_FEE** (`uint256`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **stdstore** (`struct StdStorage`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ForkedE2ETests.test_unregisterWorksCorrectlyEvenAfterXEpochs_andCanBeSavedAtLast(uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ForkedE2ETests._deposit(uint256) (NodeID: 1)
  │   💬 Args: [1000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 2)
  │   💬 Args: [address(lusd), address(user), REGISTRATION_FEE * 2]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 3)
  │     💬 Args: [token, to, give, false]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 4)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 5)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 6)
  │   │   💬 Args: [stdstore.target(token), 0x70a08231]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 7)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 8)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 9)
  │   │     💬 Args: [self, who]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 10)
  │   │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 11)
  │   │     💬 Args: [self, bytes32(amt)]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 12)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 13)
  │   │   │     💬 Args: [self._keys]
  │   │   │     👁️  Def: private
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 14)
  │   │   │   💬 Args: [self, false]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 15)
  │   │   │     💬 Args: [self, _clear]
  │   │   │     👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 16)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 17)
  │   │   │   │     💬 Args: [self._keys]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 18)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 19)
  │   │   │   │   💬 Args: [self]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 20)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 21)
  │   │   │   │ │     💬 Args: [self._keys]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 22)
  │   │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │     👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 23)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 24)
  │   │   │   │ │   💬 Args: [self]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 25)
  │   │   │   │ │ │   💬 Args: [self]
  │   │   │   │ │ │   👁️  Def: internal
  │   │   │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 26)
  │   │   │   │ │ │     💬 Args: [self._keys]
  │   │   │   │ │ │     👁️  Def: private
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 27)
  │   │   │   │ │     💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │     👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 28)
  │   │   │   │     💬 Args: [self]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 29)
  │   │   │   │   │   💬 Args: [self]
  │   │   │   │   │   👁️  Def: internal
  │   │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 30)
  │   │   │   │   │     💬 Args: [self._keys]
  │   │   │   │   │     👁️  Def: private
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 31)
  │   │   │   │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │       👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 32)
  │   │   │   │   💬 Args: [self, reads[i]]
  │   │   │   │   👁️  Def: internal
  │   │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 33)
  │   │   │   │ │   💬 Args: [self, slot, true]
  │   │   │   │ │   👁️  Def: internal
  │   │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 34)
  │   │   │   │ │     💬 Args: [self]
  │   │   │   │ │     👁️  Def: internal
  │   │   │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 35)
  │   │   │   │ │   │   💬 Args: [self]
  │   │   │   │ │   │   👁️  Def: internal
  │   │   │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 36)
  │   │   │   │ │   │     💬 Args: [self._keys]
  │   │   │   │ │   │     👁️  Def: private
  │   │   │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 37)
  │   │   │   │ │       💬 Args: [rdat, 32 * self._depth]
  │   │   │   │ │       👁️  Def: private
  │   │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 38)
  │   │   │   │     💬 Args: [self, slot, false]
  │   │   │   │     👁️  Def: internal
  │   │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 39)
  │   │   │   │       💬 Args: [self]
  │   │   │   │       👁️  Def: internal
  │   │   │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 40)
  │   │   │   │     │   💬 Args: [self]
  │   │   │   │     │   👁️  Def: internal
  │   │   │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 41)
  │   │   │   │     │     💬 Args: [self._keys]
  │   │   │   │     │     👁️  Def: private
  │   │   │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 42)
  │   │   │   │         💬 Args: [rdat, 32 * self._depth]
  │   │   │   │         👁️  Def: private
  │   │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 43)
  │   │   │   │   💬 Args: [offsetLeft, offsetRight]
  │   │   │   │   👁️  Def: internal
  │   │   │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 44)
  │   │   │       💬 Args: [self]
  │   │   │       👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 45)
  │   │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │   │   │   👁️  Def: internal
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 46)
  │   │   │     💬 Args: [offsetLeft, offsetRight]
  │   │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 47)
  │   │   │   💬 Args: [self]
  │   │   │   👁️  Def: internal
  │   │   │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 48)
  │   │   │ │   💬 Args: [self]
  │   │   │ │   👁️  Def: internal
  │   │   │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 49)
  │   │   │ │     💬 Args: [self._keys]
  │   │   │ │     👁️  Def: private
  │   │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 50)
  │   │   │     💬 Args: [rdat, 32 * self._depth]
  │   │   │     👁️  Def: private
  │   │   └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 51)
  │   │       💬 Args: [self]
  │   │       👁️  Def: internal
  │   │     └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 52)
  │   │         💬 Args: [self]
  │   │         👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 53)
  │   │   💬 Args: [stdstore, token]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 54)
  │   │     💬 Args: [self, _target]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 55)
  │   │   💬 Args: [stdstore.target(token), 0x18160ddd]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 56)
  │   │     💬 Args: [self, _sig]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 57)
  │       💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 58)
  │         💬 Args: [self, bytes32(amt)]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 59)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 60)
  │       │     💬 Args: [self._keys]
  │       │     👁️  Def: private
  │       ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 61)
  │       │   💬 Args: [self, false]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 62)
  │       │     💬 Args: [self, _clear]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 63)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 64)
  │       │   │     💬 Args: [self._keys]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 65)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 66)
  │       │   │   💬 Args: [self]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 67)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 68)
  │       │   │ │     💬 Args: [self._keys]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 69)
  │       │   │     💬 Args: [rdat, 32 * self._depth]
  │       │   │     👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 70)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 71)
  │       │   │ │   💬 Args: [self]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 72)
  │       │   │ │ │   💬 Args: [self]
  │       │   │ │ │   👁️  Def: internal
  │       │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 73)
  │       │   │ │ │     💬 Args: [self._keys]
  │       │   │ │ │     👁️  Def: private
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 74)
  │       │   │ │     💬 Args: [rdat, 32 * self._depth]
  │       │   │ │     👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 75)
  │       │   │     💬 Args: [self]
  │       │   │     👁️  Def: internal
  │       │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 76)
  │       │   │   │   💬 Args: [self]
  │       │   │   │   👁️  Def: internal
  │       │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 77)
  │       │   │   │     💬 Args: [self._keys]
  │       │   │   │     👁️  Def: private
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 78)
  │       │   │       💬 Args: [rdat, 32 * self._depth]
  │       │   │       👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 79)
  │       │   │   💬 Args: [self, reads[i]]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 80)
  │       │   │ │   💬 Args: [self, slot, true]
  │       │   │ │   👁️  Def: internal
  │       │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 81)
  │       │   │ │     💬 Args: [self]
  │       │   │ │     👁️  Def: internal
  │       │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 82)
  │       │   │ │   │   💬 Args: [self]
  │       │   │ │   │   👁️  Def: internal
  │       │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 83)
  │       │   │ │   │     💬 Args: [self._keys]
  │       │   │ │   │     👁️  Def: private
  │       │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 84)
  │       │   │ │       💬 Args: [rdat, 32 * self._depth]
  │       │   │ │       👁️  Def: private
  │       │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 85)
  │       │   │     💬 Args: [self, slot, false]
  │       │   │     👁️  Def: internal
  │       │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 86)
  │       │   │       💬 Args: [self]
  │       │   │       👁️  Def: internal
  │       │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 87)
  │       │   │     │   💬 Args: [self]
  │       │   │     │   👁️  Def: internal
  │       │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 88)
  │       │   │     │     💬 Args: [self._keys]
  │       │   │     │     👁️  Def: private
  │       │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 89)
  │       │   │         💬 Args: [rdat, 32 * self._depth]
  │       │   │         👁️  Def: private
  │       │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 90)
  │       │   │   💬 Args: [offsetLeft, offsetRight]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 91)
  │       │       💬 Args: [self]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 92)
  │       │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 93)
  │       │     💬 Args: [offsetLeft, offsetRight]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 94)
  │       │   💬 Args: [self]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 95)
  │       │ │   💬 Args: [self]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 96)
  │       │ │     💬 Args: [self._keys]
  │       │ │     👁️  Def: private
  │       │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 97)
  │       │     💬 Args: [rdat, 32 * self._depth]
  │       │     👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 98)
  │           💬 Args: [self]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 99)
  │             💬 Args: [self]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 100)
  │   💬 Args: [uint256(IGovernance.InitiativeStatus.WARM_UP), _getInitiativeStatus(newInitiative), "Cooldown"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ForkedE2ETests._getInitiativeStatus(address) (NodeID: 101)
  │     💬 Args: [newInitiative]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 102)
  │   💬 Args: [uint256(IGovernance.InitiativeStatus.WARM_UP), _getInitiativeStatus(newInitiative2), "Cooldown"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ForkedE2ETests._getInitiativeStatus(address) (NodeID: 103)
  │     💬 Args: [newInitiative2]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 104)
  │   💬 Args: [uint256(IGovernance.InitiativeStatus.SKIP), _getInitiativeStatus(newInitiative), "SKIP"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ForkedE2ETests._getInitiativeStatus(address) (NodeID: 105)
  │     💬 Args: [newInitiative]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ForkedE2ETests._allocate(address,int256,int256) (NodeID: 106)
  │   💬 Args: [newInitiative2, 1e18, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 107)
  │   💬 Args: [uint256(IGovernance.InitiativeStatus.SKIP), _getInitiativeStatus(newInitiative), "SKIP"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ForkedE2ETests._getInitiativeStatus(address) (NodeID: 108)
  │     💬 Args: [newInitiative]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 109)
  │   💬 Args: [uint256(IGovernance.InitiativeStatus.SKIP), _getInitiativeStatus(newInitiative), "SKIP"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ForkedE2ETests._getInitiativeStatus(address) (NodeID: 110)
  │     💬 Args: [newInitiative]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 111)
  │   💬 Args: [uint256(IGovernance.InitiativeStatus.SKIP), _getInitiativeStatus(newInitiative), "SKIP"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ForkedE2ETests._getInitiativeStatus(address) (NodeID: 112)
  │     💬 Args: [newInitiative]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ForkedE2ETests._reset(address) (NodeID: 113)
  │   💬 Args: [newInitiative2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ForkedE2ETests._allocate(address,int256,int256) (NodeID: 114)
  │   💬 Args: [newInitiative, 1e18, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 115)
      💬 Args: [uint256(IGovernance.InitiativeStatus.CLAIMABLE), _getInitiativeStatus(newInitiative), "UNREGISTERABLE"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ForkedE2ETests._getInitiativeStatus(address) (NodeID: 116)
        💬 Args: [newInitiative]
        👁️  Def: internal
```
