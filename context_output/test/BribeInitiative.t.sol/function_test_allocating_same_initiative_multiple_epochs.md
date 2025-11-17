# Function: test_allocating_same_initiative_multiple_epochs()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_allocating_same_initiative_multiple_epochs()`
- **Visibility**: public
- **Source Range**: 4790:1164:92

## Implementation

```solidity
function test_allocating_same_initiative_multiple_epochs() public {
    _stakeLQTY(user1, 10e18);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _allocateLQTY(user1, 5e18, 0);
    (uint256 totalLQTYAllocated1, , , ) = bribeInitiative.totalLQTYAllocatedByEpoch(governance.epoch());
    (uint256 userLQTYAllocated1, , , ) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user1, governance.epoch());
    assertEq(totalLQTYAllocated1, 5e18);
    assertEq(userLQTYAllocated1, 5e18);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _allocateLQTY(user1, 5e18, 0);
    (uint256 totalLQTYAllocated2, , , ) = bribeInitiative.totalLQTYAllocatedByEpoch(governance.epoch());
    (uint256 userLQTYAllocated2, , , ) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user1, governance.epoch());
    assertEq(totalLQTYAllocated2, 5e18);
    assertEq(userLQTYAllocated1, 5e18);
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
- **BribeInitiative::totalLQTYAllocatedByEpoch(uint256)**
- **Governance::epoch()**
- **BribeInitiative::lqtyAllocatedByUserAtEpoch(address,uint256)**

## State Variable Reads

- **user1** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_allocating_same_initiative_multiple_epochs() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._stakeLQTY(address,uint256) (NodeID: 1)
  │   💬 Args: [user1, 10e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._allocateLQTY(address,int256,int256) (NodeID: 2)
  │   💬 Args: [user1, 5e18, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [totalLQTYAllocated1, 5e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [userLQTYAllocated1, 5e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTest._allocateLQTY(address,int256,int256) (NodeID: 5)
  │   💬 Args: [user1, 5e18, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [totalLQTYAllocated2, 5e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
      💬 Args: [userLQTYAllocated1, 5e18]
      👁️  Def: internal
```
