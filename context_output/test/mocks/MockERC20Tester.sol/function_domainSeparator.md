# Function: domainSeparator()

**Contract**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Metadata

- **Contract**: MockERC20Tester
- **Signature**: `domainSeparator()`
- **Visibility**: external
- **Source Range**: 845:103:110

## Implementation

```solidity
function domainSeparator() external view returns (bytes32) {
    return _domainSeparatorV4();
}
```

## Related Implementations

### _domainSeparatorV4()

- **Kind**: internal
- **Source**: 3845:262:50
- **Link**: `lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol:EIP712:_domainSeparatorV4()`

```solidity
///  @dev Returns the domain separator for the current chain.
function _domainSeparatorV4() internal view returns (bytes32) {
    if ((address(this) == _cachedThis) && (block.chainid == _cachedChainId)) {
        return _cachedDomainSeparator;
    } else {
        return _buildDomainSeparator();
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

- **_cachedThis** (`address`)
- **_cachedChainId** (`uint256`)
- **_cachedDomainSeparator** (`bytes32`)
- **TYPE_HASH** (`bytes32`)
- **_hashedName** (`bytes32`)
- **_hashedVersion** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20Tester.domainSeparator() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: EIP712._domainSeparatorV4() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EIP712._buildDomainSeparator() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: private
```
