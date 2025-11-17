# Function: test_AtStart_CannotRegisterNewInitiative()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `test_AtStart_CannotRegisterNewInitiative()`
- **Visibility**: external
- **Source Range**: 3765:166:96

## Implementation

```solidity
function test_AtStart_CannotRegisterNewInitiative() external {
    _registerNewInitiative({expectRevertReason: "Governance: registration-not-yet-enabled"});
}
```

## Related Implementations

### _registerNewInitiative(bytes)

- **Kind**: internal
- **Source**: 5485:384:96
- **Link**: `test/Deployment.t.sol:DeploymentTest:_registerNewInitiative(bytes)`

```solidity
function _registerNewInitiative(bytes memory expectRevertReason) internal {
    bold.mint(registrant, REGISTRATION_FEE);
    vm.startPrank(registrant);
    bold.approve(address(governance), REGISTRATION_FEE);
    if (expectRevertReason.length > 0) vm.expectRevert(expectRevertReason);
    governance.registerInitiative(newInitiative);
    vm.stopPrank();
}
```

## State Variable Reads

- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **registrant** (`address`)
- **REGISTRATION_FEE** (`uint128`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **newInitiative** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploymentTest.test_AtStart_CannotRegisterNewInitiative() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DeploymentTest._registerNewInitiative(bytes) (NodeID: 1)
      💬 Args: ["Governance: registration-not-yet-enabled"]
      👁️  Def: internal
```
