# Function: test_allocateLQTY_after_cutoff()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_allocateLQTY_after_cutoff()`
- **Visibility**: public
- **Source Range**: 45519:4643:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_allocateLQTY_after_cutoff() public {
    vm.startPrank(user);
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), 1e18);
    governance.depositLQTY(1e18);
    (, , uint256 allocatedLQTY, uint256 allocatedOffset) = governance.userStates(user);
    assertEq(allocatedLQTY, 0);
    (uint256 countedVoteLQTY, ) = governance.globalState();
    assertEq(countedVoteLQTY, 0);
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](1);
    initiatives[0] = baseInitiative1;
    int256[] memory deltaLQTYVotes = new int256[](1);
    deltaLQTYVotes[0] = 1e18;
    int256[] memory deltaLQTYVetos = new int256[](1);
    vm.expectRevert("Governance: active-vote-fsm");
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    (, , allocatedLQTY, ) = governance.userStates(user);
    assertEq(allocatedLQTY, 1e18);
    (uint256 voteLQTY, uint256 voteOffset, uint256 vetoLQTY, uint256 vetoOffset, ) = governance.initiativeStates(baseInitiative1);
    assertEq(voteLQTY, 1e18);
    assertEq(vetoLQTY, 0);
    (countedVoteLQTY, ) = governance.globalState();
    assertEq(countedVoteLQTY, 1e18);
    uint256 atEpoch;
    (voteLQTY, , vetoLQTY, , atEpoch) = governance.lqtyAllocatedByUserToInitiative(user, baseInitiative1);
    assertEq(voteLQTY, 1e18);
    assertEq(vetoLQTY, 0);
    assertEq(atEpoch, governance.epoch());
    assertGt(atEpoch, 0);
    (, uint256 forEpoch) = governance.votesSnapshot();
    assertEq(forEpoch, governance.epoch() - 1);
    (, forEpoch, , ) = governance.votesForInitiativeSnapshot(baseInitiative1);
    assertEq(forEpoch, governance.epoch() - 1);
    vm.stopPrank();
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    vm.startPrank(user2);
    address user2Proxy = governance.deployUserProxy();
    lqty.approve(address(user2Proxy), 1e18);
    governance.depositLQTY(1e18);
    (, uint256 unallocatedOffset, , ) = governance.userStates(user2);
    assertEq(governance.lqtyToVotes(1e18, block.timestamp, unallocatedOffset), 0);
    deltaLQTYVetos[0] = 1e18;
    vm.expectRevert("Governance: vote-and-veto");
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    deltaLQTYVetos[0] = 0;
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    (, , allocatedLQTY, ) = governance.userStates(user2);
    assertEq(allocatedLQTY, 1e18);
    (voteLQTY, voteOffset, vetoLQTY, vetoOffset, ) = governance.initiativeStates(baseInitiative1);
    assertEq(voteLQTY, 2e18);
    assertEq(vetoLQTY, 0);
    vm.expectRevert("Governance: insufficient-unallocated-lqty");
    governance.withdrawLQTY(1e18);
    vm.warp(((block.timestamp + EPOCH_DURATION) - governance.secondsWithinEpoch()) - 1);
    initiatives[0] = baseInitiative1;
    deltaLQTYVotes[0] = 1e18;
    governance.allocateLQTY(initiatives, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    (, , allocatedLQTY, ) = governance.userStates(msg.sender);
    assertEq(allocatedLQTY, 0, "user can allocate after voting cutoff");
    vm.stopPrank();
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

### assertGt(uint256,uint256)

- **Kind**: internal
- **Source**: 13112:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256)`

```solidity
function assertGt(uint256 left, uint256 right) virtual internal pure {
    vm.assertGt(left, right);
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

## External Calls

- **Vm::startPrank(address)**
- **GovernanceTester::deployUserProxy()**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **GovernanceTester::userStates(address)**
- **GovernanceTester::globalState()**
- **Vm::expectRevert(bytes)**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **GovernanceTester::initiativeStates(address)**
- **GovernanceTester::lqtyAllocatedByUserToInitiative(address,address)**
- **GovernanceTester::epoch()**
- **GovernanceTester::votesSnapshot()**
- **GovernanceTester::votesForInitiativeSnapshot(address)**
- **Vm::stopPrank()**
- **GovernanceTester::lqtyToVotes(uint256,uint256,uint256)**
- **GovernanceTester::withdrawLQTY(uint256)**
- **GovernanceTester::secondsWithinEpoch()**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **baseInitiative1** (`address`)
- **user2** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_allocateLQTY_after_cutoff() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [allocatedLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [countedVoteLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [allocatedLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [voteLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [vetoLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [countedVoteLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [voteLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
  │   💬 Args: [vetoLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 9)
  │   💬 Args: [atEpoch, governance.epoch()]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 10)
  │   💬 Args: [atEpoch, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 11)
  │   💬 Args: [forEpoch, governance.epoch() - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 12)
  │   💬 Args: [forEpoch, governance.epoch() - 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 13)
  │   💬 Args: [governance.lqtyToVotes(1e18, block.timestamp, unallocatedOffset), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 14)
  │   💬 Args: [allocatedLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 15)
  │   💬 Args: [voteLQTY, 2e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 16)
  │   💬 Args: [vetoLQTY, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 17)
      💬 Args: [allocatedLQTY, 0, "user can allocate after voting cutoff"]
      👁️  Def: internal
```
