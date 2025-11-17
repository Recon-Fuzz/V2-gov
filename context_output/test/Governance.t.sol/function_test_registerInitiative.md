# Function: test_registerInitiative()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_registerInitiative()`
- **Visibility**: public
- **Source Range**: 17604:2018:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_registerInitiative() public {
    vm.startPrank(user);
    address userProxy = governance.deployUserProxy();
    vm.expectRevert("Governance: registration-not-yet-enabled");
    governance.registerInitiative(baseInitiative3);
    vm.warp(block.timestamp + (2 * EPOCH_DURATION));
    assertEq(governance.epoch(), 3, "We should be in epoch #3");
    IGovernance.VoteSnapshot memory snapshot = IGovernance.VoteSnapshot(1e18, governance.epoch());
    governance.tester_setVotesSnapshot(snapshot);
    _expectInsufficientAllowanceAndBalance();
    governance.registerInitiative(baseInitiative3);
    vm.startPrank(lusdHolder);
    lusd.transfer(user, 2e18);
    vm.stopPrank();
    vm.startPrank(user);
    lusd.approve(address(governance), 2e18);
    vm.expectRevert("Governance: insufficient-lqty");
    governance.registerInitiative(baseInitiative3);
    _expectInsufficientAllowance();
    governance.depositLQTY(1e18);
    lqty.approve(address(userProxy), 1e18);
    governance.depositLQTY(1e18);
    vm.warp(block.timestamp + EPOCH_DURATION);
    vm.expectRevert("Governance: zero-address");
    governance.registerInitiative(address(0));
    governance.registerInitiative(baseInitiative3);
    uint256 atEpoch = governance.registeredInitiatives(baseInitiative3);
    assertEq(atEpoch, governance.epoch());
    vm.expectRevert("Governance: initiative-already-registered");
    governance.registerInitiative(baseInitiative3);
    vm.stopPrank();
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### _expectInsufficientAllowanceAndBalance()

- **Kind**: internal
- **Source**: 116029:113:99
- **Link**: `test/Governance.t.sol:ForkedGovernanceTest:_expectInsufficientAllowanceAndBalance()`

```solidity
function _expectInsufficientAllowanceAndBalance() override internal {
    _expectInsufficientBalance();
}
```

### _expectInsufficientBalance()

- **Kind**: internal
- **Source**: 115893:130:99
- **Link**: `test/Governance.t.sol:ForkedGovernanceTest:_expectInsufficientBalance()`

```solidity
function _expectInsufficientBalance() override internal {
    vm.expectRevert("ERC20: transfer amount exceeds balance");
}
```

### _expectInsufficientAllowance()

- **Kind**: internal
- **Source**: 115753:134:99
- **Link**: `test/Governance.t.sol:ForkedGovernanceTest:_expectInsufficientAllowance()`

```solidity
function _expectInsufficientAllowance() override internal {
    vm.expectRevert("ERC20: transfer amount exceeds allowance");
}
```

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

## External Calls

- **Vm::startPrank(address)**
- **GovernanceTester::deployUserProxy()**
- **Vm::expectRevert(bytes)**
- **GovernanceTester::registerInitiative(address)**
- **Vm::warp(uint256)**
- **GovernanceTester::epoch()**
- **GovernanceTester::tester_setVotesSnapshot(struct IGovernance.VoteSnapshot)**
- **ILUSD::transfer(address,uint256)**
- **Vm::stopPrank()**
- **ILUSD::approve(address,uint256)**
- **GovernanceTester::depositLQTY(uint256)**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::registeredInitiatives(address)**

## Native Transfers

- **lusd** (computed)

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **baseInitiative3** (`address`)
- **EPOCH_DURATION** (`uint256`)
- **lusdHolder** (`address`)
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_registerInitiative() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [governance.epoch(), 3, "We should be in epoch #3"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ForkedGovernanceTest._expectInsufficientAllowanceAndBalance() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ForkedGovernanceTest._expectInsufficientBalance() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ForkedGovernanceTest._expectInsufficientAllowance() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
      💬 Args: [atEpoch, governance.epoch()]
      👁️  Def: internal
```
