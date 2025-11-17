# Function: onClaimForInitiative(uint256,uint256)

**Contract**: [src/UniV4MerklRewards.sol/contract_UniV4MerklRewards.md]

## Metadata

- **Contract**: UniV4MerklRewards
- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 4905:101:68

## Implementation

```solidity
/// @notice Callback hook that is called by Governance after the claim for the last epoch was distributed
///  to the initiative
///  @param _claimEpoch Epoch at which the claim was distributed
///  @param _bold Amount of BOLD that was distributed
function onClaimForInitiative(uint256 _claimEpoch, uint256 _bold) override external onlyGovernance() {}
```

## Related Implementations

### onlyGovernance()

- **Kind**: modifier
- **Source**: 1383:136:68
- **Link**: `src/UniV4MerklRewards.sol:UniV4MerklRewards:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    require(msg.sender == address(governance), "UniV4MerklInitiative: invalid-sender");
    _;
}
```

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklRewards.onClaimForInitiative(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: UniV4MerklRewards.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@notice Callback hook that is called by Governance after the claim for the last epoch was distributed
 to the initiative
 @param _claimEpoch Epoch at which the claim was distributed
 @param _bold Amount of BOLD that was distributed

### Interface Documentation

@notice Callback hook that is called by Governance after the claim for the last epoch was distributed
 to the initiative
 @param _claimEpoch Epoch at which the claim was distributed
 @param _bold Amount of BOLD that was distributed
