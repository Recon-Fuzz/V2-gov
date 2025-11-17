# Function: test_OneEpochLater_WeAreInEpoch3()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `test_OneEpochLater_WeAreInEpoch3()`
- **Visibility**: external
- **Source Range**: 3157:180:96

## Implementation

```solidity
function test_OneEpochLater_WeAreInEpoch3() external {
    vm.warp(block.timestamp + EPOCH_DURATION);
    assertEq(governance.epoch(), 3, "We should be in epoch #3");
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

## External Calls

- **Vm::warp(uint256)**
- **Governance::epoch()**

## State Variable Reads

- **EPOCH_DURATION** (`uint32`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploymentTest.test_OneEpochLater_WeAreInEpoch3() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [governance.epoch(), 3, "We should be in epoch #3"]
      👁️  Def: internal
```
