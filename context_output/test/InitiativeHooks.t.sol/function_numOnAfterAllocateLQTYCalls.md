# Function: numOnAfterAllocateLQTYCalls()

**Contract**: [test/InitiativeHooks.t.sol/contract_MockInitiative.md]

## Metadata

- **Contract**: MockInitiative
- **Signature**: `numOnAfterAllocateLQTYCalls()`
- **Visibility**: external
- **Source Range**: 771:126:101

## Implementation

```solidity
function numOnAfterAllocateLQTYCalls() external view returns (uint256) {
    return onAfterAllocateLQTYCalls.length;
}
```

## State Variable Reads

- **onAfterAllocateLQTYCalls** (`struct MockInitiative.OnAfterAllocateLQTYParams[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockInitiative.numOnAfterAllocateLQTYCalls() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
