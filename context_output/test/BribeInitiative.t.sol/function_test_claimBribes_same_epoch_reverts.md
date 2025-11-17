# Function: test_claimBribes_same_epoch_reverts()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_claimBribes_same_epoch_reverts()`
- **Visibility**: public
- **Source Range**: 31238:1544:92

## Implementation

```solidity
function test_claimBribes_same_epoch_reverts() public {
    _stakeLQTY(user1, 1e18);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _depositBribe(1e18, 1e18, governance.epoch() + 1);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _allocateLQTY(user1, 1e18, 0);
    (uint256 totalLQTYAllocated, , , ) = bribeInitiative.totalLQTYAllocatedByEpoch(governance.epoch());
    (uint256 userLQTYAllocated, , , ) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user1, governance.epoch());
    assertEq(totalLQTYAllocated, 1e18);
    assertEq(userLQTYAllocated, 1e18);
    _depositBribe(1e18, 1e18, governance.epoch() + 1);
    vm.warp(block.timestamp + (EPOCH_DURATION * 2));
    (uint256 boldAmount1, uint256 bribeTokenAmount1) = _claimBribe(user1, governance.epoch() - 1, governance.epoch() - 2, governance.epoch() - 2);
    assertEq(boldAmount1, 1e18);
    assertEq(bribeTokenAmount1, 1e18);
    vm.startPrank(user1);
    BribeInitiative.ClaimData[] memory epochs = new BribeInitiative.ClaimData[](1);
    epochs[0].epoch = governance.epoch() - 1;
    epochs[0].prevLQTYAllocationEpoch = governance.epoch() - 2;
    epochs[0].prevTotalLQTYAllocationEpoch = governance.epoch() - 2;
    vm.expectRevert("BribeInitiative: already-claimed");
    (uint256 boldAmount2, uint256 bribeTokenAmount2) = bribeInitiative.claimBribes(epochs);
    vm.stopPrank();
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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
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

## External Calls

- **Vm::warp(uint256)**
- **Governance::epoch()**
- **BribeInitiative::totalLQTYAllocatedByEpoch(uint256)**
- **BribeInitiative::lqtyAllocatedByUserAtEpoch(address,uint256)**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes)**
- **BribeInitiative::claimBribes(struct IBribeInitiative.ClaimData[])**
- **Vm::stopPrank()**

## State Variable Reads

- **user1** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusdHolder** (`address`)
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_claimBribes_same_epoch_reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._stakeLQTY(address,uint256) (NodeID: 1)
  │   💬 Args: [user1, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [1e18, 1e18, governance.epoch() + 1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._allocateLQTY(address,int256,int256) (NodeID: 3)
  │   💬 Args: [user1, 1e18, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [totalLQTYAllocated, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [userLQTYAllocated, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [1e18, 1e18, governance.epoch() + 1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [user1, governance.epoch() - 1, governance.epoch() - 2, governance.epoch() - 2]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256,bool) (NodeID: 8)
  │     💬 Args: [claimer, epoch, prevLQTYAllocationEpoch, prevTotalLQTYAllocationEpoch, false]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 9)
  │   💬 Args: [boldAmount1, 1e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
      💬 Args: [bribeTokenAmount1, 1e18]
      👁️  Def: internal
```
