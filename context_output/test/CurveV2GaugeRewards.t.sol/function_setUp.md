# Function: setUp()

**Contract**: [test/CurveV2GaugeRewards.t.sol/contract_ForkedCurveV2GaugeRewardsTest.md]

## Metadata

- **Contract**: ForkedCurveV2GaugeRewardsTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2111:2602:95

## Implementation

```solidity
function setUp() public {
    vm.createSelectFork(vm.rpcUrl("mainnet"), 20430000);
    IGovernance.Configuration memory config = IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint32(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF});
    governance = new Governance(address(lqty), address(lusd), stakingV1, address(lusd), config, address(this), initialInitiatives);
    address[] memory _coins = new address[](2);
    _coins[0] = address(lusd);
    _coins[1] = address(usdc);
    uint8[] memory _asset_types = new uint8[](2);
    _asset_types[0] = 0;
    _asset_types[1] = 0;
    bytes4[] memory _method_ids = new bytes4[](2);
    _method_ids[0] = 0x0;
    _method_ids[1] = 0x0;
    address[] memory _oracles = new address[](2);
    _oracles[0] = address(0x0);
    _oracles[1] = address(0x0);
    curvePool = ICurveStableswapNG(curveFactory.deploy_plain_pool("BOLD-USDC", "BOLDUSDC", _coins, 200, 1000000, 50000000000, 866, 0, _asset_types, _method_ids, _oracles));
    gauge = ILiquidityGauge(curveFactory.deploy_gauge(address(curvePool)));
    curveV2GaugeRewards = new CurveV2GaugeRewards(address(governance), address(lusd), address(lqty), address(gauge), 604800);
    initialInitiatives.push(address(curveV2GaugeRewards));
    governance.registerInitialInitiatives(initialInitiatives);
    vm.startPrank(curveFactory.admin());
    gauge.add_reward(address(lusd), address(curveV2GaugeRewards));
    vm.stopPrank();
    vm.startPrank(lusdHolder);
    lusd.approve(address(curvePool), type(uint256).max);
    usdc.approve(address(curvePool), type(uint256).max);
    uint256[] memory _amounts = new uint256[](2);
    _amounts[0] = 3000e18;
    _amounts[1] = 3000e6;
    curvePool.add_liquidity(_amounts, 5998200000000000000000);
    vm.stopPrank();
}
```

## External Calls

- **Vm::createSelectFork(string,uint256)**
- **Vm::rpcUrl(string)**
- **ICurveStableswapFactoryNG::deploy_plain_pool(string,string,address[],uint256,uint256,uint256,uint256,uint256,uint8[],bytes4[],address[])**
- **ICurveStableswapFactoryNG::deploy_gauge(address)**
- **Governance::registerInitialInitiatives(address[])**
- **Vm::startPrank(address)**
- **ICurveStableswapFactoryNG::admin()**
- **ILiquidityGauge::add_reward(address,address)**
- **Vm::stopPrank()**
- **IERC20::approve(address,uint256)**
- **ICurveStableswapNG::add_liquidity(uint256[],uint256)**

## State Variable Reads

- **REGISTRATION_FEE** (`uint128`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint128`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint128`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint16`)
- **VOTING_THRESHOLD_FACTOR** (`uint128`)
- **MIN_CLAIM** (`uint256`)
- **MIN_ACCRUAL** (`uint256`)
- **EPOCH_DURATION** (`uint32`)
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **lusd** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **stakingV1** (`address`)
- **initialInitiatives** (`address[]`)
- **usdc** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **curveFactory** (`contract ICurveStableswapFactoryNG`) [src/interfaces/ICurveStableswapFactoryNG.sol/interface_ICurveStableswapFactoryNG.md]
- **curvePool** (`contract ICurveStableswapNG`) [src/interfaces/ICurveStableswapNG.sol/interface_ICurveStableswapNG.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **gauge** (`contract ILiquidityGauge`) [src/interfaces/ILiquidityGauge.sol/interface_ILiquidityGauge.md]
- **curveV2GaugeRewards** (`contract CurveV2GaugeRewards`) [src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **lusdHolder** (`address`)

## State Variable Writes

- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **curvePool** (`contract ICurveStableswapNG`) [src/interfaces/ICurveStableswapNG.sol/interface_ICurveStableswapNG.md]
- **gauge** (`contract ILiquidityGauge`) [src/interfaces/ILiquidityGauge.sol/interface_ILiquidityGauge.md]
- **curveV2GaugeRewards** (`contract CurveV2GaugeRewards`) [src/CurveV2GaugeRewards.sol/contract_CurveV2GaugeRewards.md]
- **initialInitiatives** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ForkedCurveV2GaugeRewardsTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
