# Function: test_OnAfterAllocateLQTY_IsCalledOnceWithZeroVotes_WhenCastingVetosAfterHavingCastVotes()

**Contract**: [test/InitiativeHooks.t.sol/contract_InitiativeHooksTest.md]

## Metadata

- **Contract**: InitiativeHooksTest
- **Signature**: `test_OnAfterAllocateLQTY_IsCalledOnceWithZeroVotes_WhenCastingVetosAfterHavingCastVotes()`
- **Visibility**: external
- **Source Range**: 4876:837:101

## Implementation

```solidity
function test_OnAfterAllocateLQTY_IsCalledOnceWithZeroVotes_WhenCastingVetosAfterHavingCastVotes() external {
    vm.startPrank(voter);
    votes[0] = 123;
    governance.allocateLQTY(noInitiatives, initiatives, votes, vetos);
    vm.stopPrank();
    assertEq(initiative.numOnAfterAllocateLQTYCalls(), 1, "onAfterAllocateLQTY should have been called once");
    vm.startPrank(voter);
    votes[0] = 0;
    vetos[0] = 456;
    governance.allocateLQTY(initiatives, initiatives, votes, vetos);
    vm.stopPrank();
    assertEq(initiative.numOnAfterAllocateLQTYCalls(), 2, "onAfterAllocateLQTY should have been called once more");
    (, , , IGovernance.Allocation memory allocation, ) = initiative.onAfterAllocateLQTYCalls(1);
    assertEq(allocation.voteLQTY, 0, "wrong voteLQTY");
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
- **MockInitiative::onAfterAllocateLQTYCalls(int_const 1)**

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

- **votes** (`int256[]`)
- **vetos** (`int256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InitiativeHooksTest.test_OnAfterAllocateLQTY_IsCalledOnceWithZeroVotes_WhenCastingVetosAfterHavingCastVotes() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [initiative.numOnAfterAllocateLQTYCalls(), 1, "onAfterAllocateLQTY should have been called once"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [initiative.numOnAfterAllocateLQTYCalls(), 2, "onAfterAllocateLQTY should have been called once more"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
      💬 Args: [allocation.voteLQTY, 0, "wrong voteLQTY"]
      👁️  Def: internal
```
