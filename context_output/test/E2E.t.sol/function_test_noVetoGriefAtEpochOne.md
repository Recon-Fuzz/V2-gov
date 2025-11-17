# Function: test_noVetoGriefAtEpochOne()

**Contract**: [test/E2E.t.sol/contract_ForkedE2ETests.md]

## Metadata

- **Contract**: ForkedE2ETests
- **Signature**: `test_noVetoGriefAtEpochOne()`
- **Visibility**: public
- **Source Range**: 5283:691:98

## Implementation

```solidity
function test_noVetoGriefAtEpochOne() public {
    /// @audit NOTE: In order for this to work, the constructor must set the start time a week behind
    ///  This will make the initiatives work on the first epoch
    vm.startPrank(user);
    _deposit(1000e18);
    console.log("epoch", governance.epoch());
    _allocate(baseInitiative1, 0, 1e18);
    vm.expectRevert();
    governance.unregisterInitiative(baseInitiative1);
    vm.warp(block.timestamp + EPOCH_DURATION);
    governance.unregisterInitiative(baseInitiative1);
}
```

## Related Implementations

### _deposit(uint256)

- **Kind**: internal
- **Source**: 13441:190:98
- **Link**: `test/E2E.t.sol:ForkedE2ETests:_deposit(uint256)`

```solidity
function _deposit(uint256 amt) internal {
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), amt);
    governance.depositLQTY(amt);
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

### _allocate(address,int256,int256)

- **Kind**: internal
- **Source**: 13637:525:98
- **Link**: `test/E2E.t.sol:ForkedE2ETests:_allocate(address,int256,int256)`

```solidity
function _allocate(address initiative, int256 votes, int256 vetos) internal {
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](1);
    initiatives[0] = initiative;
    int256[] memory absoluteLQTYVotes = new int256[](1);
    absoluteLQTYVotes[0] = votes;
    int256[] memory absoluteLQTYVetos = new int256[](1);
    absoluteLQTYVetos[0] = vetos;
    governance.allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
}
```

## External Calls

- **Vm::startPrank(address)**
- **Governance::epoch()**
- **Vm::expectRevert()**
- **Governance::unregisterInitiative(address)**
- **Vm::warp(uint256)**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **baseInitiative1** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ForkedE2ETests.test_noVetoGriefAtEpochOne() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ForkedE2ETests._deposit(uint256) (NodeID: 1)
  │   💬 Args: [1000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 2)
  │   💬 Args: ["epoch", governance.epoch()]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 3)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 4)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ForkedE2ETests._allocate(address,int256,int256) (NodeID: 5)
      💬 Args: [baseInitiative1, 0, 1e18]
      👁️  Def: internal
```
