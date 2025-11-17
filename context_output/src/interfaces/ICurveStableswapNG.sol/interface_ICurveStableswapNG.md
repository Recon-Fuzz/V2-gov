# Interface: ICurveStableswapNG

## Metadata

- **Name**: ICurveStableswapNG
- **Type**: Interface
- **Path**: src/interfaces/ICurveStableswapNG.sol

## Public/External Functions

### add_liquidity(uint256[],uint256)

- **Signature**: `add_liquidity(uint256[],uint256)`
- **Visibility**: external
- **Source Range**: 93:105:73

**Signature:**
```solidity
function add_liquidity(uint256[] calldata _amounts, uint256 _min_mint_amount) external returns (uint256);;
```

### deposit_reward_token(address,uint256,uint256)

- **Signature**: `deposit_reward_token(address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 204:95:73

**Signature:**
```solidity
function deposit_reward_token(address _reward_token, uint256 _amount, uint256 _epoch) external;;
```
