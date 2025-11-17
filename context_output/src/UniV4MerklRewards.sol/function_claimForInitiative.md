# Function: claimForInitiative()

**Contract**: [src/UniV4MerklRewards.sol/contract_UniV4MerklRewards.md]

## Metadata

- **Contract**: UniV4MerklRewards
- **Signature**: `claimForInitiative()`
- **Visibility**: external
- **Source Range**: 6030:340:68

## Implementation

```solidity
function claimForInitiative() external {
    uint256 claimableAmount = governance.claimForInitiative(address(this));
    uint256 amount = boldToken.balanceOf(address(this));
    assert(amount >= claimableAmount);
    require(amount > 0, "UniV4MerklInitiative: no funds for campaign");
    _createCampaign(amount);
}
```

## Related Implementations

### _createCampaign(uint256)

- **Kind**: internal
- **Source**: 5012:973:68
- **Link**: `src/UniV4MerklRewards.sol:UniV4MerklRewards:_createCampaign(uint256)`

```solidity
function _createCampaign(uint256 _amount) internal {
    if (_amount < CAMPAIGN_BOLD_AMOUNT_THRESHOLD) return;
    uint256 claimEpoch = governance.epoch() - 1;
    uint256 epochEnd = EPOCH_START + (claimEpoch * EPOCH_DURATION);
    IDistributionCreator.CampaignParameters memory params = IDistributionCreator.CampaignParameters({campaignId: bytes32(0), creator: address(this), rewardToken: address(boldToken), amount: _amount, campaignType: CAMPAIGN_TYPE, startTimestamp: uint32(epochEnd), duration: uint32(EPOCH_DURATION), campaignData: getCampaignData()});
    bytes32 campaignId = merklDistributionCreator.createCampaign(params);
    emit NewMerklCampaign(claimEpoch, _amount, campaignId);
}
```

### getCampaignData()

- **Kind**: internal
- **Source**: 2557:1071:68
- **Link**: `src/UniV4MerklRewards.sol:UniV4MerklRewards:getCampaignData()`

```solidity
function getCampaignData() public view returns (bytes memory) {
    return bytes.concat(abi.encode(416, IS_OUT_OF_RANGE_INCENTIVIZED, WEIGHT_FEES, WEIGHT_TOKEN_0, WEIGHT_TOKEN_1, 480, 512, 576), abi.encode(0, 0, 0, 0, 608, 32, UNIV4_POOL_ID, 0, 1, LIQUITY_FUNDS_SAFE, 0, 0));
}
```

## External Calls

- **IGovernance::claimForInitiative(address)**
- **IERC20::balanceOf(address)**

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]
- **boldToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **CAMPAIGN_BOLD_AMOUNT_THRESHOLD** (`uint256`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **CAMPAIGN_TYPE** (`uint32`)
- **merklDistributionCreator** (`contract IDistributionCreator`) [src/interfaces/IDistributionCreator.sol/interface_IDistributionCreator.md]
- **IS_OUT_OF_RANGE_INCENTIVIZED** (`bool`)
- **WEIGHT_FEES** (`uint32`)
- **WEIGHT_TOKEN_0** (`uint32`)
- **WEIGHT_TOKEN_1** (`uint32`)
- **UNIV4_POOL_ID** (`bytes32`)
- **LIQUITY_FUNDS_SAFE** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklRewards.claimForInitiative() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: UniV4MerklRewards._createCampaign(uint256) (NodeID: 1)
      💬 Args: [amount]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: UniV4MerklRewards.getCampaignData() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: public
```
