# Function: constructor(address,address,address)

**Contract**: [test/Governance.t.sol/contract_GovernanceTester.md]

## Metadata

- **Contract**: GovernanceTester
- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 382:153:70
- **Inherited From**: UserProxyFactory

## Implementation

```solidity
constructor(address _lqty, address _lusd, address _stakingV1) {
    userProxyImplementation = address(new UserProxy(_lqty, _lusd, _stakingV1));
}
```

## State Variable Writes

- **userProxyImplementation** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: UserProxyFactory.constructor(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: UserProxyFactory
```
