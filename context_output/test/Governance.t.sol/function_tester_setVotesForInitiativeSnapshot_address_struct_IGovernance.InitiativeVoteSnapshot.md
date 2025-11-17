# Function: tester_setVotesForInitiativeSnapshot(address,struct IGovernance.InitiativeVoteSnapshot)

**Contract**: [test/Governance.t.sol/contract_GovernanceTester.md]

## Metadata

- **Contract**: GovernanceTester
- **Signature**: `tester_setVotesForInitiativeSnapshot(address,struct IGovernance.InitiativeVoteSnapshot)`
- **Visibility**: external
- **Source Range**: 1554:245:99

## Implementation

```solidity
function tester_setVotesForInitiativeSnapshot(address _initiative, InitiativeVoteSnapshot calldata _votesForInitiativeSnapshot) external {
    votesForInitiativeSnapshot[_initiative] = _votesForInitiativeSnapshot;
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTester.tester_setVotesForInitiativeSnapshot(address,struct IGovernance.InitiativeVoteSnapshot) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
