# Contract: MockedGovernanceTest

## Metadata

- **Name**: MockedGovernanceTest
- **Type**: Contract
- **Path**: test/Governance.t.sol

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

### vm (inherited from StdAssertions)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### _failed (inherited from StdAssertions)

```solidity
bool private _failed
```

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

### stdstore (inherited from StdCheats)

```solidity
StdStorage private stdstore
```

### vm (inherited from StdCheats)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### CONSOLE2_ADDRESS (inherited from StdCheats)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### _excludedContracts (inherited from StdInvariant)

```solidity
address[] private _excludedContracts
```

### _excludedSenders (inherited from StdInvariant)

```solidity
address[] private _excludedSenders
```

### _targetedContracts (inherited from StdInvariant)

```solidity
address[] private _targetedContracts
```

### _targetedSenders (inherited from StdInvariant)

```solidity
address[] private _targetedSenders
```

### _excludedArtifacts (inherited from StdInvariant)

```solidity
string[] private _excludedArtifacts
```

### _targetedArtifacts (inherited from StdInvariant)

```solidity
string[] private _targetedArtifacts
```

### _targetedArtifactSelectors (inherited from StdInvariant)

```solidity
FuzzArtifactSelector[] private _targetedArtifactSelectors
```

### _excludedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _excludedSelectors
```

### _targetedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _targetedSelectors
```

### _targetedInterfaces (inherited from StdInvariant)

```solidity
FuzzInterface[] private _targetedInterfaces
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

### IS_TEST (inherited from Test)

```solidity
bool public IS_TEST = true
```

### lqty (inherited from GovernanceTest)

```solidity
ILQTY internal lqty
```

**ILQTY**: [src/interfaces/ILQTY.sol/interface_ILQTY.md]

### lusd (inherited from GovernanceTest)

```solidity
ILUSD internal lusd
```

**ILUSD**: [src/interfaces/ILUSD.sol/interface_ILUSD.md]

### stakingV1 (inherited from GovernanceTest)

```solidity
ILQTYStaking internal stakingV1
```

**ILQTYStaking**: [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]

### user (inherited from GovernanceTest)

```solidity
address internal constant user = address(0xF977814e90dA44bFA03b6295A0616a897441aceC)
```

### user2 (inherited from GovernanceTest)

```solidity
address internal constant user2 = address(0x10C9cff3c4Faa8A60cB8506a7A99411E6A199038)
```

### lusdHolder (inherited from GovernanceTest)

```solidity
address internal constant lusdHolder = address(0xcA7f01403C4989d2b1A9335A2F09dD973709957c)
```

### REGISTRATION_FEE (inherited from GovernanceTest)

```solidity
uint256 private constant REGISTRATION_FEE = 1e18
```

### REGISTRATION_THRESHOLD_FACTOR (inherited from GovernanceTest)

```solidity
uint256 private constant REGISTRATION_THRESHOLD_FACTOR = 0.01e18
```

### UNREGISTRATION_THRESHOLD_FACTOR (inherited from GovernanceTest)

```solidity
uint256 private constant UNREGISTRATION_THRESHOLD_FACTOR = 4e18
```

### UNREGISTRATION_AFTER_EPOCHS (inherited from GovernanceTest)

```solidity
uint256 private constant UNREGISTRATION_AFTER_EPOCHS = 4
```

### VOTING_THRESHOLD_FACTOR (inherited from GovernanceTest)

```solidity
uint256 private constant VOTING_THRESHOLD_FACTOR = 0.04e18
```

### MIN_CLAIM (inherited from GovernanceTest)

```solidity
uint256 private constant MIN_CLAIM = 500e18
```

### MIN_ACCRUAL (inherited from GovernanceTest)

```solidity
uint256 private constant MIN_ACCRUAL = 1000e18
```

### EPOCH_DURATION (inherited from GovernanceTest)

```solidity
uint256 private constant EPOCH_DURATION = 604800
```

### EPOCH_VOTING_CUTOFF (inherited from GovernanceTest)

```solidity
uint32 private constant EPOCH_VOTING_CUTOFF = 518400
```

### governance (inherited from GovernanceTest)

```solidity
GovernanceTester private governance
```

**GovernanceTester**: [test/Governance.t.sol/contract_GovernanceTester.md]

### initialInitiatives (inherited from GovernanceTest)

```solidity
address[] private initialInitiatives
```

### baseInitiative2 (inherited from GovernanceTest)

```solidity
address private baseInitiative2
```

### baseInitiative3 (inherited from GovernanceTest)

```solidity
address private baseInitiative3
```

### baseInitiative1 (inherited from GovernanceTest)

```solidity
address private baseInitiative1
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

