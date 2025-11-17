# Function: test_AbleToClaimBribesInAnyOrder_EvenFromEpochsWhereVoterStayedInactive(bytes32)

**Contract**: [test/BribeInitiativeFireAndForget.t.sol/contract_BribeInitiativeFireAndForgetTest.md]

## Metadata

- **Contract**: BribeInitiativeFireAndForgetTest
- **Signature**: `test_AbleToClaimBribesInAnyOrder_EvenFromEpochsWhereVoterStayedInactive(bytes32)`
- **Visibility**: external
- **Source Range**: 4850:5521:94

## Implementation

```solidity
/// forge-config: ci.fuzz.runs = 50
function test_AbleToClaimBribesInAnyOrder_EvenFromEpochsWhereVoterStayedInactive(bytes32 seed) external {
    Random.Context memory random = Random.init(seed);
    uint256 startingEpoch = governance.epoch();
    uint256 lastEpoch = startingEpoch;
    for (uint256 i = startingEpoch; i < (startingEpoch + MAX_NUM_EPOCHS); ++i) {
        boldAtEpoch[i] = random.generate(MAX_BRIBE);
        brybAtEpoch[i] = random.generate(MAX_BRIBE);
        bold.mint(briber, boldAtEpoch[i]);
        bryb.mint(briber, brybAtEpoch[i]);
        vm.prank(briber);
        bribeInitiative.depositBribe(uint128(boldAtEpoch[i]), uint128(brybAtEpoch[i]), i);
    }
    for (; ; ) {
        vm.warp(block.timestamp + random.generate(2 * MEAN_TIME_BETWEEN_VOTES));
        uint256 epoch = governance.epoch();
        for (uint256 i = lastEpoch; i < epoch; ++i) {
            voteAtEpoch[i] = latestVote[voter].amount;
            toteAtEpoch[i] = latestVote[voter].amount + latestVote[other].amount;
            console.log(string.concat("epoch #", i.toString(), ": vote = ", voteAtEpoch[i].decimal(), ", tote = ", toteAtEpoch[i].decimal()));
        }
        lastEpoch = epoch;
        if (epoch >= (startingEpoch + MAX_NUM_EPOCHS)) break;
        (IGovernance.InitiativeStatus status, , ) = governance.getInitiativeState(address(bribeInitiative));
        if (status == IGovernance.InitiativeStatus.CLAIMABLE) {
            governance.claimForInitiative(address(bribeInitiative));
        }
        if (status == IGovernance.InitiativeStatus.UNREGISTERABLE) {
            governance.unregisterInitiative(address(bribeInitiative));
            break;
        }
        address who = (random.generate() < VOTER_PROBABILITY) ? voter : other;
        uint256 vote = (governance.secondsWithinEpoch() <= EPOCH_VOTING_CUTOFF) ? random.generate(MAX_VOTE) : 0;
        if ((vote > 0) || (latestVote[who].amount > 0)) {
            latestVote[who].epoch = epoch;
            latestVote[who].amount = vote;
            _vote(who, address(bribeInitiative), latestVote[who].amount);
        }
    }
    uint256[] memory epochPermutation = UintArray.seq(startingEpoch, lastEpoch + 1).permute(random);
    uint256 start = 0;
    uint256 expectedBold = 0;
    uint256 expectedBryb = 0;
    while (start < epochPermutation.length) {
        uint256 end = Math.min(start + random.generate(MAX_CLAIMS_PER_CALL), epochPermutation.length);
        for (uint256 i = start; i < end; ++i) {
            if ((voteAtEpoch[epochPermutation[i]] > 0) && ((boldAtEpoch[epochPermutation[i]] > 0) || (brybAtEpoch[epochPermutation[i]] > 0))) {
                IBribeInitiative.ClaimData memory claimDataAtEpoch;
                claimDataAtEpoch.epoch = epochPermutation[i];
                uint256 l;
                uint256 p;
                uint256 n;
                uint256 userPrevAllocation = epochPermutation[i] + 1;
                while ((((l == 0) && (p == 0)) && (n == 0)) && (userPrevAllocation > 0)) {
                    userPrevAllocation--;
                    (l, , p, n) = bribeInitiative.lqtyAllocatedByUserAtEpoch(voter, userPrevAllocation);
                }
                l = 0;
                p = 0;
                n = 0;
                uint256 totalPrevAllocation = epochPermutation[i] + 1;
                while (((p == 0) && (n == 0)) && (totalPrevAllocation > 0)) {
                    totalPrevAllocation--;
                    (l, , p, n) = bribeInitiative.totalLQTYAllocatedByEpoch(totalPrevAllocation);
                }
                claimDataAtEpoch.prevLQTYAllocationEpoch = userPrevAllocation;
                claimDataAtEpoch.prevTotalLQTYAllocationEpoch = totalPrevAllocation;
                claimData.push(claimDataAtEpoch);
                expectedBold += (boldAtEpoch[epochPermutation[i]] * voteAtEpoch[epochPermutation[i]]) / toteAtEpoch[epochPermutation[i]];
                expectedBryb += (brybAtEpoch[epochPermutation[i]] * voteAtEpoch[epochPermutation[i]]) / toteAtEpoch[epochPermutation[i]];
            }
        }
        vm.prank(voter);
        bribeInitiative.claimBribes(claimData);
        delete claimData;
        assertEqDecimal(bold.balanceOf(voter), expectedBold, 18, "bold.balanceOf(voter) != expectedBold");
        assertEqDecimal(bryb.balanceOf(voter), expectedBryb, 18, "bryb.balanceOf(voter) != expectedBryb");
        start = end;
    }
}
```

