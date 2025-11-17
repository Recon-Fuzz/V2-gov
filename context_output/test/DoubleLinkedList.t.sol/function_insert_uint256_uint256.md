# Function: insert(uint256,uint256)

**Contract**: [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListWrapper.md]

## Metadata

- **Contract**: DoubleLinkedListWrapper
- **Signature**: `insert(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 699:93:97

## Implementation

```solidity
function insert(uint256 id, uint256 next) public {
    list.insert(id, 1, 1, next);
}
```

## Related Implementations

### insert(struct DoubleLinkedList.List,uint256,uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 3585:498:84
- **Link**: `src/utils/DoubleLinkedList.sol:DoubleLinkedList:insert(struct DoubleLinkedList.List,uint256,uint256,uint256,uint256)`

```solidity
/// @notice Inserts an item with `id` in the list before item `next`
///  - if `next` is 0, the item is inserted at the start (head) of the list
///  @dev This function should not be called with an `id` that is already in the list.
///  @param list Linked list which contains the next item and into which the new item will be inserted
///  @param id Id of the item to insert
///  @param lqty amount of LQTY
///  @param offset associated with the LQTY amount
///  @param next Id of the item which should follow item `id`
function insert(List storage list, uint256 id, uint256 lqty, uint256 offset, uint256 next) internal {
    if (contains(list, id)) revert ItemInList();
    if ((next != 0) && (!contains(list, next))) revert ItemNotInList();
    uint256 prev = list.items[next].prev;
    list.items[prev].next = id;
    list.items[next].prev = id;
    list.items[id].prev = prev;
    list.items[id].next = next;
    list.items[id].lqty = lqty;
    list.items[id].offset = offset;
}
```

### contains(struct DoubleLinkedList.List,uint256)

- **Kind**: internal
- **Source**: 2810:224:84
- **Link**: `src/utils/DoubleLinkedList.sol:DoubleLinkedList:contains(struct DoubleLinkedList.List,uint256)`

```solidity
/// @notice Returns whether the list contains item `id`
///  @param list Linked list which should contain the item
///  @param id Id of the item to check
///  @return _ True if the list contains the item, false otherwise
function contains(List storage list, uint256 id) internal view returns (bool) {
    if (id == 0) revert IdIsZero();
    return (((list.items[id].prev != 0) || (list.items[id].next != 0)) || (list.items[0].next == id));
}
```

## State Variable Reads

- **list** (`struct DoubleLinkedList.List`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoubleLinkedListWrapper.insert(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.insert(struct DoubleLinkedList.List,uint256,uint256,uint256,uint256) (NodeID: 1)
      💬 Args: [list, id, 1, 1, next]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: DoubleLinkedList.contains(struct DoubleLinkedList.List,uint256) (NodeID: 2)
    │   💬 Args: [list, id]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: DoubleLinkedList.contains(struct DoubleLinkedList.List,uint256) (NodeID: 3)
        💬 Args: [list, next]
        👁️  Def: internal
```
