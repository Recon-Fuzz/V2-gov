# Function: test_claimForInitiative()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_claimForInitiative()`
- **Visibility**: public
- **Source Range**: 53630:3358:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_claimForInitiative() public {
    vm.startPrank(user);
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), 1000e18);
    governance.depositLQTY(1000e18);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    vm.stopPrank();
    vm.startPrank(lusdHolder);
    lusd.transfer(address(governance), 10000e18);
    vm.stopPrank();
    vm.startPrank(user);
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](2);
    initiatives[0] = baseInitiative1;
    initiatives[1] = baseInitiative2;
    int256[] memory deltaVoteLQTY = new int256[](2);
    deltaVoteLQTY[0] = 500e18;
    deltaVoteLQTY[1] = 500e18;
    int256[] memory deltaVetoLQTY = new int256[](2);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    (, , uint256 allocatedLQTY, ) = governance.userStates(user);
    assertEq(allocatedLQTY, 1000e18);
    vm.warp((block.timestamp + governance.EPOCH_DURATION()) + 1);
    assertEq(governance.claimForInitiative(baseInitiative1), 5000e18, "first claim");
    assertEq(governance.claimForInitiative(baseInitiative1), 0);
    assertEq(governance.claimForInitiative(baseInitiative2), 5000e18, "first claim 2");
    assertEq(governance.claimForInitiative(baseInitiative2), 0);
    assertEq(lusd.balanceOf(baseInitiative2), 5000e18);
    vm.stopPrank();
    vm.startPrank(lusdHolder);
    lusd.transfer(address(governance), 10000e18);
    vm.stopPrank();
    vm.startPrank(user);
    initiativesToReset = new address[](2);
    initiativesToReset[0] = baseInitiative1;
    initiativesToReset[1] = baseInitiative2;
    initiatives = new address[](1);
    initiatives[0] = baseInitiative1;
    deltaVoteLQTY = new int256[](1);
    deltaVetoLQTY = new int256[](1);
    deltaVoteLQTY[0] = 495e18;
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    vm.warp((block.timestamp + governance.EPOCH_DURATION()) + 1);
    assertEq(governance.claimForInitiative(baseInitiative1), 10000e18);
    assertEq(governance.claimForInitiative(baseInitiative1), 0);
    assertEq(lusd.balanceOf(baseInitiative1), 15000e18);
    (IGovernance.InitiativeStatus status, , uint256 claimable) = governance.getInitiativeState(baseInitiative2);
    console.log("res", uint8(status));
    console.log("claimable", claimable);
    (uint256 votes, , , uint256 vetos) = governance.votesForInitiativeSnapshot(baseInitiative2);
    console.log("snapshot votes", votes);
    console.log("snapshot vetos", vetos);
    console.log("governance.getLatestVotingThreshold()", governance.getLatestVotingThreshold());
    assertEq(governance.claimForInitiative(baseInitiative2), 0, "zero 2");
    assertEq(governance.claimForInitiative(baseInitiative2), 0, "zero 3");
    assertEq(lusd.balanceOf(baseInitiative2), 5000e18, "zero bal");
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

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
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
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **Vm::stopPrank()**
- **ILUSD::transfer(address,uint256)**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **GovernanceTester::userStates(address)**
- **GovernanceTester::claimForInitiative(address)**
- **ILUSD::balanceOf(address)**
- **GovernanceTester::getInitiativeState(address)**
- **GovernanceTester::votesForInitiativeSnapshot(address)**
- **GovernanceTester::getLatestVotingThreshold()**

## Native Transfers

- **lusd** (computed)

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusdHolder** (`address`)
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_claimForInitiative() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [allocatedLQTY, 1000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [governance.claimForInitiative(baseInitiative1), 5000e18, "first claim"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [governance.claimForInitiative(baseInitiative1), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [governance.claimForInitiative(baseInitiative2), 5000e18, "first claim 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [governance.claimForInitiative(baseInitiative2), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [lusd.balanceOf(baseInitiative2), 5000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [governance.claimForInitiative(baseInitiative1), 10000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
  │   💬 Args: [governance.claimForInitiative(baseInitiative1), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 9)
  │   💬 Args: [lusd.balanceOf(baseInitiative1), 15000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 10)
  │   💬 Args: ["res", uint8(status)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 11)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 12)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 13)
  │   💬 Args: ["claimable", claimable]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 16)
  │   💬 Args: ["snapshot votes", votes]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 17)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 18)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 19)
  │   💬 Args: ["snapshot vetos", vetos]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 20)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 21)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 22)
  │   💬 Args: ["governance.getLatestVotingThreshold()", governance.getLatestVotingThreshold()]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 23)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 24)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 25)
  │   💬 Args: [governance.claimForInitiative(baseInitiative2), 0, "zero 2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 26)
  │   💬 Args: [governance.claimForInitiative(baseInitiative2), 0, "zero 3"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 27)
      💬 Args: [lusd.balanceOf(baseInitiative2), 5000e18, "zero bal"]
      👁️  Def: internal
```
