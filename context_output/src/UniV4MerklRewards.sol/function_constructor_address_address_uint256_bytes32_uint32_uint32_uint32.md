# Function: constructor(address,address,uint256,bytes32,uint32,uint32,uint32)

**Contract**: [src/UniV4MerklRewards.sol/contract_UniV4MerklRewards.md]

## Metadata

- **Contract**: UniV4MerklRewards
- **Signature**: `constructor(address,address,uint256,bytes32,uint32,uint32,uint32)`
- **Visibility**: public
- **Source Range**: 1525:1026:68

## Implementation

```solidity
constructor(address _governanceAddress, address _boldTokenAddress, uint256 _campaignBoldAmountThreshold, bytes32 _uniV4PoolId, uint32 _weightFees, uint32 _weightToken0, uint32 _weightToken1) {
    require(((_weightFees + _weightToken0) + _weightToken1) == 10000, "Wrong weigths");
    governance = IGovernance(_governanceAddress);
    boldToken = IERC20(_boldTokenAddress);
    CAMPAIGN_BOLD_AMOUNT_THRESHOLD = _campaignBoldAmountThreshold;
    UNIV4_POOL_ID = _uniV4PoolId;
    WEIGHT_FEES = _weightFees;
    WEIGHT_TOKEN_0 = _weightToken0;
    WEIGHT_TOKEN_1 = _weightToken1;
    EPOCH_START = governance.EPOCH_START();
    EPOCH_DURATION = governance.EPOCH_DURATION();
    boldToken.approve(address(merklDistributionCreator), type(uint256).max);
    merklDistributionCreator.acceptConditions();
}
```

## External Calls

- **IGovernance::EPOCH_START()**
- **IGovernance::EPOCH_DURATION()**
- **IERC20::approve(address,uint256)**
- **IDistributionCreator::acceptConditions()**

## State Variable Reads

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]
- **boldToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **merklDistributionCreator** (`contract IDistributionCreator`) [src/interfaces/IDistributionCreator.sol/interface_IDistributionCreator.md]

## State Variable Writes

- **governance** (`contract IGovernance`) [src/interfaces/IGovernance.sol/interface_IGovernance.md]
- **boldToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **CAMPAIGN_BOLD_AMOUNT_THRESHOLD** (`uint256`)
- **UNIV4_POOL_ID** (`bytes32`)
- **WEIGHT_FEES** (`uint32`)
- **WEIGHT_TOKEN_0** (`uint32`)
- **WEIGHT_TOKEN_1** (`uint32`)
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: UniV4MerklRewards.constructor(address,address,uint256,bytes32,uint32,uint32,uint32) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: UniV4MerklRewards
```
