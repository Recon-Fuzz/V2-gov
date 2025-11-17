# Function: symbol()

**Contract**: [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Metadata

- **Contract**: MockERC20Tester
- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 2276:93:36
- **Inherited From**: ERC20

## Implementation

```solidity
///  @dev Returns the symbol of the token, usually a shorter version of the
///  name.
function symbol() virtual public view returns (string memory) {
    return _symbol;
}
```

## State Variable Reads

- **_symbol** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20.symbol() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

 @dev Returns the symbol of the token, usually a shorter version of the
 name.

### Interface Documentation

 @dev Returns the symbol of the token.
