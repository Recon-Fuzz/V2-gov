# Function: onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

**Contract**: [test/mocks/MockInitiative.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 733:484:112

## Implementation

```solidity
/// @inheritdoc IInitiative
function onAfterAllocateLQTY(uint256, address, IGovernance.UserState calldata, IGovernance.Allocation calldata, IGovernance.InitiativeState calldata) virtual external {
    address[] memory initiatives = new address[](0);
    int256[] memory deltaLQTYVotes = new int256[](0);
    int256[] memory deltaLQTYVetos = new int256[](0);
    governance.allocateLQTY(initiatives, initiatives, deltaLQTYVotes, deltaLQTYVetos);
}
```

## External Calls

- **IGovernance::allocateLQTY(address[],address[],int256[],int256[])**

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IInitiative

### Interface Documentation

@notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
 @param _currentEpoch Epoch at which the LQTY allocation is updated
 @param _user Address of the user that updated their LQTY allocation
 @param _userState User state
 @param _allocation Allocation state from user to initiative
 @param _initiativeState Initiative state
