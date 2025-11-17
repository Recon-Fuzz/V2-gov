# Function: getPrev(uint256)

**Contract**: [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListWrapper.md]

## Metadata

- **Contract**: DoubleLinkedListWrapper
- **Signature**: `getPrev(uint256)`
- **Visibility**: public
- **Source Range**: 594:99:97

## Implementation

```solidity
function getPrev(uint256 id) public view returns (uint256) {
    return list.getPrev(id);
}
```

## Related Implementations

### getPrev(struct DoubleLinkedList.List,uint256)

- **Kind**: internal
- **Source**: 1760:123:84
- **Link**: `src/utils/DoubleLinkedList.sol:DoubleLinkedList:getPrev(struct DoubleLinkedList.List,uint256)`

```solidity
/// @notice Returns the item id which precedes item `id`. Returns the head item id of the list if the `id` is 0.
///  @param list Linked list which contains the items
///  @param id Id of the current item
///  @return _ Id of the current item's previous item
function getPrev(List storage list, uint256 id) internal view returns (uint256) {
    return list.items[id].prev;
}
```

## State Variable Reads

- **list** (`struct DoubleLinkedList.List`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoubleLinkedListWrapper.getPrev(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.getPrev(struct DoubleLinkedList.List,uint256) (NodeID: 1)
      💬 Args: [list, id]
      👁️  Def: internal
```
