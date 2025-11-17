# Function: test_StopsAtFirstRevertAndBubblesItUp()

**Contract**: [test/MultiDelegateCall.t.sol/contract_MultiDelegateCallTest.md]

## Metadata

- **Contract**: MultiDelegateCallTest
- **Signature**: `test_StopsAtFirstRevertAndBubblesItUp()`
- **Visibility**: external
- **Source Range**: 1772:432:102

## Implementation

```solidity
function test_StopsAtFirstRevertAndBubblesItUp() external {
    Target target = new Target();
    bytes[] memory inputs = new bytes[](3);
    inputs[0] = abi.encodeCall(target.id, ("asd"));
    inputs[1] = abi.encodeCall(target.revertWithMessage, ("fgh"));
    inputs[2] = abi.encodeCall(target.revertWithMessage, ("jkl"));
    vm.expectRevert(bytes("fgh"));
    target.multiDelegateCall(inputs);
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **Target::multiDelegateCall(bytes[])**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MultiDelegateCallTest.test_StopsAtFirstRevertAndBubblesItUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
