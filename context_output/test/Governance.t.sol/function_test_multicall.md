# Function: test_multicall()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_multicall()`
- **Visibility**: public
- **Source Range**: 59709:2279:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_multicall() public {
    vm.startPrank(user);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    uint256 lqtyAmount = 1000e18;
    uint256 lqtyBalance = lqty.balanceOf(user);
    lqty.approve(address(governance.deriveUserProxyAddress(user)), lqtyAmount);
    bytes[] memory data = new bytes[](8);
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](1);
    initiatives[0] = baseInitiative1;
    int256[] memory deltaVoteLQTY = new int256[](1);
    deltaVoteLQTY[0] = int256(uint256(lqtyAmount));
    int256[] memory deltaVetoLQTY = new int256[](1);
    int256[] memory deltaVoteLQTY_ = new int256[](1);
    deltaVoteLQTY_[0] = 1;
    data[0] = abi.encodeWithSignature("deployUserProxy()");
    data[1] = abi.encodeWithSignature("depositLQTY(uint256)", lqtyAmount);
    data[2] = abi.encodeWithSignature("allocateLQTY(address[],address[],int256[],int256[])", initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    data[3] = abi.encodeWithSignature("userStates(address)", user);
    data[4] = abi.encodeWithSignature("snapshotVotesForInitiative(address)", baseInitiative1);
    data[5] = abi.encodeWithSignature("allocateLQTY(address[],address[],int256[],int256[])", initiatives, initiatives, deltaVoteLQTY_, deltaVetoLQTY);
    data[6] = abi.encodeWithSignature("resetAllocations(address[],bool)", initiatives, true);
    data[7] = abi.encodeWithSignature("withdrawLQTY(uint256)", lqtyAmount);
    bytes[] memory response = governance.multiDelegateCall(data);
    (, , uint256 allocatedLQTY, ) = abi.decode(response[3], (uint256, uint256, uint256, uint256));
    assertEq(allocatedLQTY, lqtyAmount);
    (IGovernance.VoteSnapshot memory votes, IGovernance.InitiativeVoteSnapshot memory votesForInitiative) = abi.decode(response[4], (IGovernance.VoteSnapshot, IGovernance.InitiativeVoteSnapshot));
    assertEq(votes.votes + votesForInitiative.votes, 0);
    assertEq(lqty.balanceOf(user), lqtyBalance);
    vm.stopPrank();
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
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **ILQTY::balanceOf(address)**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **GovernanceTester::multiDelegateCall(bytes[])**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **baseInitiative1** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_multicall() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [allocatedLQTY, lqtyAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [votes.votes + votesForInitiative.votes, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
      💬 Args: [lqty.balanceOf(user), lqtyBalance]
      👁️  Def: internal
```
