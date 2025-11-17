# Function: test_allocateLQTY_multiple()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_allocateLQTY_multiple()`
- **Visibility**: public
- **Source Range**: 50219:1542:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_allocateLQTY_multiple() public {
    vm.startPrank(user);
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), 2e18);
    governance.depositLQTY(2e18);
    (, , uint256 allocatedLQTY, ) = governance.userStates(user);
    assertEq(allocatedLQTY, 0);
    (uint256 countedVoteLQTY, ) = governance.globalState();
    assertEq(countedVoteLQTY, 0);
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](2);
    initiatives[0] = baseInitiative1;
    initiatives[1] = baseInitiative2;
    int256[] memory deltaLQTYVotes = new int256[](2);
    deltaLQTYVotes[0] = 1e18;
    deltaLQTYVotes[1] = 1e18;
    int256[] memory deltaLQTYVetos = new int256[](2);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    (, , allocatedLQTY, ) = governance.userStates(user);
    assertEq(allocatedLQTY, 2e18);
    (countedVoteLQTY, ) = governance.globalState();
    assertEq(countedVoteLQTY, 2e18);
    (uint256 voteLQTY, uint256 voteOffset, uint256 vetoLQTY, uint256 vetoOffset, ) = governance.initiativeStates(baseInitiative1);
    assertEq(voteLQTY, 1e18);
    assertEq(vetoLQTY, 0);
    (voteLQTY, voteOffset, vetoLQTY, vetoOffset, ) = governance.initiativeStates(baseInitiative2);
    assertEq(voteLQTY, 1e18);
    assertEq(vetoLQTY, 0);
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

- **Vm::startPrank(address)**
- **GovernanceTester::deployUserProxy()**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **GovernanceTester::userStates(address)**
- **GovernanceTester::globalState()**
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **GovernanceTester::initiativeStates(address)**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_allocateLQTY_multiple() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [allocatedLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [countedVoteLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [allocatedLQTY, 2e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [countedVoteLQTY, 2e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [voteLQTY, 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [vetoLQTY, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [voteLQTY, 1e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
      💬 Args: [vetoLQTY, 0]
      👁️  Def: internal
```
