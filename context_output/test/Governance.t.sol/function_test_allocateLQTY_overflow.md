# Function: test_allocateLQTY_overflow()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_allocateLQTY_overflow()`
- **Visibility**: public
- **Source Range**: 64305:1093:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_allocateLQTY_overflow() public {
    vm.startPrank(user);
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](2);
    initiatives[0] = baseInitiative1;
    initiatives[1] = baseInitiative2;
    int256[] memory deltaLQTYVotes = new int256[](2);
    deltaLQTYVotes[0] = 1;
    deltaLQTYVotes[1] = type(int256).max;
    int256[] memory deltaLQTYVetos = new int256[](2);
    deltaLQTYVetos[0] = 0;
    deltaLQTYVetos[1] = 0;
    vm.warp(block.timestamp + governance.EPOCH_DURATION());
    vm.expectRevert("Governance: insufficient-or-allocated-lqty");
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    deltaLQTYVotes[0] = 0;
    deltaLQTYVotes[1] = 0;
    deltaLQTYVetos[0] = 1;
    deltaLQTYVetos[1] = type(int256).max;
    vm.expectRevert("Governance: insufficient-or-allocated-lqty");
    governance.allocateLQTY(initiativesToReset, initiatives, deltaLQTYVotes, deltaLQTYVetos);
    vm.stopPrank();
}
```

## External Calls

- **Vm::startPrank(address)**
- **Vm::warp(uint256)**
- **GovernanceTester::EPOCH_DURATION()**
- **Vm::expectRevert(bytes)**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **Vm::stopPrank()**

## State Variable Reads

- **user** (`address`)
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_allocateLQTY_overflow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
