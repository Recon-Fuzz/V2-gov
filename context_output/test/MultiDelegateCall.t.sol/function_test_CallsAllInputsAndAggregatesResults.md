# Function: test_CallsAllInputsAndAggregatesResults()

**Contract**: [test/MultiDelegateCall.t.sol/contract_MultiDelegateCallTest.md]

## Metadata

- **Contract**: MultiDelegateCallTest
- **Signature**: `test_CallsAllInputsAndAggregatesResults()`
- **Visibility**: external
- **Source Range**: 775:991:102

## Implementation

```solidity
function test_CallsAllInputsAndAggregatesResults() external {
    Target target = new Target();
    bytes[] memory inputValues = new bytes[](3);
    inputValues[0] = abi.encode("asd", 123);
    inputValues[1] = abi.encode("fgh", 456);
    inputValues[2] = abi.encode("jkl", 789);
    bytes[] memory inputs = new bytes[](3);
    inputs[0] = abi.encodeCall(target.id, (inputValues[0]));
    inputs[1] = abi.encodeCall(target.id, (inputValues[1]));
    inputs[2] = abi.encodeCall(target.id, (inputValues[2]));
    bytes[] memory returnValues = target.multiDelegateCall(inputs);
    assertEq(returnValues.length, inputs.length, "returnValues.length != inputs.length");
    assertEq(abi.decode(returnValues[0], (bytes)), inputValues[0], "returnValues[0]");
    assertEq(abi.decode(returnValues[1], (bytes)), inputValues[1], "returnValues[1]");
    assertEq(abi.decode(returnValues[2], (bytes)), inputValues[2], "returnValues[2]");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertEq(bytes,bytes,string)

- **Kind**: internal
- **Source**: 4626:144:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes,bytes,string)`

```solidity
function assertEq(bytes memory left, bytes memory right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Target::multiDelegateCall(bytes[])**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MultiDelegateCallTest.test_CallsAllInputsAndAggregatesResults() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [returnValues.length, inputs.length, "returnValues.length != inputs.length"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes,bytes,string) (NodeID: 2)
  │   💬 Args: [abi.decode(returnValues[0], (bytes)), inputValues[0], "returnValues[0]"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes,bytes,string) (NodeID: 3)
  │   💬 Args: [abi.decode(returnValues[1], (bytes)), inputValues[1], "returnValues[1]"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes,bytes,string) (NodeID: 4)
      💬 Args: [abi.decode(returnValues[2], (bytes)), inputValues[2], "returnValues[2]"]
      👁️  Def: internal
```
