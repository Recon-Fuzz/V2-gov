# Function: test_epoch()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_epoch()`
- **Visibility**: public
- **Source Range**: 11104:368:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_epoch() public {
    assertEq(governance.epoch(), 1);
    vm.warp((block.timestamp + 7 days) - 1);
    assertEq(governance.epoch(), 1);
    vm.warp(block.timestamp + 1);
    assertEq(governance.epoch(), 2);
    vm.warp((block.timestamp + 3653 days) - 7 days);
    assertEq(governance.epoch(), 522);
}
```

## Related Implementations

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **GovernanceTester::epoch()**
- **Vm::warp(uint256)**

## State Variable Reads

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_epoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [governance.epoch(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [governance.epoch(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [governance.epoch(), 2]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
      💬 Args: [governance.epoch(), 522]
      👁️  Def: internal
```
