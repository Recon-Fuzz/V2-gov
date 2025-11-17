# Function: test_voting_power_increase()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_voting_power_increase()`
- **Visibility**: public
- **Source Range**: 65404:6318:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_voting_power_increase() public {
    governance = new GovernanceTester(address(lqty), address(lusd), address(stakingV1), address(lusd), IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint256(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF}), address(this), initialInitiatives);
    uint256 lqtyAmount = 1e18;
    _stakeLQTY(user, lqtyAmount);
    (, , uint256 allocatedLQTY0, uint256 allocatedOffset0) = governance.userStates(user);
    uint256 currentUserPower0 = governance.lqtyToVotes(allocatedLQTY0, block.timestamp, allocatedOffset0);
    (uint256 voteLQTY0, uint256 voteOffset0, , , ) = governance.initiativeStates(baseInitiative1);
    uint256 currentInitiativePower0 = governance.lqtyToVotes(voteLQTY0, block.timestamp, voteOffset0);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _allocateLQTY(user, lqtyAmount);
    (, , uint256 allocatedLQTY1, uint256 allocatedOffset1) = governance.userStates(user);
    uint256 currentUserPower1 = governance.lqtyToVotes(allocatedLQTY1, block.timestamp, allocatedOffset1);
    assertGt(currentUserPower1, 0, "current user voting power is 0");
    (uint256 voteLQTY1, uint256 votOffset1, , , ) = governance.initiativeStates(baseInitiative1);
    uint256 currentInitiativePower1 = governance.lqtyToVotes(voteLQTY1, block.timestamp, votOffset1);
    assertGt(currentInitiativePower1, 0, "current initiative voting power is 0");
    assertEq(currentUserPower1, currentInitiativePower1, "initiative and user voting power should be equal");
    vm.warp((block.timestamp + EPOCH_DURATION) - 1);
    governance.snapshotVotesForInitiative(baseInitiative1);
    (, , uint256 allocatedLQTY2, uint256 allocatedOffset2) = governance.userStates(user);
    uint256 currentUserPower2 = governance.lqtyToVotes(allocatedLQTY2, block.timestamp, allocatedOffset2);
    assertGt(currentUserPower2, currentUserPower1);
    (uint256 voteLQTY2, uint256 voteOffset2, , , ) = governance.initiativeStates(baseInitiative1);
    uint256 currentInitiativePower2 = governance.lqtyToVotes(voteLQTY2, block.timestamp, voteOffset2);
    assertEq(currentUserPower2, currentInitiativePower2, "user power and initiative power should increase by same amount");
    (uint256 votes, uint256 forEpoch, , ) = governance.votesForInitiativeSnapshot(baseInitiative1);
    assertEq(votes, 0, "votes get counted in epoch that they were allocated");
    vm.warp(block.timestamp + 1);
    governance.snapshotVotesForInitiative(baseInitiative1);
    (, , uint256 allocatedLQTY3, uint256 allocatedOffset) = governance.userStates(user);
    uint256 currentUserPower3 = governance.lqtyToVotes(allocatedLQTY3, block.timestamp, allocatedOffset);
    (uint256 voteLQTY3, uint256 voteOffset3, , , ) = governance.initiativeStates(baseInitiative1);
    uint256 currentInitiativePower3 = governance.lqtyToVotes(voteLQTY3, block.timestamp, voteOffset3);
    (votes, forEpoch, , ) = governance.votesForInitiativeSnapshot(baseInitiative1);
    assertEq(votes, currentUserPower3, "initiative votes != user allocated lqty power");
    assertEq(votes, currentInitiativePower3, "initiative votes != iniative allocated lqty power");
    vm.warp((block.timestamp + EPOCH_DURATION) - 1);
    governance.snapshotVotesForInitiative(baseInitiative1);
    (, , uint256 allocatedLQTY4, uint256 allocatedOffset4) = governance.userStates(user);
    uint256 currentUserPower4 = governance.lqtyToVotes(allocatedLQTY4, block.timestamp, allocatedOffset4);
    (uint256 voteLQTY4, uint256 voteOffset4, , , ) = governance.initiativeStates(baseInitiative1);
    uint256 currentInitiativePower4 = governance.lqtyToVotes(voteLQTY4, block.timestamp, voteOffset4);
    (uint256 votes2, , , ) = governance.votesForInitiativeSnapshot(baseInitiative1);
    assertEq(votes, votes2, "votes for an initiative snapshot increase in same epoch");
}
```

## Related Implementations

### _stakeLQTY(address,uint256)

- **Kind**: internal
- **Source**: 111633:285:99
- **Link**: `test/Governance.t.sol:GovernanceTest:_stakeLQTY(address,uint256)`

```solidity
function _stakeLQTY(address staker, uint256 amount) internal {
    vm.startPrank(staker);
    address userProxy = governance.deriveUserProxyAddress(staker);
    lqty.approve(address(userProxy), amount);
    governance.depositLQTY(amount);
    vm.stopPrank();
}
```

### _allocateLQTY(address,uint256)

- **Kind**: internal
- **Source**: 111924:861:99
- **Link**: `test/Governance.t.sol:GovernanceTest:_allocateLQTY(address,uint256)`

```solidity
function _allocateLQTY(address allocator, uint256 amount) internal {
    vm.startPrank(allocator);
    address[] memory initiativesToReset;
    (uint256 currentVote, , uint256 currentVeto, , ) = governance.lqtyAllocatedByUserToInitiative(allocator, address(baseInitiative1));
    if ((currentVote != 0) || (currentVeto != 0)) {
        initiativesToReset = new address[](1);
        initiativesToReset[0] = address(baseInitiative1);
    }
    address[] memory initiatives = new address[](1);
    initiatives[0] = baseInitiative1;
    int256[] memory deltaLQTYVotes = new int256[](1);
    deltaLQTYVotes[0] = int256(amount);
    int256[] memory deltaLQTYVetos = new int256[](1);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    vm.stopPrank();
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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

## External Calls

- **GovernanceTester::userStates(address)**
- **GovernanceTester::lqtyToVotes(uint256,uint256,uint256)**
- **GovernanceTester::initiativeStates(address)**
- **Vm::warp(uint256)**
- **GovernanceTester::snapshotVotesForInitiative(address)**
- **GovernanceTester::votesForInitiativeSnapshot(address)**

## State Variable Reads

- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **stakingV1** (`contract ILQTYStaking`) [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **REGISTRATION_FEE** (`uint256`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **MIN_ACCRUAL** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **initialInitiatives** (`address[]`)
- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **baseInitiative1** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_voting_power_increase() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: GovernanceTest._stakeLQTY(address,uint256) (NodeID: 1)
  │   💬 Args: [user, lqtyAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GovernanceTest._allocateLQTY(address,uint256) (NodeID: 2)
  │   💬 Args: [user, lqtyAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [currentUserPower1, 0, "current user voting power is 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [currentInitiativePower1, 0, "current initiative voting power is 0"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
  │   💬 Args: [currentUserPower1, currentInitiativePower1, "initiative and user voting power should be equal"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256) (NodeID: 6)
  │   💬 Args: [currentUserPower2, currentUserPower1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [currentUserPower2, currentInitiativePower2, "user power and initiative power should increase by same amount"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [votes, 0, "votes get counted in epoch that they were allocated"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [votes, currentUserPower3, "initiative votes != user allocated lqty power"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 10)
  │   💬 Args: [votes, currentInitiativePower3, "initiative votes != iniative allocated lqty power"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 11)
      💬 Args: [votes, votes2, "votes for an initiative snapshot increase in same epoch"]
      👁️  Def: internal
```
