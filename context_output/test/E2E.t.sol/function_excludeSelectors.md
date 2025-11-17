# Function: excludeSelectors()

**Contract**: [test/E2E.t.sol/contract_ForkedE2ETests.md]

## Metadata

- **Contract**: ForkedE2ETests
- **Signature**: `excludeSelectors()`
- **Visibility**: public
- **Source Range**: 2754:147:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeSelectors() public view returns (FuzzSelector[] memory excludedSelectors_) {
    excludedSelectors_ = _excludedSelectors;
}
```

## State Variable Reads

- **_excludedSelectors** (`struct StdInvariant.FuzzSelector[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeSelectors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
