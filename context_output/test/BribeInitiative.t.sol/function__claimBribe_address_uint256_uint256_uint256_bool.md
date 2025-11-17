# Function: _claimBribe(address,uint256,uint256,uint256,bool)

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `_claimBribe(address,uint256,uint256,uint256,bool)`
- **Visibility**: public
- **Source Range**: 43428:730:92

## Implementation

```solidity
function _claimBribe(address claimer, uint256 epoch, uint256 prevLQTYAllocationEpoch, uint256 prevTotalLQTYAllocationEpoch, bool expectRevert) public returns (uint256 boldAmount, uint256 bribeTokenAmount) {
    vm.startPrank(claimer);
    BribeInitiative.ClaimData[] memory epochs = new BribeInitiative.ClaimData[](1);
    epochs[0].epoch = epoch;
    epochs[0].prevLQTYAllocationEpoch = prevLQTYAllocationEpoch;
    epochs[0].prevTotalLQTYAllocationEpoch = prevTotalLQTYAllocationEpoch;
    if (expectRevert) {
        vm.expectRevert();
    }
    (boldAmount, bribeTokenAmount) = bribeInitiative.claimBribes(epochs);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::expectRevert()**
- **BribeInitiative::claimBribes(struct IBribeInitiative.ClaimData[])**
- **Vm::stopPrank()**

## State Variable Reads

- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
