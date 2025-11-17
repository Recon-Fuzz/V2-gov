# Contract: BribeInitiativeTest

## Metadata

- **Name**: BribeInitiativeTest
- **Type**: Contract
- **Path**: test/BribeInitiative.t.sol

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

### lqty

```solidity
MockERC20Tester private lqty
```

**MockERC20Tester**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

### lusd

```solidity
MockERC20Tester private lusd
```

**MockERC20Tester**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

### stakingV1

```solidity
MockStakingV1 private stakingV1
```

**MockStakingV1**: [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]

### user1

```solidity
address private constant user1 = address(0xF977814e90dA44bFA03b6295A0616a897441aceC)
```

### user2

```solidity
address private constant user2 = address(0x10C9cff3c4Faa8A60cB8506a7A99411E6A199038)
```

### user3

```solidity
address private user3 = makeAddr("user3")
```

### lusdHolder

```solidity
address private constant lusdHolder = address(0xcA7f01403C4989d2b1A9335A2F09dD973709957c)
```

### REGISTRATION_FEE

```solidity
uint256 private constant REGISTRATION_FEE = 1e18
```

### REGISTRATION_THRESHOLD_FACTOR

```solidity
uint256 private constant REGISTRATION_THRESHOLD_FACTOR = 0.01e18
```

### UNREGISTRATION_THRESHOLD_FACTOR

```solidity
uint256 private constant UNREGISTRATION_THRESHOLD_FACTOR = 4e18
```

### UNREGISTRATION_AFTER_EPOCHS

```solidity
uint256 private constant UNREGISTRATION_AFTER_EPOCHS = 4
```

### VOTING_THRESHOLD_FACTOR

```solidity
uint256 private constant VOTING_THRESHOLD_FACTOR = 0.04e18
```

### MIN_CLAIM

```solidity
uint256 private constant MIN_CLAIM = 500e18
```

### MIN_ACCRUAL

```solidity
uint256 private constant MIN_ACCRUAL = 1000e18
```

### EPOCH_DURATION

```solidity
uint256 private constant EPOCH_DURATION = 7 days
```

### EPOCH_VOTING_CUTOFF

```solidity
uint256 private constant EPOCH_VOTING_CUTOFF = 518400
```

### governance

```solidity
Governance private governance
```

**Governance**: [src/Governance.sol/contract_Governance.md]

### initialInitiatives

```solidity
address[] private initialInitiatives
```

### bribeInitiative

```solidity
BribeInitiative private bribeInitiative
```

