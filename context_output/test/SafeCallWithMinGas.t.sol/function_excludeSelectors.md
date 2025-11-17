# Function: excludeSelectors()

**Contract**: [test/SafeCallWithMinGas.t.sol/contract_SafeCallWithMinGasTests.md]

## Metadata

- **Contract**: SafeCallWithMinGasTests
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
