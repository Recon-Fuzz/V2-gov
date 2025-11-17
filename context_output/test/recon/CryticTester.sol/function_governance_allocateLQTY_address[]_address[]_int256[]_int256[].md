# Function: governance_allocateLQTY(address[],address[],int256[],int256[])

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `governance_allocateLQTY(address[],address[],int256[],int256[])`
- **Visibility**: public
- **Source Range**: 612:304:125
- **Inherited From**: GovernanceTargets

## Implementation

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function governance_allocateLQTY(address[] memory _initiativesToReset, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory _absoluteLQTYVetos) public asActor() {
    governance.allocateLQTY(_initiativesToReset, _initiatives, _absoluteLQTYVotes, _absoluteLQTYVetos);
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

- **Governance::allocateLQTY(address[],address[],int256[],int256[])**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTargets.governance_allocateLQTY(address[],address[],int256[],int256[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
