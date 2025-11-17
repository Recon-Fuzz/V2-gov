# Function: onClaimForInitiative(uint256,uint256)

**Contract**: [test/InitiativeHooks.t.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1473:68:101

## Implementation

```solidity
function onClaimForInitiative(uint256, uint256) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.onClaimForInitiative(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Callback hook that is called by Governance after the claim for the last epoch was distributed
 to the initiative
 @param _claimEpoch Epoch at which the claim was distributed
 @param _bold Amount of BOLD that was distributed
