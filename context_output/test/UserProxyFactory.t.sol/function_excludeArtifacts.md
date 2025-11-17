# Function: excludeArtifacts()

**Contract**: [test/UserProxyFactory.t.sol/contract_UserProxyFactoryTest.md]

## Metadata

- **Contract**: UserProxyFactoryTest
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
