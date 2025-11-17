# Function: setRevertBehaviour(enum MaliciousInitiative.FunctionType,enum MaliciousInitiative.RevertType)

**Contract**: [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]

## Metadata

- **Contract**: MaliciousInitiative
- **Signature**: `setRevertBehaviour(enum MaliciousInitiative.FunctionType,enum MaliciousInitiative.RevertType)`
- **Visibility**: external
- **Source Range**: 574:111:109

## Implementation

```solidity
/// @dev specify the revert behaviour on each function
function setRevertBehaviour(FunctionType ft, RevertType rt) external {
    revertBehaviours[ft] = rt;
}
```

## State Variable Writes

- **revertBehaviours** (`mapping(enum MaliciousInitiative.FunctionType => enum MaliciousInitiative.RevertType)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MaliciousInitiative.setRevertBehaviour(enum MaliciousInitiative.FunctionType,enum MaliciousInitiative.RevertType) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev specify the revert behaviour on each function
