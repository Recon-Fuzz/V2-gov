# Function: validCall()

**Contract**: [test/SafeCallWithMinGas.t.sol/contract_BasicRecipient.md]

## Metadata

- **Contract**: BasicRecipient
- **Signature**: `validCall()`
- **Visibility**: external
- **Source Range**: 234:66:103

## Implementation

```solidity
function validCall() external {
    callWasValid = true;
}
```

## State Variable Writes

- **callWasValid** (`bool`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BasicRecipient.validCall() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
