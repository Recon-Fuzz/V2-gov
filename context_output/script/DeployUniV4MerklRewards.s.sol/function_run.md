# Function: run()

**Contract**: [script/DeployUniV4MerklRewards.s.sol/contract_DeployUniV4MerklRewards.md]

## Metadata

- **Contract**: DeployUniV4MerklRewards
- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 771:872:62

## Implementation

```solidity
function run() external {
    if (vm.envBytes("DEPLOYER").length == 20) {
        deployer = vm.envAddress("DEPLOYER");
        vm.startBroadcast(deployer);
    } else {
        uint256 privateKey = vm.envUint("DEPLOYER");
        deployer = vm.addr(privateKey);
        vm.startBroadcast(privateKey);
    }
    console2.log("deployer: ", deployer);
    console2.log("Chain Id: ", block.chainid);
    UniV4MerklRewards uniV4MerklRewards = new UniV4MerklRewards(GOVERNANCE_ADDRESS, BOLD_TOKEN_ADDRESS, CAMPAIGN_BOLD_AMOUNT_THRESHOLD, UNIV4_POOL_ID, WEIGHT_FEES, WEIGHT_TOKEN_0, WEIGHT_TOKEN_1);
    console2.log("Deployed UniV4MerklRewards: ", address(uniV4MerklRewards));
}
```

## Related Implementations

### log(string,address)

- **Kind**: internal
- **Source**: 7740:145:22
- **Link**: `lib/forge-std/src/console.sol:console:log(string,address)`

```solidity
function log(string memory p0, address p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
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

### log(string,uint256)

- **Kind**: internal
- **Source**: 7139:145:22
- **Link**: `lib/forge-std/src/console.sol:console:log(string,uint256)`

```solidity
function log(string memory p0, uint256 p1) internal pure {
    _sendLogPayload(abi.encodeWithSignature("log(string,uint256)", p0, p1));
}
```

## External Calls

- **Vm::envBytes(string)**
- **Vm::envAddress(string)**
- **Vm::startBroadcast(address)**
- **Vm::envUint(string)**
- **Vm::addr(uint256)**
- **Vm::startBroadcast(uint256)**

## State Variable Reads

- **deployer** (`address`)
- **GOVERNANCE_ADDRESS** (`address`)
- **BOLD_TOKEN_ADDRESS** (`address`)
- **CAMPAIGN_BOLD_AMOUNT_THRESHOLD** (`uint256`)
- **UNIV4_POOL_ID** (`bytes32`)
- **WEIGHT_FEES** (`uint32`)
- **WEIGHT_TOKEN_0** (`uint32`)
- **WEIGHT_TOKEN_1** (`uint32`)

## State Variable Writes

- **deployer** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeployUniV4MerklRewards.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 1)
  │   💬 Args: ["deployer: ", deployer]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 2)
  │     💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 3)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: console.log(string,uint256) (NodeID: 4)
  │   💬 Args: ["Chain Id: ", block.chainid]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 5)
  │     💬 Args: [abi.encodeWithSignature("log(string,uint256)", p0, p1)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 6)
  │       💬 Args: [_sendLogPayloadView]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: console.log(string,address) (NodeID: 7)
      💬 Args: ["Deployed UniV4MerklRewards: ", address(uniV4MerklRewards)]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdUtils._sendLogPayload(bytes) (NodeID: 8)
        💬 Args: [abi.encodeWithSignature("log(string,address)", p0, p1)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: StdUtils._castLogPayloadViewToPure(function (bytes) view) (NodeID: 9)
          💬 Args: [_sendLogPayloadView]
          👁️  Def: internal
```
