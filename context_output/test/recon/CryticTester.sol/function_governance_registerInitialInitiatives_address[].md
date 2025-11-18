# Function: governance_registerInitialInitiatives(address[])

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `governance_registerInitialInitiatives(address[])`
- **Visibility**: public
- **Source Range**: 742:161:122
- **Inherited From**: AdminTargets

## Implementation

```solidity
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
