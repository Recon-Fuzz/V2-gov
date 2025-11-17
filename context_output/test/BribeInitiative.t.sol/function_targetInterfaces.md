# Function: targetInterfaces()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `targetInterfaces()`
- **Visibility**: public
- **Source Range**: 3823:151:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetInterfaces() public view returns (FuzzInterface[] memory targetedInterfaces_) {
    targetedInterfaces_ = _targetedInterfaces;
}
```

## State Variable Reads

- **_targetedInterfaces** (`struct StdInvariant.FuzzInterface[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetInterfaces() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
