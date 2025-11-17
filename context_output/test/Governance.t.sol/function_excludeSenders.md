# Function: excludeSenders()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2907:134:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_) {
    excludedSenders_ = _excludedSenders;
}
```

## State Variable Reads

- **_excludedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeSenders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
