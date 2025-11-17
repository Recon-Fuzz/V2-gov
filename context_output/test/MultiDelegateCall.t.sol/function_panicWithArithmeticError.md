# Function: panicWithArithmeticError()

**Contract**: [test/MultiDelegateCall.t.sol/contract_Target.md]

## Metadata

- **Contract**: Target
- **Signature**: `panicWithArithmeticError()`
- **Visibility**: external
- **Source Range**: 618:108:102

## Implementation

```solidity
function panicWithArithmeticError() external pure returns (int256) {
    return -type(int256).min;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Target.panicWithArithmeticError() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
