# Function: test_AtStart_CanVoteOnInitialInitiative()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `test_AtStart_CanVoteOnInitialInitiative()`
- **Visibility**: external
- **Source Range**: 3343:416:96

## Implementation

```solidity
function test_AtStart_CanVoteOnInitialInitiative() external {
    _voteOnInitiative();
    uint256 boldAccrued = 1 ether;
    bold.mint(address(governance), boldAccrued);
    vm.warp(block.timestamp + EPOCH_DURATION);
    governance.claimForInitiative(initialInitiative);
    assertEqDecimal(bold.balanceOf(initialInitiative), boldAccrued, 18, "Initiative should have received BOLD");
}
```

## Related Implementations

### _voteOnInitiative()

- **Kind**: internal
- **Source**: 4902:485:96
- **Link**: `test/Deployment.t.sol:DeploymentTest:_voteOnInitiative()`

```solidity
function _voteOnInitiative() internal {
    uint256 lqtyAmount = 1 ether;
    lqty.mint(voter, lqtyAmount);
    votes.push(int256(lqtyAmount));
    vetos.push(0);
    vm.startPrank(voter);
    lqty.approve(governance.deriveUserProxyAddress(voter), lqtyAmount);
    governance.depositLQTY(lqtyAmount);
    governance.allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    vm.stopPrank();
    delete votes;
    delete vetos;
}
```

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

- **MockERC20Tester::mint(address,uint256)**
- **Vm::warp(uint256)**
- **Governance::claimForInitiative(address)**
- **MockERC20Tester::balanceOf(address)**

## State Variable Reads

- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **EPOCH_DURATION** (`uint32`)
- **initialInitiative** (`address`)
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **voter** (`address`)
- **initiativesToReset** (`address[]`)
- **initiatives** (`address[]`)
- **votes** (`int256[]`)
- **vetos** (`int256[]`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **votes** (`int256[]`)
- **vetos** (`int256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploymentTest.test_AtStart_CanVoteOnInitialInitiative() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: DeploymentTest._voteOnInitiative() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 2)
      💬 Args: [bold.balanceOf(initialInitiative), boldAccrued, 18, "Initiative should have received BOLD"]
      👁️  Def: internal
```
