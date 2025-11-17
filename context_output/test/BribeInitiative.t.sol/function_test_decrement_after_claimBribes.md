# Function: test_decrement_after_claimBribes()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_decrement_after_claimBribes()`
- **Visibility**: public
- **Source Range**: 23302:2024:92

## Implementation

```solidity
function test_decrement_after_claimBribes() public {
    _stakeLQTY(user1, 1e18);
    vm.warp(block.timestamp + EPOCH_DURATION);
    assertEq(2, governance.epoch(), "not in epoch 2");
    _depositBribe(1e18, 1e18, governance.epoch() + 1);
    vm.warp(block.timestamp + EPOCH_DURATION);
    assertEq(3, governance.epoch(), "not in epoch 3");
    _allocateLQTY(user1, 1e18, 0);
    _depositBribe(1e18, 1e18, governance.epoch() + 1);
    vm.warp(block.timestamp + (EPOCH_DURATION * 2));
    console2.log("current epoch: ", governance.epoch());
    uint256 claimEpoch = governance.epoch() - 2;
    uint256 prevAllocationEpoch = governance.epoch() - 2;
    (uint256 boldAmount, uint256 bribeTokenAmount) = _claimBribe(user1, claimEpoch, prevAllocationEpoch, prevAllocationEpoch);
    assertEq(boldAmount, 1e18);
    assertEq(bribeTokenAmount, 1e18);
    _resetAllocation(user1);
    claimEpoch = governance.epoch() - 1;
    prevAllocationEpoch = governance.epoch() - 2;
    (boldAmount, bribeTokenAmount) = _claimBribe(user1, claimEpoch, prevAllocationEpoch, prevAllocationEpoch);
    assertEq(boldAmount, 1e18);
    assertEq(bribeTokenAmount, 1e18);
}
```

## Related Implementations

### _stakeLQTY(address,uint256)

- **Kind**: internal
- **Source**: 39703:284:92
- **Link**: `test/BribeInitiative.t.sol:BribeInitiativeTest:_stakeLQTY(address,uint256)`

