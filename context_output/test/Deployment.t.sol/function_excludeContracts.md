# Function: excludeContracts()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2606:142:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_) {
    excludedContracts_ = _excludedContracts;
}
```

## State Variable Reads

- **_excludedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeContracts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
