# Function: getHead()

**Contract**: [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListWrapper.md]

## Metadata

- **Contract**: DoubleLinkedListWrapper
- **Signature**: `getHead()`
- **Visibility**: public
- **Source Range**: 303:87:97

## Implementation

```solidity
function getHead() public view returns (uint256) {
    return list.getHead();
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

- **list** (`struct DoubleLinkedList.List`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoubleLinkedListWrapper.getHead() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: DoubleLinkedList.getHead(struct DoubleLinkedList.List) (NodeID: 1)
      💬 Args: [list]
      👁️  Def: internal
```
