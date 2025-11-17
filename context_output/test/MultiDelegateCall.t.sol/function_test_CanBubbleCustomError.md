# Function: test_CanBubbleCustomError()

**Contract**: [test/MultiDelegateCall.t.sol/contract_MultiDelegateCallTest.md]

## Metadata

- **Contract**: MultiDelegateCallTest
- **Signature**: `test_CanBubbleCustomError()`
- **Visibility**: external
- **Source Range**: 2210:470:102

## Implementation

```solidity
function test_CanBubbleCustomError() external {
    Target target = new Target();
    bytes[] memory inputs = new bytes[](3);
    inputs[0] = abi.encodeCall(target.id, ("asd"));
    inputs[1] = abi.encodeCall(target.revertWithCustomError, ("fgh"));
    inputs[2] = abi.encodeCall(target.revertWithMessage, ("jkl"));
    vm.expectRevert(abi.encodeWithSelector(Target.CustomError.selector, "fgh"));
    target.multiDelegateCall(inputs);
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **Target::multiDelegateCall(bytes[])**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MultiDelegateCallTest.test_CanBubbleCustomError() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
