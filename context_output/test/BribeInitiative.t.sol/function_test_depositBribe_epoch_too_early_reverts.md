# Function: test_depositBribe_epoch_too_early_reverts()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_depositBribe_epoch_too_early_reverts()`
- **Visibility**: public
- **Source Range**: 28401:365:92

## Implementation

```solidity
///  Revert Cases
function test_depositBribe_epoch_too_early_reverts() public {
    vm.startPrank(lusdHolder);
    lqty.approve(address(bribeInitiative), 1e18);
    lusd.approve(address(bribeInitiative), 1e18);
    vm.expectRevert("BribeInitiative: now-or-future-epochs");
    bribeInitiative.depositBribe(1e18, 1e18, uint256(0));
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **MockERC20Tester::approve(address,uint256)**
- **Vm::expectRevert(bytes)**
- **BribeInitiative::depositBribe(uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **lusdHolder** (`address`)
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_depositBribe_epoch_too_early_reverts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 Revert Cases
