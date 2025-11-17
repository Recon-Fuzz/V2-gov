# Function: test_depositLQTY_withdrawLQTY()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_depositLQTY_withdrawLQTY()`
- **Visibility**: public
- **Source Range**: 4799:3156:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_depositLQTY_withdrawLQTY() public {
    uint256 timeIncrease = 86400 * 30;
    vm.warp(block.timestamp + timeIncrease);
    vm.startPrank(user);
    vm.expectRevert("Governance: zero-lqty-amount");
    governance.depositLQTY(0);
    _expectInsufficientAllowance();
    governance.depositLQTY(1e18);
    _expectInsufficientAllowanceAndBalance();
    governance.depositLQTY(1e26);
    uint256 lqtyDeposit = 2e18;
    address userProxy = governance.deriveUserProxyAddress(user);
    lqty.approve(address(userProxy), lqtyDeposit);
    governance.depositLQTY(lqtyDeposit);
    assertEq(UserProxy(payable(userProxy)).staked(), lqtyDeposit);
    (uint256 unallocatedLQTY, uint256 unallocatedOffset, , ) = governance.userStates(user);
    assertEq(unallocatedLQTY, lqtyDeposit);
    uint256 expectedOffset1 = block.timestamp * lqtyDeposit;
    assertEq(unallocatedOffset, expectedOffset1);
    vm.warp(block.timestamp + timeIncrease);
    lqty.approve(address(userProxy), lqtyDeposit);
    governance.depositLQTY(lqtyDeposit);
    assertEq(UserProxy(payable(userProxy)).staked(), lqtyDeposit * 2);
    (unallocatedLQTY, unallocatedOffset, , ) = governance.userStates(user);
    assertEq(unallocatedLQTY, lqtyDeposit * 2);
    uint256 expectedOffset2 = expectedOffset1 + (block.timestamp * lqtyDeposit);
    assertEq(unallocatedOffset, expectedOffset2, "unallocated offset");
    vm.warp(block.timestamp + timeIncrease);
    vm.startPrank(address(this));
    vm.expectRevert("Governance: user-proxy-not-deployed");
    governance.withdrawLQTY(lqtyDeposit);
    vm.stopPrank();
    vm.startPrank(user);
    governance.withdrawLQTY(lqtyDeposit);
    assertEq(UserProxy(payable(userProxy)).staked(), lqtyDeposit);
    (unallocatedLQTY, unallocatedOffset, , ) = governance.userStates(user);
    assertEq(unallocatedLQTY, lqtyDeposit);
    assertEq(unallocatedOffset, expectedOffset2 / 2, "unallocated offset2");
    governance.withdrawLQTY(lqtyDeposit);
    assertEq(UserProxy(payable(userProxy)).staked(), 0);
    (unallocatedLQTY, unallocatedOffset, , ) = governance.userStates(user);
    assertEq(unallocatedLQTY, 0);
    assertEq(unallocatedOffset, 0, "unallocated offset2");
    vm.stopPrank();
}
```

## Related Implementations

### _expectInsufficientAllowance()

- **Kind**: internal
- **Source**: 115753:134:99
- **Link**: `test/Governance.t.sol:ForkedGovernanceTest:_expectInsufficientAllowance()`

```solidity
function _expectInsufficientAllowance() override internal {
    vm.expectRevert("ERC20: transfer amount exceeds allowance");
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

### assertEq(uint256,uint256)

- **Kind**: internal
- **Source**: 2270:110:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256)`

```solidity
function assertEq(uint256 left, uint256 right) virtual internal pure {
    vm.assertEq(left, right);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Vm::startPrank(address)**
- **Vm::expectRevert(bytes)**
- **GovernanceTester::depositLQTY(uint256)**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **ILQTY::approve(address,uint256)**
- **UserProxy::staked()**
- **GovernanceTester::userStates(address)**
- **GovernanceTester::withdrawLQTY(uint256)**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_depositLQTY_withdrawLQTY() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ForkedGovernanceTest._expectInsufficientAllowance() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ForkedGovernanceTest._expectInsufficientAllowanceAndBalance() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: ForkedGovernanceTest._expectInsufficientBalance() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 4)
  │   💬 Args: [UserProxy(payable(userProxy)).staked(), lqtyDeposit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [unallocatedLQTY, lqtyDeposit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
  │   💬 Args: [unallocatedOffset, expectedOffset1]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 7)
  │   💬 Args: [UserProxy(payable(userProxy)).staked(), lqtyDeposit * 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 8)
  │   💬 Args: [unallocatedLQTY, lqtyDeposit * 2]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [unallocatedOffset, expectedOffset2, "unallocated offset"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 10)
  │   💬 Args: [UserProxy(payable(userProxy)).staked(), lqtyDeposit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 11)
  │   💬 Args: [unallocatedLQTY, lqtyDeposit]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 12)
  │   💬 Args: [unallocatedOffset, expectedOffset2 / 2, "unallocated offset2"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 13)
  │   💬 Args: [UserProxy(payable(userProxy)).staked(), 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 14)
  │   💬 Args: [unallocatedLQTY, 0]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 15)
      💬 Args: [unallocatedOffset, 0, "unallocated offset2"]
      👁️  Def: internal
```