### FuzzSelector (inherited from StdInvariant)

```solidity
struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}
```

### FuzzArtifactSelector (inherited from StdInvariant)

```solidity
struct FuzzArtifactSelector {
    string artifact;
    bytes4[] selectors;
}
```

### FuzzInterface (inherited from StdInvariant)

```solidity
struct FuzzInterface {
    address addr;
    string[] artifacts;
}
```

### StakingOp (inherited from GovernanceTest)

```solidity
struct StakingOp {
    uint256 lqtyAmount;
    uint256 waitTime;
}
```

## Events

### log (inherited from StdAssertions)

```solidity
event log(string);
```

### logs (inherited from StdAssertions)

```solidity
event logs(bytes);
```

### log_address (inherited from StdAssertions)

```solidity
event log_address(address);
```

### log_bytes32 (inherited from StdAssertions)

```solidity
event log_bytes32(bytes32);
```

### log_int (inherited from StdAssertions)

```solidity
event log_int(int256);
```

### log_uint (inherited from StdAssertions)

```solidity
event log_uint(uint256);
```

### log_bytes (inherited from StdAssertions)

```solidity
event log_bytes(bytes);
```

### log_string (inherited from StdAssertions)

```solidity
event log_string(string);
```

### log_named_address (inherited from StdAssertions)

```solidity
event log_named_address(string key, address val);
```

### log_named_bytes32 (inherited from StdAssertions)

```solidity
event log_named_bytes32(string key, bytes32 val);
```

### log_named_decimal_int (inherited from StdAssertions)

```solidity
event log_named_decimal_int(string key, int256 val, uint256 decimals);
```

### log_named_decimal_uint (inherited from StdAssertions)

```solidity
event log_named_decimal_uint(string key, uint256 val, uint256 decimals);
```

### log_named_int (inherited from StdAssertions)

```solidity
event log_named_int(string key, int256 val);
```

### log_named_uint (inherited from StdAssertions)

```solidity
event log_named_uint(string key, uint256 val);
```

### log_named_bytes (inherited from StdAssertions)

```solidity
event log_named_bytes(string key, bytes val);
```

### log_named_string (inherited from StdAssertions)

```solidity
event log_named_string(string key, string val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(uint256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(int256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(address[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, uint256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, int256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, address[] val);
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

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 114620:392:99
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() override public;
```

### failed() (inherited from StdAssertions)

- **Signature**: `failed()`
- **Visibility**: public
- **Source Range**: 1243:204:9
- **Details**: [function_failed.md](./function_failed.md)

**Signature:**
```solidity
function failed() public view returns (bool);
```

### excludeArtifacts() (inherited from StdInvariant)

- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2459:141:13
- **Details**: [function_excludeArtifacts.md](./function_excludeArtifacts.md)

**Signature:**
```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_);
```

### excludeContracts() (inherited from StdInvariant)

- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2606:142:13
- **Details**: [function_excludeContracts.md](./function_excludeContracts.md)

**Signature:**
```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_);
```

### excludeSelectors() (inherited from StdInvariant)

- **Signature**: `excludeSelectors()`
- **Visibility**: public
- **Source Range**: 2754:147:13
- **Details**: [function_excludeSelectors.md](./function_excludeSelectors.md)

**Signature:**
```solidity
function excludeSelectors() public view returns (FuzzSelector[] memory excludedSelectors_);
```

### excludeSenders() (inherited from StdInvariant)

- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2907:134:13
- **Details**: [function_excludeSenders.md](./function_excludeSenders.md)

**Signature:**
```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_);
```

### targetArtifacts() (inherited from StdInvariant)

- **Signature**: `targetArtifacts()`
- **Visibility**: public
- **Source Range**: 3047:140:13
- **Details**: [function_targetArtifacts.md](./function_targetArtifacts.md)

**Signature:**
```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_);
```

### targetArtifactSelectors() (inherited from StdInvariant)

- **Signature**: `targetArtifactSelectors()`
- **Visibility**: public
- **Source Range**: 3193:186:13
- **Details**: [function_targetArtifactSelectors.md](./function_targetArtifactSelectors.md)

