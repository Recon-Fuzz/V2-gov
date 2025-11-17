# Function: onClaimForInitiative(uint256,uint256)

**Contract**: [test/mocks/MockInitiative.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1255:132:112

## Implementation

```solidity
/// @inheritdoc IInitiative
function onClaimForInitiative(uint256, uint256) virtual override external {
    governance.claimForInitiative(address(0));
}
```

## External Calls

- **IGovernance::claimForInitiative(address)**

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.onClaimForInitiative(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IInitiative

### Interface Documentation

@notice Callback hook that is called by Governance after the claim for the last epoch was distributed
 to the initiative
 @param _claimEpoch Epoch at which the claim was distributed
 @param _bold Amount of BOLD that was distributed
