# Function: test_stakeViaPermit()

**Contract**: [test/UserProxy.t.sol/contract_ForkedUserProxyTest.md]

## Metadata

- **Contract**: ForkedUserProxyTest
- **Signature**: `test_stakeViaPermit()`
- **Visibility**: public
- **Source Range**: 1646:2057:105
- **Inherited From**: UserProxyTest

## Implementation

```solidity
function test_stakeViaPermit() public {
    vm.startPrank(user);
    VmSafe.Wallet memory wallet = vm.createWallet(uint256(keccak256(bytes("1"))));
    lqty.transfer(wallet.addr, 1e18);
    vm.stopPrank();
    vm.startPrank(wallet.addr);
    userProxy = UserProxy(payable(userProxyFactory.deployUserProxy()));
    PermitParams memory permitParams = PermitParams({owner: wallet.addr, spender: address(userProxy), value: 1e18, deadline: block.timestamp + 86400, v: 0, r: "", s: ""});
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(wallet.privateKey, keccak256(abi.encodePacked("\u0019\u0001", ILQTY(address(lqty)).domainSeparator(), keccak256(abi.encode(0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9, permitParams.owner, permitParams.spender, permitParams.value, 0, permitParams.deadline)))));
    permitParams.v = v;
    permitParams.r = r;
    permitParams.s = s;
    vm.stopPrank();
    vm.startPrank(user);
    lqty.approve(address(userProxy), 1e18);
    vm.stopPrank();
    vm.startPrank(address(userProxyFactory));
    vm.expectRevert();
    userProxy.stakeViaPermit(0.5e18, user, permitParams, false, address(0));
    userProxy.stakeViaPermit(0.5e18, wallet.addr, permitParams, false, address(0));
    userProxy.stakeViaPermit(0.5e18, wallet.addr, permitParams, false, address(0));
    vm.expectRevert();
    userProxy.stakeViaPermit(1, wallet.addr, permitParams, false, address(0));
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::createWallet(uint256)**
- **ILQTY::transfer(address,uint256)**
- **Vm::stopPrank()**
- **UserProxyFactory::deployUserProxy()**
- **Vm::sign(uint256,bytes32)**
- **ILQTY::domainSeparator()**
- **ILQTY::approve(address,uint256)**
- **Vm::expectRevert()**
- **UserProxy::stakeViaPermit(uint256,address,struct PermitParams,bool,address)**

## Native Transfers

- **lqty** (computed)

## State Variable Reads

- **user** (`address`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **userProxyFactory** (`contract UserProxyFactory`) [src/UserProxyFactory.sol/contract_UserProxyFactory.md]
- **userProxy** (`contract UserProxy`) [src/UserProxy.sol/contract_UserProxy.md]

## State Variable Writes

- **userProxy** (`contract UserProxy`) [src/UserProxy.sol/contract_UserProxy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxyTest.test_stakeViaPermit() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
