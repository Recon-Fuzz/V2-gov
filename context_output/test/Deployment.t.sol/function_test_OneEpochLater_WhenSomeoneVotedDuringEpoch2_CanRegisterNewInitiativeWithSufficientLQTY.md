# Function: test_OneEpochLater_WhenSomeoneVotedDuringEpoch2_CanRegisterNewInitiativeWithSufficientLQTY()

**Contract**: [test/Deployment.t.sol/contract_DeploymentTest.md]

## Metadata

- **Contract**: DeploymentTest
- **Signature**: `test_OneEpochLater_WhenSomeoneVotedDuringEpoch2_CanRegisterNewInitiativeWithSufficientLQTY()`
- **Visibility**: external
- **Source Range**: 4585:256:96

## Implementation

```solidity
function test_OneEpochLater_WhenSomeoneVotedDuringEpoch2_CanRegisterNewInitiativeWithSufficientLQTY() external {
    _voteOnInitiative();
    _depositLQTY();
    vm.warp(block.timestamp + EPOCH_DURATION);
    _registerNewInitiative();
}
```

## Related Implementations

### _voteOnInitiative()

- **Kind**: internal
- **Source**: 4902:485:96
- **Link**: `test/Deployment.t.sol:DeploymentTest:_voteOnInitiative()`

```solidity
function _voteOnInitiative() internal {
    uint256 lqtyAmount = 1 ether;
    lqty.mint(voter, lqtyAmount);
    votes.push(int256(lqtyAmount));
    vetos.push(0);
    vm.startPrank(voter);
    lqty.approve(governance.deriveUserProxyAddress(voter), lqtyAmount);
    governance.depositLQTY(lqtyAmount);
    governance.allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    vm.stopPrank();
    delete votes;
    delete vetos;
}
```

### _depositLQTY()

- **Kind**: internal
- **Source**: 5875:305:96
- **Link**: `test/Deployment.t.sol:DeploymentTest:_depositLQTY()`

```solidity
function _depositLQTY() internal {
    uint256 lqtyAmount = 1 ether;
    lqty.mint(registrant, lqtyAmount);
    vm.startPrank(registrant);
    lqty.approve(governance.deriveUserProxyAddress(registrant), lqtyAmount);
    governance.depositLQTY(lqtyAmount);
    vm.stopPrank();
}
```

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
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **voter** (`address`)
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **initiativesToReset** (`address[]`)
- **initiatives** (`address[]`)
- **votes** (`int256[]`)
- **vetos** (`int256[]`)
- **registrant** (`address`)
- **bold** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **REGISTRATION_FEE** (`uint128`)
- **newInitiative** (`address`)

## State Variable Writes

- **votes** (`int256[]`)
- **vetos** (`int256[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploymentTest.test_OneEpochLater_WhenSomeoneVotedDuringEpoch2_CanRegisterNewInitiativeWithSufficientLQTY() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: DeploymentTest._voteOnInitiative() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: DeploymentTest._depositLQTY() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: DeploymentTest._registerNewInitiative() (NodeID: 3)
      💬 Args: [no args]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: DeploymentTest._registerNewInitiative(bytes) (NodeID: 4)
        💬 Args: [""]
        👁️  Def: internal
```
