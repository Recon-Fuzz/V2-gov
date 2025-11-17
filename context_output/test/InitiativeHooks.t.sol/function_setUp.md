# Function: setUp()

**Contract**: [test/InitiativeHooks.t.sol/contract_InitiativeHooksTest.md]

## Metadata

- **Contract**: InitiativeHooksTest
- **Signature**: `setUp()`
- **Visibility**: external
- **Source Range**: 2484:975:101

## Implementation

```solidity
function setUp() external {
    vm.warp(START_TIME);
    (stakingV1, lqty, lusd) = deployMockStakingV1();
    bold = new MockERC20Tester("BOLD Stablecoin", "BOLD");
    vm.label(address(bold), "BOLD");
    governance = new Governance({_lqty: address(lqty), _lusd: address(lusd), _stakingV1: address(stakingV1), _bold: address(bold), _config: config, _owner: address(this), _initiatives: new address[](0)});
    initiative = new MockInitiative();
    initiatives.push(address(initiative));
    governance.registerInitialInitiatives(initiatives);
    voter = makeAddr("voter");
    lqty.mint(voter, 1 ether);
    vm.startPrank(voter);
    lqty.approve(governance.deriveUserProxyAddress(voter), type(uint256).max);
    governance.depositLQTY(1 ether);
    vm.stopPrank();
    votes.push();
    vetos.push();
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

### makeAddr(string)

- **Kind**: internal
- **Source**: 20454:125:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20173:242:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Vm::label(address,string)**
- **Governance::registerInitialInitiatives(address[])**
- **MockERC20Tester::mint(address,uint256)**
- **Vm::startPrank(address)**
- **MockERC20Tester::approve(address,uint256)**
- **Governance::deriveUserProxyAddress(address)**
- **Governance::depositLQTY(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **START_TIME** (`uint32`)
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **config** (`struct IGovernance.Configuration`)
- **initiative** (`contract MockInitiative`) [test/InitiativeHooks.t.sol/contract_MockInitiative.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **initiatives** (`address[]`)
- **voter** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **stakingV1** (`contract MockStakingV1`) [test/mocks/MockStakingV1.sol/contract_MockStakingV1.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **initiative** (`contract MockInitiative`) [test/InitiativeHooks.t.sol/contract_MockInitiative.md]
- **initiatives** (`address[]`)
- **voter** (`address`)
- **votes** (`int256[]`)
- **vetos** (`int256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InitiativeHooksTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MockStakingV1Deployer.deployMockStakingV1() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 2)
      💬 Args: ["voter"]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 3)
        💬 Args: [name]
        👁️  Def: internal
```
