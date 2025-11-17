# Function: setUp()

**Contract**: [test/UserProxyFactory.t.sol/contract_UserProxyFactoryTest.md]

## Metadata

- **Contract**: UserProxyFactoryTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 815:121:106

## Implementation

```solidity
function setUp() public {
    userProxyFactory = new UserProxyFactory(address(lqty), address(lusd), stakingV1);
}
```

## State Variable Reads

- **lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **lusd** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **stakingV1** (`address`)

## State Variable Writes

- **userProxyFactory** (`contract UserProxyFactory`) [src/UserProxyFactory.sol/contract_UserProxyFactory.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UserProxyFactoryTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
