# Function: onUnregisterInitiative(uint256)

**Contract**: [test/mocks/MockInitiative.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `onUnregisterInitiative(uint256)`
- **Visibility**: external
- **Source Range**: 568:127:112

## Implementation

```solidity
/// @inheritdoc IInitiative
function onUnregisterInitiative(uint256) virtual override external {
    governance.unregisterInitiative(address(0));
}
```

## External Calls

- **IGovernance::unregisterInitiative(address)**

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.onUnregisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IInitiative

### Interface Documentation

@notice Callback hook that is called by Governance after the initiative was unregistered
 @param _atEpoch Epoch at which the initiative is unregistered
