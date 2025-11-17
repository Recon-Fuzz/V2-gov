# Function: test_voting_power_lqtyAllocatedByUserToInitiative()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_voting_power_lqtyAllocatedByUserToInitiative()`
- **Visibility**: public
- **Source Range**: 79053:2044:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_voting_power_lqtyAllocatedByUserToInitiative() public {
    governance = new GovernanceTester(address(lqty), address(lusd), address(stakingV1), address(lusd), IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint256(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF}), address(this), initialInitiatives);
    uint256 lqtyAmount = 1e18;
    _stakeLQTY(user, lqtyAmount);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _allocateLQTY(user, lqtyAmount);
    (uint256 voteLQTY, uint256 voteOffset, , , ) = governance.lqtyAllocatedByUserToInitiative(user, baseInitiative1);
    (, , uint256 allocatedLQTY, uint256 allocatedOffset) = governance.userStates(user);
    uint256 currentInitiativePowerFrom1 = governance.lqtyToVotes(voteLQTY, block.timestamp, voteOffset);
    uint256 currentInitiativePowerFrom2 = governance.lqtyToVotes(allocatedLQTY, block.timestamp, allocatedOffset);
    assertEq(currentInitiativePowerFrom1, currentInitiativePowerFrom2, "currentInitiativePowerFrom1 != currentInitiativePowerFrom2");
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

- **Vm::warp(uint256)**
- **GovernanceTester::lqtyAllocatedByUserToInitiative(address,address)**
- **GovernanceTester::userStates(address)**
- **GovernanceTester::lqtyToVotes(uint256,uint256,uint256)**

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
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_voting_power_lqtyAllocatedByUserToInitiative() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: GovernanceTest._stakeLQTY(address,uint256) (NodeID: 1)
  │   💬 Args: [user, lqtyAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GovernanceTest._allocateLQTY(address,uint256) (NodeID: 2)
  │   💬 Args: [user, lqtyAmount]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [currentInitiativePowerFrom1, currentInitiativePowerFrom2, "currentInitiativePowerFrom1 != currentInitiativePowerFrom2"]
      👁️  Def: internal
```
