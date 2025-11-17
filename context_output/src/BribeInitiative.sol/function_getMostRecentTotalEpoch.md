# Function: getMostRecentTotalEpoch()

**Contract**: [src/BribeInitiative.sol/contract_BribeInitiative.md]

## Metadata

- **Contract**: BribeInitiative
- **Signature**: `getMostRecentTotalEpoch()`
- **Visibility**: external
- **Source Range**: 8556:189:65

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function getMostRecentTotalEpoch() external view returns (uint256) {
    uint256 mostRecentTotalEpoch = totalLQTYAllocationByEpoch.getHead();
    return mostRecentTotalEpoch;
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

- **totalLQTYAllocationByEpoch** (`struct DoubleLinkedList.List`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.getMostRecentTotalEpoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.getHead(struct DoubleLinkedList.List) (NodeID: 1)
      💬 Args: [totalLQTYAllocationByEpoch]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice Return the last recorded epoch for the system
