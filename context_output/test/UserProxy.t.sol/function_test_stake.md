# Function: test_stake()

**Contract**: [test/UserProxy.t.sol/contract_ForkedUserProxyTest.md]

## Metadata

- **Contract**: ForkedUserProxyTest
- **Signature**: `test_stake()`
- **Visibility**: public
- **Source Range**: 1372:268:105
- **Inherited From**: UserProxyTest

## Implementation

```solidity
function test_stake() public {
    vm.startPrank(user);
    lqty.approve(address(userProxy), 1e18);
    vm.stopPrank();
    vm.startPrank(address(userProxyFactory));
    userProxy.stake(1e18, user, false, address(0));
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **ILQTY::approve(address,uint256)**
- **Vm::stopPrank()**
- **UserProxy::stake(uint256,address,bool,address)**

## State Variable Reads

- **user** (`address`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **userProxy** (`contract UserProxy`) [src/UserProxy.sol/contract_UserProxy.md]
- **userProxyFactory** (`contract UserProxyFactory`) [src/UserProxyFactory.sol/contract_UserProxyFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxyTest.test_stake() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
