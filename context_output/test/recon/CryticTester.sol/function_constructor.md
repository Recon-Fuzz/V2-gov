# Function: constructor()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 360:46:117

## Implementation

```solidity
constructor() payable {
    setup();
}
```

## Related Implementations

### setup()

- **Kind**: internal
- **Source**: 1243:3589:120
- **Link**: `test/recon/Setup.sol:Setup:setup()`

```solidity
/// === Setup === ///
///  This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
function setup() virtual override internal {
    _addActor(address(0x100));
    _addActor(address(0x200));
    lqty = new MockERC20Tester("Liquity", "LQTY");
    lusd = new MockERC20Tester("Liquity USD", "LUSD");
    bold = new MockERC20Tester("BOLD Stablecoin", "BOLD");
    bribeToken = new MockERC20Tester("Bribe Token", "BRYB");
    stakingV1 = new MockStakingV1(lqty, lusd);
    lqty.mock_setWildcardSpender(address(stakingV1), true);
    IGovernance.Configuration memory config = IGovernance.Configuration({registrationFee: 1e18, registrationThresholdFactor: 0.01e18, unregistrationThresholdFactor: 4e18, unregistrationAfterEpochs: 4, votingThresholdFactor: 0.04e18, minClaim: 500e18, minAccrual: 1000e18, epochStart: block.timestamp - (604800 * 3), epochDuration: 604800, epochVotingCutoff: 518400});
    address[] memory initialInitiatives = new address[](0);
    governance = new Governance(address(lqty), address(lusd), address(stakingV1), address(bold), config, address(this), initialInitiatives);
    bribeInitiative = new BribeInitiative(address(governance), address(bold), address(bribeToken));
    address[] memory actors = _getActors();
    uint256 mintAmount = type(uint88).max;
    for (uint256 i = 0; i < actors.length; i++) {
        lqty.mint(actors[i], mintAmount);
        lusd.mint(actors[i], mintAmount);
        bold.mint(actors[i], mintAmount);
        bribeToken.mint(actors[i], mintAmount);
    }
    for (uint256 i = 0; i < actors.length; i++) {
        address userProxy = governance.deriveUserProxyAddress(actors[i]);
        address[] memory approvalArray = new address[](4);
        approvalArray[0] = address(governance);
        approvalArray[1] = address(bribeInitiative);
        approvalArray[2] = address(stakingV1);
        approvalArray[3] = userProxy;
        for (uint256 j = 0; j < approvalArray.length; j++) {
            vm.prank(actors[i]);
            lqty.approve(approvalArray[j], type(uint256).max);
            vm.prank(actors[i]);
            lusd.approve(approvalArray[j], type(uint256).max);
            vm.prank(actors[i]);
            bold.approve(approvalArray[j], type(uint256).max);
            vm.prank(actors[i]);
            bribeToken.approve(approvalArray[j], type(uint256).max);
        }
    }
    _addAsset(address(lqty));
    _addAsset(address(lusd));
    _addAsset(address(bold));
    _addAsset(address(bribeToken));
}
```

### _addActor(address)

- **Kind**: internal
- **Source**: 1411:250:55
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_addActor(address)`

```solidity
/// @notice Adds an actor to the list of actors
function _addActor(address target) internal {
    if (_actors.contains(target)) {
        revert ActorExists();
    }
    if (target == address(this)) {
        revert DefaultActor();
    }
    _actors.add(target);
}
```

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8860:165:57
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4255:127:57
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._indexes[value] != 0;
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8305:150:57
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2214:404:57
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._indexes[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _getActors()

- **Kind**: internal
- **Source**: 1250:103:55
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActors()`

```solidity
/// @notice Returns all actors being used
function _getActors() internal view returns (address[] memory) {
    return _actors.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:57
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:57
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
}
```

### _addAsset(address)

- **Kind**: internal
- **Source**: 1878:160:56
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_addAsset(address)`

```solidity
/// @notice Adds an asset to the list of assets
///  @param target The address of the asset to add
function _addAsset(address target) internal {
    if (_assets.contains(target)) {
        revert Exists();
    }
    _assets.add(target);
}
```

## State Variable Reads

- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeToken** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_assets** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bribeToken** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_assets** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: CryticTester.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: CryticTester
  └─ [1] ⚙️ FUNCTION: Setup.setup() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 2)
    │   💬 Args: [address(0x100)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 3)
    │ │   💬 Args: [_actors, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 4)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 5)
    │     💬 Args: [_actors, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 6)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 8)
    │   💬 Args: [address(0x200)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 9)
    │ │   💬 Args: [_actors, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 10)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 11)
    │     💬 Args: [_actors, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 12)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 13)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 14)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 15)
    │     💬 Args: [_actors]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 16)
    │       💬 Args: [set._inner]
    │       👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 17)
    │   💬 Args: [address(lqty)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 18)
    │ │   💬 Args: [_assets, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 19)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 20)
    │     💬 Args: [_assets, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 21)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 22)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 23)
    │   💬 Args: [address(lusd)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 24)
    │ │   💬 Args: [_assets, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 25)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 26)
    │     💬 Args: [_assets, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 27)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 28)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 29)
    │   💬 Args: [address(bold)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 30)
    │ │   💬 Args: [_assets, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 31)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 32)
    │     💬 Args: [_assets, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 33)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 34)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    └─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 35)
        💬 Args: [address(bribeToken)]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 36)
      │   💬 Args: [_assets, target]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 37)
      │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
      │     👁️  Def: private
      └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 38)
          💬 Args: [_assets, target]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 39)
            💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
            👁️  Def: private
          └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 40)
              💬 Args: [set, value]
              👁️  Def: private
```
