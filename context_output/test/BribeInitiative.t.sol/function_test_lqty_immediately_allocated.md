# Function: test_lqty_immediately_allocated()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_lqty_immediately_allocated()`
- **Visibility**: public
- **Source Range**: 25332:899:92

## Implementation

```solidity
function test_lqty_immediately_allocated() public {
    _stakeLQTY(user1, 1e18);
    vm.warp(block.timestamp + EPOCH_DURATION);
    assertEq(2, governance.epoch(), "not in epoch 2");
    _depositBribe(1e18, 1e18, governance.epoch() + 1);
    vm.warp(block.timestamp + EPOCH_DURATION);
    assertEq(3, governance.epoch(), "not in epoch 3");
    _allocateLQTY(user1, 1e18, 0);
    (uint256 lqtyAllocated, , , ) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user1, governance.epoch());
    assertEq(lqtyAllocated, 1e18, "lqty doesn't immediately get allocated");
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

## External Calls

- **Vm::warp(uint256)**
- **Governance::epoch()**
- **BribeInitiative::lqtyAllocatedByUserAtEpoch(address,uint256)**

## State Variable Reads

- **user1** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **lusdHolder** (`address`)
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_lqty_immediately_allocated() (NodeID: 0)
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
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
      💬 Args: [lqtyAllocated, 1e18, "lqty doesn't immediately get allocated"]
      👁️  Def: internal
```
