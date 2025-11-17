# Function: test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY(uint256[3],struct GovernanceTest.StakingOp[4])

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY(uint256[3],struct GovernanceTest.StakingOp[4])`
- **Visibility**: external
- **Source Range**: 101052:2850:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY(uint256[3] memory _votes, StakingOp[4] memory _stakes) external {
    address[] memory initiatives = new address[](_votes.length + 1);
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
        uint256 maxWaitTime = (EPOCH_DURATION * UNREGISTRATION_AFTER_EPOCHS) / _stakes.length;
        address userProxy = governance.deriveUserProxyAddress(user);
        uint256 lqtyBalance = lqty.balanceOf(user);
        uint256 unallocatedLQTY_ = 0;
        for (uint256 i = 0; i < _stakes.length; ++i) {
            _stakes[i].lqtyAmount = _bound(_stakes[i].lqtyAmount, 1, lqtyBalance - ((_stakes.length - 1) - i));
            lqtyBalance -= _stakes[i].lqtyAmount;
            unallocatedLQTY_ += _stakes[i].lqtyAmount;
            lqty.approve(userProxy, _stakes[i].lqtyAmount);
            governance.depositLQTY(_stakes[i].lqtyAmount);
            _stakes[i].waitTime = _bound(_stakes[i].waitTime, 1, maxWaitTime);
            vm.warp(block.timestamp + _stakes[i].waitTime);
        }
        address[] memory initiativesToReset;
        int256[] memory votes = new int256[](initiatives.length);
        int256[] memory vetos = new int256[](initiatives.length);
        for (uint256 i = 0; i < (initiatives.length - 1); ++i) {
            uint256 vote = _bound(_votes[i], 1, unallocatedLQTY_ - ((initiatives.length - 1) - i));
            unallocatedLQTY_ -= vote;
            votes[i] = int256(vote);
        }
        votes[initiatives.length - 1] = int256(unallocatedLQTY_);
        vm.assume(governance.secondsWithinEpoch() < EPOCH_VOTING_CUTOFF);
        governance.allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }
    vm.stopPrank();
    (uint256 unallocatedLQTY, uint256 unallocatedOffset, , ) = governance.userStates(user);
    assertEqDecimal(unallocatedLQTY, 0, 18, "user should have no unallocated LQTY");
    assertEqDecimal(unallocatedOffset, 0, 18, "user should have no unallocated offset");
}
```

## Related Implementations

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

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Vm::startPrank(address)**
- **ILUSD::approve(address,uint256)**
- **GovernanceTester::registerInitiative(address)**
- **Vm::stopPrank()**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **ILQTY::balanceOf(address)**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **Vm::assume(bool)**
- **GovernanceTester::secondsWithinEpoch()**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **GovernanceTester::userStates(address)**

## State Variable Reads

- **EPOCH_DURATION** (`uint256`)
- **lusdHolder** (`address`)
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **REGISTRATION_FEE** (`uint256`)
- **user** (`address`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]
- **UINT256_MAX** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY(uint256[3],struct GovernanceTest.StakingOp[4]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: [string.concat("initiative", i.toString())]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 3)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 4)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [_stakes[i].lqtyAmount, 1, lqtyBalance - ((_stakes.length - 1) - i)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 6)
  │   💬 Args: [_stakes[i].waitTime, 1, maxWaitTime]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 7)
  │   💬 Args: [_votes[i], 1, unallocatedLQTY_ - ((initiatives.length - 1) - i)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [unallocatedLQTY, 0, 18, "user should have no unallocated LQTY"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 9)
      💬 Args: [unallocatedOffset, 0, 18, "user should have no unallocated offset"]
      👁️  Def: internal
```
