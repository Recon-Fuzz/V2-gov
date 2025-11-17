# Function: constructor(string,string)

**Contract**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Metadata

- **Contract**: MockERC20Tester
- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 694:114:110

## Implementation

```solidity
constructor(string memory name, string memory symbol) ERC20Permit(name) ERC20(name,symbol) Ownable(msg.sender) {}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 1225:187:31
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:constructor(address)`

```solidity
///  @dev Initializes the contract setting the address provided by the deployer as the initial owner.
constructor(address initialOwner) {
    if (initialOwner == address(0)) {
        revert OwnableInvalidOwner(address(0));
    }
    _transferOwnership(initialOwner);
}
```

### _transferOwnership(address)

- **Kind**: internal
- **Source**: 2912:187:31
- **Link**: `lib/openzeppelin-contracts/contracts/access/Ownable.sol:Ownable:_transferOwnership(address)`

```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Internal function without access restriction.
function _transferOwnership(address newOwner) virtual internal {
    address oldOwner = _owner;
    _owner = newOwner;
    emit OwnershipTransferred(oldOwner, newOwner);
}
```

### (string,string)

- **Kind**: internal
- **Source**: 1896:113:36
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:constructor(string,string)`

```solidity
///  @dev Sets the values for {name} and {symbol}.
///  All two of these values are immutable: they can only be set once during
///  construction.
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

### (string)

- **Kind**: internal
- **Source**: 1574:52:38
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol:ERC20Permit:constructor(string)`

```solidity
///  @dev Initializes the {EIP712} domain separator using the `name` parameter, and setting `version` to `"1"`.
///  It's a good idea to use the same `name` that is defined as the ERC20 token name.
constructor(string memory name) EIP712(name,"1") {}
```

### (string,string)

- **Kind**: internal
- **Source**: 3328:431:50
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:constructor(string,string)`

```solidity
///  @dev Initializes the domain separator and parameter caches.
///  The meaning of `name` and `version` is specified in
///  https://eips.ethereum.org/EIPS/eip-712#definition-of-domainseparator[EIP 712]:
///  - `name`: the user readable name of the signing domain, i.e. the name of the DApp or the protocol.
///  - `version`: the current major version of the signing domain.
///  NOTE: These parameters cannot be changed except through a xref:learn::upgrading-smart-contracts.adoc[smart
///  contract upgrade].
constructor(string memory name, string memory version) {
    _name = name.toShortStringWithFallback(_nameFallback);
    _version = version.toShortStringWithFallback(_versionFallback);
    _hashedName = keccak256(bytes(name));
    _hashedVersion = keccak256(bytes(version));
    _cachedChainId = block.chainid;
    _cachedDomainSeparator = _buildDomainSeparator();
    _cachedThis = address(this);
}
```

### toShortStringWithFallback(string,string)

- **Kind**: internal
- **Source**: 2914:340:46
- **Link**: `lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toShortStringWithFallback(string,string)`

```solidity
///  @dev Encode a string into a `ShortString`, or write it to storage if it is too long.
function toShortStringWithFallback(string memory value, string storage store) internal returns (ShortString) {
    if (bytes(value).length < 32) {
        return toShortString(value);
    } else {
        StorageSlot.getStringSlot(store).value = value;
        return ShortString.wrap(FALLBACK_SENTINEL);
    }
}
```

### toShortString(string)

- **Kind**: internal
- **Source**: 1708:286:46
- **Link**: `lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol:ShortStrings:toShortString(string)`

```solidity
///  @dev Encode a string of at most 31 chars into a `ShortString`.
///  This will trigger a `StringTooLong` error is the input string is too long.
function toShortString(string memory str) internal pure returns (ShortString) {
    bytes memory bstr = bytes(str);
    if (bstr.length > 31) {
        revert StringTooLong(str);
    }
    return ShortString.wrap(bytes32(uint256(bytes32(bstr)) | bstr.length));
}
```

### getStringSlot(string)

- **Kind**: internal
- **Source**: 3135:202:47
- **Link**: `lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol:StorageSlot:getStringSlot(string)`

```solidity
///  @dev Returns an `StringSlot` representation of the string storage pointer `store`.
function getStringSlot(string storage store) internal pure returns (StringSlot storage r) {
    /// @solidity memory-safe-assembly
    assembly {
        r.slot := store.slot
    }
}
```

### _buildDomainSeparator()

- **Kind**: internal
- **Source**: 4113:179:50
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_buildDomainSeparator()`

```solidity
function _buildDomainSeparator() private view returns (bytes32) {
    return keccak256(abi.encode(TYPE_HASH, _hashedName, _hashedVersion, block.chainid, address(this)));
}
```

## State Variable Reads

- **_owner** (`address`)
- **_nameFallback** (`string`)
- **_versionFallback** (`string`)
- **FALLBACK_SENTINEL** (`bytes32`)
- **TYPE_HASH** (`bytes32`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)

## State Variable Writes

- **_owner** (`address`)
- **_name** (`string`)
- **_symbol** (`string`)
- **_version** (`ShortString`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)
- **_cachedChainId** (`uint256`)
- **_cachedDomainSeparator** (`bytes32`)
- **_cachedThis** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MockERC20Tester.constructor(string,string) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MockERC20Tester
  ├─ [1] 🏗️ CONSTRUCTOR: Ownable.constructor(address) (NodeID: 1)
  │   💬 Args: [msg.sender]
  │   🏗️  Contract: Ownable
  │ └─ [2] ⚙️ FUNCTION: Ownable._transferOwnership(address) (NodeID: 2)
  │     💬 Args: [initialOwner]
  │     👁️  Def: internal
  ├─ [1] 🏗️ CONSTRUCTOR: ERC20.constructor(string,string) (NodeID: 3)
  │   💬 Args: [name, symbol]
  │   🏗️  Contract: ERC20
  └─ [1] 🏗️ CONSTRUCTOR: ERC20Permit.constructor(string) (NodeID: 4)
      💬 Args: [name]
      🏗️  Contract: ERC20Permit
    └─ [2] 🏗️ CONSTRUCTOR: EIP712.constructor(string,string) (NodeID: 5)
        💬 Args: [name, "1"]
        🏗️  Contract: EIP712
      ├─ [3] ⚙️ FUNCTION: ShortStrings.toShortStringWithFallback(string,string) (NodeID: 6)
      │   💬 Args: [name, _nameFallback]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: ShortStrings.toShortString(string) (NodeID: 7)
      │ │   💬 Args: [value]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: StorageSlot.getStringSlot(string) (NodeID: 8)
      │     💬 Args: [store]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: ShortStrings.toShortStringWithFallback(string,string) (NodeID: 9)
      │   💬 Args: [version, _versionFallback]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: ShortStrings.toShortString(string) (NodeID: 10)
      │ │   💬 Args: [value]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: StorageSlot.getStringSlot(string) (NodeID: 11)
      │     💬 Args: [store]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EIP712._buildDomainSeparator() (NodeID: 12)
          💬 Args: [no args]
          👁️  Def: private
```
