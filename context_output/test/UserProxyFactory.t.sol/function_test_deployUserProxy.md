# Function: test_deployUserProxy()

**Contract**: [test/UserProxyFactory.t.sol/contract_UserProxyFactoryTest.md]

## Metadata

- **Contract**: UserProxyFactoryTest
- **Signature**: `test_deployUserProxy()`
- **Visibility**: public
- **Source Range**: 942:432:106

## Implementation

```solidity
function test_deployUserProxy() public {
    address userProxy = userProxyFactory.deriveUserProxyAddress(user);
    vm.startPrank(user);
    assertEq(userProxyFactory.deployUserProxy(), userProxy);
    vm.expectRevert();
    userProxyFactory.deployUserProxy();
    vm.stopPrank();
    userProxyFactory.deployUserProxy();
    assertEq(userProxyFactory.deriveUserProxyAddress(user), userProxy);
}
```

## Related Implementations

### assertEq(address,address)

- **Kind**: internal
- **Source**: 3454:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address)`

```solidity
function assertEq(address left, address right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **UserProxyFactory::deriveUserProxyAddress(address)**
- **Vm::startPrank(address)**
- **UserProxyFactory::deployUserProxy()**
- **Vm::expectRevert()**
- **Vm::stopPrank()**

## State Variable Reads

- **userProxyFactory** (`contract UserProxyFactory`) [src/UserProxyFactory.sol/contract_UserProxyFactory.md]
- **user** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxyFactoryTest.test_deployUserProxy() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 1)
  │   💬 Args: [userProxyFactory.deployUserProxy(), userProxy]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address) (NodeID: 2)
      💬 Args: [userProxyFactory.deriveUserProxyAddress(user), userProxy]
      👁️  Def: internal
```
