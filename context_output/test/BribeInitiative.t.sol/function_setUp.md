# Function: setUp()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1817:1524:92

## Implementation

```solidity
function setUp() public {
    (stakingV1, lqty, lusd) = deployMockStakingV1();
    lqty.mint(lusdHolder, 10_000_000e18);
    lusd.mint(lusdHolder, 10_000_000e18);
    IGovernance.Configuration memory config = IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: MIN_CLAIM, minAccrual: MIN_ACCRUAL, epochStart: uint256(block.timestamp), epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF});
    governance = new Governance(address(lqty), address(lusd), address(stakingV1), address(lusd), config, address(this), new address[](0));
    bribeInitiative = new BribeInitiative(address(governance), address(lusd), address(lqty));
    initialInitiatives.push(address(bribeInitiative));
    governance.registerInitialInitiatives(initialInitiatives);
    vm.startPrank(lusdHolder);
    lqty.transfer(user1, 1_000_000e18);
    lusd.transfer(user1, 1_000_000e18);
    lqty.transfer(user2, 1_000_000e18);
    lusd.transfer(user2, 1_000_000e18);
    lqty.transfer(user3, 1_000_000e18);
    lusd.transfer(user3, 1_000_000e18);
    vm.stopPrank();
}
```

## Related Implementations

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

## External Calls

- **MockERC20Tester::mint(address,uint256)**
- **Governance::registerInitialInitiatives(address[])**
- **Vm::startPrank(address)**
- **MockERC20Tester::transfer(address,uint256)**
- **Vm::stopPrank()**

## Native Transfers

- **lqty** (state variable) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (state variable) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## State Variable Reads

- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusdHolder** (`address`)
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **REGISTRATION_FEE** (`uint256`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)
- **MIN_CLAIM** (`uint256`)
- **MIN_ACCRUAL** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint256`)
- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **initialInitiatives** (`address[]`)
- **user1** (`address`)
- **user2** (`address`)
- **user3** (`address`)

## State Variable Writes

- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **initialInitiatives** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: MockStakingV1Deployer.deployMockStakingV1() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
