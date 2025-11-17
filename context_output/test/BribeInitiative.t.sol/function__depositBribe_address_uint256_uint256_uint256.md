# Function: _depositBribe(address,uint256,uint256,uint256)

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `_depositBribe(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 42728:351:92

## Implementation

```solidity
function _depositBribe(address _initiative, uint256 boldAmount, uint256 bribeAmount, uint256 epoch) public {
    vm.startPrank(lusdHolder);
    lusd.approve(_initiative, boldAmount);
    lqty.approve(_initiative, bribeAmount);
    BribeInitiative(_initiative).depositBribe(boldAmount, bribeAmount, epoch);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **MockERC20Tester::approve(address,uint256)**
- **BribeInitiative::depositBribe(uint256,uint256,uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **lusdHolder** (`address`)
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(address,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
