# Function: targetContracts()

**Contract**: [test/CurveV2GaugeRewards.t.sol/contract_ForkedCurveV2GaugeRewardsTest.md]

## Metadata

- **Contract**: ForkedCurveV2GaugeRewardsTest
- **Signature**: `targetContracts()`
- **Visibility**: public
- **Source Range**: 3385:141:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetContracts() public view returns (address[] memory targetedContracts_) {
    targetedContracts_ = _targetedContracts;
}
```

## State Variable Reads

- **_targetedContracts** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetContracts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
