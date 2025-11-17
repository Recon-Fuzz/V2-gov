# Function: getPendingLUSDGain(address)

**Contract**: [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]

## Metadata

- **Contract**: MockStakingV1
- **Signature**: `getPendingLUSDGain(address)`
- **Visibility**: external
- **Source Range**: 2554:129:113

## Implementation

```solidity
function getPendingLUSDGain(address user) override external view returns (uint256) {
    return _pendingLUSDGain[user];
}
```

## State Variable Reads

- **_pendingLUSDGain** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStakingV1.getPendingLUSDGain(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
