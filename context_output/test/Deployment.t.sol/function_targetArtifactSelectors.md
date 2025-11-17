# Function: targetArtifactSelectors()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `targetArtifactSelectors()`
- **Visibility**: public
- **Source Range**: 3193:186:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetArtifactSelectors() public view returns (FuzzArtifactSelector[] memory targetedArtifactSelectors_) {
    targetedArtifactSelectors_ = _targetedArtifactSelectors;
}
```

## State Variable Reads

- **_targetedArtifactSelectors** (`struct StdInvariant.FuzzArtifactSelector[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetArtifactSelectors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
