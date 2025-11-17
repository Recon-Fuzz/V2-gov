# Function: test_unstake()

**Contract**: [test/UserProxy.t.sol/contract_ForkedUserProxyTest.md]

## Metadata

- **Contract**: ForkedUserProxyTest
- **Signature**: `test_unstake()`
- **Visibility**: public
- **Source Range**: 3709:797:105
- **Inherited From**: UserProxyTest

## Implementation

```solidity
function test_unstake() public {
    vm.startPrank(user);
    lqty.approve(address(userProxy), 1e18);
    vm.stopPrank();
    vm.startPrank(address(userProxyFactory));
    userProxy.stake(1e18, user, false, address(0));
    (, , uint256 lusdAmount, , uint256 ethAmount, ) = userProxy.unstake(0, true, user);
    assertEq(lusdAmount, 0);
    assertEq(ethAmount, 0);
    vm.stopPrank();
    vm.warp(block.timestamp + 7 days);
    _addETHGain(stakingV1.totalLQTYStaked());
    _addLUSDGain(stakingV1.totalLQTYStaked());
    vm.startPrank(address(userProxyFactory));
    (, , lusdAmount, , ethAmount, ) = userProxy.unstake(1e18, true, user);
    assertEq(lusdAmount, 1e18);
    assertEq(ethAmount, 1e18);
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

### _addETHGain(uint256)

- **Kind**: internal
- **Source**: 5909:352:105
- **Link**: `test/UserProxy.t.sol:ForkedUserProxyTest:_addETHGain(uint256)`

```solidity
function _addETHGain(uint256 amount) override internal {
    deal(MAINNET_ACTIVE_POOL, MAINNET_ACTIVE_POOL.balance + amount);
    vm.prank(MAINNET_ACTIVE_POOL);
    (bool success, ) = address(stakingV1).call{value: amount}("");
    assert(success);
    vm.prank(MAINNET_TROVE_MANAGER);
    stakingV1.increaseF_ETH(amount);
}
```

### deal(address,uint256)

- **Kind**: internal
- **Source**: 26735:91:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheats:deal(address,uint256)`

```solidity
function deal(address to, uint256 give) virtual internal {
    vm.deal(to, give);
}
```

### _addLUSDGain(uint256)

- **Kind**: internal
- **Source**: 5656:247:105
- **Link**: `test/UserProxy.t.sol:ForkedUserProxyTest:_addLUSDGain(uint256)`

```solidity
function _addLUSDGain(uint256 amount) override internal {
    vm.prank(MAINNET_BORROWER_OPERATIONS);
    stakingV1.increaseF_LUSD(amount);
    vm.prank(MAINNET_BORROWER_OPERATIONS);
    lusd.mint(address(stakingV1), amount);
}
```

## External Calls

- **Vm::startPrank(address)**
- **ILQTY::approve(address,uint256)**
- **Vm::stopPrank()**
- **UserProxy::stake(uint256,address,bool,address)**
- **UserProxy::unstake(uint256,bool,address)**
- **Vm::warp(uint256)**
- **ILQTYStaking::totalLQTYStaked()**

## State Variable Reads

- **user** (`address`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **userProxy** (`contract UserProxy`) [src/UserProxy.sol/contract_UserProxy.md]
- **userProxyFactory** (`contract UserProxyFactory`) [src/UserProxyFactory.sol/contract_UserProxyFactory.md]
- **stakingV1** (`contract ILQTYStaking`) [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxyTest.test_unstake() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 1)
  │   💬 Args: [lusdAmount, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 2)
  │   💬 Args: [ethAmount, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ForkedUserProxyTest._addETHGain(uint256) (NodeID: 3)
  │   💬 Args: [stakingV1.totalLQTYStaked()]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheats.deal(address,uint256) (NodeID: 4)
  │     💬 Args: [MAINNET_ACTIVE_POOL, MAINNET_ACTIVE_POOL.balance + amount]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ForkedUserProxyTest._addLUSDGain(uint256) (NodeID: 5)
  │   💬 Args: [stakingV1.totalLQTYStaked()]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [lusdAmount, 1e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
      💬 Args: [ethAmount, 1e18]
      👁️  Def: internal
```
