# Contract: CryticToFoundry

## Metadata

- **Name**: CryticToFoundry
- **Type**: Contract
- **Path**: test/recon/CryticToFoundry.sol

## State Variables

### _actor (inherited from ActorManager)

```solidity
/// @notice The current actor being used
address private _actor
```

### _actors (inherited from ActorManager)

```solidity
/// @notice The list of all actors being used
EnumerableSet.AddressSet private _actors
```

### __asset (inherited from AssetManager)

```solidity
/// @notice The current target for this set of variables
address private __asset
```

### _assets (inherited from AssetManager)

```solidity
/// @notice The list of all assets being used
EnumerableSet.AddressSet private _assets
```

### DECIMALS (inherited from Setup)

```solidity
uint256 internal constant DECIMALS = 18
```

### bribeInitiative (inherited from Setup)

```solidity
BribeInitiative internal bribeInitiative
```

**BribeInitiative**: [src/BribeInitiative.sol/contract_BribeInitiative.md]

### governance (inherited from Setup)

```solidity
Governance internal governance
```

**Governance**: [src/Governance.sol/contract_Governance.md]

### lqty (inherited from Setup)

```solidity
MockERC20Tester internal lqty
```

**MockERC20Tester**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

### lusd (inherited from Setup)

```solidity
MockERC20Tester internal lusd
```

**MockERC20Tester**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

### bold (inherited from Setup)

```solidity
MockERC20Tester internal bold
```

**MockERC20Tester**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

### bribeToken (inherited from Setup)

```solidity
MockERC20Tester internal bribeToken
```

**MockERC20Tester**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

### stakingV1 (inherited from Setup)

```solidity
MockStakingV1 internal stakingV1
```

**MockStakingV1**: [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]

### _before (inherited from BeforeAfter)

```solidity
Vars internal _before
```

### _after (inherited from BeforeAfter)

```solidity
Vars internal _after
```

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

## Structs

### Vars (inherited from BeforeAfter)

```solidity
struct Vars {
    uint256 __ignore__;
}
```

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

## Errors

### ActorNotSetup (inherited from ActorManager)

```solidity
error ActorNotSetup();
```

### ActorExists (inherited from ActorManager)

```solidity
error ActorExists();
```

### ActorNotAdded (inherited from ActorManager)

```solidity
error ActorNotAdded();
```

### DefaultActor (inherited from ActorManager)

```solidity
error DefaultActor();
```

### NotSetup (inherited from AssetManager)

```solidity
error NotSetup();
```

### Exists (inherited from AssetManager)

```solidity
error Exists();
```

### NotAdded (inherited from AssetManager)

```solidity
error NotAdded();
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
- **Source Range**: 447:88:118
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() public;
```

### test_crytic()

- **Signature**: `test_crytic()`
- **Visibility**: public
- **Source Range**: 589:100:118
- **Details**: [function_test_crytic.md](./function_test_crytic.md)

**Signature:**
```solidity
function test_crytic() public;
```

### test_governance_deployUserProxy()

- **Signature**: `test_governance_deployUserProxy()`
- **Visibility**: public
- **Source Range**: 788:119:118
- **Details**: [function_test_governance_deployUserProxy.md](./function_test_governance_deployUserProxy.md)

**Signature:**
```solidity
function test_governance_deployUserProxy() public;
```

### test_governance_depositLQTY_simple()

- **Signature**: `test_governance_depositLQTY_simple()`
- **Visibility**: public
- **Source Range**: 967:122:118
- **Details**: [function_test_governance_depositLQTY_simple.md](./function_test_governance_depositLQTY_simple.md)

**Signature:**
```solidity
function test_governance_depositLQTY_simple() public;
```

### test_governance_depositLQTY_withParams()

- **Signature**: `test_governance_depositLQTY_withParams()`
- **Visibility**: public
- **Source Range**: 1190:177:118
- **Details**: [function_test_governance_depositLQTY_withParams.md](./function_test_governance_depositLQTY_withParams.md)

**Signature:**
```solidity
function test_governance_depositLQTY_withParams() public;
```

### test_governance_registerInitiative()

- **Signature**: `test_governance_registerInitiative()`
- **Visibility**: public
- **Source Range**: 1663:280:118
- **Details**: [function_test_governance_registerInitiative.md](./function_test_governance_registerInitiative.md)

