# Function: failed()

**Contract**: [test/E2E.t.sol/contract_ForkedE2ETests.md]

## Metadata

- **Contract**: ForkedE2ETests
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
