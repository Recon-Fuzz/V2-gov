# Function: test_secondsWithinEpoch_fuzz(uint32)

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_secondsWithinEpoch_fuzz(uint32)`
- **Visibility**: public
- **Source Range**: 12869:168:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_secondsWithinEpoch_fuzz(uint32 _timestamp) public {
    vm.warp(governance.EPOCH_START() + _timestamp);
    governance.secondsWithinEpoch();
}
```

## External Calls

- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_START()**
- **GovernanceTester::secondsWithinEpoch()**

## State Variable Reads

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_secondsWithinEpoch_fuzz(uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
