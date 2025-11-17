# Function: run()

**Contract**: [script/DeploySepolia.s.sol/contract_DeploySepoliaScript.md]

## Metadata

- **Contract**: DeploySepoliaScript
- **Signature**: `run()`
- **Visibility**: public
- **Source Range**: 4689:153:61

## Implementation

```solidity
function run() public {
    vm.startBroadcast(privateKey);
    deployEnvironment();
    deployGovernance();
    vm.stopBroadcast();
}
```

## Related Implementations

### deployEnvironment()

- **Kind**: internal
- **Source**: 2337:204:61
- **Link**: `script/DeploySepolia.s.sol:DeploySepoliaScript:deployEnvironment()`

```solidity
function deployEnvironment() private {
    (stakingV1, lqty, ) = deployMockStakingV1();
    bold = new MockERC20Tester("Bold", "BOLD");
    usdc = new MockERC20Tester("USD Coin", "USDC");
}
```

### deployMockStakingV1()

- **Kind**: internal
- **Source**: 260:551:114
- **Link**: `test/mocks/MockStakingV1Deployer.sol:MockStakingV1Deployer:deployMockStakingV1()`

```solidity
function deployMockStakingV1() internal returns (MockStakingV1 stakingV1, MockERC20Tester lqty, MockERC20Tester lusd) {
    lqty = new MockERC20Tester("Liquity", "LQTY");
    vm.label(address(lqty), "LQTY");
    lusd = new MockERC20Tester("Liquity USD", "LUSD");
    vm.label(address(lusd), "LUSD");
    stakingV1 = new MockStakingV1(lqty, lusd);
    lqty.mock_setWildcardSpender(address(stakingV1), true);
}
```

### deployGovernance()

- **Kind**: internal
- **Source**: 2547:975:61
- **Link**: `script/DeploySepolia.s.sol:DeploySepoliaScript:deployGovernance()`

```solidity
function deployGovernance() private {
    governance = new Governance(address(lqty), address(bold), address(stakingV1), address(bold), IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: block.timestamp - EPOCH_DURATION, epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF}), deployer, initialInitiatives);
}
```

## External Calls

- **Vm::startBroadcast(uint256)**
- **Vm::stopBroadcast()**

## State Variable Reads

- **privateKey** (`uint256`)
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **REGISTRATION_FEE** (`uint128`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint128`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint128`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint16`)
- **VOTING_THRESHOLD_FACTOR** (`uint128`)
- **MIN_CLAIM** (`uint88`)
- **MIN_ACCRUAL** (`uint88`)
- **EPOCH_DURATION** (`uint32`)
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **deployer** (`address`)
- **initialInitiatives** (`address[]`)

## State Variable Writes

- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **usdc** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploySepoliaScript.run() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: DeploySepoliaScript.deployEnvironment() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: MockStakingV1Deployer.deployMockStakingV1() (NodeID: 2)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: DeploySepoliaScript.deployGovernance() (NodeID: 3)
      💬 Args: [no args]
      👁️  Def: private
```
