# Function: onUnregisterInitiative(uint256)

**Contract**: [src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 7193:84:65
- **Inherited From**: BribeInitiative

## Implementation

```solidity
/// @inheritdoc IInitiative
function onUnregisterInitiative(uint256) virtual override external onlyGovernance() {}
```

## Related Implementations

### onlyGovernance()

- **Kind**: modifier
- **Source**: 1897:131:65
- **Link**: `src/BribeInitiative.sol:BribeInitiative:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    require(msg.sender == address(governance), "BribeInitiative: invalid-sender");
    _;
}
```

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.onUnregisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: BribeInitiative.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IInitiative

### Interface Documentation

@notice Callback hook that is called by Governance after the initiative was unregistered
 @param _atEpoch Epoch at which the initiative is unregistered
