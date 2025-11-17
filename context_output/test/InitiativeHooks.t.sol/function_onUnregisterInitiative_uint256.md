# Function: onUnregisterInitiative(uint256)

**Contract**: [test/InitiativeHooks.t.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 1407:61:101

## Implementation

```solidity
function onUnregisterInitiative(uint256) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.onUnregisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Callback hook that is called by Governance after the initiative was unregistered
 @param _atEpoch Epoch at which the initiative is unregistered
