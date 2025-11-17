# Function: test_overflow_crit()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_overflow_crit()`
- **Visibility**: public
- **Source Range**: 37170:2425:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_overflow_crit() public {
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
    (uint256 allocatedB4Test, , , , ) = governance.lqtyAllocatedByUserToInitiative(user, baseInitiative1);
    console.log("allocatedB4Test", allocatedB4Test);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    address[] memory removeInitiatives = new address[](2);
    removeInitiatives[0] = baseInitiative1;
    removeInitiatives[1] = baseInitiative2;
    (uint256 allocatedB4Removal, , , , ) = governance.lqtyAllocatedByUserToInitiative(user, baseInitiative1);
    console.log("allocatedB4Removal", allocatedB4Removal);
    governance.resetAllocations(removeInitiatives, true);
    (uint256 allocatedAfterRemoval, , , , ) = governance.lqtyAllocatedByUserToInitiative(user, baseInitiative1);
    console.log("allocatedAfterRemoval", allocatedAfterRemoval);
    vm.expectRevert("Governance: nothing to reset");
    governance.resetAllocations(removeInitiatives, true);
    int256[] memory removeDeltaLQTYVotes = new int256[](2);
    int256[] memory removeDeltaLQTYVetos = new int256[](2);
    vm.expectRevert("Governance: voting nothing");
    governance.allocateLQTY(initiativesToReset, removeInitiatives, removeDeltaLQTYVotes, removeDeltaLQTYVetos);
    (uint256 allocatedAfter, , , , ) = governance.lqtyAllocatedByUserToInitiative(user, baseInitiative1);
    console.log("allocatedAfter", allocatedAfter);
}
```

## Related Implementations

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
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **GovernanceTester::lqtyAllocatedByUserToInitiative(address,address)**
- **GovernanceTester::resetAllocations(address[],bool)**
- **Vm::expectRevert(bytes)**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_overflow_crit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 1)
  │   💬 Args: ["allocatedB4Test", allocatedB4Test]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 4)
  │   💬 Args: ["allocatedB4Removal", allocatedB4Removal]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 7)
  │   💬 Args: ["allocatedAfterRemoval", allocatedAfterRemoval]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 10)
      💬 Args: ["allocatedAfter", allocatedAfter]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 11)
        💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 12)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
