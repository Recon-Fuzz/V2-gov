# Function: totalLQTYAllocatedByEpoch(uint256)

**Contract**: [src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `totalLQTYAllocatedByEpoch(uint256)`
- **Visibility**: external
- **Source Range**: 2071:382:65
- **Inherited From**: BribeInitiative

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function totalLQTYAllocatedByEpoch(uint256 _epoch) external view returns (uint256, uint256, uint256, uint256) {
    return (totalLQTYAllocationByEpoch.items[_epoch].lqty, totalLQTYAllocationByEpoch.items[_epoch].offset, totalLQTYAllocationByEpoch.items[_epoch].prev, totalLQTYAllocationByEpoch.items[_epoch].next);
}
```

## State Variable Reads

- **totalLQTYAllocationByEpoch** (`struct DoubleLinkedList.List`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.totalLQTYAllocatedByEpoch(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice Total LQTY allocated to the initiative at a given epoch
         Voting power can be calculated as `totalLQTYAllocated * timestamp - offset`
 @param _epoch Epoch at which the LQTY was allocated
 @return totalLQTYAllocated Total LQTY allocated
 @return offset Voting power offset
 @return prev Previous epoch at which the total LQTY allocation was updated
 @return next Next epoch at which the total LQTY allocation was updated
