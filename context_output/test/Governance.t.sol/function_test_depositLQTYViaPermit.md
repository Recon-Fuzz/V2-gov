# Function: test_depositLQTYViaPermit()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_depositLQTYViaPermit()`
- **Visibility**: public
- **Source Range**: 7961:2331:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_depositLQTYViaPermit() public {
    uint256 timeIncrease = 86400 * 30;
    vm.warp(block.timestamp + timeIncrease);
    vm.startPrank(user);
    VmSafe.Wallet memory wallet = vm.createWallet(uint256(keccak256(bytes("1"))));
    lqty.transfer(wallet.addr, 1e18);
    vm.stopPrank();
    vm.startPrank(wallet.addr);
    address userProxy = governance.deriveUserProxyAddress(wallet.addr);
    PermitParams memory permitParams = PermitParams({owner: wallet.addr, spender: address(userProxy), value: 1e18, deadline: block.timestamp + 86400, v: 0, r: "", s: ""});
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(wallet.privateKey, keccak256(abi.encodePacked("\u0019\u0001", ILQTY(address(lqty)).domainSeparator(), keccak256(abi.encode(0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9, permitParams.owner, permitParams.spender, permitParams.value, 0, permitParams.deadline)))));
    permitParams.v = v;
    permitParams.r = r;
    _expectInsufficientAllowance();
    governance.depositLQTYViaPermit(1e18, permitParams);
    permitParams.s = s;
    vm.startPrank(address(this));
    vm.expectRevert("UserProxy: owner-not-sender");
    governance.depositLQTYViaPermit(1e18, permitParams);
    vm.stopPrank();
    vm.startPrank(wallet.addr);
    _expectInsufficientAllowanceAndBalance();
    governance.depositLQTYViaPermit(1e26, permitParams);
    governance.depositLQTYViaPermit(1e18, permitParams);
    assertEq(UserProxy(payable(userProxy)).staked(), 1e18);
    (uint256 unallocatedLQTY, uint256 unallocatedOffset, , ) = governance.userStates(wallet.addr);
    assertEq(unallocatedLQTY, 1e18);
    assertEq(unallocatedOffset, 1e18 * block.timestamp);
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

## External Calls

- **Vm::warp(uint256)**
- **Vm::startPrank(address)**
- **Vm::createWallet(uint256)**
- **ILQTY::transfer(address,uint256)**
- **Vm::stopPrank()**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **Vm::sign(uint256,bytes32)**
- **ILQTY::domainSeparator()**
- **GovernanceTester::depositLQTYViaPermit(uint256,struct PermitParams)**
- **Vm::expectRevert(bytes)**
- **UserProxy::staked()**
- **GovernanceTester::userStates(address)**

## Native Transfers

- **lqty** (computed)

## State Variable Reads

- **user** (`address`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_depositLQTYViaPermit() (NodeID: 0)
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
  │   💬 Args: [UserProxy(payable(userProxy)).staked(), 1e18]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 5)
  │   💬 Args: [unallocatedLQTY, 1e18]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256) (NodeID: 6)
      💬 Args: [unallocatedOffset, 1e18 * block.timestamp]
      👁️  Def: internal
```