## Related Implementations

### init(bytes32)

- **Kind**: internal
- **Source**: 328:106:127
- **Link**: `test/util/Random.sol:Random:init(bytes32)`

```solidity
function init(bytes32 seed) internal pure returns (Random.Context memory c) {
    init(c, seed);
}
```

### init(struct Random.Context,bytes32)

- **Kind**: internal
- **Source**: 440:90:127
- **Link**: `test/util/Random.sol:Random:init(struct Random.Context,bytes32)`

```solidity
function init(Context memory c, bytes32 seed) internal pure {
    c.seed = seed;
}
```

### generate(struct Random.Context,uint256)

- **Kind**: internal
- **Source**: 667:124:127
- **Link**: `test/util/Random.sol:Random:generate(struct Random.Context,uint256)`

```solidity
function generate(Context memory c, uint256 max) internal pure returns (uint256) {
    return generate(c, 0, max);
}
```

### generate(struct Random.Context,uint256,uint256)

- **Kind**: internal
- **Source**: 797:198:127
- **Link**: `test/util/Random.sol:Random:generate(struct Random.Context,uint256,uint256)`

```solidity
function generate(Context memory c, uint256 min, uint256 max) internal pure returns (uint256) {
    c.seed = keccak256(abi.encode(c.seed));
    return bound(uint256(c.seed), min, max);
}
```

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

### log(string)

- **Kind**: internal
- **Source**: 6191:121:22
- **Link**: `lib/forge-std/src/console.sol:console:log(string)`

```solidity
function log(string memory p0) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
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

### decimal(uint256)

- **Kind**: internal
- **Source**: 1333:608:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:decimal(uint256)`

```solidity
function decimal(uint256 n) internal pure returns (string memory) {
    if (n == type(uint256).max) {
        return "type(uint256).max";
    }
    uint256 integerPart = n / ONE;
    uint256 fractionalPart = n % ONE;
    if (fractionalPart == 0) {
        return string.concat(integerPart.groupRight(), DECIMAL_UNIT);
    } else {
        return string.concat(integerPart.groupRight(), DECIMAL_SEPARATOR, (ONE + fractionalPart).toString().slice(1).trimEnd("0"), DECIMAL_UNIT);
    }
}
```

### groupRight(uint256)

