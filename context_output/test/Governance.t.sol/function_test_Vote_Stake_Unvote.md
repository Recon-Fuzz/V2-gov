# Function: test_Vote_Stake_Unvote()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_Vote_Stake_Unvote()`
- **Visibility**: external
- **Source Range**: 109752:1875:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_Vote_Stake_Unvote() external {
    address[] memory noInitiatives;
    address[] memory initiatives = new address[](1);
    int256[] memory noVotes;
    int256[] memory votes = new int256[](1);
    int256[] memory vetos = new int256[](1);
    initiatives[0] = baseInitiative1;
    vm.warp(block.timestamp + EPOCH_DURATION);
    vm.startPrank(user2);
    {
        address userProxy = governance.deriveUserProxyAddress(user2);
        lqty.approve(userProxy, type(uint256).max);
        governance.depositLQTY(1 ether);
        votes[0] = 1 ether;
        governance.allocateLQTY(noInitiatives, initiatives, votes, vetos);
    }
    vm.stopPrank();
    (uint256 voteLQTYBefore, uint256 voteOffsetBefore, , , ) = governance.initiativeStates(baseInitiative1);
    vm.startPrank(user);
    {
        address userProxy = governance.deriveUserProxyAddress(user);
        lqty.approve(userProxy, type(uint256).max);
        governance.depositLQTY(1 ether);
        votes[0] = 1 ether;
        governance.allocateLQTY(noInitiatives, initiatives, votes, vetos);
        vm.warp(block.timestamp + 1 days);
        governance.depositLQTY(1 ether);
        governance.allocateLQTY(initiatives, noInitiatives, noVotes, noVotes);
    }
    vm.stopPrank();
    (uint256 voteLQTYAfter, uint256 voteOffsetAfter, , , ) = governance.initiativeStates(baseInitiative1);
    assertEqDecimal(voteLQTYAfter, voteLQTYBefore, 18, "voteLQTYAfter != voteLQTYBefore");
    assertEqDecimal(voteOffsetAfter, voteOffsetBefore, 18, "voteOffsetAfter != voteOffsetBefore");
}
```

## Related Implementations

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Vm::startPrank(address)**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **Vm::stopPrank()**
- **GovernanceTester::initiativeStates(address)**

## State Variable Reads

- **baseInitiative1** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **user2** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_Vote_Stake_Unvote() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [voteLQTYAfter, voteLQTYBefore, 18, "voteLQTYAfter != voteLQTYBefore"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 2)
      💬 Args: [voteOffsetAfter, voteOffsetBefore, 18, "voteOffsetAfter != voteOffsetBefore"]
      👁️  Def: internal
```
