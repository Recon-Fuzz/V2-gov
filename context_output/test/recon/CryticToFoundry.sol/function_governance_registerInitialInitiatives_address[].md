# Function: governance_registerInitialInitiatives(address[])

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `governance_registerInitialInitiatives(address[])`
- **Visibility**: public
- **Source Range**: 486:161:122
- **Inherited From**: AdminTargets

## Implementation

```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function governance_registerInitialInitiatives(address[] memory _initiatives) public asAdmin() {
    governance.registerInitialInitiatives(_initiatives);
}
```

## Related Implementations

### asAdmin()

- **Kind**: modifier
- **Source**: 4899:68:120
- **Link**: `test/recon/Setup.sol:Setup:asAdmin()`

```solidity
/// === MODIFIERS === ///
///  Prank admin and actor
modifier asAdmin() {
    vm.prank(address(this));
    _;
}
```

## External Calls

- **Governance::registerInitialInitiatives(address[])**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.governance_registerInitialInitiatives(address[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
