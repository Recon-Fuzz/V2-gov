# Function: targetSelectors()

**Contract**: [test/CurveV2GaugeRewards.t.sol/contract_ForkedCurveV2GaugeRewardsTest.md]

## Metadata

- **Contract**: ForkedCurveV2GaugeRewardsTest
- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3532:146:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_) {
    targetedSelectors_ = _targetedSelectors;
}
```

## State Variable Reads

- **_targetedSelectors** (`struct StdInvariant.FuzzSelector[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetSelectors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
