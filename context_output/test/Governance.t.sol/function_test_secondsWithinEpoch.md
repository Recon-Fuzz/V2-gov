# Function: test_secondsWithinEpoch()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_secondsWithinEpoch()`
- **Visibility**: public
- **Source Range**: 12311:501:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_secondsWithinEpoch() public {
    assertEq(governance.secondsWithinEpoch(), 0);
    vm.warp(block.timestamp + 1);
    assertEq(governance.secondsWithinEpoch(), 1);
    vm.warp((block.timestamp + EPOCH_DURATION) - 1);
    assertEq(governance.secondsWithinEpoch(), 0);
    vm.warp(block.timestamp + EPOCH_DURATION);
    assertEq(governance.secondsWithinEpoch(), 0);
    vm.warp(block.timestamp + 1);
    assertEq(governance.secondsWithinEpoch(), 1);
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

- **GovernanceTester::secondsWithinEpoch()**
- **Vm::warp(uint256)**

## State Variable Reads

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **EPOCH_DURATION** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_secondsWithinEpoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [governance.secondsWithinEpoch(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [governance.secondsWithinEpoch(), 1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [governance.secondsWithinEpoch(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [governance.secondsWithinEpoch(), 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
      💬 Args: [governance.secondsWithinEpoch(), 1]
      👁️  Def: internal
```