**Signature:**
```solidity
function test_governance_registerInitiative() public;
```

### test_governance_allocateLQTY()

- **Signature**: `test_governance_allocateLQTY()`
- **Visibility**: public
- **Source Range**: 1983:785:118
- **Details**: [function_test_governance_allocateLQTY.md](./function_test_governance_allocateLQTY.md)

**Signature:**
```solidity
function test_governance_allocateLQTY() public;
```

### test_governance_calculateVotingThreshold()

- **Signature**: `test_governance_calculateVotingThreshold()`
- **Visibility**: public
- **Source Range**: 2820:137:118
- **Details**: [function_test_governance_calculateVotingThreshold.md](./function_test_governance_calculateVotingThreshold.md)

**Signature:**
```solidity
function test_governance_calculateVotingThreshold() public;
```

### test_governance_getInitiativeState()

- **Signature**: `test_governance_getInitiativeState()`
- **Visibility**: public
- **Source Range**: 3003:149:118
- **Details**: [function_test_governance_getInitiativeState.md](./function_test_governance_getInitiativeState.md)

**Signature:**
```solidity
function test_governance_getInitiativeState() public;
```

### test_governance_snapshotVotesForInitiative()

- **Signature**: `test_governance_snapshotVotesForInitiative()`
- **Visibility**: public
- **Source Range**: 3207:165:118
- **Details**: [function_test_governance_snapshotVotesForInitiative.md](./function_test_governance_snapshotVotesForInitiative.md)

**Signature:**
```solidity
function test_governance_snapshotVotesForInitiative() public;
```

### test_governance_claimForInitiative()

- **Signature**: `test_governance_claimForInitiative()`
- **Visibility**: public
- **Source Range**: 3419:892:118
- **Details**: [function_test_governance_claimForInitiative.md](./function_test_governance_claimForInitiative.md)

**Signature:**
```solidity
function test_governance_claimForInitiative() public;
```

### test_governance_withdrawLQTY_simple()

- **Signature**: `test_governance_withdrawLQTY_simple()`
- **Visibility**: public
- **Source Range**: 4357:216:118
- **Details**: [function_test_governance_withdrawLQTY_simple.md](./function_test_governance_withdrawLQTY_simple.md)

**Signature:**
```solidity
function test_governance_withdrawLQTY_simple() public;
```

### test_governance_withdrawLQTY_withParams()

- **Signature**: `test_governance_withdrawLQTY_withParams()`
- **Visibility**: public
- **Source Range**: 4579:283:118
- **Details**: [function_test_governance_withdrawLQTY_withParams.md](./function_test_governance_withdrawLQTY_withParams.md)

**Signature:**
```solidity
function test_governance_withdrawLQTY_withParams() public;
```

### test_governance_resetAllocations()

- **Signature**: `test_governance_resetAllocations()`
- **Visibility**: public
- **Source Range**: 4907:936:118
- **Details**: [function_test_governance_resetAllocations.md](./function_test_governance_resetAllocations.md)

**Signature:**
```solidity
function test_governance_resetAllocations() public;
```

### test_governance_claimFromStakingV1()

- **Signature**: `test_governance_claimFromStakingV1()`
- **Visibility**: public
- **Source Range**: 6045:328:118
- **Details**: [function_test_governance_claimFromStakingV1.md](./function_test_governance_claimFromStakingV1.md)

**Signature:**
```solidity
function test_governance_claimFromStakingV1() public;
```

### test_governance_registerInitialInitiatives()

- **Signature**: `test_governance_registerInitialInitiatives()`
- **Visibility**: public
- **Source Range**: 6599:226:118
- **Details**: [function_test_governance_registerInitialInitiatives.md](./function_test_governance_registerInitialInitiatives.md)

**Signature:**
```solidity
function test_governance_registerInitialInitiatives() public;
```

### test_bribeInitiative_depositBribe()

- **Signature**: `test_bribeInitiative_depositBribe()`
- **Visibility**: public
- **Source Range**: 6932:203:118
- **Details**: [function_test_bribeInitiative_depositBribe.md](./function_test_bribeInitiative_depositBribe.md)

