# Function: test_calculateVotingThreshold_fuzz(uint256,uint256,uint256,uint256,uint256)

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_calculateVotingThreshold_fuzz(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 15964:1634:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_calculateVotingThreshold_fuzz(uint256 _votes, uint256 _forEpoch, uint256 _boldAccrued, uint256 _votingThresholdFactor, uint256 _minClaim) public {
    _votes = bound(_votes, 0, type(uint128).max);
    _forEpoch = bound(_forEpoch, 0, type(uint16).max);
    _boldAccrued = bound(_boldAccrued, 0, 1e9 ether);
    _votingThresholdFactor = bound(_votingThresholdFactor, 0, 1 ether - 1);
    _minClaim = bound(_minClaim, 0, 1e9 ether);
    governance = new GovernanceTester(address(lqty), address(lusd), address(stakingV1), address(lusd), IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: _votingThresholdFactor, minClaim: _minClaim, minAccrual: type(uint256).max, epochStart: uint256(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF}), address(this), initialInitiatives);
    IGovernance.VoteSnapshot memory snapshot = IGovernance.VoteSnapshot(_votes, _forEpoch);
    governance.tester_setVotesSnapshot(snapshot);
    governance.tester_setBoldAccrued(_boldAccrued);
    governance.getLatestVotingThreshold();
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

## External Calls

- **GovernanceTester::tester_setVotesSnapshot(struct IGovernance.VoteSnapshot)**
- **GovernanceTester::tester_setBoldAccrued(uint256)**
- **GovernanceTester::getLatestVotingThreshold()**

## State Variable Reads

- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **stakingV1** (`contract ILQTYStaking`) [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **REGISTRATION_FEE** (`uint256`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **initialInitiatives** (`address[]`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **UINT256_MAX** (`uint256`)

## State Variable Writes

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_calculateVotingThreshold_fuzz(uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [_votes, 0, type(uint128).max]
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
  │   💬 Args: [_forEpoch, 0, type(uint16).max]
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
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 11)
  │   💬 Args: [_boldAccrued, 0, 1e9 ether]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 12)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 13)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 14)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 15)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 16)
  │   💬 Args: [_votingThresholdFactor, 0, 1 ether - 1]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 17)
  │ │   💬 Args: [x, min, max]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 18)
  │     💬 Args: ["Bound result", result]
  │     👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 19)
  │       💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 20)
  │         💬 Args: [_sendLogPayloadView]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdUtils.bound(uint256,uint256,uint256) (NodeID: 21)
      💬 Args: [_minClaim, 0, 1e9 ether]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: StdUtils._bound(uint256,uint256,uint256) (NodeID: 22)
    │   💬 Args: [x, min, max]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils.console2_log_StdUtils(string,uint256) (NodeID: 23)
        💬 Args: ["Bound result", result]
        👁️  Def: private
      └─ [3] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 24)
          💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 25)
            💬 Args: [_sendLogPayloadView]
            👁️  Def: internal
```
