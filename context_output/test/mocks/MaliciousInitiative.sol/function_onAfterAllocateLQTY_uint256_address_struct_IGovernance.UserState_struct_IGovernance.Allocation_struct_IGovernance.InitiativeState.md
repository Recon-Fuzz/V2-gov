# Function: onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)

**Contract**: [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]

## Metadata

- **Contract**: MaliciousInitiative
- **Signature**: `onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState)`
- **Visibility**: external
- **Source Range**: 1022:300:109

## Implementation

```solidity
function onAfterAllocateLQTY(uint256, address, IGovernance.UserState calldata, IGovernance.Allocation calldata, IGovernance.InitiativeState calldata) override external view {
    _performRevertBehaviour(revertBehaviours[FunctionType.ALLOCATE]);
}
```

## Related Implementations

### _performRevertBehaviour(enum MaliciousInitiative.RevertType)

- **Kind**: internal
- **Source**: 1483:758:109
- **Link**: `test/mocks/MaliciousInitiative.sol:MaliciousInitiative:_performRevertBehaviour(enum MaliciousInitiative.RevertType)`

```solidity
function _performRevertBehaviour(RevertType action) internal pure {
    if (action == RevertType.THROW) {
        revert("A normal Revert");
    }
    if (action == RevertType.OOG) {
        uint256 i;
        while (true) {
            ++i;
        }
    }
    if (action == RevertType.RETURN_BOMB) {
        uint256 _bytes = 2_000_000;
        assembly {
            return(0, _bytes)
        }
    }
    if (action == RevertType.REVERT_BOMB) {
        uint256 _bytes = 2_000_000;
        assembly {
            revert(0, _bytes)
        }
    }
    return;
}
```

## State Variable Reads

- **revertBehaviours** (`mapping(enum MaliciousInitiative.FunctionType => enum MaliciousInitiative.RevertType)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MaliciousInitiative.onAfterAllocateLQTY(uint256,address,struct IGovernance.UserState,struct IGovernance.Allocation,struct IGovernance.InitiativeState) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MaliciousInitiative._performRevertBehaviour(enum MaliciousInitiative.RevertType) (NodeID: 1)
      💬 Args: [revertBehaviours[FunctionType.ALLOCATE]]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

@notice Callback hook that is called by Governance after the LQTY allocation is updated by a user
 @param _currentEpoch Epoch at which the LQTY allocation is updated
 @param _user Address of the user that updated their LQTY allocation
 @param _userState User state
 @param _allocation Allocation state from user to initiative
 @param _initiativeState Initiative state
