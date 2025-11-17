# Function: setUp()

**Contract**: [test/E2E.t.sol/contract_ForkedE2ETests.md]

## Metadata

- **Contract**: ForkedE2ETests
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1742:1412:98

## Implementation

```solidity
function setUp() public {
    vm.createSelectFork(vm.rpcUrl("mainnet"), 20430000);
    IGovernance.Configuration memory config = IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint256(block.timestamp - EPOCH_DURATION), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF});
    governance = new Governance(address(lqty), address(lusd), stakingV1, address(lusd), config, address(this), new address[](0));
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
- **Governance::registerInitialInitiatives(address[])**

## State Variable Reads

- **REGISTRATION_FEE** (`uint256`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **MIN_ACCRUAL** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint256`)
- **lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **lusd** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **stakingV1** (`address`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **initialInitiatives** (`address[]`)

## State Variable Writes

- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **baseInitiative3** (`address`)
- **initialInitiatives** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ForkedE2ETests.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
