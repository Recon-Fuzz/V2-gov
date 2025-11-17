# Function: totalSupply()

**Contract**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Metadata

- **Contract**: MockERC20Tester
- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 3144:97:36
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev See {IERC20-totalSupply}.
function totalSupply() virtual public view returns (uint256) {
    return _totalSupply;
}
```

## State Variable Reads

- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.totalSupply() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev See {IERC20-totalSupply}.

### Interface Documentation

 @dev Returns the value of tokens in existence.
