# Function: tester_setVotesSnapshot(struct IGovernance.VoteSnapshot)

**Contract**: [test/Governance.t.sol/contract_GovernanceTester.md]

## Metadata

- **Contract**: GovernanceTester
- **Signature**: `tester_setVotesSnapshot(struct IGovernance.VoteSnapshot)`
- **Visibility**: external
- **Source Range**: 1421:127:99

## Implementation

```solidity
function tester_setVotesSnapshot(VoteSnapshot calldata _votesSnapshot) external {
    votesSnapshot = _votesSnapshot;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTester.tester_setVotesSnapshot(struct IGovernance.VoteSnapshot) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
