# Function: onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

**Contract**: [test/mocks/UniV4MerklRewardsWrapper.sol/contract_UniV4MerklRewardsWrapper.md]

## Metadata

- **Contract**: UniV4MerklRewardsWrapper
- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 4362:276:68
- **Inherited From**: UniV4MerklRewards

## Implementation

```solidity
/// @notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
///  @param _currentEpoch Epoch at which the LQTY allocation is updated
///  @param _user Address of the user that updated their LQTY allocation
///  @param _userState User state
///  @param _allocation Allocation state from user to initiative
///  @param _initiativeState Initiative state
function onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState calldata _userState, IGovernance.Allocation calldata _allocation, IGovernance.InitiativeState calldata _initiativeState) override external {}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklRewards.onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
 @param _currentEpoch Epoch at which the LQTY allocation is updated
 @param _user Address of the user that updated their LQTY allocation
 @param _userState User state
 @param _allocation Allocation state from user to initiative
 @param _initiativeState Initiative state

### Interface Documentation

@notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
 @param _currentEpoch Epoch at which the LQTY allocation is updated
 @param _user Address of the user that updated their LQTY allocation
 @param _userState User state
 @param _allocation Allocation state from user to initiative
 @param _initiativeState Initiative state
