# Function: test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256)

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 108293:1453:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256 initialVotingPower, uint256 numWithdrawals) external {
    initialVotingPower = bound(initialVotingPower, 1, 20);
    numWithdrawals = bound(numWithdrawals, 1, 20);
    vm.startPrank(user);
    {
        address userProxy = governance.deriveUserProxyAddress(user);
        lqty.approve(userProxy, type(uint256).max);
        governance.depositLQTY(1);
        vm.warp(block.timestamp + initialVotingPower);
        governance.depositLQTY(1 ether);
        for (uint256 i = 0; i < numWithdrawals; ++i) {
            governance.withdrawLQTY(1);
        }
    }
    vm.stopPrank();
    (uint256 unallocatedLQTY, uint256 unallocatedOffset, , ) = governance.userStates(user);
    int256 votingPower = int256(unallocatedLQTY * block.timestamp) - int256(unallocatedOffset);
    assertEq(votingPower, int256((initialVotingPower > numWithdrawals) ? (initialVotingPower - numWithdrawals) : 0), "voting power should stay non-negative");
}
```

## Related Implementations

### bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2915:199:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:bound(uint256,uint256,uint256)`

```solidity
function bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    result = _bound(x, min, max);
    console2_log_StdUtils("Bound result", result);
}
```

### _bound(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1646:1263:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:_bound(uint256,uint256,uint256)`

```solidity
function _bound(uint256 x, uint256 min, uint256 max) virtual internal pure returns (uint256 result) {
    require(min <= max, "StdUtils bound(uint256,uint256,uint256): Max is less than min.");
    if ((x >= min) && (x <= max)) return x;
    uint256 size = (max - min) + 1;
    if ((x <= 3) && (size > x)) return min + x;
    if ((x >= (UINT256_MAX - 3)) && (size > (UINT256_MAX - x))) return max - (UINT256_MAX - x);
    if (x > max) {
        uint256 diff = x - max;
        uint256 rem = diff % size;
        if (rem == 0) return max;
        result = (min + rem) - 1;
    } else if (x < min) {
        uint256 diff = min - x;
        uint256 rem = diff % size;
        if (rem == 0) return min;
        result = (max - rem) + 1;
    }
}
```

### console2_log_StdUtils(string,uint256)

- **Kind**: internal
- **Source**: 10318:162:19
- **Link**: `lib/forge-std/src/StdUtils.sol:StdUtils:console2_log_StdUtils(string,uint256)`

```solidity
function console2_log_StdUtils(string memory p0, uint256 p1) private pure {
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

### assertEq(int256,int256,string)

- **Kind**: internal
- **Source**: 2980:132:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(int256,int256,string)`

```solidity
function assertEq(int256 left, int256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Vm::startPrank(address)**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **Vm::warp(uint256)**
- **GovernanceTester::withdrawLQTY(uint256)**
- **Vm::stopPrank()**
- **GovernanceTester::userStates(address)**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **UINT256_MAX** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [initialVotingPower, 1, 20]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 3)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 4)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 5)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [numWithdrawals, 1, 20]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 7)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 8)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 9)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 10)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256,string) (NodeID: 11)
      💬 Args: [votingPower, int256((initialVotingPower > numWithdrawals) ? (initialVotingPower - numWithdrawals) : 0), "voting power should stay non-negative"]
      👁️  Def: internal
```
