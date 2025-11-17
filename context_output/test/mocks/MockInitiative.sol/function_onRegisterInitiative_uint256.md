# Function: onRegisterInitiative(uint256)

**Contract**: [test/mocks/MockInitiative.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `onRegisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 407:123:112

## Implementation

```solidity
/// @inheritdoc IInitiative
function onRegisterInitiative(uint256) virtual override external {
    governance.registerInitiative(address(0));
}
```

## External Calls

- **IGovernance::registerInitiative(address)**

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.onRegisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IInitiative

### Interface Documentation

@notice Callback hook that is called by Governance after the initiative was successfully registered
 @param _atEpoch Epoch at which the initiative is registered
