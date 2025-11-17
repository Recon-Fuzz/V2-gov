# Function: allowance(address,address)

**Contract**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Metadata

- **Contract**: MockERC20Tester
- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 1108:222:110

## Implementation

```solidity
function allowance(address owner, address spender) virtual override(IERC20, ERC20) public view returns (uint256) {
    return mock_isWildcardSpender[spender] ? type(uint256).max : super.allowance(owner, spender);
}
```

## Related Implementations

### allowance(address,address)

- **Kind**: internal
- **Source**: 3846:140:36
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol:ERC20:allowance(address,address)`

```solidity
///  @dev See {IERC20-allowance}.
function allowance(address owner, address spender) virtual public view returns (uint256) {
    return _allowances[owner][spender];
}
```

## State Variable Reads

- **mock_isWildcardSpender** (`mapping(address => bool)`)
- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockERC20Tester.allowance(address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC20.allowance(address,address) (NodeID: 1)
      💬 Args: [owner, spender]
      👁️  Def: public
```

## Documentation

### Interface Documentation

 @dev Returns the remaining number of tokens that `spender` will be
 allowed to spend on behalf of `owner` through {transferFrom}. This is
 zero by default.
 This value changes when {approve} or {transferFrom} are called.
