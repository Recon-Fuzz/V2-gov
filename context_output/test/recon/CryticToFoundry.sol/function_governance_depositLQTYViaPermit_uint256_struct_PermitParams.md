# Function: governance_depositLQTYViaPermit(uint256,struct PermitParams)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `governance_depositLQTYViaPermit(uint256,struct PermitParams)`
- **Visibility**: public
- **Source Range**: 2022:188:125
- **Inherited From**: GovernanceTargets

## Implementation

```solidity
function governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams) public asActor() {
    governance.depositLQTYViaPermit(_lqtyAmount, _permitParams);
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

- **Governance::depositLQTYViaPermit(uint256,struct PermitParams)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTargets.governance_depositLQTYViaPermit(uint256,struct PermitParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
