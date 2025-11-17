# Function: test_AtStart_WeAreInEpoch2()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `test_AtStart_WeAreInEpoch2()`
- **Visibility**: external
- **Source Range**: 3020:131:96

## Implementation

```solidity
function test_AtStart_WeAreInEpoch2() external view {
    assertEq(governance.epoch(), 2, "We should start in epoch #2");
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

- **Governance::epoch()**

## State Variable Reads

- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploymentTest.test_AtStart_WeAreInEpoch2() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [governance.epoch(), 2, "We should start in epoch #2"]
      👁️  Def: internal
```
