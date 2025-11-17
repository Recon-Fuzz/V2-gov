# Function: setUp()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `setUp()`
- **Visibility**: external
- **Source Range**: 2161:853:96

## Implementation

```solidity
function setUp() external {
    vm.warp(START_TIME);
    vm.label(deployer, "deployer");
    vm.label(voter, "voter");
    vm.label(registrant, "registrant");
    vm.label(initialInitiative, "initialInitiative");
    vm.label(newInitiative, "newInitiative");
    (stakingV1, lqty, lusd) = deployMockStakingV1();
    bold = new MockERC20Tester("BOLD Stablecoin", "BOLD");
    initiatives.push(initialInitiative);
    vm.prank(deployer);
    governance = new Governance({_lqty: address(lqty), _lusd: address(lusd), _stakingV1: address(stakingV1), _bold: address(bold), _config: config, _owner: deployer, _initiatives: initiatives});
    vm.label(governance.deriveUserProxyAddress(voter), "voterProxy");
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

- **Vm::warp(uint256)**
- **Vm::label(address,string)**
- **Vm::prank(address)**
- **Governance::deriveUserProxyAddress(address)**

## State Variable Reads

- **START_TIME** (`uint32`)
- **deployer** (`address`)
- **voter** (`address`)
- **registrant** (`address`)
- **initialInitiative** (`address`)
- **newInitiative** (`address`)
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **config** (`struct IGovernance.Configuration`)
- **initiatives** (`address[]`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]

## State Variable Writes

- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **initiatives** (`address[]`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploymentTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MockStakingV1Deployer.deployMockStakingV1() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
