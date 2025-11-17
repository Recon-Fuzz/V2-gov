# Function: targetSenders()

**Contract**: [test/UserProxy.t.sol/contract_ForkedUserProxyTest.md]

## Metadata

- **Contract**: ForkedUserProxyTest
- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3684:133:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetSenders() public view returns (address[] memory targetedSenders_) {
    targetedSenders_ = _targetedSenders;
}
```

## State Variable Reads

- **_targetedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetSenders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