- **Kind**: internal
- **Source**: 1947:118:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:groupRight(uint256)`

```solidity
function groupRight(uint256 n) internal pure returns (string memory) {
    return n.toString().groupRight();
}
```

### groupRight(string)

- **Kind**: internal
- **Source**: 2071:135:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:groupRight(string)`

```solidity
function groupRight(string memory str) internal pure returns (string memory) {
    return bytes(str).groupRight().toString();
}
```

### groupRight(bytes)

- **Kind**: internal
- **Source**: 2212:539:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:groupRight(bytes)`

```solidity
function groupRight(bytes memory str) internal pure returns (bytes memory ret) {
    uint256 length = str.length;
    if (length == 0) return "";
    uint256 retLength = length + ((length - 1) / GROUP_DIGITS);
    ret = new bytes(retLength);
    uint256 j = 1;
    for (uint256 i = 1; i <= retLength; ++i) {
        if ((i % (GROUP_DIGITS + 1)) == 0) {
            ret[retLength - i] = GROUP_SEPARATOR;
        } else {
            ret[retLength - i] = str[length - (j++)];
        }
    }
}
```

### toString(bytes)

- **Kind**: internal
- **Source**: 709:109:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:toString(bytes)`

```solidity
function toString(bytes memory str) internal pure returns (string memory) {
    return string(str);
}
```

### slice(string,int256)

- **Kind**: internal
- **Source**: 2757:144:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:slice(string,int256)`

```solidity
function slice(string memory str, int256 start) internal pure returns (string memory) {
    return bytes(str).slice(start).toString();
}
```

### slice(bytes,int256)

- **Kind**: internal
- **Source**: 3074:144:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:slice(bytes,int256)`

```solidity
function slice(bytes memory str, int256 start) internal pure returns (bytes memory) {
    return str.slice(start, int256(str.length));
}
```

### slice(bytes,int256,int256)

- **Kind**: internal
- **Source**: 3268:472:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:slice(bytes,int256,int256)`

```solidity
function slice(bytes memory str, int256 start, int256 end) internal pure returns (bytes memory ret) {
    uint256 uStart = uint256((start < 0) ? (int256(str.length) + start) : start);
    uint256 uEnd = uint256((end < 0) ? (int256(str.length) + end) : end);
    assert(((0 <= uStart) && (uStart <= uEnd)) && (uEnd <= str.length));
    ret = new bytes(uEnd - uStart);
    for (uint256 i = uStart; i < uEnd; ++i) {
        ret[i - uStart] = str[i];
    }
}
```

### trimEnd(string,bytes1)

- **Kind**: internal
- **Source**: 3746:146:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:trimEnd(string,bytes1)`

```solidity
function trimEnd(string memory str, bytes1 char) internal pure returns (string memory) {
    return bytes(str).trimEnd(char).toString();
}
```

### trimEnd(bytes,bytes1)

- **Kind**: internal
- **Source**: 3898:229:128
- **Link**: `test/util/StringFormatting.sol:StringFormatting:trimEnd(bytes,bytes1)`

```solidity
function trimEnd(bytes memory str, bytes1 char) internal pure returns (bytes memory) {
    uint256 end;
    for (end = str.length; (end > 0) && (str[end - 1] == char); --end) {}
    return str.slice(0, int256(end));
}
```

### generate(struct Random.Context)

- **Kind**: internal
- **Source**: 536:125:127
- **Link**: `test/util/Random.sol:Random:generate(struct Random.Context)`

```solidity
function generate(Context memory c) internal pure returns (uint256) {
    return generate(c, 0, type(uint256).max);
}
```

### _vote(address,address,uint256)

- **Kind**: internal
- **Source**: 10432:956:94
- **Link**: `test/BribeInitiativeFireAndForget.t.sol:BribeInitiativeFireAndForgetTest:_vote(address,address,uint256)`

