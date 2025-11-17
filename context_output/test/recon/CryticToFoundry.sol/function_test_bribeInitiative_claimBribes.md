# Function: test_bribeInitiative_claimBribes()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `test_bribeInitiative_claimBribes()`
- **Visibility**: public
- **Source Range**: 7310:1099:118

## Implementation

```solidity
function test_bribeInitiative_claimBribes() public {
    switchActor(0);
    uint256 currentEpoch = governance.epoch();
    bribeInitiative_depositBribe(10e18, 5e18, currentEpoch + 1);
    governance_depositLQTY(100e18);
    governance_registerInitiative(address(bribeInitiative));
    vm.warp(block.timestamp + 604800);
    address[] memory initiativesToReset = new address[](0);
    address[] memory initiatives = new address[](1);
    initiatives[0] = address(bribeInitiative);
    int256[] memory votes = new int256[](1);
    votes[0] = 50e18;
    int256[] memory vetos = new int256[](1);
    vetos[0] = 0;
    governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](0);
    bribeInitiative_claimBribes(claimData);
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

### bribeInitiative_depositBribe(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 784:202:123
- **Link**: `test/recon/targets/BribeInitiativeTargets.sol:BribeInitiativeTargets:bribeInitiative_depositBribe(uint256,uint256,uint256)`

```solidity
function bribeInitiative_depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) public asActor() {
    bribeInitiative.depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
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
- **Source**: 1438:120:125
- **Link**: `test/recon/targets/GovernanceTargets.sol:GovernanceTargets:governance_depositLQTY(uint256)`

```solidity
function governance_depositLQTY(uint256 _lqtyAmount) public asActor() {
    governance.depositLQTY(_lqtyAmount);
}
```

### governance_registerInitiative(address)

- **Kind**: internal
- **Source**: 2491:134:125
- **Link**: `test/recon/targets/GovernanceTargets.sol:GovernanceTargets:governance_registerInitiative(address)`

```solidity
function governance_registerInitiative(address _initiative) public asActor() {
    governance.registerInitiative(_initiative);
}
```

### governance_allocateLQTY(address[],address[],int256[],int256[])

- **Kind**: internal
- **Source**: 612:304:125
- **Link**: `test/recon/targets/GovernanceTargets.sol:GovernanceTargets:governance_allocateLQTY(address[],address[],int256[],int256[])`

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function governance_allocateLQTY(address[] memory _initiativesToReset, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory _absoluteLQTYVetos) public asActor() {
    governance.allocateLQTY(_initiativesToReset, _initiatives, _absoluteLQTYVotes, _absoluteLQTYVetos);
}
```

### bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[])

- **Kind**: internal
- **Source**: 622:156:123
- **Link**: `test/recon/targets/BribeInitiativeTargets.sol:BribeInitiativeTargets:bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[])`

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function bribeInitiative_claimBribes(IBribeInitiative.ClaimData[] memory _claimData) public asActor() {
    bribeInitiative.claimBribes(_claimData);
}
```

## External Calls

- **Governance::epoch()**
- **Vm::warp(uint256)**

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)
- **_actor** (`address`)

## State Variable Writes

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CryticToFoundry.test_bribeInitiative_claimBribes() (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: BribeInitiativeTargets.bribeInitiative_depositBribe(uint256,uint256,uint256) (NodeID: 5)
  │   💬 Args: [10e18, 5e18, currentEpoch + 1]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 6)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 7)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GovernanceTargets.governance_depositLQTY(uint256) (NodeID: 8)
  │   💬 Args: [100e18]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 9)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 10)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GovernanceTargets.governance_registerInitiative(address) (NodeID: 11)
  │   💬 Args: [address(bribeInitiative)]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 12)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 13)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GovernanceTargets.governance_allocateLQTY(address[],address[],int256[],int256[]) (NodeID: 14)
  │   💬 Args: [initiativesToReset, initiatives, votes, vetos]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 15)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 16)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: BribeInitiativeTargets.bribeInitiative_claimBribes(struct IBribeInitiative.ClaimData[]) (NodeID: 17)
      💬 Args: [claimData]
      👁️  Def: public
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 18)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 19)
          💬 Args: [no args]
          👁️  Def: internal
```
