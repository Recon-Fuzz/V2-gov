# Function: test_addRemoveAllocation_accounting()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_addRemoveAllocation_accounting()`
- **Visibility**: public
- **Source Range**: 32677:4378:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_addRemoveAllocation_accounting() public {
    vm.startPrank(user);
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), 1_000e18);
    governance.depositLQTY(1_000e18);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    /// Setup and vote for 2 initiatives, 0.1% vs 99.9%
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](2);
    initiatives[0] = baseInitiative1;
    initiatives[1] = baseInitiative2;
    int256[] memory deltaLQTYVotes = new int256[](2);
    deltaLQTYVotes[0] = 1e18;
    deltaLQTYVotes[1] = 999e18;
    int256[] memory deltaLQTYVetos = new int256[](2);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    {
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        (IGovernance.VoteSnapshot memory snapshot, IGovernance.InitiativeVoteSnapshot memory initiativeVoteSnapshot1) = governance.snapshotVotesForInitiative(baseInitiative1);
        uint256 threshold = governance.getLatestVotingThreshold();
        assertLt(initiativeVoteSnapshot1.votes, threshold, "it didn't get rewards");
    }
    vm.warp(block.timestamp + (governance.UNREGISTRATION_AFTER_EPOCHS() * governance.EPOCH_DURATION()));
    /// === END SETUP === ///
    (uint256 b4_countedVoteLQTY, uint256 b4_countedVoteOffset) = governance.globalState();
    (, , uint256 b4_allocatedLQTY, uint256 b4_allocatedOffset) = governance.userStates(user);
    (uint256 b4_voteLQTY, , , , ) = governance.initiativeStates(baseInitiative1);
    governance.unregisterInitiative(baseInitiative1);
    (uint256 after_countedVoteLQTY, ) = governance.globalState();
    assertEq(after_countedVoteLQTY, b4_countedVoteLQTY - b4_voteLQTY, "Global Lqty change after unregister");
    assertEq(1e18, b4_voteLQTY, "sanity check");
    (, , uint256 after_allocatedLQTY, uint256 after_unallocatedOffset) = governance.userStates(user);
    (uint256 after_voteLQTY, uint256 after_voteOffset, uint256 after_vetoLQTY, uint256 after_vetoOffset, uint256 after_lastEpochClaim) = governance.initiativeStates(baseInitiative1);
    assertEq(b4_voteLQTY, after_voteLQTY, "Initiative votes are the same");
    address[] memory removeInitiatives = new address[](2);
    removeInitiatives[0] = baseInitiative1;
    removeInitiatives[1] = baseInitiative2;
    /// @audit the next call MUST not revert - this is a critical bug
    governance.resetAllocations(removeInitiatives, true);
    {
        (uint256 after_user_countedVoteLQTY, uint256 after_user_countedVoteOffset) = governance.globalState();
        assertEq(after_user_countedVoteLQTY, 0, "Removal 1");
    }
    {
        (, , uint256 after_user_allocatedLQTY, ) = governance.userStates(user);
        assertEq(after_user_allocatedLQTY, 0, "Removal 2");
    }
    {
        (uint256 after_user_voteLQTY, , , , ) = governance.initiativeStates(baseInitiative1);
        assertEq(after_user_voteLQTY, 0, "Removal 3");
    }
}
```

## Related Implementations

### assertLt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 12044:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLt(uint256,uint256,string)`

```solidity
function assertLt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertLt(left, right, err);
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
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **GovernanceTester::snapshotVotesForInitiative(address)**
- **GovernanceTester::getLatestVotingThreshold()**
- **GovernanceTester::UNREGISTRATION_AFTER_EPOCHS()**
- **GovernanceTester::globalState()**
- **GovernanceTester::userStates(address)**
- **GovernanceTester::initiativeStates(address)**
- **GovernanceTester::unregisterInitiative(address)**
- **GovernanceTester::resetAllocations(address[],bool)**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_addRemoveAllocation_accounting() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [initiativeVoteSnapshot1.votes, threshold, "it didn't get rewards"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [after_countedVoteLQTY, b4_countedVoteLQTY - b4_voteLQTY, "Global Lqty change after unregister"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [1e18, b4_voteLQTY, "sanity check"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [b4_voteLQTY, after_voteLQTY, "Initiative votes are the same"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [after_user_countedVoteLQTY, 0, "Removal 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [after_user_allocatedLQTY, 0, "Removal 2"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
      💬 Args: [after_user_voteLQTY, 0, "Removal 3"]
      👁️  Def: internal
```
