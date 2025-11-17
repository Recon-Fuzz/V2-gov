# Invariant Testing Scaffolding Requirements

This file defines the contracts that need to be scaffolded for comprehensive invariant testing of the Liquity V2 Governance system.

## Core Contracts for Direct Testing

These contracts are the primary targets for invariant testing and should be deployed properly in the test environment:

1. **Governance** - Main governance contract handling LQTY staking, voting, and initiative management
   - Path: `src/Governance.sol`
   - Dependencies: LQTY token, LUSD token, StakingV1, BOLD token

2. **BribeInitiative** - Initiative that allows bribing voters with rewards
   - Path: `src/BribeInitiative.sol`
   - Dependencies: Governance, BOLD token, Bribe token

3. **UserProxy** - Individual proxy for each user to interact with StakingV1
   - Path: `src/UserProxy.sol`
   - Dependencies: LQTY token, LUSD token, StakingV1

4. **UserProxyFactory** - Factory for creating user proxies
   - Path: `src/UserProxyFactory.sol`
   - Dependencies: LQTY token, LUSD token, StakingV1

5. **CurveV2GaugeRewards** - Initiative that deposits rewards into Curve gauges
   - Path: `src/CurveV2GaugeRewards.sol`
   - Dependencies: Governance, BOLD token, Bribe token, Curve Gauge

6. **UniV4MerklRewards** - Initiative that creates Merkl campaigns for Uniswap V4
   - Path: `src/UniV4MerklRewards.sol`
   - Dependencies: Governance, BOLD token, Merkl Distribution Creator

## Dependency Contracts to Mock

These are external dependencies that should be mocked for isolated testing:

1. **LQTYMock** - Mock LQTY token (ERC20 with permit)
   - Interface: `src/interfaces/ILQTY.sol`
   - Required functionality: Standard ERC20 + permit + domainSeparator

2. **LUSDMock** - Mock LUSD token
   - Interface: `src/interfaces/ILUSD.sol`
   - Required functionality: Standard ERC20

3. **BOLDMock** - Mock BOLD token
   - Required functionality: Standard ERC20

4. **StakingV1Mock** - Mock of LQTY Staking V1 contract
   - Interface: `src/interfaces/ILQTYStaking.sol`
   - Required functionality: stake(), unstake(), stakes(), getPendingLUSDGain(), getPendingETHGain()
   - Note: Existing mock at `test/mocks/MockStakingV1.sol` can be used

5. **BribeTokenMock** - Mock token used for bribes
   - Required functionality: Standard ERC20

6. **LiquidityGaugeMock** - Mock Curve Liquidity Gauge
   - Interface: `src/interfaces/ILiquidityGauge.sol`
   - Required functionality: deposit_reward_token(), add_reward()

7. **DistributionCreatorMock** - Mock Merkl Distribution Creator
   - Interface: `src/interfaces/IDistributionCreator.sol`
   - Required functionality: createCampaign(), acceptConditions(), campaignId()

## Target Function Files Already Created

The following target function files already exist in `test/recon/targets/`:

1. **GovernanceTargets.sol** - Auto-generated target functions for Governance contract
2. **BribeInitiativeTargets.sol** - Auto-generated target functions for BribeInitiative contract
3. **AdminTargets.sol** - Target functions for admin operations
4. **ManagersTargets.sol** - Target functions for Actor and Asset managers
5. **DoomsdayTargets.sol** - Stateless/edge case target functions

## Scaffolding Format

```
# Mocks Section
Mock contracts that need to be created:
- LQTYMock
- LUSDMock
- BOLDMock
- StakingV1Mock (use existing test/mocks/MockStakingV1.sol)
- BribeTokenMock
- LiquidityGaugeMock
- DistributionCreatorMock

# Target Functions Section
Contracts to generate target functions for:
- Governance (already done)
- BribeInitiative (already done)
- UserProxy
- UserProxyFactory
- CurveV2GaugeRewards
- UniV4MerklRewards
```

## Next Steps

After scaffolding:
1. Update `Setup.sol` to properly deploy all core contracts with mock dependencies
2. Import and inherit new target function contracts in `TargetFunctions.sol`
3. Set up proper token approvals and initial state
4. Configure actor management for multi-user scenarios
5. Define invariant properties in `Properties.sol`
