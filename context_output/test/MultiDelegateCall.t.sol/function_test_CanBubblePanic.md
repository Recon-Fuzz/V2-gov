# Function: test_CanBubblePanic()

**Contract**: [test/MultiDelegateCall.t.sol/contract_MultiDelegateCallTest.md]

## Metadata

- **Contract**: MultiDelegateCallTest
- **Signature**: `test_CanBubblePanic()`
- **Visibility**: external
- **Source Range**: 2686:428:102

## Implementation

```solidity
function test_CanBubblePanic() external {
    Target target = new Target();
    bytes[] memory inputs = new bytes[](3);
    inputs[0] = abi.encodeCall(target.id, ("asd"));
    inputs[1] = abi.encodeCall(target.panicWithArithmeticError, ());
    inputs[2] = abi.encodeCall(target.revertWithMessage, ("jkl"));
    vm.expectRevert(stdError.arithmeticError);
    target.multiDelegateCall(inputs);
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **Target::multiDelegateCall(bytes[])**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MultiDelegateCallTest.test_CanBubblePanic() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
