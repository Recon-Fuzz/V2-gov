# Function: setUp()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 115493:254:99

## Implementation

```solidity
function setUp() override public {
    vm.createSelectFork(vm.rpcUrl("mainnet"), 20430000);
    lqty = ILQTY(MAINNET_LQTY);
    lusd = ILUSD(MAINNET_LUSD);
    stakingV1 = ILQTYStaking(MAINNET_LQTY_STAKING);
    super.setUp();
}
```

## Related Implementations

### setUp()

- **Kind**: internal
- **Source**: 3400:1328:99
- **Link**: `test/Governance.t.sol:GovernanceTest:setUp()`

```solidity
function setUp() virtual public {
    IGovernance.Configuration memory config = IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint256(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF});
    governance = new GovernanceTester(address(lqty), address(lusd), address(stakingV1), address(lusd), config, address(this), new address[](0));
    baseInitiative1 = address(new BribeInitiative(address(governance), address(lusd), address(lqty)));
    baseInitiative2 = address(new BribeInitiative(address(governance), address(lusd), address(lqty)));
    baseInitiative3 = address(new BribeInitiative(address(governance), address(lusd), address(lqty)));
    initialInitiatives.push(baseInitiative1);
    initialInitiatives.push(baseInitiative2);
    governance.registerInitialInitiatives(initialInitiatives);
}
```

## External Calls

- **Vm::createSelectFork(string,uint256)**
- **Vm::rpcUrl(string)**

## State Variable Reads

- **REGISTRATION_FEE** (`uint256`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **MIN_ACCRUAL** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **stakingV1** (`contract ILQTYStaking`) [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **initialInitiatives** (`address[]`)

## State Variable Writes

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **baseInitiative3** (`address`)
- **initialInitiatives** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ForkedGovernanceTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: GovernanceTest.setUp() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```
