# Function: onClaimForInitiative(uint256,uint256)

**Contract**: [src/BribeInitiative.sol/contract_BribeInitiative.md]

## Metadata

- **Contract**: BribeInitiative
- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 9726:91:65

## Implementation

```solidity
/// @inheritdoc IInitiative
function onClaimForInitiative(uint256, uint256) virtual override external onlyGovernance() {}
```

## Related Implementations

### onlyGovernance()

- **Kind**: modifier
- **Source**: 1897:131:65
- **Link**: `src/BribeInitiative.sol:BribeInitiative:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    require(msg.sender == address(governance), "BribeInitiative: invalid-sender");
    _;
}
```

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.onClaimForInitiative(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: BribeInitiative.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IInitiative

### Interface Documentation

@notice Callback hook that is called by Governance after the claim for the last epoch was distributed
 to the initiative
 @param _claimEpoch Epoch at which the claim was distributed
 @param _bold Amount of BOLD that was distributed
