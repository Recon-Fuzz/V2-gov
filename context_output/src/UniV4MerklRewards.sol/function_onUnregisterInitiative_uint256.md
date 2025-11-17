# Function: onUnregisterInitiative(uint256)

**Contract**: [src/UniV4MerklRewards.sol/contract_UniV4MerklRewards.md]

## Metadata

- **Contract**: UniV4MerklRewards
- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 3875:70:68

## Implementation

```solidity
/// @notice Callback hook that is called by Governance after the initiative was unregistered
///  @param _atEpoch Epoch at which the initiative is unregistered
function onUnregisterInitiative(uint256 _atEpoch) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklRewards.onUnregisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Callback hook that is called by Governance after the initiative was unregistered
 @param _atEpoch Epoch at which the initiative is unregistered

### Interface Documentation

@notice Callback hook that is called by Governance after the initiative was unregistered
 @param _atEpoch Epoch at which the initiative is unregistered
