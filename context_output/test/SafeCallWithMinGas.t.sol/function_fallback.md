# Function: fallback()

**Contract**: [test/SafeCallWithMinGas.t.sol/contract_FallbackRecipient.md]

## Metadata

- **Contract**: FallbackRecipient
- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 365:64:103

## Implementation

```solidity
fallback() external payable {
    received = msg.data;
}
```

## State Variable Writes

- **received** (`bytes`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FallbackRecipient.fallback() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