```solidity
function _vote(address who, address initiative, uint256 vote) internal {
    assertLeDecimal(vote, uint256(int256(type(int256).max)), 18, "vote > type(uint256).max");
    vm.startPrank(who);
    if (vote > 0) {
        address[] memory initiatives = new address[](1);
        int256[] memory votes = new int256[](1);
        int256[] memory vetos = new int256[](1);
        initiatives[0] = initiative;
        votes[0] = int256(uint256(vote));
        governance.allocateLQTY(initiativesToReset[who], initiatives, votes, vetos);
        if (initiativesToReset[who].length != 0) initiativesToReset[who].pop();
        initiativesToReset[who].push(initiative);
    } else {
        if (initiativesToReset[who].length != 0) {
            governance.resetAllocations(initiativesToReset[who], true);
            initiativesToReset[who].pop();
        }
    }
    vm.stopPrank();
}
```

### assertLeDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 14710:176:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertLeDecimal(uint256,uint256,uint256,string)`

```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertLeDecimal(left, right, decimals, err);
}
```

### seq(uint256,uint256)

- **Kind**: internal
- **Source**: 268:200:129
- **Link**: `test/util/UintArray.sol:UintArray:seq(uint256,uint256)`

```solidity
function seq(uint256 first, uint256 last) internal pure returns (uint256[] memory array) {
    require(first <= last, "first > last");
    return seq(new uint256[](last - first), first);
}
```

### seq(uint256[],uint256)

- **Kind**: internal
- **Source**: 595:220:129
- **Link**: `test/util/UintArray.sol:UintArray:seq(uint256[],uint256)`

```solidity
function seq(uint256[] memory array, uint256 first) internal pure returns (uint256[] memory) {
    for (uint256 i = 0; i < array.length; ++i) {
        array[i] = first + i;
    }
    return array;
}
```

### permute(uint256[],struct Random.Context)

- **Kind**: internal
- **Source**: 2543:328:129
- **Link**: `test/util/UintArray.sol:UintArray:permute(uint256[],struct Random.Context)`

```solidity
function permute(uint256[] memory array, Random.Context memory random) internal pure returns (uint256[] memory) {
    for (uint256 i = 0; i < (array.length - 1); ++i) {
        uint256 j = random.generate(i, array.length - 1);
        (array[i], array[j]) = (array[j], array[i]);
    }
    return array;
}
```

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 2557:104:52
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/Math.sol:Math:min(uint256,uint256)`

```solidity
///  @dev Returns the smallest of two numbers.
function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a < b) ? a : b;
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

- **Governance::epoch()**
- **MockERC20Tester::mint(address,uint256)**
- **Vm::prank(address)**
- **BribeInitiative::depositBribe(uint256,uint256,uint256)**
- **Vm::warp(uint256)**
- **Governance::getInitiativeState(address)**
- **Governance::claimForInitiative(address)**
- **Governance::unregisterInitiative(address)**
- **Governance::secondsWithinEpoch()**
- **BribeInitiative::lqtyAllocatedByUserAtEpoch(address,uint256)**
- **BribeInitiative::totalLQTYAllocatedByEpoch(uint256)**
- **BribeInitiative::claimBribes(struct IBribeInitiative.ClaimData[])**
- **MockERC20Tester::balanceOf(address)**

## State Variable Reads

- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **MAX_NUM_EPOCHS** (`uint256`)
- **MAX_BRIBE** (`uint128`)
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **briber** (`address`)
- **boldAtEpoch** (`mapping(uint256 => uint256)`)
- **bryb** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **brybAtEpoch** (`mapping(uint256 => uint256)`)
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **MEAN_TIME_BETWEEN_VOTES** (`uint256`)
- **latestVote** (`mapping(address => struct BribeInitiativeFireAndForgetTest.Vote)`)
- **voter** (`address`)
- **other** (`address`)
- **voteAtEpoch** (`mapping(uint256 => uint256)`)
- **toteAtEpoch** (`mapping(uint256 => uint256)`)
- **VOTER_PROBABILITY** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **MAX_VOTE** (`uint256`)
- **MAX_CLAIMS_PER_CALL** (`uint256`)
- **claimData** (`struct IBribeInitiative.ClaimData[]`)
- **UINT256_MAX** (`uint256`)
- **ONE** (`uint256`)
- **DECIMAL_UNIT** (`string`)
- **DECIMAL_SEPARATOR** (`string`)
- **GROUP_DIGITS** (`uint256`)
- **GROUP_SEPARATOR** (`bytes1`)
- **initiativesToReset** (`mapping(address => address[])`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **boldAtEpoch** (`mapping(uint256 => uint256)`)
- **brybAtEpoch** (`mapping(uint256 => uint256)`)
- **voteAtEpoch** (`mapping(uint256 => uint256)`)
- **toteAtEpoch** (`mapping(uint256 => uint256)`)
- **latestVote** (`mapping(address => struct BribeInitiativeFireAndForgetTest.Vote)`)
- **claimData** (`struct IBribeInitiative.ClaimData[]`)
- **initiativesToReset** (`mapping(address => address[])`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeFireAndForgetTest.test_AbleToClaimBribesInAnyOrder_EvenFromEpochsWhereVoterStayedInactive(bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Random.init(bytes32) (NodeID: 1)
  │   💬 Args: [seed]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Random.init(struct Random.Context,bytes32) (NodeID: 2)
  │     💬 Args: [c, seed]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256) (NodeID: 3)
  │   💬 Args: [random, MAX_BRIBE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256,uint256) (NodeID: 4)
  │     💬 Args: [c, 0, max]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 5)
  │       💬 Args: [uint256(c.seed), min, max]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 6)
  │     │   💬 Args: [x, min, max]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 7)
  │         💬 Args: ["Bound result", result]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256) (NodeID: 10)
  │   💬 Args: [random, MAX_BRIBE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256,uint256) (NodeID: 11)
  │     💬 Args: [c, 0, max]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 12)
  │       💬 Args: [uint256(c.seed), min, max]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 13)
  │     │   💬 Args: [x, min, max]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 14)
  │         💬 Args: ["Bound result", result]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 15)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 16)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256) (NodeID: 17)
  │   💬 Args: [random, 2 * MEAN_TIME_BETWEEN_VOTES]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256,uint256) (NodeID: 18)
  │     💬 Args: [c, 0, max]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 19)
  │       💬 Args: [uint256(c.seed), min, max]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 20)
  │     │   💬 Args: [x, min, max]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 21)
  │         💬 Args: ["Bound result", result]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 22)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 23)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string) (NodeID: 24)
  │   💬 Args: [string.concat("epoch #", i.toString(), ": vote = ", voteAtEpoch[i].decimal(), ", tote = ", toteAtEpoch[i].decimal())]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 27)
  │ │   💬 Args: [i]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 28)
  │ │     💬 Args: [value]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 29)
  │ │   💬 Args: [voteAtEpoch[i]]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 30)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 31)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 32)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 33)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 34)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 35)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 36)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 37)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 38)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 39)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 40)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 41)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 42)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 43)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 44)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 45)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 46)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 47)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 48)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 49)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 50)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 51)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StringFormatting.decimal(uint256) (NodeID: 52)
  │ │   💬 Args: [toteAtEpoch[i]]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 53)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 54)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 55)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 56)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 57)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 58)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.groupRight(uint256) (NodeID: 59)
  │ │ │   💬 Args: [integerPart]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 60)
  │ │ │ │   💬 Args: [n]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 61)
  │ │ │ │     💬 Args: [value]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.groupRight(string) (NodeID: 62)
  │ │ │     💬 Args: [n.toString()]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: StringFormatting.groupRight(bytes) (NodeID: 63)
  │ │ │   │   💬 Args: [bytes(str)]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 64)
  │ │ │       💬 Args: [bytes(str).groupRight()]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: Strings.toString(uint256) (NodeID: 65)
  │ │ │   💬 Args: [(ONE + fractionalPart)]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: Math.log10(uint256) (NodeID: 66)
  │ │ │     💬 Args: [value]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: StringFormatting.slice(string,int256) (NodeID: 67)
  │ │ │   💬 Args: [(ONE + fractionalPart).toString(), 1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256) (NodeID: 68)
  │ │ │ │   💬 Args: [bytes(str), start]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 69)
  │ │ │ │     💬 Args: [str, start, int256(str.length)]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 70)
  │ │ │     💬 Args: [bytes(str).slice(start)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: StringFormatting.trimEnd(string,bytes1) (NodeID: 71)
  │ │     💬 Args: [(ONE + fractionalPart).toString().slice(1), "0"]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: StringFormatting.trimEnd(bytes,bytes1) (NodeID: 72)
  │ │   │   💬 Args: [bytes(str), char]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: StringFormatting.slice(bytes,int256,int256) (NodeID: 73)
  │ │   │     💬 Args: [str, 0, int256(end)]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: StringFormatting.toString(bytes) (NodeID: 74)
  │ │       💬 Args: [bytes(str).trimEnd(char)]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 25)
  │     💬 Args: [abi.encodeWithSignature("log(string)", p0)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 26)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Random.generate(struct Random.Context) (NodeID: 75)
  │   💬 Args: [random]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256,uint256) (NodeID: 76)
  │     💬 Args: [c, 0, type(uint256).max]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 77)
  │       💬 Args: [uint256(c.seed), min, max]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 78)
  │     │   💬 Args: [x, min, max]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 79)
  │         💬 Args: ["Bound result", result]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 80)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 81)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256) (NodeID: 82)
  │   💬 Args: [random, MAX_VOTE]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256,uint256) (NodeID: 83)
  │     💬 Args: [c, 0, max]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 84)
  │       💬 Args: [uint256(c.seed), min, max]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 85)
  │     │   💬 Args: [x, min, max]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 86)
  │         💬 Args: ["Bound result", result]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 87)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 88)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeFireAndForgetTest._vote(address,address,uint256) (NodeID: 89)
  │   💬 Args: [who, address(bribeInitiative), latestVote[who].amount]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdAssertions.assertLeDecimal(uint256,uint256,uint256,string) (NodeID: 90)
  │     💬 Args: [vote, uint256(int256(type(int256).max)), 18, "vote > type(uint256).max"]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UintArray.seq(uint256,uint256) (NodeID: 91)
  │   💬 Args: [startingEpoch, lastEpoch + 1]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: UintArray.seq(uint256[],uint256) (NodeID: 92)
  │     💬 Args: [new uint256[](last - first), first]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UintArray.permute(uint256[],struct Random.Context) (NodeID: 93)
  │   💬 Args: [UintArray.seq(startingEpoch, lastEpoch + 1), random]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256,uint256) (NodeID: 94)
  │     💬 Args: [random, i, array.length - 1]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 95)
  │       💬 Args: [uint256(c.seed), min, max]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 96)
  │     │   💬 Args: [x, min, max]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 97)
  │         💬 Args: ["Bound result", result]
  │         👁️  Def: private
  │       └─ [5] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 98)
  │           💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │           👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 99)
  │             💬 Args: [_sendLogPayloadView]
  │             👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Math.min(uint256,uint256) (NodeID: 100)
  │   💬 Args: [start + random.generate(MAX_CLAIMS_PER_CALL), epochPermutation.length]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256) (NodeID: 101)
  │     💬 Args: [random, MAX_CLAIMS_PER_CALL]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Random.generate(struct Random.Context,uint256,uint256) (NodeID: 102)
  │       💬 Args: [c, 0, max]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 103)
  │         💬 Args: [uint256(c.seed), min, max]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 104)
  │       │   💬 Args: [x, min, max]
  │       │   👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 105)
  │           💬 Args: ["Bound result", result]
  │           👁️  Def: private
  │         └─ [6] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 106)
  │             💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 107)
  │               💬 Args: [_sendLogPayloadView]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 108)
  │   💬 Args: [bold.balanceOf(voter), expectedBold, 18, "bold.balanceOf(voter) != expectedBold"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 109)
      💬 Args: [bryb.balanceOf(voter), expectedBryb, 18, "bryb.balanceOf(voter) != expectedBryb"]
      👁️  Def: internal
```

## Documentation

### Function Documentation

forge-config: ci.fuzz.runs = 50