**Signature:**
```solidity
function targetArtifactSelectors() public view returns (FuzzArtifactSelector[] memory targetedArtifactSelectors_);
```

### targetContracts() (inherited from StdInvariant)

- **Signature**: `targetContracts()`
- **Visibility**: public
- **Source Range**: 3385:141:13
- **Details**: [function_targetContracts.md](./function_targetContracts.md)

**Signature:**
```solidity
function targetContracts() public view returns (address[] memory targetedContracts_);
```

### targetSelectors() (inherited from StdInvariant)

- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3532:146:13
- **Details**: [function_targetSelectors.md](./function_targetSelectors.md)

**Signature:**
```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_);
```

### targetSenders() (inherited from StdInvariant)

- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3684:133:13
- **Details**: [function_targetSenders.md](./function_targetSenders.md)

**Signature:**
```solidity
function targetSenders() public view returns (address[] memory targetedSenders_);
```

### targetInterfaces() (inherited from StdInvariant)

- **Signature**: `targetInterfaces()`
- **Visibility**: public
- **Source Range**: 3823:151:13
- **Details**: [function_targetInterfaces.md](./function_targetInterfaces.md)

**Signature:**
```solidity
function targetInterfaces() public view returns (FuzzInterface[] memory targetedInterfaces_);
```

### test_depositLQTY_withdrawLQTY() (inherited from GovernanceTest)

- **Signature**: `test_depositLQTY_withdrawLQTY()`
- **Visibility**: public
- **Source Range**: 4799:3156:99
- **Details**: [function_test_depositLQTY_withdrawLQTY.md](./function_test_depositLQTY_withdrawLQTY.md)

**Signature:**
```solidity
function test_depositLQTY_withdrawLQTY() public;
```

### test_depositLQTYViaPermit() (inherited from GovernanceTest)

- **Signature**: `test_depositLQTYViaPermit()`
- **Visibility**: public
- **Source Range**: 7961:2331:99
- **Details**: [function_test_depositLQTYViaPermit.md](./function_test_depositLQTYViaPermit.md)

**Signature:**
```solidity
function test_depositLQTYViaPermit() public;
```

### test_claimFromStakingV1() (inherited from GovernanceTest)

- **Signature**: `test_claimFromStakingV1()`
- **Visibility**: public
- **Source Range**: 10298:733:99
- **Details**: [function_test_claimFromStakingV1.md](./function_test_claimFromStakingV1.md)

**Signature:**
```solidity
function test_claimFromStakingV1() public;
```

### test_epoch() (inherited from GovernanceTest)

- **Signature**: `test_epoch()`
- **Visibility**: public
- **Source Range**: 11104:368:99
- **Details**: [function_test_epoch.md](./function_test_epoch.md)

**Signature:**
```solidity
function test_epoch() public;
```

### test_epoch_fuzz(uint32) (inherited from GovernanceTest)

- **Signature**: `test_epoch_fuzz(uint32)`
- **Visibility**: public
- **Source Range**: 11544:142:99
- **Details**: [function_test_epoch_fuzz_uint32.md](./function_test_epoch_fuzz_uint32.md)

**Signature:**
```solidity
function test_epoch_fuzz(uint32 _timestamp) public;
```

### test_epochStart() (inherited from GovernanceTest)

- **Signature**: `test_epochStart()`
- **Visibility**: public
- **Source Range**: 11775:203:99
- **Details**: [function_test_epochStart.md](./function_test_epochStart.md)

**Signature:**
```solidity
function test_epochStart() public;
```

### test_epochStart_fuzz(uint32) (inherited from GovernanceTest)

- **Signature**: `test_epochStart_fuzz(uint32)`
- **Visibility**: public
- **Source Range**: 12050:152:99
- **Details**: [function_test_epochStart_fuzz_uint32.md](./function_test_epochStart_fuzz_uint32.md)

**Signature:**
```solidity
function test_epochStart_fuzz(uint32 _timestamp) public;
```

### test_secondsWithinEpoch() (inherited from GovernanceTest)

- **Signature**: `test_secondsWithinEpoch()`
- **Visibility**: public
- **Source Range**: 12311:501:99
- **Details**: [function_test_secondsWithinEpoch.md](./function_test_secondsWithinEpoch.md)

**Signature:**
```solidity
function test_secondsWithinEpoch() public;
```

### test_secondsWithinEpoch_fuzz(uint32) (inherited from GovernanceTest)

