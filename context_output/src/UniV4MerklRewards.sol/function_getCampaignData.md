# Function: getCampaignData()

**Contract**: [src/UniV4MerklRewards.sol/contract_UniV4MerklRewards.md]

## Metadata

- **Contract**: UniV4MerklRewards
- **Signature**: `getCampaignData()`
- **Visibility**: public
- **Source Range**: 2557:1071:68

## Implementation

```solidity
function getCampaignData() public view returns (bytes memory) {
    return bytes.concat(abi.encode(416, IS_OUT_OF_RANGE_INCENTIVIZED, WEIGHT_FEES, WEIGHT_TOKEN_0, WEIGHT_TOKEN_1, 480, 512, 576), abi.encode(0, 0, 0, 0, 608, 32, UNIV4_POOL_ID, 0, 1, LIQUITY_FUNDS_SAFE, 0, 0));
}
```

## State Variable Reads

- **IS_OUT_OF_RANGE_INCENTIVIZED** (`bool`)
- **WEIGHT_FEES** (`uint32`)
- **WEIGHT_TOKEN_0** (`uint32`)
- **WEIGHT_TOKEN_1** (`uint32`)
- **UNIV4_POOL_ID** (`bytes32`)
- **LIQUITY_FUNDS_SAFE** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklRewards.getCampaignData() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
