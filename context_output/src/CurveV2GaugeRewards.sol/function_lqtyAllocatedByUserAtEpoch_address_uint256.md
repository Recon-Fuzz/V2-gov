# Function: lqtyAllocatedByUserAtEpoch(address,uint256)

**Contract**: [src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `lqtyAllocatedByUserAtEpoch(address,uint256)`
- **Visibility**: external
- **Source Range**: 2496:458:65
- **Inherited From**: BribeInitiative

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function lqtyAllocatedByUserAtEpoch(address _user, uint256 _epoch) external view returns (uint256, uint256, uint256, uint256) {
    return (lqtyAllocationByUserAtEpoch[_user].items[_epoch].lqty, lqtyAllocationByUserAtEpoch[_user].items[_epoch].offset, lqtyAllocationByUserAtEpoch[_user].items[_epoch].prev, lqtyAllocationByUserAtEpoch[_user].items[_epoch].next);
}
```

## State Variable Reads

- **lqtyAllocationByUserAtEpoch** (`mapping(address => struct DoubleLinkedList.List)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.lqtyAllocatedByUserAtEpoch(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice LQTY allocated by a user to the initiative at a given epoch
         Voting power can be calculated as `lqtyAllocated * timestamp - offset`
 @param _user Address of the user
 @param _epoch Epoch at which the LQTY was allocated by the user
 @return lqtyAllocated LQTY allocated by the user
 @return offset Voting power offset
 @return prev Previous epoch at which the user updated the LQTY allocation for this initiative
 @return next Next epoch at which the user updated the LQTY allocation for this initiative
