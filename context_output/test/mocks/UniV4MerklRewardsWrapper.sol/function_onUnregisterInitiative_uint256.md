# Function: onUnregisterInitiative(uint256)

**Contract**: [test/mocks/UniV4MerklRewardsWrapper.sol/contract_UniV4MerklRewardsWrapper.md]

## Metadata

- **Contract**: UniV4MerklRewardsWrapper
- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 3875:70:68
- **Inherited From**: UniV4MerklRewards

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
