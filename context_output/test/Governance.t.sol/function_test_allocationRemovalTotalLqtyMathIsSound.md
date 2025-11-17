# Function: test_allocationRemovalTotalLqtyMathIsSound()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_allocationRemovalTotalLqtyMathIsSound()`
- **Visibility**: public
- **Source Range**: 29923:2659:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_allocationRemovalTotalLqtyMathIsSound() public {
    vm.startPrank(user2);
    address userProxy_2 = governance.deployUserProxy();
    lqty.approve(address(userProxy_2), 1_000e18);
    governance.depositLQTY(1_000e18);
    vm.startPrank(user);
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), 1_000e18);
    governance.depositLQTY(1_000e18);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    /// Setup and vote for 2 initiatives, 0.1% vs 99.9%
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](2);
    initiatives[0] = baseInitiative1;
    initiatives[1] = baseInitiative2;
    int256[] memory deltaLQTYVotes = new int256[](2);
    deltaLQTYVotes[0] = 1e18;
    deltaLQTYVotes[1] = 999e18;
    int256[] memory deltaLQTYVetos = new int256[](2);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    vm.startPrank(user2);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    vm.startPrank(user);
    vm.warp(block.timestamp + ((governance.UNREGISTRATION_AFTER_EPOCHS()) * governance.EPOCH_DURATION()));
    governance.unregisterInitiative(baseInitiative1);
    (uint256 b4_countedVoteLQTY, uint256 b4_countedVoteOffset) = governance.globalState();
    initiativesToReset = new address[](2);
    initiativesToReset[0] = baseInitiative1;
    initiativesToReset[1] = baseInitiative2;
    address[] memory removeInitiatives = new address[](1);
    removeInitiatives[0] = baseInitiative2;
    int256[] memory removeDeltaLQTYVotes = new int256[](1);
    removeDeltaLQTYVotes[0] = 999e18;
    int256[] memory removeDeltaLQTYVetos = new int256[](1);
    governance.allocateLQTY(initiativesToReset, removeInitiatives, removeDeltaLQTYVotes, removeDeltaLQTYVetos);
    {
        (uint256 after_countedVoteLQTY, uint256 after_countedVoteOffset) = governance.globalState();
        assertEq(after_countedVoteLQTY, b4_countedVoteLQTY, "LQTY should not change");
        assertEq(b4_countedVoteOffset, after_countedVoteOffset, "Offset should not change");
    }
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
- **GovernanceTester::deployUserProxy()**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **GovernanceTester::UNREGISTRATION_AFTER_EPOCHS()**
- **GovernanceTester::unregisterInitiative(address)**
- **GovernanceTester::globalState()**

## State Variable Reads

- **user2** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **user** (`address`)
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_allocationRemovalTotalLqtyMathIsSound() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [after_countedVoteLQTY, b4_countedVoteLQTY, "LQTY should not change"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 2)
      💬 Args: [b4_countedVoteOffset, after_countedVoteOffset, "Offset should not change"]
      👁️  Def: internal
```
