# Function: test_governance_claimFromStakingV1()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_governance_claimFromStakingV1()`
- **Visibility**: public
- **Source Range**: 6045:328:118

## Implementation

```solidity
function test_governance_claimFromStakingV1() public {
    switchActor(0);
    address actor = _getActor();
    governance_depositLQTY(10e18);
    governance_claimFromStakingV1(actor);
}
```

## Related Implementations

### switchActor(uint256)

- **Kind**: internal
- **Source**: 680:83:126
- **Link**: `test/recon/targets/ManagersTargets.sol:ManagersTargets:switchActor(uint256)`

```solidity
/// @dev Start acting as another actor
function switchActor(uint256 entropy) public {
    _switchActor(entropy);
}
```

### _switchActor(uint256)

- **Kind**: internal
- **Source**: 2547:143:55
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_switchActor(uint256)`

```solidity
/// @dev Expose this in the `TargetFunctions` contract to let the fuzzer switch actors
///    NOTE: We revert if the entropy is greater than the number of actors, for Halmos compatibility
///  @dev This may reduce fuzzing performance if using multiple actors, if so add explicitly clamped handlers to ManagersTargets using the index of all added actors
///  @notice Switches the current actor based on the entropy
///  @param entropy The entropy to choose a random actor in the array for switching
///  @return target The new active actor
function _switchActor(uint256 entropy) internal returns (address target) {
    target = _actors.at(entropy);
    _actor = target;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 9563:156:57
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 4912:118:57
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
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

### governance_depositLQTY(uint256)

- **Kind**: internal
- **Source**: 5403:120:125
- **Link**: `test/recon/targets/GovernanceTargets.sol:GovernanceTargets:governance_depositLQTY(uint256)`

```solidity
function governance_depositLQTY(uint256 _lqtyAmount) public asActor() {
    governance.depositLQTY(_lqtyAmount);
}
```

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

### governance_claimFromStakingV1(address)

- **Kind**: internal
- **Source**: 5149:144:125
- **Link**: `test/recon/targets/GovernanceTargets.sol:GovernanceTargets:governance_claimFromStakingV1(address)`

```solidity
function governance_claimFromStakingV1(address _rewardRecipient) public asActor() {
    governance.claimFromStakingV1(_rewardRecipient);
}
```

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)
- **_actor** (`address`)

## State Variable Writes

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_governance_claimFromStakingV1() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ManagersTargets.switchActor(uint256) (NodeID: 1)
  │   💬 Args: [0]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ActorManager._switchActor(uint256) (NodeID: 2)
  │     💬 Args: [entropy]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 3)
  │       💬 Args: [_actors, entropy]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 4)
  │         💬 Args: [set._inner, index]
  │         👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GovernanceTargets.governance_depositLQTY(uint256) (NodeID: 6)
  │   💬 Args: [10e18]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 7)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 8)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: GovernanceTargets.governance_claimFromStakingV1(address) (NodeID: 9)
      💬 Args: [actor]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 10)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 11)
          💬 Args: [no args]
          👁️  Def: internal
```
