# Function: test_epochStart()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_epochStart()`
- **Visibility**: public
- **Source Range**: 11775:203:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_epochStart() public {
    assertEq(governance.epochStart(), block.timestamp);
    vm.warp(block.timestamp + 1);
    assertEq(governance.epochStart(), block.timestamp - 1);
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

- **GovernanceTester::epochStart()**
- **Vm::warp(uint256)**

## State Variable Reads

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_epochStart() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [governance.epochStart(), block.timestamp]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [governance.epochStart(), block.timestamp - 1]
      👁️  Def: internal
```
