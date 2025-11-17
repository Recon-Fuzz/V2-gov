# Function: test_OnAfterAllocateLQTY_IsCalled_WhenCastingVotes()

**Contract**: [test/InitiativeHooks.t.sol/contract_InitiativeHooksTest.md]

## Metadata

- **Contract**: InitiativeHooksTest
- **Signature**: `test_OnAfterAllocateLQTY_IsCalled_WhenCastingVotes()`
- **Visibility**: external
- **Source Range**: 3465:1045:101

## Implementation

```solidity
function test_OnAfterAllocateLQTY_IsCalled_WhenCastingVotes() external {
    vm.startPrank(voter);
    votes[0] = 123;
    governance.allocateLQTY(noInitiatives, initiatives, votes, vetos);
    vm.stopPrank();
    assertEq(initiative.numOnAfterAllocateLQTYCalls(), 1, "onAfterAllocateLQTY should have been called once");
    (, , , IGovernance.Allocation memory allocation, ) = initiative.onAfterAllocateLQTYCalls(0);
    assertEq(allocation.voteLQTY, 123, "wrong voteLQTY 1");
    vm.startPrank(voter);
    votes[0] = 456;
    governance.allocateLQTY(initiatives, initiatives, votes, vetos);
    vm.stopPrank();
    assertEq(initiative.numOnAfterAllocateLQTYCalls(), 3, "onAfterAllocateLQTY should have been called twice more");
    (, , , allocation, ) = initiative.onAfterAllocateLQTYCalls(1);
    assertEq(allocation.voteLQTY, 0, "wrong voteLQTY 2");
    (, , , allocation, ) = initiative.onAfterAllocateLQTYCalls(2);
    assertEq(allocation.voteLQTY, 456, "wrong voteLQTY 3");
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
- **MockInitiative::onAfterAllocateLQTYCalls(int_const 0)**
- **MockInitiative::onAfterAllocateLQTYCalls(int_const 1)**
- **MockInitiative::onAfterAllocateLQTYCalls(int_const 2)**

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InitiativeHooksTest.test_OnAfterAllocateLQTY_IsCalled_WhenCastingVotes() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [initiative.numOnAfterAllocateLQTYCalls(), 1, "onAfterAllocateLQTY should have been called once"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
  │   💬 Args: [allocation.voteLQTY, 123, "wrong voteLQTY 1"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [initiative.numOnAfterAllocateLQTYCalls(), 3, "onAfterAllocateLQTY should have been called twice more"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 4)
  │   💬 Args: [allocation.voteLQTY, 0, "wrong voteLQTY 2"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 5)
      💬 Args: [allocation.voteLQTY, 456, "wrong voteLQTY 3"]
      👁️  Def: internal
```
