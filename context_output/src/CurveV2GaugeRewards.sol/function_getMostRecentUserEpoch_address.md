# Function: getMostRecentUserEpoch(address)

**Contract**: [src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]

## Metadata

- **Contract**: CurveV2GaugeRewards
- **Signature**: `getMostRecentUserEpoch(address)`
- **Visibility**: external
- **Source Range**: 8306:207:65
- **Inherited From**: BribeInitiative

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function getMostRecentUserEpoch(address _user) external view returns (uint256) {
    uint256 mostRecentUserEpoch = lqtyAllocationByUserAtEpoch[_user].getHead();
    return mostRecentUserEpoch;
}
```

## Related Implementations

### getHead(struct DoubleLinkedList.List)

- **Kind**: internal
- **Source**: 713:110:84
- **Link**: `src/utils/DoubleLinkedList.sol:DoubleLinkedList:getHead(struct DoubleLinkedList.List)`

```solidity
/// @notice Returns the head item id of the list
///  @param list Linked list which contains the item
///  @return _ Id of the head item
function getHead(List storage list) internal view returns (uint256) {
    return list.items[0].prev;
}
```

## State Variable Reads

- **lqtyAllocationByUserAtEpoch** (`mapping(address => struct DoubleLinkedList.List)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.getMostRecentUserEpoch(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.getHead(struct DoubleLinkedList.List) (NodeID: 1)
      💬 Args: [lqtyAllocationByUserAtEpoch[_user]]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice Given a user address return the last recorded epoch for their allocation
