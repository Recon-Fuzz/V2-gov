# Function: test_unregisterInitiative()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_unregisterInitiative()`
- **Visibility**: public
- **Source Range**: 22575:1667:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_unregisterInitiative() public {
    vm.startPrank(lusdHolder);
    lusd.transfer(user, 1e18);
    vm.stopPrank();
    vm.startPrank(user);
    vm.expectRevert("Governance: cannot-unregister-initiative");
    governance.unregisterInitiative(baseInitiative3);
    vm.warp(block.timestamp + (2 * EPOCH_DURATION));
    assertEq(governance.epoch(), 3, "We should be in epoch #3");
    lusd.approve(address(governance), 1e18);
    governance.registerInitiative(baseInitiative3);
    vm.expectRevert("Governance: cannot-unregister-initiative");
    /// @audit should fail due to not waiting enough time
    governance.unregisterInitiative(baseInitiative3);
    vm.warp(block.timestamp + EPOCH_DURATION);
    vm.expectRevert("Governance: cannot-unregister-initiative");
    governance.unregisterInitiative(baseInitiative3);
    vm.warp(block.timestamp + (EPOCH_DURATION * UNREGISTRATION_AFTER_EPOCHS));
    governance.unregisterInitiative(baseInitiative3);
    vm.stopPrank();
    vm.startPrank(lusdHolder);
    lusd.transfer(user, 1e18);
    vm.stopPrank();
    vm.startPrank(user);
    lusd.approve(address(governance), 1e18);
    vm.expectRevert("Governance: initiative-already-registered");
    governance.registerInitiative(baseInitiative3);
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
- **ILUSD::transfer(address,uint256)**
- **Vm::stopPrank()**
- **Vm::expectRevert(bytes)**
- **GovernanceTester::unregisterInitiative(address)**
- **Vm::warp(uint256)**
- **GovernanceTester::epoch()**
- **ILUSD::approve(address,uint256)**
- **GovernanceTester::registerInitiative(address)**

## Native Transfers

- **lusd** (computed)

## State Variable Reads

- **lusdHolder** (`address`)
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **baseInitiative3** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_unregisterInitiative() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [governance.epoch(), 3, "We should be in epoch #3"]
      👁️  Def: internal
```
