# Function: getTail()

**Contract**: [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListWrapper.md]

## Metadata

- **Contract**: DoubleLinkedListWrapper
- **Signature**: `getTail()`
- **Visibility**: public
- **Source Range**: 396:87:97

## Implementation

```solidity
function getTail() public view returns (uint256) {
    return list.getTail();
}
```

## Related Implementations

### getTail(struct DoubleLinkedList.List)

- **Kind**: internal
- **Source**: 976:110:84
- **Link**: `src/utils/DoubleLinkedList.sol:DoubleLinkedList:getTail(struct DoubleLinkedList.List)`

```solidity
/// @notice Returns the tail item id of the list
///  @param list Linked list which contains the item
///  @return _ Id of the tail item
function getTail(List storage list) internal view returns (uint256) {
    return list.items[0].next;
}
```

## State Variable Reads

- **list** (`struct DoubleLinkedList.List`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoubleLinkedListWrapper.getTail() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.getTail(struct DoubleLinkedList.List) (NodeID: 1)
      💬 Args: [list]
      👁️  Def: internal
```
