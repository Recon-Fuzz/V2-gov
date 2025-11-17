# Function: test_OneEpochLater_WhenNoOneVotedDuringEpoch2_CanRegisterNewInitiativeWithNoLQTY()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `test_OneEpochLater_WhenNoOneVotedDuringEpoch2_CanRegisterNewInitiativeWithNoLQTY()`
- **Visibility**: external
- **Source Range**: 3937:193:96

## Implementation

```solidity
function test_OneEpochLater_WhenNoOneVotedDuringEpoch2_CanRegisterNewInitiativeWithNoLQTY() external {
    vm.warp(block.timestamp + EPOCH_DURATION);
    _registerNewInitiative();
}
```

## Related Implementations

### _registerNewInitiative()

- **Kind**: internal
- **Source**: 5393:86:96
- **Link**: `test/Deployment.t.sol:DeploymentTest:_registerNewInitiative()`

```solidity
function _registerNewInitiative() internal {
    _registerNewInitiative("");
}
```

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

## External Calls

- **Vm::warp(uint256)**

## State Variable Reads

- **EPOCH_DURATION** (`uint32`)
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **registrant** (`address`)
- **REGISTRATION_FEE** (`uint128`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **newInitiative** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploymentTest.test_OneEpochLater_WhenNoOneVotedDuringEpoch2_CanRegisterNewInitiativeWithNoLQTY() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: DeploymentTest._registerNewInitiative() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: DeploymentTest._registerNewInitiative(bytes) (NodeID: 2)
        💬 Args: [""]
        👁️  Def: internal
```