**Signature:**
```solidity
function test_bribeInitiative_depositBribe() public;
```

### test_bribeInitiative_claimBribes()

- **Signature**: `test_bribeInitiative_claimBribes()`
- **Visibility**: public
- **Source Range**: 7310:1099:118
- **Details**: [function_test_bribeInitiative_claimBribes.md](./function_test_bribeInitiative_claimBribes.md)

**Signature:**
```solidity
function test_bribeInitiative_claimBribes() public;
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

### optimize_coverage() (inherited from Properties)

- **Signature**: `optimize_coverage()`
- **Visibility**: public
- **Source Range**: 259:79:119
- **Details**: [function_optimize_coverage.md](./function_optimize_coverage.md)

**Signature:**
```solidity
function optimize_coverage() public returns (uint256);
```

### governance_registerInitialInitiatives(address[]) (inherited from AdminTargets)

- **Signature**: `governance_registerInitialInitiatives(address[])`
- **Visibility**: public
- **Source Range**: 486:161:122
- **Details**: [function_governance_registerInitialInitiatives_address[].md](./function_governance_registerInitialInitiatives_address[].md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function governance_registerInitialInitiatives(address[] memory _initiatives) public asAdmin();
```

### bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[]) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[])`
- **Visibility**: public
- **Source Range**: 622:156:123
- **Details**: [function_bribeInitiative_claimBribes_struct_IBribeInitiative.ClaimData[].md](./function_bribeInitiative_claimBribes_struct_IBribeInitiative.ClaimData[].md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function bribeInitiative_claimBribes(IBribeInitiative.ClaimData[] memory _claimData) public asActor();
```

### bribeInitiative_depositBribe(uint256,uint256,uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_depositBribe(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 784:202:123
- **Details**: [function_bribeInitiative_depositBribe_uint256_uint256_uint256.md](./function_bribeInitiative_depositBribe_uint256_uint256_uint256.md)

**Signature:**
```solidity
function bribeInitiative_depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) public asActor();
```

### bribeInitiative_onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: public
- **Source Range**: 992:352:123
- **Details**: [function_bribeInitiative_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md](./function_bribeInitiative_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md)

**Signature:**
```solidity
function bribeInitiative_onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState memory _userState, IGovernance.Allocation memory _allocation, IGovernance.InitiativeState memory _initiativeState) public asActor();
```

### bribeInitiative_onClaimForInitiative(uint256,uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_onClaimForInitiative(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1350:140:123
- **Details**: [function_bribeInitiative_onClaimForInitiative_uint256_uint256.md](./function_bribeInitiative_onClaimForInitiative_uint256_uint256.md)

**Signature:**
```solidity
function bribeInitiative_onClaimForInitiative(uint256, uint256) public asActor();
```

### bribeInitiative_onRegisterInitiative(uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_onRegisterInitiative(uint256)`
- **Visibility**: public
- **Source Range**: 1496:127:123
- **Details**: [function_bribeInitiative_onRegisterInitiative_uint256.md](./function_bribeInitiative_onRegisterInitiative_uint256.md)

**Signature:**
```solidity
function bribeInitiative_onRegisterInitiative(uint256) public asActor();
```

### bribeInitiative_onUnregisterInitiative(uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_onUnregisterInitiative(uint256)`
- **Visibility**: public
- **Source Range**: 1629:131:123
- **Details**: [function_bribeInitiative_onUnregisterInitiative_uint256.md](./function_bribeInitiative_onUnregisterInitiative_uint256.md)

**Signature:**
```solidity
function bribeInitiative_onUnregisterInitiative(uint256) public asActor();
```

### governance_allocateLQTY(address[],address[],int256[],int256[]) (inherited from GovernanceTargets)

