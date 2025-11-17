# Function: test_basic_contractCall()

**Contract**: [test/SafeCallWithMinGas.t.sol/contract_SafeCallWithMinGasTests.md]

## Metadata

- **Contract**: SafeCallWithMinGasTests
- **Signature**: `test_basic_contractCall()`
- **Visibility**: public
- **Source Range**: 1341:319:103

## Implementation

```solidity
function test_basic_contractCall() public {
    BasicRecipient recipient = new BasicRecipient();
    safeCallWithMinGas(address(recipient), 35_000, 0, abi.encodeCall(BasicRecipient.validCall, ()));
    assertEq(recipient.callWasValid(), true, "Call success");
}
```

## Related Implementations

### safeCallWithMinGas(address,uint256,uint256,bytes)

- **Kind**: free-function
- **Source**: 775:892:88
- **Link**: `src/utils/SafeCallMinGas.sol:safeCallWithMinGas(address,uint256,uint256,bytes)`

```solidity
/// @dev Performs a call ignoring the recipient existing or not, passing the exact gas value, ignoring any return value
function safeCallWithMinGas(address _target, uint256 _gas, uint256 _value, bytes memory _calldata) returns (bool success) {
    /// This is not necessary
    ///  But this is basically a worst case estimate of mem exp cost + operations before the call
    require(hasMinGas(_gas, 1_000), "Must have minGas");
    assembly {
        success := call(_gas, _target, _value, add(_calldata, 0x20), mload(_calldata), 0, 0)
    }
    return (success);
}
```

### hasMinGas(uint256,uint256)

- **Kind**: free-function
- **Source**: 325:328:88
- **Link**: `src/utils/SafeCallMinGas.sol:hasMinGas(uint256,uint256)`

```solidity
/// @notice Given the gas requirement, ensures that the current context has sufficient gas to perform a call + a fixed buffer
///  @dev Credits: https://github.com/ethereum-optimism/optimism/blob/develop/packages/contracts-bedrock/src/libraries/SafeCall.sol#L100-L107
function hasMinGas(uint256 _minGas, uint256 _reservedGas) view returns (bool) {
    bool _hasMinGas;
    assembly {
        _hasMinGas := iszero(lt(mul(gas(), 63), add(mul(_minGas, 64), mul(add(40000, _reservedGas), 63))))
    }
    return _hasMinGas;
}
```

### assertEq(bool,bool,string)

- **Kind**: internal
- **Source**: 2136:128:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bool,bool,string)`

```solidity
function assertEq(bool left, bool right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **BasicRecipient::callWasValid()**

## State Variable Reads

- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SafeCallWithMinGasTests.test_basic_contractCall() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: Unknown.safeCallWithMinGas(address,uint256,uint256,bytes) (NodeID: 1)
  │   💬 Args: [address(recipient), 35_000, 0, abi.encodeCall(BasicRecipient.validCall, ())]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.hasMinGas(uint256,uint256) (NodeID: 2)
  │     💬 Args: [_gas, 1_000]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bool,bool,string) (NodeID: 3)
      💬 Args: [recipient.callWasValid(), true, "Call success"]
      👁️  Def: internal
```
