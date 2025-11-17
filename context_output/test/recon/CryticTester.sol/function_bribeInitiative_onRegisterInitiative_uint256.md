# Function: bribeInitiative_onRegisterInitiative(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `bribeInitiative_onRegisterInitiative(uint256)`
- **Visibility**: public
- **Source Range**: 1496:127:123
- **Inherited From**: BribeInitiativeTargets

## Implementation

```solidity
function bribeInitiative_onRegisterInitiative(uint256) public asActor() {
    bribeInitiative.onRegisterInitiative(0);
}
```

## Related Implementations

### asActor()

- **Kind**: modifier
- **Source**: 4973:75:120
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:55
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

## External Calls

- **BribeInitiative::onRegisterInitiative(uint256)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTargets.bribeInitiative_onRegisterInitiative(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
