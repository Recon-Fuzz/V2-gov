# Function: test_rationalFlow()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_rationalFlow()`
- **Visibility**: public
- **Source Range**: 26292:2067:92

## Implementation

```solidity
function test_rationalFlow() public {
    vm.warp(block.timestamp + (EPOCH_DURATION));
    _stakeLQTY(user1, 1e18);
    _allocateLQTY(user1, 5e17, 0);
    /// @audit WTF
    _depositBribe(1e18, 1e18, governance.epoch());
    /// @audit IMO this should also work
    _allocateLQTY(user1, 5e17, 0);
    /// @audit Allocate b4 or after bribe should be irrelevant
    _depositBribe(1e18, 1e18, governance.epoch() + 1);
    (uint256 totalLQTYAllocated, , , ) = bribeInitiative.totalLQTYAllocatedByEpoch(governance.epoch());
    (uint256 userLQTYAllocated, , , ) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user1, governance.epoch());
    assertEq(totalLQTYAllocated, 5e17, "total allocation");
    assertEq(userLQTYAllocated, 5e17, "user allocation");
    vm.warp(block.timestamp + (EPOCH_DURATION));
    (uint256 boldAmount, uint256 bribeTokenAmount) = _claimBribe(user1, governance.epoch() - 1, governance.epoch() - 1, governance.epoch() - 1);
    assertEq(boldAmount, 1e18, "bold amount");
    assertEq(bribeTokenAmount, 1e18, "bribe amount");
    _claimBribe(user1, governance.epoch(), governance.epoch() - 1, governance.epoch() - 1, true);
    _resetAllocation(user1);
    (userLQTYAllocated, , , ) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user1, governance.epoch());
    (totalLQTYAllocated, , , ) = bribeInitiative.totalLQTYAllocatedByEpoch(governance.epoch());
    assertEq(userLQTYAllocated, 0, "total allocation");
    assertEq(totalLQTYAllocated, 0, "user allocation");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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
- **BribeInitiative::totalLQTYAllocatedByEpoch(uint256)**
- **BribeInitiative::lqtyAllocatedByUserAtEpoch(address,uint256)**

## State Variable Reads

- **EPOCH_DURATION** (`uint256`)
- **user1** (`address`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusdHolder** (`address`)
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_rationalFlow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._stakeLQTY(address,uint256) (NodeID: 1)
  │   💬 Args: [user1, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._allocateLQTY(address,int256,int256) (NodeID: 2)
  │   💬 Args: [user1, 5e17, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [1e18, 1e18, governance.epoch()]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._allocateLQTY(address,int256,int256) (NodeID: 4)
  │   💬 Args: [user1, 5e17, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [1e18, 1e18, governance.epoch() + 1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [totalLQTYAllocated, 5e17, "total allocation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [userLQTYAllocated, 5e17, "user allocation"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256) (NodeID: 8)
  │   💬 Args: [user1, governance.epoch() - 1, governance.epoch() - 1, governance.epoch() - 1]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256,bool) (NodeID: 9)
  │     💬 Args: [claimer, epoch, prevLQTYAllocationEpoch, prevTotalLQTYAllocationEpoch, false]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [boldAmount, 1e18, "bold amount"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
  │   💬 Args: [bribeTokenAmount, 1e18, "bribe amount"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256,bool) (NodeID: 12)
  │   💬 Args: [user1, governance.epoch(), governance.epoch() - 1, governance.epoch() - 1, true]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._resetAllocation(address) (NodeID: 13)
  │   💬 Args: [user1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 14)
  │   💬 Args: [userLQTYAllocated, 0, "total allocation"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 15)
      💬 Args: [totalLQTYAllocated, 0, "user allocation"]
      👁️  Def: internal
```
