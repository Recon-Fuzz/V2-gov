# Function: onClaimForInitiative(uint256,uint256)

**Contract**: [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]

## Metadata

- **Contract**: MaliciousInitiative
- **Signature**: `onClaimForInitiative(uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1328:149:109

## Implementation

```solidity
function onClaimForInitiative(uint256, uint256) override external view {
    _performRevertBehaviour(revertBehaviours[FunctionType.CLAIM]);
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
┌─ [0] ⚙️ FUNCTION: MaliciousInitiative.onClaimForInitiative(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MaliciousInitiative._performRevertBehaviour(enum MaliciousInitiative.RevertType) (NodeID: 1)
      💬 Args: [revertBehaviours[FunctionType.CLAIM]]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

@notice Callback hook that is called by Governance after the claim for the last epoch was distributed
 to the initiative
 @param _claimEpoch Epoch at which the claim was distributed
 @param _bold Amount of BOLD that was distributed
