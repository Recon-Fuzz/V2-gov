# Function: test_claimBribes_no_allocation_reverts()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_claimBribes_no_allocation_reverts()`
- **Visibility**: public
- **Source Range**: 33842:1312:92

## Implementation

```solidity
function test_claimBribes_no_allocation_reverts() public {
    _stakeLQTY(user1, 1e18);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _depositBribe(1e18, 1e18, governance.epoch() + 1);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _tryAllocateNothing(user1);
    (uint256 totalLQTYAllocated, , , ) = bribeInitiative.totalLQTYAllocatedByEpoch(governance.epoch());
    (uint256 userLQTYAllocated, , , ) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user1, governance.epoch());
    assertEq(totalLQTYAllocated, 0);
    assertEq(userLQTYAllocated, 0);
    _depositBribe(1e18, 1e18, governance.epoch() + 1);
    vm.warp(block.timestamp + (EPOCH_DURATION * 2));
    vm.startPrank(user1);
    BribeInitiative.ClaimData[] memory epochs = new BribeInitiative.ClaimData[](1);
    epochs[0].epoch = governance.epoch() - 1;
    epochs[0].prevLQTYAllocationEpoch = governance.epoch() - 2;
    epochs[0].prevTotalLQTYAllocationEpoch = governance.epoch() - 2;
    vm.expectRevert("BribeInitiative: total-lqty-allocation-zero");
    (uint256 boldAmount, uint256 bribeTokenAmount) = bribeInitiative.claimBribes(epochs);
    vm.stopPrank();
    assertEq(boldAmount, 0);
    assertEq(bribeTokenAmount, 0);
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

### _tryAllocateNothing(address)

- **Kind**: internal
- **Source**: 41519:549:92
- **Link**: `test/BribeInitiative.t.sol:BribeInitiativeTest:_tryAllocateNothing(address)`

```solidity
function _tryAllocateNothing(address staker) internal {
    vm.startPrank(staker);
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](1);
    initiatives[0] = address(bribeInitiative);
    int256[] memory absoluteVoteLQTY = new int256[](1);
    int256[] memory absoluteVetoLQTY = new int256[](1);
    vm.expectRevert("Governance: voting nothing");
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
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_claimBribes_no_allocation_reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._stakeLQTY(address,uint256) (NodeID: 1)
  │   💬 Args: [user1, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [1e18, 1e18, governance.epoch() + 1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._tryAllocateNothing(address) (NodeID: 3)
  │   💬 Args: [user1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [totalLQTYAllocated, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [userLQTYAllocated, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [1e18, 1e18, governance.epoch() + 1]
  │   👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [boldAmount, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
      💬 Args: [bribeTokenAmount, 0]
      👁️  Def: internal
```
