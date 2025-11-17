# Function: test_claimFromStakingV1()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_claimFromStakingV1()`
- **Visibility**: public
- **Source Range**: 10298:733:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_claimFromStakingV1() public {
    uint256 timeIncrease = 86400 * 30;
    vm.warp(block.timestamp + timeIncrease);
    vm.expectRevert("Governance: user-proxy-not-deployed");
    governance.claimFromStakingV1(address(this));
    vm.startPrank(user);
    address userProxy = governance.deriveUserProxyAddress(user);
    lqty.approve(address(userProxy), 1e18);
    governance.depositLQTY(1e18);
    assertEq(UserProxy(payable(userProxy)).staked(), 1e18);
    vm.warp(block.timestamp + timeIncrease);
    governance.claimFromStakingV1(user);
    assertEq(UserProxy(payable(userProxy)).staked(), 1e18);
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

- **Vm::warp(uint256)**
- **Vm::expectRevert(bytes)**
- **GovernanceTester::claimFromStakingV1(address)**
- **Vm::startPrank(address)**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **UserProxy::staked()**

## State Variable Reads

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **user** (`address`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_claimFromStakingV1() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [UserProxy(payable(userProxy)).staked(), 1e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
      💬 Args: [UserProxy(payable(userProxy)).staked(), 1e18]
      👁️  Def: internal
```
