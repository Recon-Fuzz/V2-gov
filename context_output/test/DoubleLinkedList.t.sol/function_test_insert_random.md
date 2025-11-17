# Function: test_insert_random()

**Contract**: [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListTest.md]

## Metadata

- **Contract**: DoubleLinkedListTest
- **Signature**: `test_insert_random()`
- **Visibility**: public
- **Source Range**: 1013:1100:97

## Implementation

```solidity
function test_insert_random() public {
    vm.expectRevert(DoubleLinkedList.IdIsZero.selector);
    wrapper.insert(0, 0);
    wrapper.insert(1, 0);
    assertEq(wrapper.getHead(), 1);
    assertEq(wrapper.getTail(), 1);
    wrapper.insert(2, 1);
    assertEq(wrapper.getHead(), 1);
    assertEq(wrapper.getTail(), 2);
    wrapper.insert(3, 2);
    assertEq(wrapper.getHead(), 1);
    assertEq(wrapper.getTail(), 3);
    wrapper.insert(4, 2);
    assertEq(wrapper.getHead(), 1);
    assertEq(wrapper.getTail(), 3);
    vm.expectRevert(DoubleLinkedList.ItemInList.selector);
    wrapper.insert(4, 2);
    vm.expectRevert(DoubleLinkedList.ItemNotInList.selector);
    wrapper.insert(5, 10);
    assertEq(wrapper.getNext(1), 0);
    assertEq(wrapper.getNext(2), 1);
    assertEq(wrapper.getNext(3), 4);
    assertEq(wrapper.getNext(4), 2);
    assertEq(wrapper.getPrev(1), 2);
    assertEq(wrapper.getPrev(2), 4);
    assertEq(wrapper.getPrev(4), 3);
    assertEq(wrapper.getPrev(3), 0);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **Vm::expectRevert(bytes4)**
- **DoubleLinkedListWrapper::insert(uint256,uint256)**
- **DoubleLinkedListWrapper::getHead()**
- **DoubleLinkedListWrapper::getTail()**
- **DoubleLinkedListWrapper::getNext(uint256)**
- **DoubleLinkedListWrapper::getPrev(uint256)**

## State Variable Reads

- **wrapper** (`contract DoubleLinkedListWrapper`) [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListWrapper.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoubleLinkedListTest.test_insert_random() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [wrapper.getHead(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [wrapper.getTail(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [wrapper.getHead(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [wrapper.getTail(), 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [wrapper.getHead(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [wrapper.getTail(), 3]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [wrapper.getHead(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
  │   💬 Args: [wrapper.getTail(), 3]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 9)
  │   💬 Args: [wrapper.getNext(1), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
  │   💬 Args: [wrapper.getNext(2), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 11)
  │   💬 Args: [wrapper.getNext(3), 4]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 12)
  │   💬 Args: [wrapper.getNext(4), 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 13)
  │   💬 Args: [wrapper.getPrev(1), 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 14)
  │   💬 Args: [wrapper.getPrev(2), 4]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 15)
  │   💬 Args: [wrapper.getPrev(4), 3]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 16)
      💬 Args: [wrapper.getPrev(3), 0]
      👁️  Def: internal
```
