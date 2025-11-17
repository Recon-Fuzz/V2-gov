# Function: test_OnAfterAllocateLQTY_IsNotCalled_WhenCastingVetos()

**Contract**: [test/InitiativeHooks.t.sol/contract_InitiativeHooksTest.md]

## Metadata

- **Contract**: InitiativeHooksTest
- **Signature**: `test_OnAfterAllocateLQTY_IsNotCalled_WhenCastingVetos()`
- **Visibility**: external
- **Source Range**: 4516:354:101

## Implementation

```solidity
function test_OnAfterAllocateLQTY_IsNotCalled_WhenCastingVetos() external {
    vm.startPrank(voter);
    vetos[0] = 123;
    governance.allocateLQTY(noInitiatives, initiatives, votes, vetos);
    vm.stopPrank();
    assertEq(initiative.numOnAfterAllocateLQTYCalls(), 0, "onAfterAllocateLQTY should not have been called once");
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

- **Vm::startPrank(address)**
- **Governance::allocateLQTY(address[],address[],int256[],int256[])**
- **Vm::stopPrank()**
- **MockInitiative::numOnAfterAllocateLQTYCalls()**

## State Variable Reads

- **voter** (`address`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **noInitiatives** (`address[]`)
- **initiatives** (`address[]`)
- **votes** (`int256[]`)
- **vetos** (`int256[]`)
- **initiative** (`contract MockInitiative`) [test/InitiativeHooks.t.sol/contract_MockInitiative.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **vetos** (`int256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InitiativeHooksTest.test_OnAfterAllocateLQTY_IsNotCalled_WhenCastingVetos() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [initiative.numOnAfterAllocateLQTYCalls(), 0, "onAfterAllocateLQTY should not have been called once"]
      👁️  Def: internal
```
