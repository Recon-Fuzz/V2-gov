# Function: governance_resetAllocations(address[],bool)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `governance_resetAllocations(address[],bool)`
- **Visibility**: public
- **Source Range**: 2631:180:125
- **Inherited From**: GovernanceTargets

## Implementation

```solidity
function governance_resetAllocations(address[] memory _initiativesToReset, bool checkAll) public asActor() {
    governance.resetAllocations(_initiativesToReset, checkAll);
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

- **Governance::resetAllocations(address[],bool)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTargets.governance_resetAllocations(address[],bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
