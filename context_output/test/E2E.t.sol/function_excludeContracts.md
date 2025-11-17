# Function: excludeContracts()

**Contract**: [test/E2E.t.sol/contract_ForkedE2ETests.md]

## Metadata

- **Contract**: ForkedE2ETests
- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2606:142:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_) {
    excludedContracts_ = _excludedContracts;
}
```

## State Variable Reads

- **_excludedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeContracts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
