# Function: governance_withdrawLQTY(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `governance_withdrawLQTY(uint256)`
- **Visibility**: public
- **Source Range**: 3117:122:125
- **Inherited From**: GovernanceTargets

## Implementation

```solidity
function governance_withdrawLQTY(uint256 _lqtyAmount) public asActor() {
    governance.withdrawLQTY(_lqtyAmount);
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

- **Governance::withdrawLQTY(uint256)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTargets.governance_withdrawLQTY(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
