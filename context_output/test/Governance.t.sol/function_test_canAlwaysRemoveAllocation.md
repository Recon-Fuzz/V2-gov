# Function: test_canAlwaysRemoveAllocation()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_canAlwaysRemoveAllocation()`
- **Visibility**: public
- **Source Range**: 26918:2869:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_canAlwaysRemoveAllocation() public {
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
    governance.unregisterInitiative(baseInitiative1);
    address[] memory removeInitiatives = new address[](2);
    removeInitiatives[0] = baseInitiative1;
    removeInitiatives[1] = baseInitiative2;
    governance.resetAllocations(removeInitiatives, true);
    int256[] memory removeDeltaLQTYVotes = new int256[](2);
    int256[] memory removeDeltaLQTYVetos = new int256[](2);
    removeDeltaLQTYVotes[0] = -1e18;
    vm.expectRevert("Cannot be negative");
    governance.allocateLQTY(initiativesToReset, removeInitiatives, removeDeltaLQTYVotes, removeDeltaLQTYVetos);
    address[] memory reAddInitiatives = new address[](1);
    reAddInitiatives[0] = baseInitiative1;
    int256[] memory reAddDeltaLQTYVotes = new int256[](1);
    reAddDeltaLQTYVotes[0] = 1e18;
    int256[] memory reAddDeltaLQTYVetos = new int256[](1);
    /// @audit This MUST revert, an initiative should not be re-votable once disabled
    vm.expectRevert("Governance: active-vote-fsm");
    governance.allocateLQTY(initiativesToReset, reAddInitiatives, reAddDeltaLQTYVotes, reAddDeltaLQTYVetos);
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
- **GovernanceTester::unregisterInitiative(address)**
- **GovernanceTester::resetAllocations(address[],bool)**
- **Vm::expectRevert(bytes)**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_canAlwaysRemoveAllocation() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 1)
      💬 Args: [initiativeVoteSnapshot1.votes, threshold, "it didn't get rewards"]
      👁️  Def: internal
```
