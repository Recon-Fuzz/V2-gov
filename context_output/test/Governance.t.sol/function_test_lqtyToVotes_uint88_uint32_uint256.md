# Function: test_lqtyToVotes(uint88,uint32,uint256)

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_lqtyToVotes(uint88,uint32,uint256)`
- **Visibility**: public
- **Source Range**: 13084:176:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_lqtyToVotes(uint88 _lqtyAmount, uint32 _currentTimestamp, uint256 _offset) public {
    governance.lqtyToVotes(_lqtyAmount, _currentTimestamp, _offset);
}
```

## External Calls

- **GovernanceTester::lqtyToVotes(uint256,uint256,uint256)**

## State Variable Reads

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_lqtyToVotes(uint88,uint32,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
