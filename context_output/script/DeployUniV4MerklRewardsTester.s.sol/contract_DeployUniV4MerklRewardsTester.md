# Contract: DeployUniV4MerklRewardsTester

## Metadata

- **Name**: DeployUniV4MerklRewardsTester
- **Type**: Contract
- **Path**: script/DeployUniV4MerklRewardsTester.s.sol

## State Variables

### VM_ADDRESS (inherited from CommonBase)

```solidity
address internal constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))))
```

### CONSOLE (inherited from CommonBase)

```solidity
address internal constant CONSOLE = 0x000000000000000000636F6e736F6c652e6c6f67
```

### CREATE2_FACTORY (inherited from CommonBase)

```solidity
address internal constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### DEFAULT_SENDER (inherited from CommonBase)

```solidity
address internal constant DEFAULT_SENDER = address(uint160(uint256(keccak256("foundry default caller"))))
```

### DEFAULT_TEST_CONTRACT (inherited from CommonBase)

```solidity
address internal constant DEFAULT_TEST_CONTRACT = 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
```

### MULTICALL3_ADDRESS (inherited from CommonBase)

```solidity
address internal constant MULTICALL3_ADDRESS = 0xcA11bde05977b3631167028862bE2a173976CA11
```

### SECP256K1_ORDER (inherited from CommonBase)

```solidity
uint256 internal constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from CommonBase)

```solidity
uint256 internal constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### vm (inherited from CommonBase)

```solidity
Vm internal constant vm = Vm(VM_ADDRESS)
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### stdstore (inherited from CommonBase)

```solidity
StdStorage internal stdstore
```

### vmSafe (inherited from ScriptBase)

```solidity
VmSafe internal constant vmSafe = VmSafe(VM_ADDRESS)
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### vm (inherited from StdChains)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### stdChainsInitialized (inherited from StdChains)

```solidity
bool private stdChainsInitialized
```

### chains (inherited from StdChains)

```solidity
mapping(string => Chain) private chains
```

### defaultRpcUrls (inherited from StdChains)

```solidity
mapping(string => string) private defaultRpcUrls
```

### idToAlias (inherited from StdChains)

```solidity
mapping(uint256 => string) private idToAlias
```

### fallbackToDefaultRpcUrls (inherited from StdChains)

```solidity
bool private fallbackToDefaultRpcUrls = true
```

### vm (inherited from StdCheatsSafe)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### UINT256_MAX (inherited from StdCheatsSafe)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### gasMeteringOff (inherited from StdCheatsSafe)

```solidity
bool private gasMeteringOff
```

### multicall (inherited from StdUtils)

```solidity
IMulticall3 private constant multicall = IMulticall3(0xcA11bde05977b3631167028862bE2a173976CA11)
```

**IMulticall3**: [lib/forge-std/src/interfaces/IMulticall3.sol/interface_IMulticall3.md]

### vm (inherited from StdUtils)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### CONSOLE2_ADDRESS (inherited from StdUtils)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### INT256_MIN_ABS (inherited from StdUtils)

```solidity
uint256 private constant INT256_MIN_ABS = 57896044618658097711785492504343953926634992332820282019728792003956564819968
```

### SECP256K1_ORDER (inherited from StdUtils)

```solidity
uint256 private constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from StdUtils)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### CREATE2_FACTORY (inherited from StdUtils)

