# Function: setUp()

**Contract**: [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListTest.md]

## Metadata

- **Contract**: DoubleLinkedListTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 887:80:97

## Implementation

```solidity
function setUp() public {
    wrapper = new DoubleLinkedListWrapper();
}
```

## State Variable Writes

- **wrapper** (`contract DoubleLinkedListWrapper`) [test/DoubleLinkedList.t.sol/contract_DoubleLinkedListWrapper.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoubleLinkedListTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
