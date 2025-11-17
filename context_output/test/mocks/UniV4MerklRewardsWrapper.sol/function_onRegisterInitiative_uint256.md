# Function: onRegisterInitiative(uint256)

**Contract**: [test/mocks/UniV4MerklRewardsWrapper.sol/contract_UniV4MerklRewardsWrapper.md]

## Metadata

- **Contract**: UniV4MerklRewardsWrapper
- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 3634:68:68
- **Inherited From**: UniV4MerklRewards

## Implementation

```solidity
function onRegisterInitiative(uint256 _atEpoch) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklRewards.onRegisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Callback hook that is called by Governance after the initiative was successfully registered
 @param _atEpoch Epoch at which the initiative is registered