- **Signature**: `test_secondsWithinEpoch_fuzz(uint32)`
- **Visibility**: public
- **Source Range**: 12869:168:99
- **Details**: [function_test_secondsWithinEpoch_fuzz_uint32.md](./function_test_secondsWithinEpoch_fuzz_uint32.md)

**Signature:**
```solidity
function test_secondsWithinEpoch_fuzz(uint32 _timestamp) public;
```

### test_lqtyToVotes(uint88,uint32,uint256) (inherited from GovernanceTest)

- **Signature**: `test_lqtyToVotes(uint88,uint32,uint256)`
- **Visibility**: public
- **Source Range**: 13084:176:99
- **Details**: [function_test_lqtyToVotes_uint88_uint32_uint256.md](./function_test_lqtyToVotes_uint88_uint32_uint256.md)

**Signature:**
```solidity
function test_lqtyToVotes(uint88 _lqtyAmount, uint32 _currentTimestamp, uint256 _offset) public;
```

### test_getLatestVotingThreshold() (inherited from GovernanceTest)

- **Signature**: `test_getLatestVotingThreshold()`
- **Visibility**: public
- **Source Range**: 13266:2651:99
- **Details**: [function_test_getLatestVotingThreshold.md](./function_test_getLatestVotingThreshold.md)

**Signature:**
```solidity
function test_getLatestVotingThreshold() public;
```

### test_calculateVotingThreshold_fuzz(uint256,uint256,uint256,uint256,uint256) (inherited from GovernanceTest)

