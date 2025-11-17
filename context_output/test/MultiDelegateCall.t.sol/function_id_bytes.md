# Function: id(bytes)

**Contract**: [test/MultiDelegateCall.t.sol/contract_Target.md]

## Metadata

- **Contract**: Target
- **Signature**: `id(bytes)`
- **Visibility**: external
- **Source Range**: 294:94:102

## Implementation

```solidity
function id(bytes calldata x) external pure returns (bytes calldata) {
    return x;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Target.id(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