```solidity
///  Helpers
function _stakeLQTY(address staker, uint256 amount) internal {
    vm.startPrank(staker);
    address userProxy = governance.deriveUserProxyAddress(staker);
    lqty.approve(address(userProxy), amount);
    governance.depositLQTY(amount);
    vm.stopPrank();
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

### _depositBribe(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 42379:343:92
- **Link**: `test/BribeInitiative.t.sol:BribeInitiativeTest:_depositBribe(uint256,uint256,uint256)`

```solidity
function _depositBribe(uint256 boldAmount, uint256 bribeAmount, uint256 epoch) public {
    vm.startPrank(lusdHolder);
    lusd.approve(address(bribeInitiative), boldAmount);
    lqty.approve(address(bribeInitiative), bribeAmount);
    bribeInitiative.depositBribe(boldAmount, bribeAmount, epoch);
    vm.stopPrank();
}
```

### _allocateLQTY(address,int256,int256)

- **Kind**: internal
- **Source**: 39993:968:92
- **Link**: `test/BribeInitiative.t.sol:BribeInitiativeTest:_allocateLQTY(address,int256,int256)`

```solidity
function _allocateLQTY(address staker, int256 absoluteVoteLQTYAmt, int256 absoluteVetoLQTYAmt) internal {
    vm.startPrank(staker);
    address[] memory initiativesToReset;
    (uint256 currentVote, , uint256 currentVeto, , ) = governance.lqtyAllocatedByUserToInitiative(staker, address(bribeInitiative));
    if ((currentVote != 0) || (currentVeto != 0)) {
        initiativesToReset = new address[](1);
        initiativesToReset[0] = address(bribeInitiative);
    }
    address[] memory initiatives = new address[](1);
    initiatives[0] = address(bribeInitiative);
    int256[] memory absoluteVoteLQTY = new int256[](1);
    absoluteVoteLQTY[0] = absoluteVoteLQTYAmt;
    int256[] memory absoluteVetoLQTY = new int256[](1);
    absoluteVetoLQTY[0] = absoluteVetoLQTYAmt;
    governance.allocateLQTY(initiativesToReset, initiatives, absoluteVoteLQTY, absoluteVetoLQTY);
    vm.stopPrank();
}
```

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:22
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
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

### _claimBribe(address,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 43085:337:92
- **Link**: `test/BribeInitiative.t.sol:BribeInitiativeTest:_claimBribe(address,uint256,uint256,uint256)`

```solidity
function _claimBribe(address claimer, uint256 epoch, uint256 prevLQTYAllocationEpoch, uint256 prevTotalLQTYAllocationEpoch) public returns (uint256 boldAmount, uint256 bribeTokenAmount) {
    return _claimBribe(claimer, epoch, prevLQTYAllocationEpoch, prevTotalLQTYAllocationEpoch, false);
}
```

### _claimBribe(address,uint256,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 43428:730:92
- **Link**: `test/BribeInitiative.t.sol:BribeInitiativeTest:_claimBribe(address,uint256,uint256,uint256,bool)`

```solidity
function _claimBribe(address claimer, uint256 epoch, uint256 prevLQTYAllocationEpoch, uint256 prevTotalLQTYAllocationEpoch, bool expectRevert) public returns (uint256 boldAmount, uint256 bribeTokenAmount) {
    vm.startPrank(claimer);
    BribeInitiative.ClaimData[] memory epochs = new BribeInitiative.ClaimData[](1);
    epochs[0].epoch = epoch;
    epochs[0].prevLQTYAllocationEpoch = prevLQTYAllocationEpoch;
    epochs[0].prevTotalLQTYAllocationEpoch = prevTotalLQTYAllocationEpoch;
    if (expectRevert) {
        vm.expectRevert();
    }
    (boldAmount, bribeTokenAmount) = bribeInitiative.claimBribes(epochs);
    vm.stopPrank();
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### _resetAllocation(address)

- **Kind**: internal
- **Source**: 42074:299:92
- **Link**: `test/BribeInitiative.t.sol:BribeInitiativeTest:_resetAllocation(address)`

```solidity
function _resetAllocation(address staker) internal {
    vm.startPrank(staker);
    address[] memory initiativesToReset = new address[](1);
    initiativesToReset[0] = address(bribeInitiative);
    governance.resetAllocations(initiativesToReset, true);
    vm.stopPrank();
}
```

## External Calls

- **Vm::warp(uint256)**
- **Governance::epoch()**

## State Variable Reads

- **user1** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **lusdHolder** (`address`)
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_decrement_after_claimBribes() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._stakeLQTY(address,uint256) (NodeID: 1)
  │   💬 Args: [user1, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [2, governance.epoch(), "not in epoch 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [1e18, 1e18, governance.epoch() + 1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [3, governance.epoch(), "not in epoch 3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._allocateLQTY(address,int256,int256) (NodeID: 5)
  │   💬 Args: [user1, 1e18, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [1e18, 1e18, governance.epoch() + 1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 7)
  │   💬 Args: ["current epoch: ", governance.epoch()]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256) (NodeID: 10)
  │   💬 Args: [user1, claimEpoch, prevAllocationEpoch, prevAllocationEpoch]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256,bool) (NodeID: 11)
  │     💬 Args: [claimer, epoch, prevLQTYAllocationEpoch, prevTotalLQTYAllocationEpoch, false]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 12)
  │   💬 Args: [boldAmount, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 13)
  │   💬 Args: [bribeTokenAmount, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._resetAllocation(address) (NodeID: 14)
  │   💬 Args: [user1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256) (NodeID: 15)
  │   💬 Args: [user1, claimEpoch, prevAllocationEpoch, prevAllocationEpoch]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256,bool) (NodeID: 16)
  │     💬 Args: [claimer, epoch, prevLQTYAllocationEpoch, prevTotalLQTYAllocationEpoch, false]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 17)
  │   💬 Args: [boldAmount, 1e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 18)
      💬 Args: [bribeTokenAmount, 1e18]
      👁️  Def: internal
```
