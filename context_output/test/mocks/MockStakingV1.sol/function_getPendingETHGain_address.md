# Function: getPendingETHGain(address)

**Contract**: [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]

## Metadata

- **Contract**: MockStakingV1
- **Signature**: `getPendingETHGain(address)`
- **Visibility**: external
- **Source Range**: 2689:127:113

## Implementation

```solidity
function getPendingETHGain(address user) override external view returns (uint256) {
    return _pendingETHGain[user];
}
```

## State Variable Reads

- **_pendingETHGain** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockStakingV1.getPendingETHGain(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
