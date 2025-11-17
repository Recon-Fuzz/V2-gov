# Function: test_governance_registerInitialInitiatives()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_governance_registerInitialInitiatives()`
- **Visibility**: public
- **Source Range**: 6599:226:118

## Implementation

```solidity
function test_governance_registerInitialInitiatives() public {
    address[] memory initiatives = new address[](1);
    initiatives[0] = address(0x999);
    governance_registerInitialInitiatives(initiatives);
}
```

## Related Implementations

### governance_registerInitialInitiatives(address[])

- **Kind**: internal
- **Source**: 486:161:122
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:governance_registerInitialInitiatives(address[])`

```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function governance_registerInitialInitiatives(address[] memory _initiatives) public asAdmin() {
    governance.registerInitialInitiatives(_initiatives);
}
```

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_governance_registerInitialInitiatives() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: AdminTargets.governance_registerInitialInitiatives(address[]) (NodeID: 1)
      💬 Args: [initiatives]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
        💬 Args: [no args]
```
