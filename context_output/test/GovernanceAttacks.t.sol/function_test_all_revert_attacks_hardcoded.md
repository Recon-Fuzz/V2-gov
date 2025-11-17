# Function: test_all_revert_attacks_hardcoded()

**Contract**: [test/GovernanceAttacks.t.sol/contract_ForkedGovernanceAttacksTest.md]

## Metadata

- **Contract**: ForkedGovernanceAttacksTest
- **Signature**: `test_all_revert_attacks_hardcoded()`
- **Visibility**: public
- **Source Range**: 3185:8415:100
- **Inherited From**: GovernanceAttacksTest

## Implementation

```solidity
function test_all_revert_attacks_hardcoded() public {
    vm.startPrank(user);
    address userProxy = governance.deriveUserProxyAddress(user);
    lqty.approve(address(userProxy), 1e18);
    governance.depositLQTY(1e18);
    assertEq(UserProxy(payable(userProxy)).staked(), 1e18);
    (, , uint256 allocatedLQTY, uint256 allocatedOffset) = governance.userStates(user);
    assertEq(allocatedLQTY, 0);
    assertEq(allocatedOffset, 0);
    vm.stopPrank();
    vm.startPrank(lusdHolder);
    lusd.transfer(address(governance), 10000e18);
    vm.stopPrank();
    address maliciousWhale = address(0xb4d);
    deal(address(lusd), maliciousWhale, 2000e18);
    vm.startPrank(maliciousWhale);
    lusd.approve(address(governance), type(uint256).max);
    /// === REGISTRATION REVERTS === ///
    uint256 registerNapshot = vm.snapshot();
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.REGISTER, MaliciousInitiative.RevertType.THROW);
    governance.registerInitiative(address(maliciousInitiative2));
    vm.revertTo(registerNapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.REGISTER, MaliciousInitiative.RevertType.OOG);
    governance.registerInitiative(address(maliciousInitiative2));
    vm.revertTo(registerNapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.REGISTER, MaliciousInitiative.RevertType.RETURN_BOMB);
    governance.registerInitiative(address(maliciousInitiative2));
    vm.revertTo(registerNapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.REGISTER, MaliciousInitiative.RevertType.REVERT_BOMB);
    governance.registerInitiative(address(maliciousInitiative2));
    vm.revertTo(registerNapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.REGISTER, MaliciousInitiative.RevertType.NONE);
    governance.registerInitiative(address(maliciousInitiative2));
    governance.registerInitiative(address(eoaInitiative));
    vm.stopPrank();
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](2);
    initiatives[0] = address(maliciousInitiative2);
    initiatives[1] = address(eoaInitiative);
    int256[] memory deltaVoteLQTY = new int256[](2);
    deltaVoteLQTY[0] = 5e17;
    deltaVoteLQTY[1] = 5e17;
    int256[] memory deltaVetoLQTY = new int256[](2);
    /// === Allocate LQTY REVERTS === ///
    uint256 allocateSnapshot = vm.snapshot();
    vm.startPrank(user);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.ALLOCATE, MaliciousInitiative.RevertType.THROW);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    vm.revertTo(allocateSnapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.ALLOCATE, MaliciousInitiative.RevertType.OOG);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    vm.revertTo(allocateSnapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.ALLOCATE, MaliciousInitiative.RevertType.RETURN_BOMB);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    vm.revertTo(allocateSnapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.ALLOCATE, MaliciousInitiative.RevertType.REVERT_BOMB);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    vm.revertTo(allocateSnapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.ALLOCATE, MaliciousInitiative.RevertType.NONE);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    vm.warp((block.timestamp + governance.EPOCH_DURATION()) + 1);
    /// === Claim for initiative REVERTS === ///
    uint256 claimShapsnot = vm.snapshot();
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.CLAIM, MaliciousInitiative.RevertType.THROW);
    governance.claimForInitiative(address(maliciousInitiative2));
    vm.revertTo(claimShapsnot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.CLAIM, MaliciousInitiative.RevertType.OOG);
    governance.claimForInitiative(address(maliciousInitiative2));
    vm.revertTo(claimShapsnot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.CLAIM, MaliciousInitiative.RevertType.RETURN_BOMB);
    governance.claimForInitiative(address(maliciousInitiative2));
    vm.revertTo(claimShapsnot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.CLAIM, MaliciousInitiative.RevertType.REVERT_BOMB);
    governance.claimForInitiative(address(maliciousInitiative2));
    vm.revertTo(claimShapsnot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.CLAIM, MaliciousInitiative.RevertType.NONE);
    governance.claimForInitiative(address(maliciousInitiative2));
    governance.claimForInitiative(address(eoaInitiative));
    /// === Unregister Reverts === ///
    vm.startPrank(user);
    initiativesToReset = new address[](2);
    initiativesToReset[0] = address(maliciousInitiative2);
    initiativesToReset[1] = address(eoaInitiative);
    initiatives = new address[](1);
    initiatives[0] = address(maliciousInitiative1);
    deltaVoteLQTY = new int256[](1);
    deltaVoteLQTY[0] = 5e17;
    deltaVetoLQTY = new int256[](1);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    (Governance.VoteSnapshot memory v, Governance.InitiativeVoteSnapshot memory initData) = governance.snapshotVotesForInitiative(address(maliciousInitiative2));
    vm.warp(block.timestamp + (governance.EPOCH_DURATION() * 5));
    /// @audit needs 5?
    (v, initData) = governance.snapshotVotesForInitiative(address(maliciousInitiative2));
    uint256 unregisterSnapshot = vm.snapshot();
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.UNREGISTER, MaliciousInitiative.RevertType.THROW);
    governance.unregisterInitiative(address(maliciousInitiative2));
    vm.revertTo(unregisterSnapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.UNREGISTER, MaliciousInitiative.RevertType.OOG);
    governance.unregisterInitiative(address(maliciousInitiative2));
    vm.revertTo(unregisterSnapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.UNREGISTER, MaliciousInitiative.RevertType.RETURN_BOMB);
    governance.unregisterInitiative(address(maliciousInitiative2));
    vm.revertTo(unregisterSnapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.UNREGISTER, MaliciousInitiative.RevertType.REVERT_BOMB);
    governance.unregisterInitiative(address(maliciousInitiative2));
    vm.revertTo(unregisterSnapshot);
    maliciousInitiative2.setRevertBehaviour(MaliciousInitiative.FunctionType.UNREGISTER, MaliciousInitiative.RevertType.NONE);
    governance.unregisterInitiative(address(maliciousInitiative2));
    governance.unregisterInitiative(address(eoaInitiative));
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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
- **Governance::deriveUserProxyAddress(address)**
- **ILQTY::approve(address,uint256)**
- **Governance::depositLQTY(uint256)**
- **UserProxy::staked()**
- **Governance::userStates(address)**
- **Vm::stopPrank()**
- **ILUSD::transfer(address,uint256)**
- **ILUSD::approve(address,uint256)**
- **Vm::snapshot()**
- **MaliciousInitiative::setRevertBehaviour(enum MaliciousInitiative.FunctionType,enum MaliciousInitiative.RevertType)**
- **Governance::registerInitiative(address)**
- **Vm::revertTo(uint256)**
- **Vm::warp(uint256)**
- **Governance::EPOCH_DURATION()**
- **Governance::allocateLQTY(address[],address[],int256[],int256[])**
- **Governance::claimForInitiative(address)**
- **Governance::snapshotVotesForInitiative(address)**
- **Governance::unregisterInitiative(address)**

## Native Transfers

- **lusd** (computed)

## State Variable Reads

- **user** (`address`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusdHolder** (`address`)
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **maliciousInitiative2** (`contract MaliciousInitiative`) [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]
- **eoaInitiative** (`contract MaliciousInitiative`) [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]
- **maliciousInitiative1** (`contract MaliciousInitiative`) [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **stdstore** (`struct StdStorage`)
- **UINT256_MAX** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceAttacksTest.test_all_revert_attacks_hardcoded() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [UserProxy(payable(userProxy)).staked(), 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [allocatedLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [allocatedOffset, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256) (NodeID: 4)
      💬 Args: [address(lusd), maliciousWhale, 2000e18]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,address,uint256,bool) (NodeID: 5)
        💬 Args: [token, to, give, false]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 6)
      │   💬 Args: [stdstore, token]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 7)
      │     💬 Args: [self, _target]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 8)
      │   💬 Args: [stdstore.target(token), 0x70a08231]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 9)
      │     💬 Args: [self, _sig]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.with_key(struct StdStorage,address) (NodeID: 10)
      │   💬 Args: [stdstore.target(token).sig(0x70a08231), to]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.with_key(struct StdStorage,address) (NodeID: 11)
      │     💬 Args: [self, who]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 12)
      │   💬 Args: [stdstore.target(token).sig(0x70a08231).with_key(to), give]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 13)
      │     💬 Args: [self, bytes32(amt)]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 14)
      │   │   💬 Args: [self]
      │   │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 15)
      │   │     💬 Args: [self._keys]
      │   │     👁️  Def: private
      │   ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 16)
      │   │   💬 Args: [self, false]
      │   │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 17)
      │   │     💬 Args: [self, _clear]
      │   │     👁️  Def: internal
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 18)
      │   │   │   💬 Args: [self]
      │   │   │   👁️  Def: internal
      │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 19)
      │   │   │     💬 Args: [self._keys]
      │   │   │     👁️  Def: private
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 20)
      │   │   │   💬 Args: [self]
      │   │   │   👁️  Def: internal
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 21)
      │   │   │   💬 Args: [self]
      │   │   │   👁️  Def: internal
      │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 22)
      │   │   │ │   💬 Args: [self]
      │   │   │ │   👁️  Def: internal
      │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 23)
      │   │   │ │     💬 Args: [self._keys]
      │   │   │ │     👁️  Def: private
      │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 24)
      │   │   │     💬 Args: [rdat, 32 * self._depth]
      │   │   │     👁️  Def: private
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 25)
      │   │   │   💬 Args: [self, reads[i]]
      │   │   │   👁️  Def: internal
      │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 26)
      │   │   │ │   💬 Args: [self]
      │   │   │ │   👁️  Def: internal
      │   │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 27)
      │   │   │ │ │   💬 Args: [self]
      │   │   │ │ │   👁️  Def: internal
      │   │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 28)
      │   │   │ │ │     💬 Args: [self._keys]
      │   │   │ │ │     👁️  Def: private
      │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 29)
      │   │   │ │     💬 Args: [rdat, 32 * self._depth]
      │   │   │ │     👁️  Def: private
      │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 30)
      │   │   │     💬 Args: [self]
      │   │   │     👁️  Def: internal
      │   │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 31)
      │   │   │   │   💬 Args: [self]
      │   │   │   │   👁️  Def: internal
      │   │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 32)
      │   │   │   │     💬 Args: [self._keys]
      │   │   │   │     👁️  Def: private
      │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 33)
      │   │   │       💬 Args: [rdat, 32 * self._depth]
      │   │   │       👁️  Def: private
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 34)
      │   │   │   💬 Args: [self, reads[i]]
      │   │   │   👁️  Def: internal
      │   │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 35)
      │   │   │ │   💬 Args: [self, slot, true]
      │   │   │ │   👁️  Def: internal
      │   │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 36)
      │   │   │ │     💬 Args: [self]
      │   │   │ │     👁️  Def: internal
      │   │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 37)
      │   │   │ │   │   💬 Args: [self]
      │   │   │ │   │   👁️  Def: internal
      │   │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 38)
      │   │   │ │   │     💬 Args: [self._keys]
      │   │   │ │   │     👁️  Def: private
      │   │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 39)
      │   │   │ │       💬 Args: [rdat, 32 * self._depth]
      │   │   │ │       👁️  Def: private
      │   │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 40)
      │   │   │     💬 Args: [self, slot, false]
      │   │   │     👁️  Def: internal
      │   │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 41)
      │   │   │       💬 Args: [self]
      │   │   │       👁️  Def: internal
      │   │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 42)
      │   │   │     │   💬 Args: [self]
      │   │   │     │   👁️  Def: internal
      │   │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 43)
      │   │   │     │     💬 Args: [self._keys]
      │   │   │     │     👁️  Def: private
      │   │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 44)
      │   │   │         💬 Args: [rdat, 32 * self._depth]
      │   │   │         👁️  Def: private
      │   │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 45)
      │   │   │   💬 Args: [offsetLeft, offsetRight]
      │   │   │   👁️  Def: internal
      │   │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 46)
      │   │       💬 Args: [self]
      │   │       👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 47)
      │   │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
      │   │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 48)
      │   │     💬 Args: [offsetLeft, offsetRight]
      │   │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 49)
      │   │   💬 Args: [self]
      │   │   👁️  Def: internal
      │   │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 50)
      │   │ │   💬 Args: [self]
      │   │ │   👁️  Def: internal
      │   │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 51)
      │   │ │     💬 Args: [self._keys]
      │   │ │     👁️  Def: private
      │   │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 52)
      │   │     💬 Args: [rdat, 32 * self._depth]
      │   │     👁️  Def: private
      │   └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 53)
      │       💬 Args: [self]
      │       👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 54)
      │         💬 Args: [self]
      │         👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.target(struct StdStorage,address) (NodeID: 55)
      │   💬 Args: [stdstore, token]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.target(struct StdStorage,address) (NodeID: 56)
      │     💬 Args: [self, _target]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: stdStorage.sig(struct StdStorage,bytes4) (NodeID: 57)
      │   💬 Args: [stdstore.target(token), 0x18160ddd]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: stdStorageSafe.sig(struct StdStorage,bytes4) (NodeID: 58)
      │     💬 Args: [self, _sig]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,uint256) (NodeID: 59)
          💬 Args: [stdstore.target(token).sig(0x18160ddd), totSup]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: stdStorage.checked_write(struct StdStorage,bytes32) (NodeID: 60)
            💬 Args: [self, bytes32(amt)]
            👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 61)
          │   💬 Args: [self]
          │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 62)
          │     💬 Args: [self._keys]
          │     👁️  Def: private
          ├─ [5] ⚙️ FUNCTION: stdStorage.find(struct StdStorage,bool) (NodeID: 63)
          │   💬 Args: [self, false]
          │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.find(struct StdStorage,bool) (NodeID: 64)
          │     💬 Args: [self, _clear]
          │     👁️  Def: internal
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 65)
          │   │   💬 Args: [self]
          │   │   👁️  Def: internal
          │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 66)
          │   │     💬 Args: [self._keys]
          │   │     👁️  Def: private
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 67)
          │   │   💬 Args: [self]
          │   │   👁️  Def: internal
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 68)
          │   │   💬 Args: [self]
          │   │   👁️  Def: internal
          │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 69)
          │   │ │   💬 Args: [self]
          │   │ │   👁️  Def: internal
          │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 70)
          │   │ │     💬 Args: [self._keys]
          │   │ │     👁️  Def: private
          │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 71)
          │   │     💬 Args: [rdat, 32 * self._depth]
          │   │     👁️  Def: private
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.checkSlotMutatesCall(struct StdStorage,bytes32) (NodeID: 72)
          │   │   💬 Args: [self, reads[i]]
          │   │   👁️  Def: internal
          │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 73)
          │   │ │   💬 Args: [self]
          │   │ │   👁️  Def: internal
          │   │ │ ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 74)
          │   │ │ │   💬 Args: [self]
          │   │ │ │   👁️  Def: internal
          │   │ │ │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 75)
          │   │ │ │     💬 Args: [self._keys]
          │   │ │ │     👁️  Def: private
          │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 76)
          │   │ │     💬 Args: [rdat, 32 * self._depth]
          │   │ │     👁️  Def: private
          │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 77)
          │   │     💬 Args: [self]
          │   │     👁️  Def: internal
          │   │   ├─ [9] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 78)
          │   │   │   💬 Args: [self]
          │   │   │   👁️  Def: internal
          │   │   │ └─ [10] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 79)
          │   │   │     💬 Args: [self._keys]
          │   │   │     👁️  Def: private
          │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 80)
          │   │       💬 Args: [rdat, 32 * self._depth]
          │   │       👁️  Def: private
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.findOffsets(struct StdStorage,bytes32) (NodeID: 81)
          │   │   💬 Args: [self, reads[i]]
          │   │   👁️  Def: internal
          │   │ ├─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 82)
          │   │ │   💬 Args: [self, slot, true]
          │   │ │   👁️  Def: internal
          │   │ │ └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 83)
          │   │ │     💬 Args: [self]
          │   │ │     👁️  Def: internal
          │   │ │   ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 84)
          │   │ │   │   💬 Args: [self]
          │   │ │   │   👁️  Def: internal
          │   │ │   │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 85)
          │   │ │   │     💬 Args: [self._keys]
          │   │ │   │     👁️  Def: private
          │   │ │   └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 86)
          │   │ │       💬 Args: [rdat, 32 * self._depth]
          │   │ │       👁️  Def: private
          │   │ └─ [8] ⚙️ FUNCTION: stdStorageSafe.findOffset(struct StdStorage,bytes32,bool) (NodeID: 87)
          │   │     💬 Args: [self, slot, false]
          │   │     👁️  Def: internal
          │   │   └─ [9] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 88)
          │   │       💬 Args: [self]
          │   │       👁️  Def: internal
          │   │     ├─ [10] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 89)
          │   │     │   💬 Args: [self]
          │   │     │   👁️  Def: internal
          │   │     │ └─ [11] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 90)
          │   │     │     💬 Args: [self._keys]
          │   │     │     👁️  Def: private
          │   │     └─ [10] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 91)
          │   │         💬 Args: [rdat, 32 * self._depth]
          │   │         👁️  Def: private
          │   ├─ [7] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 92)
          │   │   💬 Args: [offsetLeft, offsetRight]
          │   │   👁️  Def: internal
          │   └─ [7] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 93)
          │       💬 Args: [self]
          │       👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: stdStorageSafe.getUpdatedSlotValue(bytes32,uint256,uint256,uint256) (NodeID: 94)
          │   💬 Args: [curVal, uint256(set), data.offsetLeft, data.offsetRight]
          │   👁️  Def: internal
          │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.getMaskByOffsets(uint256,uint256) (NodeID: 95)
          │     💬 Args: [offsetLeft, offsetRight]
          │     👁️  Def: internal
          ├─ [5] ⚙️ FUNCTION: stdStorageSafe.callTarget(struct StdStorage) (NodeID: 96)
          │   💬 Args: [self]
          │   👁️  Def: internal
          │ ├─ [6] ⚙️ FUNCTION: stdStorageSafe.getCallParams(struct StdStorage) (NodeID: 97)
          │ │   💬 Args: [self]
          │ │   👁️  Def: internal
          │ │ └─ [7] ⚙️ FUNCTION: stdStorageSafe.flatten(bytes32[]) (NodeID: 98)
          │ │     💬 Args: [self._keys]
          │ │     👁️  Def: private
          │ └─ [6] ⚙️ FUNCTION: stdStorageSafe.bytesToBytes32(bytes,uint256) (NodeID: 99)
          │     💬 Args: [rdat, 32 * self._depth]
          │     👁️  Def: private
          └─ [5] ⚙️ FUNCTION: stdStorage.clear(struct StdStorage) (NodeID: 100)
              💬 Args: [self]
              👁️  Def: internal
            └─ [6] ⚙️ FUNCTION: stdStorageSafe.clear(struct StdStorage) (NodeID: 101)
                💬 Args: [self]
                👁️  Def: internal
```
