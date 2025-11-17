# Interface: ILiquidityGauge

## Metadata

- **Name**: ILiquidityGauge
- **Type**: Interface
- **Path**: src/interfaces/ILiquidityGauge.sol

## Public/External Functions

### add_reward(address,address)

- **Signature**: `add_reward(address,address)`
- **Visibility**: external
- **Source Range**: 90:74:80

**Signature:**
```solidity
function add_reward(address _reward_token, address _distributor) external;;
```

### deposit_reward_token(address,uint256,uint256)

- **Signature**: `deposit_reward_token(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 170:95:80

**Signature:**
```solidity
function deposit_reward_token(address _reward_token, uint256 _amount, uint256 _epoch) external;;
```
