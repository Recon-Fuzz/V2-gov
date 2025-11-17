# Function: test_getLatestVotingThreshold()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_getLatestVotingThreshold()`
- **Visibility**: public
- **Source Range**: 13266:2651:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_getLatestVotingThreshold() public {
    governance = new GovernanceTester(address(lqty), address(lusd), address(stakingV1), address(lusd), IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint256(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF}), address(this), initialInitiatives);
    assertEq(governance.getLatestVotingThreshold(), 0);
    IGovernance.VoteSnapshot memory snapshot = IGovernance.VoteSnapshot(1e18, governance.epoch());
    governance.tester_setVotesSnapshot(snapshot);
    uint256 boldAccrued = 1000e18;
    governance.tester_setBoldAccrued(boldAccrued);
    assertEq(governance.getLatestVotingThreshold(), MIN_CLAIM / 1000);
    governance = new GovernanceTester(address(lqty), address(lusd), address(stakingV1), address(lusd), IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: 10e18, minAccrual: 10e18, epochStart: uint256(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF}), address(this), initialInitiatives);
    snapshot = IGovernance.VoteSnapshot(10000e18, governance.epoch());
    governance.tester_setVotesSnapshot(snapshot);
    boldAccrued = 1000e18;
    governance.tester_setBoldAccrued(boldAccrued);
    assertEq(governance.getLatestVotingThreshold(), 10000e18 * 0.04);
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

## External Calls

- **GovernanceTester::getLatestVotingThreshold()**
- **GovernanceTester::epoch()**
- **GovernanceTester::tester_setVotesSnapshot(struct IGovernance.VoteSnapshot)**
- **GovernanceTester::tester_setBoldAccrued(uint256)**

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
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_getLatestVotingThreshold() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [governance.getLatestVotingThreshold(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [governance.getLatestVotingThreshold(), MIN_CLAIM / 1000]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
      💬 Args: [governance.getLatestVotingThreshold(), 10000e18 * 0.04]
      👁️  Def: internal
```
