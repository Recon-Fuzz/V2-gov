# Function: revertWithCustomError(string)

**Contract**: [test/MultiDelegateCall.t.sol/contract_Target.md]

## Metadata

- **Contract**: Target
- **Signature**: `revertWithCustomError(string)`
- **Visibility**: external
- **Source Range**: 498:114:102

## Implementation

```solidity
function revertWithCustomError(string calldata message) external pure {
    revert CustomError(message);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Target.revertWithCustomError(string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
