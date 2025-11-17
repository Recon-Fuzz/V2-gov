# Function: off_claimForInitiativeEOA()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `off_claimForInitiativeEOA()`
- **Visibility**: public
- **Source Range**: 57023:2680:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function off_claimForInitiativeEOA() public {
    address EOAInitiative = address(0xbeef);
    vm.startPrank(user);
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), 1000e18);
    governance.depositLQTY(1000e18);
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    vm.stopPrank();
    vm.startPrank(lusdHolder);
    lusd.transfer(address(governance), 10000e18);
    vm.stopPrank();
    vm.startPrank(user);
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](2);
    initiatives[0] = EOAInitiative;
    initiatives[1] = baseInitiative2;
    int256[] memory deltaVoteLQTY = new int256[](2);
    deltaVoteLQTY[0] = 500e18;
    deltaVoteLQTY[1] = 500e18;
    int256[] memory deltaVetoLQTY = new int256[](2);
    governance.allocateLQTY(initiativesToReset, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    (, , uint256 allocatedLQTY, ) = governance.userStates(user);
    assertEq(allocatedLQTY, 1000e18);
    vm.warp((block.timestamp + governance.EPOCH_DURATION()) + 1);
    assertEq(governance.claimForInitiative(EOAInitiative), 5000e18);
    governance.claimForInitiative(EOAInitiative);
    assertEq(governance.claimForInitiative(EOAInitiative), 0);
    assertEq(lusd.balanceOf(EOAInitiative), 5000e18);
    assertEq(governance.claimForInitiative(baseInitiative2), 5000e18);
    assertEq(governance.claimForInitiative(baseInitiative2), 0);
    assertEq(lusd.balanceOf(baseInitiative2), 5000e18);
    vm.stopPrank();
    vm.startPrank(lusdHolder);
    lusd.transfer(address(governance), 10000e18);
    vm.stopPrank();
    vm.startPrank(user);
    initiatives[0] = EOAInitiative;
    initiatives[1] = baseInitiative2;
    deltaVoteLQTY[0] = 495e18;
    deltaVoteLQTY[1] = -495e18;
    governance.allocateLQTY(initiatives, initiatives, deltaVoteLQTY, deltaVetoLQTY);
    vm.warp((block.timestamp + governance.EPOCH_DURATION()) + 1);
    assertEq(governance.claimForInitiative(EOAInitiative), 10000e18);
    assertEq(governance.claimForInitiative(EOAInitiative), 0);
    assertEq(lusd.balanceOf(EOAInitiative), 15000e18);
    assertEq(governance.claimForInitiative(baseInitiative2), 0);
    assertEq(governance.claimForInitiative(baseInitiative2), 0);
    assertEq(lusd.balanceOf(baseInitiative2), 5000e18);
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
- **GovernanceTester::deployUserProxy()**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **Vm::stopPrank()**
- **ILUSD::transfer(address,uint256)**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **GovernanceTester::userStates(address)**
- **GovernanceTester::claimForInitiative(address)**
- **ILUSD::balanceOf(address)**

## Native Transfers

- **lusd** (computed)

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusdHolder** (`address`)
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **baseInitiative2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.off_claimForInitiativeEOA() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [allocatedLQTY, 1000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [governance.claimForInitiative(EOAInitiative), 5000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 3)
  │   💬 Args: [governance.claimForInitiative(EOAInitiative), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [lusd.balanceOf(EOAInitiative), 5000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [governance.claimForInitiative(baseInitiative2), 5000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [governance.claimForInitiative(baseInitiative2), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [lusd.balanceOf(baseInitiative2), 5000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
  │   💬 Args: [governance.claimForInitiative(EOAInitiative), 10000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 9)
  │   💬 Args: [governance.claimForInitiative(EOAInitiative), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
  │   💬 Args: [lusd.balanceOf(EOAInitiative), 15000e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 11)
  │   💬 Args: [governance.claimForInitiative(baseInitiative2), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 12)
  │   💬 Args: [governance.claimForInitiative(baseInitiative2), 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 13)
      💬 Args: [lusd.balanceOf(baseInitiative2), 5000e18]
      👁️  Def: internal
```
