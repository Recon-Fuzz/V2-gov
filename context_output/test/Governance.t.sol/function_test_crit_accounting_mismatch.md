# Function: test_crit_accounting_mismatch()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_crit_accounting_mismatch()`
- **Visibility**: public
- **Source Range**: 24340:2486:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
/// Used to demonstrate how composite voting could allow using more power than intended
function test_crit_accounting_mismatch() public {
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
    (, , uint256 allocatedLQTY, ) = governance.userStates(user);
    assertEq(allocatedLQTY, 1_000e18);
    (uint256 voteLQTY1, uint256 voteOffset1, , , ) = governance.initiativeStates(baseInitiative1);
    (uint256 voteLQTY2, , , , ) = governance.initiativeStates(baseInitiative2);
    uint256 votingPower = governance.lqtyToVotes(voteLQTY1, block.timestamp, voteOffset1);
    assertGt(votingPower, 0, "Non zero power");
    /// @audit TODO Fully digest and explain the bug
    {
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        (IGovernance.VoteSnapshot memory snapshot, IGovernance.InitiativeVoteSnapshot memory initiativeVoteSnapshot1) = governance.snapshotVotesForInitiative(baseInitiative1);
        (, IGovernance.InitiativeVoteSnapshot memory initiativeVoteSnapshot2) = governance.snapshotVotesForInitiative(baseInitiative2);
        uint256 threshold = governance.getLatestVotingThreshold();
        assertLt(initiativeVoteSnapshot1.votes, threshold, "it didn't get rewards");
        uint256 votingPowerWithProjection = governance.lqtyToVotes(voteLQTY1, uint256(governance.epochStart() + governance.EPOCH_DURATION()), voteOffset1);
        assertLt(votingPower, threshold, "Current Power is not enough - Desynch A");
        assertLt(votingPowerWithProjection, threshold, "Future Power is also not enough - Desynch B");
    }
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

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

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
- **GovernanceTester::userStates(address)**
- **GovernanceTester::initiativeStates(address)**
- **GovernanceTester::lqtyToVotes(uint256,uint256,uint256)**
- **GovernanceTester::snapshotVotesForInitiative(address)**
- **GovernanceTester::getLatestVotingThreshold()**
- **GovernanceTester::epochStart()**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_crit_accounting_mismatch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [allocatedLQTY, 1_000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [votingPower, 0, "Non zero power"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [initiativeVoteSnapshot1.votes, threshold, "it didn't get rewards"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [votingPower, threshold, "Current Power is not enough - Desynch A"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertLt(uint256,uint256,string) (NodeID: 5)
      💬 Args: [votingPowerWithProjection, threshold, "Future Power is also not enough - Desynch B"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

Used to demonstrate how composite voting could allow using more power than intended