```solidity
address private constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### IS_SCRIPT (inherited from Script)

```solidity
bool public IS_SCRIPT = true
```

### GOVERNANCE_ADDRESS

```solidity
address internal constant GOVERNANCE_ADDRESS = 0x807DEf5E7d057DF05C796F4bc75C3Fe82Bd6EeE1
```

### BOLD_TOKEN_ADDRESS

```solidity
address internal constant BOLD_TOKEN_ADDRESS = 0x6440f144b7e50D6a8439336510312d2F54beB01D
```

### CAMPAIGN_BOLD_AMOUNT_THRESHOLD

```solidity
uint256 internal constant CAMPAIGN_BOLD_AMOUNT_THRESHOLD = 100e18
```

### UNIV4_POOL_ID

```solidity
bytes32 internal constant UNIV4_POOL_ID = 0x5d0ed52610c76d7bf729130ce7ddc0488b2f4bd0a0db1f12adbe6a32deaff893
```

### WEIGHT_FEES

```solidity
uint32 internal constant WEIGHT_FEES = 1500
```

### WEIGHT_TOKEN_0

```solidity
uint32 internal constant WEIGHT_TOKEN_0 = 4500
```

### WEIGHT_TOKEN_1

```solidity
uint32 internal constant WEIGHT_TOKEN_1 = 4000
```

### deployer

```solidity
address internal deployer
```

## Structs

### ChainData (inherited from StdChains)

```solidity
struct ChainData {
    string name;
    uint256 chainId;
    string rpcUrl;
}
```

### Chain (inherited from StdChains)

```solidity
struct Chain {
    string name;
    uint256 chainId;
    string chainAlias;
    string rpcUrl;
}
```

### RawTx1559 (inherited from StdCheatsSafe)

```solidity
struct RawTx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    RawTx1559Detail txDetail;
    string opcode;
}
```

### RawTx1559Detail (inherited from StdCheatsSafe)

```solidity
struct RawTx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    bytes gas;
    bytes nonce;
    address to;
    bytes txType;
    bytes value;
}
```

### Tx1559 (inherited from StdCheatsSafe)

```solidity
struct Tx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    Tx1559Detail txDetail;
    string opcode;
}
```

### Tx1559Detail (inherited from StdCheatsSafe)

```solidity
struct Tx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    uint256 gas;
    uint256 nonce;
    address to;
    uint256 txType;
    uint256 value;
}
```

### TxLegacy (inherited from StdCheatsSafe)

```solidity
struct TxLegacy {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    string hash;
    string opcode;
    TxDetailLegacy transaction;
}
```

### TxDetailLegacy (inherited from StdCheatsSafe)

```solidity
struct TxDetailLegacy {
    AccessList[] accessList;
    uint256 chainId;
    bytes data;
    address from;
    uint256 gas;
    uint256 gasPrice;
    bytes32 hash;
    uint256 nonce;
    bytes1 opcode;
    bytes32 r;
    bytes32 s;
    uint256 txType;
    address to;
    uint8 v;
    uint256 value;
}
```

### AccessList (inherited from StdCheatsSafe)

```solidity
struct AccessList {
    address accessAddress;
    bytes32[] storageKeys;
}
```

### RawReceipt (inherited from StdCheatsSafe)

```solidity
struct RawReceipt {
    bytes32 blockHash;
    bytes blockNumber;
    address contractAddress;
    bytes cumulativeGasUsed;
    bytes effectiveGasPrice;
    address from;
    bytes gasUsed;
    RawReceiptLog[] logs;
    bytes logsBloom;
    bytes status;
    address to;
    bytes32 transactionHash;
    bytes transactionIndex;
}
```

### Receipt (inherited from StdCheatsSafe)

```solidity
struct Receipt {
    bytes32 blockHash;
    uint256 blockNumber;
    address contractAddress;
    uint256 cumulativeGasUsed;
    uint256 effectiveGasPrice;
    address from;
    uint256 gasUsed;
    ReceiptLog[] logs;
    bytes logsBloom;
    uint256 status;
    address to;
    bytes32 transactionHash;
    uint256 transactionIndex;
}
```

### EIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct EIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    Receipt[] receipts;
    uint256 timestamp;
    Tx1559[] transactions;
    TxReturn[] txReturns;
}
```

### RawEIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct RawEIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    RawReceipt[] receipts;
    TxReturn[] txReturns;
    uint256 timestamp;
    RawTx1559[] transactions;
}
```

### RawReceiptLog (inherited from StdCheatsSafe)

```solidity
struct RawReceiptLog {
    address logAddress;
    bytes32 blockHash;
    bytes blockNumber;
    bytes data;
    bytes logIndex;
    bool removed;
    bytes32[] topics;
    bytes32 transactionHash;
    bytes transactionIndex;
    bytes transactionLogIndex;
}
```

### ReceiptLog (inherited from StdCheatsSafe)

```solidity
struct ReceiptLog {
    address logAddress;
    bytes32 blockHash;
    uint256 blockNumber;
    bytes data;
    uint256 logIndex;
    bytes32[] topics;
    uint256 transactionIndex;
    uint256 transactionLogIndex;
    bool removed;
}
```

### TxReturn (inherited from StdCheatsSafe)

```solidity
struct TxReturn {
    string internalType;
    string value;
}
```

### Account (inherited from StdCheatsSafe)

```solidity
struct Account {
    address addr;
    uint256 key;
}
```

## Enums

### AddressType (inherited from StdCheatsSafe)

```solidity
enum AddressType {
    Payable,
    NonPayable,
    ZeroAddress,
    Precompile,
    ForgeAddress
}
```

## Public/External Functions

### run()

- **Signature**: `run()`
- **Visibility**: external
- **Source Range**: 738:907:63
- **Details**: [function_run.md](./function_run.md)

**Signature:**
```solidity
function run() external;
```
