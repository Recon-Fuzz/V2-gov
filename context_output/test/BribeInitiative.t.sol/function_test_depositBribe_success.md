# Function: test_depositBribe_success()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_depositBribe_success()`
- **Visibility**: public
- **Source Range**: 10770:292:92

## Implementation

```solidity
function test_depositBribe_success() public {
    vm.startPrank(lusdHolder);
    lqty.approve(address(bribeInitiative), 1e18);
    lusd.approve(address(bribeInitiative), 1e18);
    bribeInitiative.depositBribe(1e18, 1e18, governance.epoch() + 1);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **MockERC20Tester::approve(address,uint256)**
- **BribeInitiative::depositBribe(uint256,uint256,uint256)**
- **Governance::epoch()**
- **Vm::stopPrank()**

## State Variable Reads

- **lusdHolder** (`address`)
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_depositBribe_success() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
