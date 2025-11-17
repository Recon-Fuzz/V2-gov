# Function: onRegisterInitiative(uint256)

**Contract**: [test/InitiativeHooks.t.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 1343:59:101

## Implementation

```solidity
function onRegisterInitiative(uint256) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.onRegisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Callback hook that is called by Governance after the initiative was successfully registered
 @param _atEpoch Epoch at which the initiative is registered
