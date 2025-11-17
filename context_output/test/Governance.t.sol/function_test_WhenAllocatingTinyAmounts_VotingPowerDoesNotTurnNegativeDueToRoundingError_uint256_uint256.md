# Function: test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256)

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 103908:2405:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256 initialVotingPower, uint256 numInitiatives) external {
    initialVotingPower = bound(initialVotingPower, 1, 20);
    numInitiatives = bound(numInitiatives, 1, 20);
    address[] memory initiatives = new address[](numInitiatives);
    vm.warp(block.timestamp + (2 * EPOCH_DURATION));
    vm.startPrank(lusdHolder);
    for (uint256 i = 0; i < initiatives.length; ++i) {
        initiatives[i] = makeAddr(string.concat("initiative", i.toString()));
        lusd.approve(address(governance), REGISTRATION_FEE);
        governance.registerInitiative(initiatives[i]);
    }
    vm.stopPrank();
    vm.warp(block.timestamp + EPOCH_DURATION);
    vm.startPrank(user);
    {
        address userProxy = governance.deriveUserProxyAddress(user);
        lqty.approve(userProxy, type(uint256).max);
        governance.depositLQTY(1);
        vm.warp(block.timestamp + initialVotingPower);
        governance.depositLQTY(1 ether);
        address[] memory initiativesToReset;
        int256[] memory votes = new int256[](initiatives.length);
        int256[] memory vetos = new int256[](initiatives.length);
        for (uint256 i = 0; i < initiatives.length; ++i) {
            votes[i] = 1;
        }
        governance.allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }
    vm.stopPrank();
    (uint256 unallocatedLQTY, uint256 unallocatedOffset, , ) = governance.userStates(user);
    int256 votingPower = int256(unallocatedLQTY * block.timestamp) - int256(unallocatedOffset);
    assertEq(votingPower, int256((initialVotingPower > numInitiatives) ? (initialVotingPower - numInitiatives) : 0), "voting power should stay non-negative");
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

### makeAddr(string)

- **Kind**: internal
- **Source**: 20454:125:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### toString(uint256)

- **Kind**: internal
- **Source**: 637:698:48
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Strings.sol:Strings:toString(uint256)`

```solidity
///  @dev Converts a `uint256` to its ASCII `string` decimal representation.
function toString(uint256 value) internal pure returns (string memory) {
    unchecked {
        uint256 length = Math.log10(value) + 1;
        string memory buffer = new string(length);
        uint256 ptr;
        /// @solidity memory-safe-assembly
        assembly {
            ptr := add(buffer, add(32, length))
        }
        while (true) {
            ptr--;
            /// @solidity memory-safe-assembly
            assembly {
                mstore8(ptr, byte(mod(value, 10), HEX_DIGITS))
            }
            value /= 10;
            if (value == 0) break;
        }
        return buffer;
    }
}
```

### log10(uint256)

- **Kind**: internal
- **Source**: 12214:916:52
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:log10(uint256)`

```solidity
///  @dev Return the log in base 10 of a positive value rounded towards zero.
///  Returns 0 if given 0.
function log10(uint256 value) internal pure returns (uint256) {
    uint256 result = 0;
    unchecked {
        if (value >= (10 ** 64)) {
            value /= 10 ** 64;
            result += 64;
        }
        if (value >= (10 ** 32)) {
            value /= 10 ** 32;
            result += 32;
        }
        if (value >= (10 ** 16)) {
            value /= 10 ** 16;
            result += 16;
        }
        if (value >= (10 ** 8)) {
            value /= 10 ** 8;
            result += 8;
        }
        if (value >= (10 ** 4)) {
            value /= 10 ** 4;
            result += 4;
        }
        if (value >= (10 ** 2)) {
            value /= 10 ** 2;
            result += 2;
        }
        if (value >= (10 ** 1)) {
            result += 1;
        }
    }
    return result;
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20173:242:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
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

- **Vm::warp(uint256)**
- **Vm::startPrank(address)**
- **ILUSD::approve(address,uint256)**
- **GovernanceTester::registerInitiative(address)**
- **Vm::stopPrank()**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **GovernanceTester::userStates(address)**

## State Variable Reads

- **EPOCH_DURATION** (`uint256`)
- **lusdHolder** (`address`)
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **REGISTRATION_FEE** (`uint256`)
- **user** (`address`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **UINT256_MAX** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256) (NodeID: 0)
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
  │   💬 Args: [numInitiatives, 1, 20]
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
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 11)
  │   💬 Args: [string.concat("initiative", i.toString())]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 13)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 14)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 12)
  │     💬 Args: [name]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(int256,int256,string) (NodeID: 15)
      💬 Args: [votingPower, int256((initialVotingPower > numInitiatives) ? (initialVotingPower - numInitiatives) : 0), "voting power should stay non-negative"]
      👁️  Def: internal
```
