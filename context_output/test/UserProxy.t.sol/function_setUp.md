# Function: setUp()

**Contract**: [test/UserProxy.t.sol/contract_ForkedUserProxyTest.md]

## Metadata

- **Contract**: ForkedUserProxyTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 5396:254:105

## Implementation

```solidity
function setUp() override public {
    vm.createSelectFork(vm.rpcUrl("mainnet"), 20430000);
    lqty = ILQTY(MAINNET_LQTY);
    lusd = ILUSD(MAINNET_LUSD);
    stakingV1 = ILQTYStaking(MAINNET_LQTY_STAKING);
    super.setUp();
}
```

## Related Implementations

### setUp()

- **Kind**: internal
- **Source**: 1032:214:105
- **Link**: `test/UserProxy.t.sol:UserProxyTest:setUp()`

```solidity
function setUp() virtual public {
    userProxyFactory = new UserProxyFactory(address(lqty), address(lusd), address(stakingV1));
    userProxy = UserProxy(payable(userProxyFactory.deployUserProxy()));
}
```

## External Calls

- **Vm::createSelectFork(string,uint256)**
- **Vm::rpcUrl(string)**

## State Variable Reads

- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **stakingV1** (`contract ILQTYStaking`) [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **userProxyFactory** (`contract UserProxyFactory`) [src/UserProxyFactory.sol/contract_UserProxyFactory.md]

## State Variable Writes

- **userProxyFactory** (`contract UserProxyFactory`) [src/UserProxyFactory.sol/contract_UserProxyFactory.md]
- **userProxy** (`contract UserProxy`) [src/UserProxy.sol/contract_UserProxy.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ForkedUserProxyTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: UserProxyTest.setUp() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```
