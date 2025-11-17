# Function: test_epoch_fuzz(uint32)

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_epoch_fuzz(uint32)`
- **Visibility**: public
- **Source Range**: 11544:142:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_epoch_fuzz(uint32 _timestamp) public {
    vm.warp(governance.EPOCH_START() + _timestamp);
    governance.epoch();
}
```

## External Calls

- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_START()**
- **GovernanceTester::epoch()**

## State Variable Reads

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_epoch_fuzz(uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
