# Function: governance_claimFromStakingV1(address)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `governance_claimFromStakingV1(address)`
- **Visibility**: public
- **Source Range**: 1184:144:125
- **Inherited From**: GovernanceTargets

## Implementation

```solidity
function governance_claimFromStakingV1(address _rewardRecipient) public asActor() {
    governance.claimFromStakingV1(_rewardRecipient);
}
```

## Related Implementations

### asActor()

- **Kind**: modifier
- **Source**: 4973:75:120
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:55
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

## External Calls

- **Governance::claimFromStakingV1(address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTargets.governance_claimFromStakingV1(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