**BribeInitiative**: [src/BribeInitiative.sol/contract_BribeInitiative.md]

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
- **Source Range**: 1817:1524:92
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() public;
```

### test_bribeToken_cannot_be_BOLD()

- **Signature**: `test_bribeToken_cannot_be_BOLD()`
- **Visibility**: external
- **Source Range**: 3347:245:92
- **Details**: [function_test_bribeToken_cannot_be_BOLD.md](./function_test_bribeToken_cannot_be_BOLD.md)

**Signature:**
```solidity
function test_bribeToken_cannot_be_BOLD() external;
```

### test_totalLQTYAllocatedByEpoch_vote()

- **Signature**: `test_totalLQTYAllocatedByEpoch_vote()`
- **Visibility**: public
- **Source Range**: 3637:554:92
- **Details**: [function_test_totalLQTYAllocatedByEpoch_vote.md](./function_test_totalLQTYAllocatedByEpoch_vote.md)

**Signature:**
```solidity
function test_totalLQTYAllocatedByEpoch_vote() public;
```

### test_totalLQTYAllocatedByEpoch_veto()

- **Signature**: `test_totalLQTYAllocatedByEpoch_veto()`
- **Visibility**: public
- **Source Range**: 4236:490:92
- **Details**: [function_test_totalLQTYAllocatedByEpoch_veto.md](./function_test_totalLQTYAllocatedByEpoch_veto.md)

**Signature:**
```solidity
function test_totalLQTYAllocatedByEpoch_veto() public;
```

### test_allocating_same_initiative_multiple_epochs()

- **Signature**: `test_allocating_same_initiative_multiple_epochs()`
- **Visibility**: public
- **Source Range**: 4790:1164:92
- **Details**: [function_test_allocating_same_initiative_multiple_epochs.md](./function_test_allocating_same_initiative_multiple_epochs.md)

**Signature:**
```solidity
function test_allocating_same_initiative_multiple_epochs() public;
```

### test_totalLQTYAllocatedByEpoch_vote_same_epoch()

- **Signature**: `test_totalLQTYAllocatedByEpoch_vote_same_epoch()`
- **Visibility**: public
- **Source Range**: 6012:896:92
- **Details**: [function_test_totalLQTYAllocatedByEpoch_vote_same_epoch.md](./function_test_totalLQTYAllocatedByEpoch_vote_same_epoch.md)

**Signature:**
```solidity
function test_totalLQTYAllocatedByEpoch_vote_same_epoch() public;
```

### test_allocation_stored_in_list()

- **Signature**: `test_allocation_stored_in_list()`
- **Visibility**: public
- **Source Range**: 6914:864:92
- **Details**: [function_test_allocation_stored_in_list.md](./function_test_allocation_stored_in_list.md)

**Signature:**
```solidity
function test_allocation_stored_in_list() public;
```

### test_totalLQTYAllocatedByEpoch_vote_multiple_epochs()

- **Signature**: `test_totalLQTYAllocatedByEpoch_vote_multiple_epochs()`
- **Visibility**: public
- **Source Range**: 7850:1118:92
- **Details**: [function_test_totalLQTYAllocatedByEpoch_vote_multiple_epochs.md](./function_test_totalLQTYAllocatedByEpoch_vote_multiple_epochs.md)

**Signature:**
```solidity
function test_totalLQTYAllocatedByEpoch_vote_multiple_epochs() public;
```

### test_totalLQTYAllocatedByEpoch_vote_same_epoch_multiple()

- **Signature**: `test_totalLQTYAllocatedByEpoch_vote_same_epoch_multiple()`
- **Visibility**: public
- **Source Range**: 9041:945:92
- **Details**: [function_test_totalLQTYAllocatedByEpoch_vote_same_epoch_multiple.md](./function_test_totalLQTYAllocatedByEpoch_vote_same_epoch_multiple.md)

**Signature:**
```solidity
function test_totalLQTYAllocatedByEpoch_vote_same_epoch_multiple() public;
```

### test_totalLQTYAllocatedByEpoch_growth()

- **Signature**: `test_totalLQTYAllocatedByEpoch_growth()`
- **Visibility**: public
- **Source Range**: 10061:674:92
- **Details**: [function_test_totalLQTYAllocatedByEpoch_growth.md](./function_test_totalLQTYAllocatedByEpoch_growth.md)

**Signature:**
```solidity
function test_totalLQTYAllocatedByEpoch_growth() public;
```

### test_depositBribe_success()

- **Signature**: `test_depositBribe_success()`
- **Visibility**: public
- **Source Range**: 10770:292:92
- **Details**: [function_test_depositBribe_success.md](./function_test_depositBribe_success.md)

**Signature:**
```solidity
function test_depositBribe_success() public;
```

### test_claimBribes()

- **Signature**: `test_claimBribes()`
- **Visibility**: public
- **Source Range**: 11167:1199:92
- **Details**: [function_test_claimBribes.md](./function_test_claimBribes.md)

**Signature:**
```solidity
function test_claimBribes() public;
```

### test_high_deny_last_claim()

- **Signature**: `test_high_deny_last_claim()`
- **Visibility**: public
- **Source Range**: 12532:1279:92
- **Details**: [function_test_high_deny_last_claim.md](./function_test_high_deny_last_claim.md)

**Signature:**
```solidity
function test_high_deny_last_claim() public;
```

### test_claimBribes_deposited_after_vote()

- **Signature**: `test_claimBribes_deposited_after_vote()`
- **Visibility**: public
- **Source Range**: 13884:2690:92
- **Details**: [function_test_claimBribes_deposited_after_vote.md](./function_test_claimBribes_deposited_after_vote.md)

**Signature:**
```solidity
function test_claimBribes_deposited_after_vote() public;
```

### test_claimedBribes_fraction()

- **Signature**: `test_claimedBribes_fraction()`
- **Visibility**: public
- **Source Range**: 16665:1407:92
- **Details**: [function_test_claimedBribes_fraction.md](./function_test_claimedBribes_fraction.md)

**Signature:**
```solidity
function test_claimedBribes_fraction() public;
```

### test_claimedBribes_fraction_fuzz(uint256[3],uint256,uint256)

- **Signature**: `test_claimedBribes_fraction_fuzz(uint256[3],uint256,uint256)`
- **Visibility**: public
- **Source Range**: 18078:3070:92
- **Details**: [function_test_claimedBribes_fraction_fuzz_uint256[3]_uint256_uint256.md](./function_test_claimedBribes_fraction_fuzz_uint256[3]_uint256_uint256.md)

**Signature:**
```solidity
function test_claimedBribes_fraction_fuzz(uint256[3] memory userStakeAmount, uint256 boldAmount, uint256 bribeTokenAmount) public;
```

### test_only_voter_receives_bribes()

- **Signature**: `test_only_voter_receives_bribes()`
- **Visibility**: public
- **Source Range**: 21232:1943:92
- **Details**: [function_test_only_voter_receives_bribes.md](./function_test_only_voter_receives_bribes.md)

**Signature:**
```solidity
function test_only_voter_receives_bribes() public;
```

### test_decrement_after_claimBribes()

- **Signature**: `test_decrement_after_claimBribes()`
- **Visibility**: public
- **Source Range**: 23302:2024:92
- **Details**: [function_test_decrement_after_claimBribes.md](./function_test_decrement_after_claimBribes.md)

**Signature:**
```solidity
function test_decrement_after_claimBribes() public;
```

### test_lqty_immediately_allocated()

- **Signature**: `test_lqty_immediately_allocated()`
- **Visibility**: public
- **Source Range**: 25332:899:92
- **Details**: [function_test_lqty_immediately_allocated.md](./function_test_lqty_immediately_allocated.md)

**Signature:**
```solidity
function test_lqty_immediately_allocated() public;
```

### test_rationalFlow()

- **Signature**: `test_rationalFlow()`
- **Visibility**: public
- **Source Range**: 26292:2067:92
- **Details**: [function_test_rationalFlow.md](./function_test_rationalFlow.md)

**Signature:**
```solidity
function test_rationalFlow() public;
```

### test_depositBribe_epoch_too_early_reverts()

- **Signature**: `test_depositBribe_epoch_too_early_reverts()`
- **Visibility**: public
- **Source Range**: 28401:365:92
- **Details**: [function_test_depositBribe_epoch_too_early_reverts.md](./function_test_depositBribe_epoch_too_early_reverts.md)

**Signature:**
```solidity
///  Revert Cases
function test_depositBribe_epoch_too_early_reverts() public;
```

### test_claimBribes_before_deposit_reverts()

- **Signature**: `test_claimBribes_before_deposit_reverts()`
- **Visibility**: public
- **Source Range**: 28772:1205:92
- **Details**: [function_test_claimBribes_before_deposit_reverts.md](./function_test_claimBribes_before_deposit_reverts.md)

**Signature:**
```solidity
function test_claimBribes_before_deposit_reverts() public;
```

### test_claimBribes_current_epoch_reverts()

- **Signature**: `test_claimBribes_current_epoch_reverts()`
- **Visibility**: public
- **Source Range**: 29983:1249:92
- **Details**: [function_test_claimBribes_current_epoch_reverts.md](./function_test_claimBribes_current_epoch_reverts.md)

**Signature:**
```solidity
function test_claimBribes_current_epoch_reverts() public;
```

### test_claimBribes_same_epoch_reverts()

- **Signature**: `test_claimBribes_same_epoch_reverts()`
- **Visibility**: public
- **Source Range**: 31238:1544:92
- **Details**: [function_test_claimBribes_same_epoch_reverts.md](./function_test_claimBribes_same_epoch_reverts.md)

**Signature:**
```solidity
function test_claimBribes_same_epoch_reverts() public;
```

### test_claimBribes_no_bribe_reverts()

- **Signature**: `test_claimBribes_no_bribe_reverts()`
- **Visibility**: public
- **Source Range**: 32788:1048:92
- **Details**: [function_test_claimBribes_no_bribe_reverts.md](./function_test_claimBribes_no_bribe_reverts.md)

**Signature:**
```solidity
function test_claimBribes_no_bribe_reverts() public;
```

### test_claimBribes_no_allocation_reverts()

- **Signature**: `test_claimBribes_no_allocation_reverts()`
- **Visibility**: public
- **Source Range**: 33842:1312:92
- **Details**: [function_test_claimBribes_no_allocation_reverts.md](./function_test_claimBribes_no_allocation_reverts.md)

**Signature:**
```solidity
function test_claimBribes_no_allocation_reverts() public;
```

### test_claimBribes_invalid_previous_allocation_epoch_reverts()

- **Signature**: `test_claimBribes_invalid_previous_allocation_epoch_reverts()`
- **Visibility**: public
- **Source Range**: 35252:1336:92
- **Details**: [function_test_claimBribes_invalid_previous_allocation_epoch_reverts.md](./function_test_claimBribes_invalid_previous_allocation_epoch_reverts.md)

**Signature:**
```solidity
function test_claimBribes_invalid_previous_allocation_epoch_reverts() public;
```

### test_VoterGetsTheirFairShareOfBribes()

- **Signature**: `test_VoterGetsTheirFairShareOfBribes()`
- **Visibility**: external
- **Source Range**: 36650:3016:92
- **Details**: [function_test_VoterGetsTheirFairShareOfBribes.md](./function_test_VoterGetsTheirFairShareOfBribes.md)

**Signature:**
```solidity
function test_VoterGetsTheirFairShareOfBribes() external;
```

### _depositBribe(uint256,uint256,uint256)

- **Signature**: `_depositBribe(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 42379:343:92
- **Details**: [function__depositBribe_uint256_uint256_uint256.md](./function__depositBribe_uint256_uint256_uint256.md)

**Signature:**
```solidity
function _depositBribe(uint256 boldAmount, uint256 bribeAmount, uint256 epoch) public;
```

### _depositBribe(address,uint256,uint256,uint256)

- **Signature**: `_depositBribe(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 42728:351:92
- **Details**: [function__depositBribe_address_uint256_uint256_uint256.md](./function__depositBribe_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function _depositBribe(address _initiative, uint256 boldAmount, uint256 bribeAmount, uint256 epoch) public;
```

### _claimBribe(address,uint256,uint256,uint256)

- **Signature**: `_claimBribe(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 43085:337:92
- **Details**: [function__claimBribe_address_uint256_uint256_uint256.md](./function__claimBribe_address_uint256_uint256_uint256.md)

**Signature:**
```solidity
function _claimBribe(address claimer, uint256 epoch, uint256 prevLQTYAllocationEpoch, uint256 prevTotalLQTYAllocationEpoch) public returns (uint256 boldAmount, uint256 bribeTokenAmount);
```

### _claimBribe(address,uint256,uint256,uint256,bool)

- **Signature**: `_claimBribe(address,uint256,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 43428:730:92
- **Details**: [function__claimBribe_address_uint256_uint256_uint256_bool.md](./function__claimBribe_address_uint256_uint256_uint256_bool.md)

**Signature:**
```solidity
function _claimBribe(address claimer, uint256 epoch, uint256 prevLQTYAllocationEpoch, uint256 prevTotalLQTYAllocationEpoch, bool expectRevert) public returns (uint256 boldAmount, uint256 bribeTokenAmount);
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
