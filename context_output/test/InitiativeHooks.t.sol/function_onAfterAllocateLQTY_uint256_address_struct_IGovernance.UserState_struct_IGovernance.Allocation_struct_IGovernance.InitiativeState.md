# Function: onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

**Contract**: [test/InitiativeHooks.t.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 903:434:101

## Implementation

```solidity
function onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState calldata _userState, IGovernance.Allocation calldata _allocation, IGovernance.InitiativeState calldata _initiativeState) override external {
    onAfterAllocateLQTYCalls.push(OnAfterAllocateLQTYParams(_currentEpoch, _user, _userState, _allocation, _initiativeState));
}
```

## State Variable Writes

- **onAfterAllocateLQTYCalls** (`struct MockInitiative.OnAfterAllocateLQTYParams[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
 @param _currentEpoch Epoch at which the LQTY allocation is updated
 @param _user Address of the user that updated their LQTY allocation
 @param _userState User state
 @param _allocation Allocation state from user to initiative
 @param _initiativeState Initiative state
