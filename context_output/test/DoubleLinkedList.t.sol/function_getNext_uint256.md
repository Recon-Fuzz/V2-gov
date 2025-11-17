# Function: getNext(uint256)

**Contract**: [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListWrapper.md]

## Metadata

- **Contract**: DoubleLinkedListWrapper
- **Signature**: `getNext(uint256)`
- **Visibility**: public
- **Source Range**: 489:99:97

## Implementation

```solidity
function getNext(uint256 id) public view returns (uint256) {
    return list.getNext(id);
}
```

## Related Implementations

### getNext(struct DoubleLinkedList.List,uint256)

- **Kind**: internal
- **Source**: 1359:123:84
- **Link**: `src/utils/DoubleLinkedList.sol:DoubleLinkedList:getNext(struct DoubleLinkedList.List,uint256)`

```solidity
/// @notice Returns the item id which follows item `id`. Returns the tail item id of the list if the `id` is 0.
///  @param list Linked list which contains the items
///  @param id Id of the current item
///  @return _ Id of the current item's next item
function getNext(List storage list, uint256 id) internal view returns (uint256) {
    return list.items[id].next;
}
```

## State Variable Reads

- **list** (`struct DoubleLinkedList.List`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoubleLinkedListWrapper.getNext(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.getNext(struct DoubleLinkedList.List,uint256) (NodeID: 1)
      💬 Args: [list, id]
      👁️  Def: internal
```
