# Function: _claimBribe(address,uint256,uint256,uint256)

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `_claimBribe(address,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 43085:337:92

## Implementation

```solidity
function _claimBribe(address claimer, uint256 epoch, uint256 prevLQTYAllocationEpoch, uint256 prevTotalLQTYAllocationEpoch) public returns (uint256 boldAmount, uint256 bribeTokenAmount) {
    return _claimBribe(claimer, epoch, prevLQTYAllocationEpoch, prevTotalLQTYAllocationEpoch, false);
}
```

## Related Implementations

### _claimBribe(address,uint256,uint256,uint256,bool)

- **Kind**: internal
- **Source**: 43428:730:92
- **Link**: `test/BribeInitiative.t.sol:BribeInitiativeTest:_claimBribe(address,uint256,uint256,uint256,bool)`

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

## State Variable Reads

- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: BribeInitiativeTest._claimBribe(address,uint256,uint256,uint256,bool) (NodeID: 1)
      💬 Args: [claimer, epoch, prevLQTYAllocationEpoch, prevTotalLQTYAllocationEpoch, false]
      👁️  Def: public
```
