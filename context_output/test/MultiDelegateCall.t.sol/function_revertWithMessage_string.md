# Function: revertWithMessage(string)

**Contract**: [test/MultiDelegateCall.t.sol/contract_Target.md]

## Metadata

- **Contract**: Target
- **Signature**: `revertWithMessage(string)`
- **Visibility**: external
- **Source Range**: 394:98:102

## Implementation

```solidity
function revertWithMessage(string calldata message) external pure {
    revert(message);
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Target.revertWithMessage(string) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
