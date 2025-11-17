# Function: excludeArtifacts()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2459:141:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_) {
    excludedArtifacts_ = _excludedArtifacts;
}
```

## State Variable Reads

- **_excludedArtifacts** (`string[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeArtifacts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
