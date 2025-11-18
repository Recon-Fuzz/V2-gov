# Contract: CryticTester

## Metadata

- **Name**: CryticTester
- **Type**: Contract
- **Path**: test/recon/CryticTester.sol

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

## Structs

### Vars (inherited from BeforeAfter)

```solidity
struct Vars {
    uint256 __ignore__;
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

### Log (inherited from CryticAsserts)

```solidity
event Log(string);
```

## Public/External Functions

### constructor()

- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 360:46:117
- **Details**: [function_constructor.md](./function_constructor.md)

**Signature:**
```solidity
constructor() payable;
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

### clamped_governance_registerInitialInitiatives() (inherited from AdminTargets)

- **Signature**: `clamped_governance_registerInitialInitiatives()`
- **Visibility**: public
- **Source Range**: 486:250:122
- **Details**: [function_clamped_governance_registerInitialInitiatives.md](./function_clamped_governance_registerInitialInitiatives.md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function clamped_governance_registerInitialInitiatives() public asAdmin();
```

### governance_registerInitialInitiatives(address[]) (inherited from AdminTargets)

- **Signature**: `governance_registerInitialInitiatives(address[])`
- **Visibility**: public
- **Source Range**: 742:161:122
- **Details**: [function_governance_registerInitialInitiatives_address[].md](./function_governance_registerInitialInitiatives_address[].md)

**Signature:**
```solidity
function governance_registerInitialInitiatives(address[] memory _initiatives) public asAdmin();
```

### clamped_bribeInitiative_depositBribe(uint256,uint256,uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `clamped_bribeInitiative_depositBribe(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 531:505:123
- **Details**: [function_clamped_bribeInitiative_depositBribe_uint256_uint256_uint256.md](./function_clamped_bribeInitiative_depositBribe_uint256_uint256_uint256.md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function clamped_bribeInitiative_depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) public asActor();
```

### clamped_bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[]) (inherited from BribeInitiativeTargets)

- **Signature**: `clamped_bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[])`
- **Visibility**: public
- **Source Range**: 1042:482:123
- **Details**: [function_clamped_bribeInitiative_claimBribes_struct_IBribeInitiative.ClaimData[].md](./function_clamped_bribeInitiative_claimBribes_struct_IBribeInitiative.ClaimData[].md)

**Signature:**
```solidity
function clamped_bribeInitiative_claimBribes(IBribeInitiative.ClaimData[] memory _claimData) public asActor();
```

### bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[]) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[])`
- **Visibility**: public
- **Source Range**: 1620:156:123
- **Details**: [function_bribeInitiative_claimBribes_struct_IBribeInitiative.ClaimData[].md](./function_bribeInitiative_claimBribes_struct_IBribeInitiative.ClaimData[].md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function bribeInitiative_claimBribes(IBribeInitiative.ClaimData[] memory _claimData) public asActor();
```

### bribeInitiative_depositBribe(uint256,uint256,uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_depositBribe(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 1782:202:123
- **Details**: [function_bribeInitiative_depositBribe_uint256_uint256_uint256.md](./function_bribeInitiative_depositBribe_uint256_uint256_uint256.md)

**Signature:**
```solidity
function bribeInitiative_depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) public asActor();
```

### bribeInitiative_onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: public
- **Source Range**: 1990:352:123
- **Details**: [function_bribeInitiative_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md](./function_bribeInitiative_onAfterAllocateLQTY_uint256_address_struct_IGovernance.UserState_struct_IGovernance.Allocation_struct_IGovernance.InitiativeState.md)

**Signature:**
```solidity
function bribeInitiative_onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState memory _userState, IGovernance.Allocation memory _allocation, IGovernance.InitiativeState memory _initiativeState) public asActor();
```

### bribeInitiative_onClaimForInitiative(uint256,uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_onClaimForInitiative(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2348:140:123
- **Details**: [function_bribeInitiative_onClaimForInitiative_uint256_uint256.md](./function_bribeInitiative_onClaimForInitiative_uint256_uint256.md)

**Signature:**
```solidity
function bribeInitiative_onClaimForInitiative(uint256, uint256) public asActor();
```

### bribeInitiative_onRegisterInitiative(uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_onRegisterInitiative(uint256)`
- **Visibility**: public
- **Source Range**: 2494:127:123
- **Details**: [function_bribeInitiative_onRegisterInitiative_uint256.md](./function_bribeInitiative_onRegisterInitiative_uint256.md)

