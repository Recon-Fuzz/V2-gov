# Function: constructor(address)

**Contract**: [test/mocks/MockInitiative.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 282:87:112

## Implementation

```solidity
constructor(address _governance) {
    governance = IGovernance(_governance);
}
```

## State Variable Writes

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockInitiative.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockInitiative
```
