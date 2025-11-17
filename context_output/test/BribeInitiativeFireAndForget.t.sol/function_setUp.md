# Function: setUp()

**Contract**: [test/BribeInitiativeFireAndForget.t.sol/contract_BribeInitiativeFireAndForgetTest.md]

## Metadata

- **Contract**: BribeInitiativeFireAndForgetTest
- **Signature**: `setUp()`
- **Visibility**: external
- **Source Range**: 2942:1827:94

## Implementation

```solidity
function setUp() external {
    vm.warp(START_TIME);
    vm.label(voter, "voter");
    vm.label(other, "other");
    vm.label(briber, "briber");
    (stakingV1, lqty, lusd) = deployMockStakingV1();
    bold = new MockERC20Tester("BOLD Stablecoin", "BOLD");
    vm.label(address(bold), "BOLD");
    bryb = new MockERC20Tester("Bribe Token", "BRYB");
    vm.label(address(bryb), "BRYB");
    governance = new Governance({_lqty: address(lqty), _lusd: address(lusd), _stakingV1: address(stakingV1), _bold: address(bold), _config: config, _owner: address(this), _initiatives: new address[](0)});
    bribeInitiative = new BribeInitiative({_governance: address(governance), _bold: address(bold), _bribeToken: address(bryb)});
    address[] memory initiatives = new address[](1);
    initiatives[0] = address(bribeInitiative);
    governance.registerInitialInitiatives(initiatives);
    address voterProxy = governance.deriveUserProxyAddress(voter);
    vm.label(voterProxy, "voterProxy");
    address otherProxy = governance.deriveUserProxyAddress(other);
    vm.label(otherProxy, "otherProxy");
    lqty.mint(voter, MAX_VOTE);
    lqty.mint(other, MAX_VOTE);
    vm.startPrank(voter);
    lqty.approve(voterProxy, MAX_VOTE);
    governance.depositLQTY(MAX_VOTE);
    vm.stopPrank();
    vm.startPrank(other);
    lqty.approve(otherProxy, MAX_VOTE);
    governance.depositLQTY(MAX_VOTE);
    vm.stopPrank();
    vm.startPrank(briber);
    bold.approve(address(bribeInitiative), type(uint256).max);
    bryb.approve(address(bribeInitiative), type(uint256).max);
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

- **Vm::warp(uint256)**
- **Vm::label(address,string)**
- **Governance::registerInitialInitiatives(address[])**
- **Governance::deriveUserProxyAddress(address)**
- **MockERC20Tester::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20Tester::approve(address,uint256)**
- **Governance::depositLQTY(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **START_TIME** (`uint32`)
- **voter** (`address`)
- **other** (`address`)
- **briber** (`address`)
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bryb** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **config** (`struct IGovernance.Configuration`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **MAX_VOTE** (`uint256`)

## State Variable Writes

- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bryb** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeFireAndForgetTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MockStakingV1Deployer.deployMockStakingV1() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
