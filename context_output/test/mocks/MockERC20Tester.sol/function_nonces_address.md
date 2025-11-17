# Function: nonces(address)

**Contract**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Metadata

- **Contract**: MockERC20Tester
- **Signature**: `nonces(address)`
- **Visibility**: public
- **Source Range**: 954:148:110

## Implementation

```solidity
function nonces(address owner) virtual override(IERC20Permit, ERC20Permit) public view returns (uint256) {
    return super.nonces(owner);
}
```

## Related Implementations

### nonces(address)

- **Kind**: internal
- **Source**: 2406:143:38
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol:ERC20Permit:nonces(address)`

```solidity
///  @inheritdoc IERC20Permit
function nonces(address owner) virtual override(IERC20Permit, Nonces) public view returns (uint256) {
    return super.nonces(owner);
}
```

### nonces(address)

- **Kind**: internal
- **Source**: 538:107:44
- **Link**: `lib/openzeppelin-contracts/contracts/utils/Nonces.sol:Nonces:nonces(address)`

```solidity
///  @dev Returns the next unused nonce for an address.
function nonces(address owner) virtual public view returns (uint256) {
    return _nonces[owner];
}
```

## State Variable Reads

- **_nonces** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20Tester.nonces(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20Permit.nonces(address) (NodeID: 1)
      💬 Args: [owner]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: Nonces.nonces(address) (NodeID: 2)
        💬 Args: [owner]
        👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the current nonce for `owner`. This value must be
 included whenever a signature is generated for {permit}.
 Every successful call to {permit} increases ``owner``'s nonce by one. This
 prevents a signature from being used multiple times.
