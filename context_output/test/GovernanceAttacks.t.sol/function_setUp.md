# Function: setUp()

**Contract**: [test/GovernanceAttacks.t.sol/contract_ForkedGovernanceAttacksTest.md]

## Metadata

- **Contract**: ForkedGovernanceAttacksTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 12114:254:100

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
- **Source**: 1912:1202:100
- **Link**: `test/GovernanceAttacks.t.sol:GovernanceAttacksTest:setUp()`

```solidity
function setUp() virtual public {
    maliciousInitiative1 = new MaliciousInitiative();
    maliciousInitiative2 = new MaliciousInitiative();
    eoaInitiative = MaliciousInitiative(address(0x123123123123));
    initialInitiatives.push(address(maliciousInitiative1));
    IGovernance.Configuration memory config = IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint256(block.timestamp - (2 * EPOCH_DURATION)), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF});
    governance = new Governance(address(lqty), address(lusd), address(stakingV1), address(lusd), config, address(this), initialInitiatives);
}
```

## External Calls

- **Vm::createSelectFork(string,uint256)**
- **Vm::rpcUrl(string)**

## State Variable Reads

- **maliciousInitiative1** (`contract MaliciousInitiative`) [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]
- **REGISTRATION_FEE** (`uint256`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **MIN_ACCRUAL** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint256`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **stakingV1** (`contract ILQTYStaking`) [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **initialInitiatives** (`address[]`)

## State Variable Writes

- **maliciousInitiative1** (`contract MaliciousInitiative`) [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]
- **maliciousInitiative2** (`contract MaliciousInitiative`) [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]
- **eoaInitiative** (`contract MaliciousInitiative`) [test/mocks/MaliciousInitiative.sol/contract_MaliciousInitiative.md]
- **initialInitiatives** (`address[]`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ForkedGovernanceAttacksTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: GovernanceAttacksTest.setUp() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: public
```