- **Signature**: `governance_allocateLQTY(address[],address[],int256[],int256[])`
- **Visibility**: public
- **Source Range**: 612:304:125
- **Details**: [function_governance_allocateLQTY_address[]_address[]_int256[]_int256[].md](./function_governance_allocateLQTY_address[]_address[]_int256[]_int256[].md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function governance_allocateLQTY(address[] memory _initiativesToReset, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory _absoluteLQTYVetos) public asActor();
```

### governance_calculateVotingThreshold() (inherited from GovernanceTargets)

- **Signature**: `governance_calculateVotingThreshold()`
- **Visibility**: public
- **Source Range**: 922:116:125
- **Details**: [function_governance_calculateVotingThreshold.md](./function_governance_calculateVotingThreshold.md)

**Signature:**
```solidity
function governance_calculateVotingThreshold() public asActor();
```

### governance_claimForInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `governance_claimForInitiative(address)`
- **Visibility**: public
- **Source Range**: 1044:134:125
- **Details**: [function_governance_claimForInitiative_address.md](./function_governance_claimForInitiative_address.md)

**Signature:**
```solidity
function governance_claimForInitiative(address _initiative) public asActor();
```

### governance_claimFromStakingV1(address) (inherited from GovernanceTargets)

- **Signature**: `governance_claimFromStakingV1(address)`
- **Visibility**: public
- **Source Range**: 1184:144:125
- **Details**: [function_governance_claimFromStakingV1_address.md](./function_governance_claimFromStakingV1_address.md)

**Signature:**
```solidity
function governance_claimFromStakingV1(address _rewardRecipient) public asActor();
```

### governance_deployUserProxy() (inherited from GovernanceTargets)

- **Signature**: `governance_deployUserProxy()`
- **Visibility**: public
- **Source Range**: 1334:98:125
- **Details**: [function_governance_deployUserProxy.md](./function_governance_deployUserProxy.md)

**Signature:**
```solidity
function governance_deployUserProxy() public asActor();
```

### governance_depositLQTY(uint256) (inherited from GovernanceTargets)

- **Signature**: `governance_depositLQTY(uint256)`
- **Visibility**: public
- **Source Range**: 1438:120:125
- **Details**: [function_governance_depositLQTY_uint256.md](./function_governance_depositLQTY_uint256.md)

**Signature:**
```solidity
function governance_depositLQTY(uint256 _lqtyAmount) public asActor();
```

### governance_depositLQTY(uint256,bool,address) (inherited from GovernanceTargets)

- **Signature**: `governance_depositLQTY(uint256,bool,address)`
- **Visibility**: public
- **Source Range**: 1564:189:125
- **Details**: [function_governance_depositLQTY_uint256_bool_address.md](./function_governance_depositLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function governance_depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor();
```

### governance_depositLQTYViaPermit(uint256,struct PermitParams,bool,address) (inherited from GovernanceTargets)

- **Signature**: `governance_depositLQTYViaPermit(uint256,struct PermitParams,bool,address)`
- **Visibility**: public
- **Source Range**: 1759:257:125
- **Details**: [function_governance_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md](./function_governance_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md)

**Signature:**
```solidity
function governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams, bool _doSendRewards, address _recipient) public asActor();
```

### governance_depositLQTYViaPermit(uint256,struct PermitParams) (inherited from GovernanceTargets)

- **Signature**: `governance_depositLQTYViaPermit(uint256,struct PermitParams)`
- **Visibility**: public
- **Source Range**: 2022:188:125
- **Details**: [function_governance_depositLQTYViaPermit_uint256_struct_PermitParams.md](./function_governance_depositLQTYViaPermit_uint256_struct_PermitParams.md)

**Signature:**
```solidity
function governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams) public asActor();
```

### governance_getInitiativeState(address) (inherited from GovernanceTargets)

- **Signature**: `governance_getInitiativeState(address)`
- **Visibility**: public
- **Source Range**: 2216:134:125
- **Details**: [function_governance_getInitiativeState_address.md](./function_governance_getInitiativeState_address.md)

**Signature:**
```solidity
function governance_getInitiativeState(address _initiative) public asActor();
```

### governance_multiDelegateCall(bytes[]) (inherited from GovernanceTargets)

- **Signature**: `governance_multiDelegateCall(bytes[])`
- **Visibility**: public
- **Source Range**: 2356:129:125
- **Details**: [function_governance_multiDelegateCall_bytes[].md](./function_governance_multiDelegateCall_bytes[].md)

**Signature:**
```solidity
function governance_multiDelegateCall(bytes[] memory inputs) public asActor();
```

### governance_registerInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `governance_registerInitiative(address)`
- **Visibility**: public
- **Source Range**: 2491:134:125
- **Details**: [function_governance_registerInitiative_address.md](./function_governance_registerInitiative_address.md)

**Signature:**
```solidity
function governance_registerInitiative(address _initiative) public asActor();
```

### governance_resetAllocations(address[],bool) (inherited from GovernanceTargets)

- **Signature**: `governance_resetAllocations(address[],bool)`
- **Visibility**: public
- **Source Range**: 2631:180:125
- **Details**: [function_governance_resetAllocations_address[]_bool.md](./function_governance_resetAllocations_address[]_bool.md)

**Signature:**
```solidity
function governance_resetAllocations(address[] memory _initiativesToReset, bool checkAll) public asActor();
```

### governance_snapshotVotesForInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `governance_snapshotVotesForInitiative(address)`
- **Visibility**: public
- **Source Range**: 2817:150:125
- **Details**: [function_governance_snapshotVotesForInitiative_address.md](./function_governance_snapshotVotesForInitiative_address.md)

**Signature:**
```solidity
function governance_snapshotVotesForInitiative(address _initiative) public asActor();
```

### governance_unregisterInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `governance_unregisterInitiative(address)`
- **Visibility**: public
- **Source Range**: 2973:138:125
- **Details**: [function_governance_unregisterInitiative_address.md](./function_governance_unregisterInitiative_address.md)

**Signature:**
```solidity
function governance_unregisterInitiative(address _initiative) public asActor();
```

### governance_withdrawLQTY(uint256) (inherited from GovernanceTargets)

- **Signature**: `governance_withdrawLQTY(uint256)`
- **Visibility**: public
- **Source Range**: 3117:122:125
- **Details**: [function_governance_withdrawLQTY_uint256.md](./function_governance_withdrawLQTY_uint256.md)

**Signature:**
```solidity
function governance_withdrawLQTY(uint256 _lqtyAmount) public asActor();
```

### governance_withdrawLQTY(uint256,bool,address) (inherited from GovernanceTargets)

- **Signature**: `governance_withdrawLQTY(uint256,bool,address)`
- **Visibility**: public
- **Source Range**: 3245:191:125
- **Details**: [function_governance_withdrawLQTY_uint256_bool_address.md](./function_governance_withdrawLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function governance_withdrawLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor();
```

### switchActor(uint256) (inherited from ManagersTargets)

- **Signature**: `switchActor(uint256)`
- **Visibility**: public
- **Source Range**: 680:83:126
- **Details**: [function_switchActor_uint256.md](./function_switchActor_uint256.md)

**Signature:**
```solidity
/// @dev Start acting as another actor
function switchActor(uint256 entropy) public;
```

### switch_asset(uint256) (inherited from ManagersTargets)

- **Signature**: `switch_asset(uint256)`
- **Visibility**: public
- **Source Range**: 808:84:126
- **Details**: [function_switch_asset_uint256.md](./function_switch_asset_uint256.md)

**Signature:**
```solidity
/// @dev Starts using a new asset
function switch_asset(uint256 entropy) public;
```

### add_new_asset(uint8) (inherited from ManagersTargets)

- **Signature**: `add_new_asset(uint8)`
- **Visibility**: public
- **Source Range**: 997:144:126
- **Details**: [function_add_new_asset_uint8.md](./function_add_new_asset_uint8.md)

**Signature:**
```solidity
/// @dev Deploy a new token and add it to the list of assets, then set it as the current asset
function add_new_asset(uint8 decimals) public returns (address);
```

### asset_approve(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_approve(address,uint128)`
- **Visibility**: public
- **Source Range**: 1467:132:126
- **Details**: [function_asset_approve_address_uint128.md](./function_asset_approve_address_uint128.md)

**Signature:**
```solidity
/// @dev Approve to arbitrary address, uses Actor by default
///  NOTE: You're almost always better off setting approvals in `Setup`
function asset_approve(address to, uint128 amt) public updateGhosts() asActor();
```

### asset_mint(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_mint(address,uint128)`
- **Visibility**: public
- **Source Range**: 1704:126:126
- **Details**: [function_asset_mint_address_uint128.md](./function_asset_mint_address_uint128.md)

**Signature:**
```solidity
/// @dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
function asset_mint(address to, uint128 amt) public updateGhosts() asAdmin();
```
