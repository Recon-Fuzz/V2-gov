# Function: _depositBribe(uint256,uint256,uint256)

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `_depositBribe(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 42379:343:92

## Implementation

```solidity
function _depositBribe(uint256 boldAmount, uint256 bribeAmount, uint256 epoch) public {
    vm.startPrank(lusdHolder);
    lusd.approve(address(bribeInitiative), boldAmount);
    lqty.approve(address(bribeInitiative), bribeAmount);
    bribeInitiative.depositBribe(boldAmount, bribeAmount, epoch);
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
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest._depositBribe(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
