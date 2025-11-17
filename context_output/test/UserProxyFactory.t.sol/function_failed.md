# Function: failed()

**Contract**: [test/UserProxyFactory.t.sol/contract_UserProxyFactoryTest.md]

## Metadata

- **Contract**: UserProxyFactoryTest
- **Signature**: `failed()`
- **Visibility**: public
- **Source Range**: 1243:204:9
- **Inherited From**: StdAssertions

## Implementation

```solidity
function failed() public view returns (bool) {
    if (_failed) {
        return _failed;
    } else {
        return vm.load(address(vm), bytes32("failed")) != bytes32(0);
    }
}
```

## External Calls

- **Vm::load(address,bytes32)**

## State Variable Reads

- **_failed** (`bool`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdAssertions.failed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
