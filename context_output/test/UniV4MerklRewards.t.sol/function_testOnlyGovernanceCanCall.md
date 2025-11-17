# Function: testOnlyGovernanceCanCall()

**Contract**: [test/UniV4MerklRewards.t.sol/contract_UniV4MerklE2ETests.md]

## Metadata

- **Contract**: UniV4MerklE2ETests
- **Signature**: `testOnlyGovernanceCanCall()`
- **Visibility**: external
- **Source Range**: 2884:259:104

## Implementation

```solidity
function testOnlyGovernanceCanCall() external {
    uint256 epoch = governance.epoch();
    vm.expectRevert("UniV4MerklInitiative: invalid-sender");
    uniV4MerklRewardsInitiative.onClaimForInitiative(epoch, CAMPAIGN_BOLD_AMOUNT_THRESHOLD);
}
```

## External Calls

- **Governance::epoch()**
- **Vm::expectRevert(bytes)**
- **UniV4MerklRewards::onClaimForInitiative(uint256,uint256)**

## State Variable Reads

- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **uniV4MerklRewardsInitiative** (`contract UniV4MerklRewards`) [src/UniV4MerklRewards.sol/contract_UniV4MerklRewards.md]
- **CAMPAIGN_BOLD_AMOUNT_THRESHOLD** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklE2ETests.testOnlyGovernanceCanCall() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
