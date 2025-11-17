# Function: test_allocateLQTY_single()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_allocateLQTY_single()`
- **Visibility**: public
- **Source Range**: 40611:4902:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_allocateLQTY_single() public {
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
    IGovernance.UserState memory user2State;
    (user2State.unallocatedLQTY, user2State.unallocatedOffset, user2State.allocatedLQTY, user2State.allocatedOffset) = governance.userStates(user2);
    assertEq(user2State.allocatedLQTY, 0);
    assertEq(user2State.allocatedOffset, 0);
    assertEq(governance.lqtyToVotes(user2State.unallocatedLQTY, uint256(block.timestamp), user2State.unallocatedOffset), 0);
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
    governance.resetAllocations(initiatives, true);
    (, , allocatedLQTY, ) = governance.userStates(user2);
    assertEq(allocatedLQTY, 0);
    (countedVoteLQTY, ) = governance.globalState();
    console.log("countedVoteLQTY: ", countedVoteLQTY);
    assertEq(countedVoteLQTY, 1e18);
    (voteLQTY, voteOffset, vetoLQTY, vetoOffset, ) = governance.initiativeStates(baseInitiative1);
    assertEq(voteLQTY, 1e18);
    assertEq(vetoLQTY, 0);
    assertEq(vetoOffset, 0);
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
- **GovernanceTester::resetAllocations(address[],bool)**

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
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_allocateLQTY_single() (NodeID: 0)
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
  │   💬 Args: [user2State.allocatedLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 14)
  │   💬 Args: [user2State.allocatedOffset, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 15)
  │   💬 Args: [governance.lqtyToVotes(user2State.unallocatedLQTY, uint256(block.timestamp), user2State.unallocatedOffset), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 16)
  │   💬 Args: [allocatedLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 17)
  │   💬 Args: [voteLQTY, 2e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 18)
  │   💬 Args: [vetoLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 19)
  │   💬 Args: [allocatedLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 20)
  │   💬 Args: ["countedVoteLQTY: ", countedVoteLQTY]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 21)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 22)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 23)
  │   💬 Args: [countedVoteLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 24)
  │   💬 Args: [voteLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 25)
  │   💬 Args: [vetoLQTY, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 26)
      💬 Args: [vetoOffset, 0]
      👁️  Def: internal
```