- **Signature**: `test_calculateVotingThreshold_fuzz(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 15964:1634:99
- **Details**: [function_test_calculateVotingThreshold_fuzz_uint256_uint256_uint256_uint256_uint256.md](./function_test_calculateVotingThreshold_fuzz_uint256_uint256_uint256_uint256_uint256.md)

**Signature:**
```solidity
function test_calculateVotingThreshold_fuzz(uint256 _votes, uint256 _forEpoch, uint256 _boldAccrued, uint256 _votingThresholdFactor, uint256 _minClaim) public;
```

### test_registerInitiative() (inherited from GovernanceTest)

- **Signature**: `test_registerInitiative()`
- **Visibility**: public
- **Source Range**: 17604:2018:99
- **Details**: [function_test_registerInitiative.md](./function_test_registerInitiative.md)

**Signature:**
```solidity
function test_registerInitiative() public;
```

### test_RegistrationFeesAreUsedAsRewardInNextEpoch() (inherited from GovernanceTest)

- **Signature**: `test_RegistrationFeesAreUsedAsRewardInNextEpoch()`
- **Visibility**: external
- **Source Range**: 19628:2880:99
- **Details**: [function_test_RegistrationFeesAreUsedAsRewardInNextEpoch.md](./function_test_RegistrationFeesAreUsedAsRewardInNextEpoch.md)

**Signature:**
```solidity
function test_RegistrationFeesAreUsedAsRewardInNextEpoch() external;
```

### test_unregisterInitiative() (inherited from GovernanceTest)

- **Signature**: `test_unregisterInitiative()`
- **Visibility**: public
- **Source Range**: 22575:1667:99
- **Details**: [function_test_unregisterInitiative.md](./function_test_unregisterInitiative.md)

**Signature:**
```solidity
function test_unregisterInitiative() public;
```

### test_crit_accounting_mismatch() (inherited from GovernanceTest)

- **Signature**: `test_crit_accounting_mismatch()`
- **Visibility**: public
- **Source Range**: 24340:2486:99
- **Details**: [function_test_crit_accounting_mismatch.md](./function_test_crit_accounting_mismatch.md)

**Signature:**
```solidity
/// Used to demonstrate how composite voting could allow using more power than intended
function test_crit_accounting_mismatch() public;
```

### test_canAlwaysRemoveAllocation() (inherited from GovernanceTest)

- **Signature**: `test_canAlwaysRemoveAllocation()`
- **Visibility**: public
- **Source Range**: 26918:2869:99
- **Details**: [function_test_canAlwaysRemoveAllocation.md](./function_test_canAlwaysRemoveAllocation.md)

**Signature:**
```solidity
function test_canAlwaysRemoveAllocation() public;
```

### test_allocationRemovalTotalLqtyMathIsSound() (inherited from GovernanceTest)

- **Signature**: `test_allocationRemovalTotalLqtyMathIsSound()`
- **Visibility**: public
- **Source Range**: 29923:2659:99
- **Details**: [function_test_allocationRemovalTotalLqtyMathIsSound.md](./function_test_allocationRemovalTotalLqtyMathIsSound.md)

**Signature:**
```solidity
function test_allocationRemovalTotalLqtyMathIsSound() public;
```

### test_addRemoveAllocation_accounting() (inherited from GovernanceTest)

- **Signature**: `test_addRemoveAllocation_accounting()`
- **Visibility**: public
- **Source Range**: 32677:4378:99
- **Details**: [function_test_addRemoveAllocation_accounting.md](./function_test_addRemoveAllocation_accounting.md)

**Signature:**
```solidity
function test_addRemoveAllocation_accounting() public;
```

### test_overflow_crit() (inherited from GovernanceTest)

- **Signature**: `test_overflow_crit()`
- **Visibility**: public
- **Source Range**: 37170:2425:99
- **Details**: [function_test_overflow_crit.md](./function_test_overflow_crit.md)

**Signature:**
```solidity
function test_overflow_crit() public;
```

### test_fuzz_canRemoveExtact() (inherited from GovernanceTest)

- **Signature**: `test_fuzz_canRemoveExtact()`
- **Visibility**: public
- **Source Range**: 39769:46:99
- **Details**: [function_test_fuzz_canRemoveExtact.md](./function_test_fuzz_canRemoveExtact.md)

**Signature:**
```solidity
/// Find some random amount
///  Divide into chunks
///  Ensure chunks above 1 wei
///  Go ahead and remove
///  Ensure that at the end you remove 100%
function test_fuzz_canRemoveExtact() public;
```

### test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths() (inherited from GovernanceTest)

- **Signature**: `test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths()`
- **Visibility**: external
- **Source Range**: 39821:784:99
- **Details**: [function_test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths.md](./function_test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths.md)

**Signature:**
```solidity
function test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths() external;
```

### test_allocateLQTY_single() (inherited from GovernanceTest)

- **Signature**: `test_allocateLQTY_single()`
- **Visibility**: public
- **Source Range**: 40611:4902:99
- **Details**: [function_test_allocateLQTY_single.md](./function_test_allocateLQTY_single.md)

**Signature:**
```solidity
function test_allocateLQTY_single() public;
```

### test_allocateLQTY_after_cutoff() (inherited from GovernanceTest)

- **Signature**: `test_allocateLQTY_after_cutoff()`
- **Visibility**: public
- **Source Range**: 45519:4643:99
- **Details**: [function_test_allocateLQTY_after_cutoff.md](./function_test_allocateLQTY_after_cutoff.md)

**Signature:**
```solidity
function test_allocateLQTY_after_cutoff() public;
```

### test_allocate_unregister() (inherited from GovernanceTest)

- **Signature**: `test_allocate_unregister()`
- **Visibility**: public
- **Source Range**: 50168:45:99
- **Details**: [function_test_allocate_unregister.md](./function_test_allocate_unregister.md)

**Signature:**
```solidity
function test_allocate_unregister() public;
```

### test_allocateLQTY_multiple() (inherited from GovernanceTest)

- **Signature**: `test_allocateLQTY_multiple()`
- **Visibility**: public
- **Source Range**: 50219:1542:99
- **Details**: [function_test_allocateLQTY_multiple.md](./function_test_allocateLQTY_multiple.md)

**Signature:**
```solidity
function test_allocateLQTY_multiple() public;
```

### test_allocateLQTY_fuzz_deltaLQTYVotes(uint256) (inherited from GovernanceTest)

- **Signature**: `test_allocateLQTY_fuzz_deltaLQTYVotes(uint256)`
- **Visibility**: public
- **Source Range**: 51767:905:99
- **Details**: [function_test_allocateLQTY_fuzz_deltaLQTYVotes_uint256.md](./function_test_allocateLQTY_fuzz_deltaLQTYVotes_uint256.md)

**Signature:**
```solidity
function test_allocateLQTY_fuzz_deltaLQTYVotes(uint256 _deltaLQTYVotes) public;
```

### test_allocateLQTY_fuzz_deltaLQTYVetos(uint256) (inherited from GovernanceTest)

- **Signature**: `test_allocateLQTY_fuzz_deltaLQTYVetos(uint256)`
- **Visibility**: public
- **Source Range**: 52678:946:99
- **Details**: [function_test_allocateLQTY_fuzz_deltaLQTYVetos_uint256.md](./function_test_allocateLQTY_fuzz_deltaLQTYVetos_uint256.md)

**Signature:**
```solidity
function test_allocateLQTY_fuzz_deltaLQTYVetos(uint256 _deltaLQTYVetos) public;
```

### test_claimForInitiative() (inherited from GovernanceTest)

- **Signature**: `test_claimForInitiative()`
- **Visibility**: public
- **Source Range**: 53630:3358:99
- **Details**: [function_test_claimForInitiative.md](./function_test_claimForInitiative.md)

**Signature:**
```solidity
function test_claimForInitiative() public;
```

### off_claimForInitiativeEOA() (inherited from GovernanceTest)

- **Signature**: `off_claimForInitiativeEOA()`
- **Visibility**: public
- **Source Range**: 57023:2680:99
- **Details**: [function_off_claimForInitiativeEOA.md](./function_off_claimForInitiativeEOA.md)

**Signature:**
```solidity
function off_claimForInitiativeEOA() public;
```

### test_multicall() (inherited from GovernanceTest)

- **Signature**: `test_multicall()`
- **Visibility**: public
- **Source Range**: 59709:2279:99
- **Details**: [function_test_multicall.md](./function_test_multicall.md)

**Signature:**
```solidity
function test_multicall() public;
```

### test_allocateLQTY_overflow() (inherited from GovernanceTest)

- **Signature**: `test_allocateLQTY_overflow()`
- **Visibility**: public
- **Source Range**: 64305:1093:99
- **Details**: [function_test_allocateLQTY_overflow.md](./function_test_allocateLQTY_overflow.md)

**Signature:**
```solidity
function test_allocateLQTY_overflow() public;
```

### test_voting_power_increase() (inherited from GovernanceTest)

- **Signature**: `test_voting_power_increase()`
- **Visibility**: public
- **Source Range**: 65404:6318:99
- **Details**: [function_test_voting_power_increase.md](./function_test_voting_power_increase.md)

**Signature:**
```solidity
function test_voting_power_increase() public;
```

### test_voting_power_in_same_epoch_as_allocation() (inherited from GovernanceTest)

- **Signature**: `test_voting_power_in_same_epoch_as_allocation()`
- **Visibility**: public
- **Source Range**: 71814:4186:99
- **Details**: [function_test_voting_power_in_same_epoch_as_allocation.md](./function_test_voting_power_in_same_epoch_as_allocation.md)

**Signature:**
```solidity
function test_voting_power_in_same_epoch_as_allocation() public;
```

### test_voting_power_increase_in_an_epoch() (inherited from GovernanceTest)

- **Signature**: `test_voting_power_increase_in_an_epoch()`
- **Visibility**: public
- **Source Range**: 76316:2579:99
- **Details**: [function_test_voting_power_increase_in_an_epoch.md](./function_test_voting_power_increase_in_an_epoch.md)

**Signature:**
```solidity
function test_voting_power_increase_in_an_epoch() public;
```

### test_voting_power_lqtyAllocatedByUserToInitiative() (inherited from GovernanceTest)

- **Signature**: `test_voting_power_lqtyAllocatedByUserToInitiative()`
- **Visibility**: public
- **Source Range**: 79053:2044:99
- **Details**: [function_test_voting_power_lqtyAllocatedByUserToInitiative.md](./function_test_voting_power_lqtyAllocatedByUserToInitiative.md)

**Signature:**
```solidity
function test_voting_power_lqtyAllocatedByUserToInitiative() public;
```

### test_allocated_offset() (inherited from GovernanceTest)

- **Signature**: `test_allocated_offset()`
- **Visibility**: public
- **Source Range**: 81210:2082:99
- **Details**: [function_test_allocated_offset.md](./function_test_allocated_offset.md)

**Signature:**
```solidity
function test_allocated_offset() public;
```

### test_offset_same_initiative() (inherited from GovernanceTest)

- **Signature**: `test_offset_same_initiative()`
- **Visibility**: public
- **Source Range**: 83452:1937:99
- **Details**: [function_test_offset_same_initiative.md](./function_test_offset_same_initiative.md)

**Signature:**
```solidity
function test_offset_same_initiative() public;
```

### test_offset_allocate_same_initiative_fuzz(uint256) (inherited from GovernanceTest)

- **Signature**: `test_offset_allocate_same_initiative_fuzz(uint256)`
- **Visibility**: public
- **Source Range**: 85475:2456:99
- **Details**: [function_test_offset_allocate_same_initiative_fuzz_uint256.md](./function_test_offset_allocate_same_initiative_fuzz_uint256.md)

**Signature:**
```solidity
function test_offset_allocate_same_initiative_fuzz(uint256 allocateAmount) public;
```

### test_voting_snapshot_start_vs_end_epoch() (inherited from GovernanceTest)

- **Signature**: `test_voting_snapshot_start_vs_end_epoch()`
- **Visibility**: public
- **Source Range**: 87937:3138:99
- **Details**: [function_test_voting_snapshot_start_vs_end_epoch.md](./function_test_voting_snapshot_start_vs_end_epoch.md)

**Signature:**
```solidity
function test_voting_snapshot_start_vs_end_epoch() public;
```

### test_voting_power_no_difference_in_allocating_start_or_end_of_epoch() (inherited from GovernanceTest)

- **Signature**: `test_voting_power_no_difference_in_allocating_start_or_end_of_epoch()`
- **Visibility**: public
- **Source Range**: 91189:3006:99
- **Details**: [function_test_voting_power_no_difference_in_allocating_start_or_end_of_epoch.md](./function_test_voting_power_no_difference_in_allocating_start_or_end_of_epoch.md)

**Signature:**
```solidity
function test_voting_power_no_difference_in_allocating_start_or_end_of_epoch() public;
```

### test_voting_power_decreases_next_epoch() (inherited from GovernanceTest)

- **Signature**: `test_voting_power_decreases_next_epoch()`
- **Visibility**: public
- **Source Range**: 94275:2562:99
- **Details**: [function_test_voting_power_decreases_next_epoch.md](./function_test_voting_power_decreases_next_epoch.md)

**Signature:**
```solidity
function test_voting_power_decreases_next_epoch() public;
```

### test_deallocating_decreases_offset() (inherited from GovernanceTest)

- **Signature**: `test_deallocating_decreases_offset()`
- **Visibility**: public
- **Source Range**: 96843:1770:99
- **Details**: [function_test_deallocating_decreases_offset.md](./function_test_deallocating_decreases_offset.md)

**Signature:**
```solidity
function test_deallocating_decreases_offset() public;
```

### test_vote_and_veto() (inherited from GovernanceTest)

- **Signature**: `test_vote_and_veto()`
- **Visibility**: public
- **Source Range**: 98682:2280:99
- **Details**: [function_test_vote_and_veto.md](./function_test_vote_and_veto.md)

**Signature:**
```solidity
function test_vote_and_veto() public;
```

### test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY(uint256[3],struct GovernanceTest.StakingOp[4]) (inherited from GovernanceTest)

- **Signature**: `test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY(uint256[3],struct GovernanceTest.StakingOp[4])`
- **Visibility**: external
- **Source Range**: 101052:2850:99
- **Details**: [function_test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY_uint256[3]_struct_GovernanceTest.StakingOp[4].md](./function_test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY_uint256[3]_struct_GovernanceTest.StakingOp[4].md)

**Signature:**
```solidity
function test_NoDustInUnallocatedOffsetAfterAllocatingAllLQTY(uint256[3] memory _votes, StakingOp[4] memory _stakes) external;
```

### test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256) (inherited from GovernanceTest)

- **Signature**: `test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 103908:2405:99
- **Details**: [function_test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError_uint256_uint256.md](./function_test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError_uint256_uint256.md)

**Signature:**
```solidity
function test_WhenAllocatingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256 initialVotingPower, uint256 numInitiatives) external;
```

### test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256) (inherited from GovernanceTest)

- **Signature**: `test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 108293:1453:99
- **Details**: [function_test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError_uint256_uint256.md](./function_test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError_uint256_uint256.md)

**Signature:**
```solidity
function test_WhenWithdrawingTinyAmounts_VotingPowerDoesNotTurnNegativeDueToRoundingError(uint256 initialVotingPower, uint256 numWithdrawals) external;
```

### test_Vote_Stake_Unvote() (inherited from GovernanceTest)

- **Signature**: `test_Vote_Stake_Unvote()`
- **Visibility**: external
- **Source Range**: 109752:1875:99
- **Details**: [function_test_Vote_Stake_Unvote.md](./function_test_Vote_Stake_Unvote.md)

**Signature:**
```solidity
function test_Vote_Stake_Unvote() external;
```
