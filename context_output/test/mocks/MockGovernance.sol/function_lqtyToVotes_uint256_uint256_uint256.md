# Function: lqtyToVotes(uint256,uint256,uint256)

**Contract**: [test/mocks/MockGovernance.sol/contract_MockGovernance.md]

## Metadata

- **Contract**: MockGovernance
- **Signature**: `lqtyToVotes(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 759:259:111

## Implementation

```solidity
function lqtyToVotes(uint256 _lqtyAmount, uint256 _currentTimestamp, uint256 _averageTimestamp) public pure returns (uint256) {
    return uint256(_lqtyAmount) * uint256(_averageAge(_currentTimestamp, _averageTimestamp));
}
```

## Related Implementations

### _averageAge(uint256,uint256)

- **Kind**: internal
- **Source**: 498:255:111
- **Link**: `test/mocks/MockGovernance.sol:MockGovernance:_averageAge(uint256,uint256)`

```solidity
function _averageAge(uint256 _currentTimestamp, uint256 _averageTimestamp) internal pure returns (uint256) {
    if ((_averageTimestamp == 0) || (_currentTimestamp < _averageTimestamp)) return 0;
    return _currentTimestamp - _averageTimestamp;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MockGovernance.lqtyToVotes(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: MockGovernance._averageAge(uint256,uint256) (NodeID: 1)
      💬 Args: [_currentTimestamp, _averageTimestamp]
      👁️  Def: internal
```
