# Function: test_voting_power_decreases_next_epoch()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_voting_power_decreases_next_epoch()`
- **Visibility**: public
- **Source Range**: 94275:2562:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_voting_power_decreases_next_epoch() public {
    governance = new GovernanceTester(address(lqty), address(lusd), address(stakingV1), address(lusd), IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint256(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF}), address(this), initialInitiatives);
    uint256 lqtyAmount = 1e18;
    _stakeLQTY(user, lqtyAmount);
    vm.warp(block.timestamp + EPOCH_DURATION);
    _allocateLQTY(user, lqtyAmount);
    vm.warp(block.timestamp + EPOCH_DURATION);
    console2.log("current epoch A: ", governance.epoch());
    governance.snapshotVotesForInitiative(baseInitiative1);
    (uint256 votes, , , ) = governance.votesForInitiativeSnapshot(baseInitiative1);
    assertGt(votes, 0, "voting power should increase");
    _deAllocateLQTY(user, 0);
    governance.snapshotVotesForInitiative(baseInitiative1);
    (uint256 votes2, , , ) = governance.votesForInitiativeSnapshot(baseInitiative1);
    assertGt(votes2, 0, "voting power should not decrease this epoch");
    vm.warp(block.timestamp + EPOCH_DURATION);
    console2.log("current epoch B: ", governance.epoch());
    governance.snapshotVotesForInitiative(baseInitiative1);
    (uint256 votes3, , , ) = governance.votesForInitiativeSnapshot(baseInitiative1);
    assertEq(votes3, 0, "voting power should be decreased in this epoch");
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:22
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

### _sendLogPayload(bytes)

- **Kind**: internal
- **Source**: 9648:133:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_sendLogPayload(bytes)`

```solidity
function _sendLogPayload(bytes memory payload) internal pure {
    _castLogPayloadViewToPure(_sendLogPayloadView)(payload);
}
```

### _castLogPayloadViewToPure(function (bytes)

- **Kind**: internal
- **Source**: 9407:235:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_castLogPayloadViewToPure(function (bytes) view)`

```solidity
function _castLogPayloadViewToPure(function(bytes memory) internal view fnIn) internal pure returns (function(bytes memory) internal pure fnOut) {
    assembly {
        fnOut := fnIn
    }
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

### _deAllocateLQTY(address,uint256)

- **Kind**: internal
- **Source**: 114249:290:99
- **Link**: `test/Governance.t.sol:GovernanceTest:_deAllocateLQTY(address,uint256)`

```solidity
function _deAllocateLQTY(address allocator, uint256 amount) internal {
    address[] memory initiatives = new address[](1);
    initiatives[0] = baseInitiative1;
    vm.startPrank(allocator);
    governance.resetAllocations(initiatives, true);
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
- **GovernanceTester::epoch()**
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
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_voting_power_decreases_next_epoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: GovernanceTest._stakeLQTY(address,uint256) (NodeID: 1)
  │   💬 Args: [user, lqtyAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GovernanceTest._allocateLQTY(address,uint256) (NodeID: 2)
  │   💬 Args: [user, lqtyAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 3)
  │   💬 Args: ["current epoch A: ", governance.epoch()]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [votes, 0, "voting power should increase"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GovernanceTest._deAllocateLQTY(address,uint256) (NodeID: 7)
  │   💬 Args: [user, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [votes2, 0, "voting power should not decrease this epoch"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 9)
  │   💬 Args: ["current epoch B: ", governance.epoch()]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 10)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 11)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
      💬 Args: [votes3, 0, "voting power should be decreased in this epoch"]
      👁️  Def: internal
```
