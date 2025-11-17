# Function: test_insert_atHead()

**Contract**: [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListTest.md]

## Metadata

- **Contract**: DoubleLinkedListTest
- **Signature**: `test_insert_atHead()`
- **Visibility**: public
- **Source Range**: 2156:624:97

## Implementation

```solidity
function test_insert_atHead() public {
    wrapper.insert(1, 0);
    assertEq(wrapper.getHead(), 1);
    assertEq(wrapper.getTail(), 1);
    wrapper.insert(2, 0);
    assertEq(wrapper.getHead(), 2);
    assertEq(wrapper.getTail(), 1);
    wrapper.insert(3, 0);
    assertEq(wrapper.getHead(), 3);
    assertEq(wrapper.getTail(), 1);
    assertEq(wrapper.getNext(1), 2);
    assertEq(wrapper.getNext(2), 3);
    assertEq(wrapper.getNext(3), 0);
    assertEq(wrapper.getPrev(1), 0);
    assertEq(wrapper.getPrev(2), 1);
    assertEq(wrapper.getPrev(3), 2);
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
┌─ [0] ⚙️ FUNCTION: DoubleLinkedListTest.test_insert_atHead() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [wrapper.getHead(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [wrapper.getTail(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [wrapper.getHead(), 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [wrapper.getTail(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [wrapper.getHead(), 3]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [wrapper.getTail(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [wrapper.getNext(1), 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
  │   💬 Args: [wrapper.getNext(2), 3]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 9)
  │   💬 Args: [wrapper.getNext(3), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
  │   💬 Args: [wrapper.getPrev(1), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 11)
  │   💬 Args: [wrapper.getPrev(2), 1]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 12)
      💬 Args: [wrapper.getPrev(3), 2]
      👁️  Def: internal
```