**Signature:**
```solidity
function bribeInitiative_onRegisterInitiative(uint256) public asActor();
```

### bribeInitiative_onUnregisterInitiative(uint256) (inherited from BribeInitiativeTargets)

- **Signature**: `bribeInitiative_onUnregisterInitiative(uint256)`
- **Visibility**: public
- **Source Range**: 2627:131:123
- **Details**: [function_bribeInitiative_onUnregisterInitiative_uint256.md](./function_bribeInitiative_onUnregisterInitiative_uint256.md)

**Signature:**
```solidity
function bribeInitiative_onUnregisterInitiative(uint256) public asActor();
```

### clamped_governance_allocateLQTY(address[],address[],int256[],int256[]) (inherited from GovernanceTargets)

- **Signature**: `clamped_governance_allocateLQTY(address[],address[],int256[],int256[])`
- **Visibility**: public
- **Source Range**: 521:1002:125
- **Details**: [function_clamped_governance_allocateLQTY_address[]_address[]_int256[]_int256[].md](./function_clamped_governance_allocateLQTY_address[]_address[]_int256[]_int256[].md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function clamped_governance_allocateLQTY(address[] memory _initiativesToReset, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory _absoluteLQTYVetos) public asActor();
```

### clamped_governance_depositLQTY(uint256,bool,address) (inherited from GovernanceTargets)

- **Signature**: `clamped_governance_depositLQTY(uint256,bool,address)`
- **Visibility**: public
- **Source Range**: 1529:450:125
- **Details**: [function_clamped_governance_depositLQTY_uint256_bool_address.md](./function_clamped_governance_depositLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function clamped_governance_depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor();
```

### clamped_governance_depositLQTYViaPermit(uint256,struct PermitParams,bool,address) (inherited from GovernanceTargets)

- **Signature**: `clamped_governance_depositLQTYViaPermit(uint256,struct PermitParams,bool,address)`
- **Visibility**: public
- **Source Range**: 1985:849:125
- **Details**: [function_clamped_governance_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md](./function_clamped_governance_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md)

**Signature:**
```solidity
function clamped_governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams, bool _doSendRewards, address _recipient) public asActor();
```

### clamped_governance_registerInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `clamped_governance_registerInitiative(address)`
- **Visibility**: public
- **Source Range**: 2840:262:125
- **Details**: [function_clamped_governance_registerInitiative_address.md](./function_clamped_governance_registerInitiative_address.md)

**Signature:**
```solidity
function clamped_governance_registerInitiative(address _initiative) public asActor();
```

### clamped_governance_withdrawLQTY(uint256,bool,address) (inherited from GovernanceTargets)

- **Signature**: `clamped_governance_withdrawLQTY(uint256,bool,address)`
- **Visibility**: public
- **Source Range**: 3108:515:125
- **Details**: [function_clamped_governance_withdrawLQTY_uint256_bool_address.md](./function_clamped_governance_withdrawLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function clamped_governance_withdrawLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor();
```

### clamped_governance_resetAllocations(address[],bool) (inherited from GovernanceTargets)

- **Signature**: `clamped_governance_resetAllocations(address[],bool)`
- **Visibility**: public
- **Source Range**: 3629:334:125
- **Details**: [function_clamped_governance_resetAllocations_address[]_bool.md](./function_clamped_governance_resetAllocations_address[]_bool.md)

**Signature:**
```solidity
function clamped_governance_resetAllocations(address[] memory _initiativesToReset, bool checkAll) public asActor();
```

### clamped_governance_multiDelegateCall(bytes[]) (inherited from GovernanceTargets)

- **Signature**: `clamped_governance_multiDelegateCall(bytes[])`
- **Visibility**: public
- **Source Range**: 3969:242:125
- **Details**: [function_clamped_governance_multiDelegateCall_bytes[].md](./function_clamped_governance_multiDelegateCall_bytes[].md)

**Signature:**
```solidity
function clamped_governance_multiDelegateCall(bytes[] memory inputs) public asActor();
```

### clamped_governance_claimFromStakingV1(address) (inherited from GovernanceTargets)

- **Signature**: `clamped_governance_claimFromStakingV1(address)`
- **Visibility**: public
- **Source Range**: 4217:264:125
- **Details**: [function_clamped_governance_claimFromStakingV1_address.md](./function_clamped_governance_claimFromStakingV1_address.md)

**Signature:**
```solidity
function clamped_governance_claimFromStakingV1(address _rewardRecipient) public asActor();
```

### governance_allocateLQTY(address[],address[],int256[],int256[]) (inherited from GovernanceTargets)

- **Signature**: `governance_allocateLQTY(address[],address[],int256[],int256[])`
- **Visibility**: public
- **Source Range**: 4577:304:125
- **Details**: [function_governance_allocateLQTY_address[]_address[]_int256[]_int256[].md](./function_governance_allocateLQTY_address[]_address[]_int256[]_int256[].md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function governance_allocateLQTY(address[] memory _initiativesToReset, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory _absoluteLQTYVetos) public asActor();
```

### governance_calculateVotingThreshold() (inherited from GovernanceTargets)

- **Signature**: `governance_calculateVotingThreshold()`
- **Visibility**: public
- **Source Range**: 4887:116:125
- **Details**: [function_governance_calculateVotingThreshold.md](./function_governance_calculateVotingThreshold.md)

**Signature:**
```solidity
function governance_calculateVotingThreshold() public asActor();
```

### governance_claimForInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `governance_claimForInitiative(address)`
- **Visibility**: public
- **Source Range**: 5009:134:125
- **Details**: [function_governance_claimForInitiative_address.md](./function_governance_claimForInitiative_address.md)

**Signature:**
```solidity
function governance_claimForInitiative(address _initiative) public asActor();
```

### governance_claimFromStakingV1(address) (inherited from GovernanceTargets)

- **Signature**: `governance_claimFromStakingV1(address)`
- **Visibility**: public
- **Source Range**: 5149:144:125
- **Details**: [function_governance_claimFromStakingV1_address.md](./function_governance_claimFromStakingV1_address.md)

**Signature:**
```solidity
function governance_claimFromStakingV1(address _rewardRecipient) public asActor();
```

### governance_deployUserProxy() (inherited from GovernanceTargets)

- **Signature**: `governance_deployUserProxy()`
- **Visibility**: public
- **Source Range**: 5299:98:125
- **Details**: [function_governance_deployUserProxy.md](./function_governance_deployUserProxy.md)

**Signature:**
```solidity
function governance_deployUserProxy() public asActor();
```

### governance_depositLQTY(uint256) (inherited from GovernanceTargets)

- **Signature**: `governance_depositLQTY(uint256)`
- **Visibility**: public
- **Source Range**: 5403:120:125
- **Details**: [function_governance_depositLQTY_uint256.md](./function_governance_depositLQTY_uint256.md)

**Signature:**
```solidity
function governance_depositLQTY(uint256 _lqtyAmount) public asActor();
```

### governance_depositLQTY(uint256,bool,address) (inherited from GovernanceTargets)

- **Signature**: `governance_depositLQTY(uint256,bool,address)`
- **Visibility**: public
- **Source Range**: 5529:189:125
- **Details**: [function_governance_depositLQTY_uint256_bool_address.md](./function_governance_depositLQTY_uint256_bool_address.md)

**Signature:**
```solidity
function governance_depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor();
```

### governance_depositLQTYViaPermit(uint256,struct PermitParams,bool,address) (inherited from GovernanceTargets)

- **Signature**: `governance_depositLQTYViaPermit(uint256,struct PermitParams,bool,address)`
- **Visibility**: public
- **Source Range**: 5724:257:125
- **Details**: [function_governance_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md](./function_governance_depositLQTYViaPermit_uint256_struct_PermitParams_bool_address.md)

**Signature:**
```solidity
function governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams, bool _doSendRewards, address _recipient) public asActor();
```

### governance_depositLQTYViaPermit(uint256,struct PermitParams) (inherited from GovernanceTargets)

- **Signature**: `governance_depositLQTYViaPermit(uint256,struct PermitParams)`
- **Visibility**: public
- **Source Range**: 5987:188:125
- **Details**: [function_governance_depositLQTYViaPermit_uint256_struct_PermitParams.md](./function_governance_depositLQTYViaPermit_uint256_struct_PermitParams.md)

**Signature:**
```solidity
function governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams) public asActor();
```

### governance_getInitiativeState(address) (inherited from GovernanceTargets)

- **Signature**: `governance_getInitiativeState(address)`
- **Visibility**: public
- **Source Range**: 6181:134:125
- **Details**: [function_governance_getInitiativeState_address.md](./function_governance_getInitiativeState_address.md)

**Signature:**
```solidity
function governance_getInitiativeState(address _initiative) public asActor();
```

### governance_multiDelegateCall(bytes[]) (inherited from GovernanceTargets)

- **Signature**: `governance_multiDelegateCall(bytes[])`
- **Visibility**: public
- **Source Range**: 6321:129:125
- **Details**: [function_governance_multiDelegateCall_bytes[].md](./function_governance_multiDelegateCall_bytes[].md)

**Signature:**
```solidity
function governance_multiDelegateCall(bytes[] memory inputs) public asActor();
```

### governance_registerInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `governance_registerInitiative(address)`
- **Visibility**: public
- **Source Range**: 6456:134:125
- **Details**: [function_governance_registerInitiative_address.md](./function_governance_registerInitiative_address.md)

**Signature:**
```solidity
function governance_registerInitiative(address _initiative) public asActor();
```

### governance_resetAllocations(address[],bool) (inherited from GovernanceTargets)

- **Signature**: `governance_resetAllocations(address[],bool)`
- **Visibility**: public
- **Source Range**: 6596:180:125
- **Details**: [function_governance_resetAllocations_address[]_bool.md](./function_governance_resetAllocations_address[]_bool.md)

**Signature:**
```solidity
function governance_resetAllocations(address[] memory _initiativesToReset, bool checkAll) public asActor();
```

### governance_snapshotVotesForInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `governance_snapshotVotesForInitiative(address)`
- **Visibility**: public
- **Source Range**: 6782:150:125
- **Details**: [function_governance_snapshotVotesForInitiative_address.md](./function_governance_snapshotVotesForInitiative_address.md)

**Signature:**
```solidity
function governance_snapshotVotesForInitiative(address _initiative) public asActor();
```

### governance_unregisterInitiative(address) (inherited from GovernanceTargets)

- **Signature**: `governance_unregisterInitiative(address)`
- **Visibility**: public
- **Source Range**: 6938:138:125
- **Details**: [function_governance_unregisterInitiative_address.md](./function_governance_unregisterInitiative_address.md)

**Signature:**
```solidity
function governance_unregisterInitiative(address _initiative) public asActor();
```

### governance_withdrawLQTY(uint256) (inherited from GovernanceTargets)

- **Signature**: `governance_withdrawLQTY(uint256)`
- **Visibility**: public
- **Source Range**: 7082:122:125
- **Details**: [function_governance_withdrawLQTY_uint256.md](./function_governance_withdrawLQTY_uint256.md)

**Signature:**
```solidity
function governance_withdrawLQTY(uint256 _lqtyAmount) public asActor();
```

### governance_withdrawLQTY(uint256,bool,address) (inherited from GovernanceTargets)

- **Signature**: `governance_withdrawLQTY(uint256,bool,address)`
- **Visibility**: public
- **Source Range**: 7210:191:125
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

### shortcut_governance_claimForInitiative() (inherited from TargetFunctions)

- **Signature**: `shortcut_governance_claimForInitiative()`
- **Visibility**: public
- **Source Range**: 915:637:121
- **Details**: [function_shortcut_governance_claimForInitiative.md](./function_shortcut_governance_claimForInitiative.md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function shortcut_governance_claimForInitiative() public asActor();
```

### shortcut_bribeInitiative_claimBribes() (inherited from TargetFunctions)

- **Signature**: `shortcut_bribeInitiative_claimBribes()`
- **Visibility**: public
- **Source Range**: 1558:753:121
- **Details**: [function_shortcut_bribeInitiative_claimBribes.md](./function_shortcut_bribeInitiative_claimBribes.md)

**Signature:**
```solidity
function shortcut_bribeInitiative_claimBribes() public asActor();
```

### shortcut_full_allocation_flow() (inherited from TargetFunctions)

- **Signature**: `shortcut_full_allocation_flow()`
- **Visibility**: public
- **Source Range**: 2317:368:121
- **Details**: [function_shortcut_full_allocation_flow.md](./function_shortcut_full_allocation_flow.md)

**Signature:**
```solidity
function shortcut_full_allocation_flow() public asActor();
```

### shortcut_reset_allocation_flow() (inherited from TargetFunctions)

- **Signature**: `shortcut_reset_allocation_flow()`
- **Visibility**: public
- **Source Range**: 2691:354:121
- **Details**: [function_shortcut_reset_allocation_flow.md](./function_shortcut_reset_allocation_flow.md)

**Signature:**
```solidity
function shortcut_reset_allocation_flow() public asActor();
```
