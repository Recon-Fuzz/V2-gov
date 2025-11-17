# Function: test_RegistrationFeesAreUsedAsRewardInNextEpoch()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_RegistrationFeesAreUsedAsRewardInNextEpoch()`
- **Visibility**: external
- **Source Range**: 19628:2880:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_RegistrationFeesAreUsedAsRewardInNextEpoch() external {
    IGovernance.Configuration memory config = IGovernance.Configuration({registrationFee: REGISTRATION_FEE, registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR, unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR, unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS, votingThresholdFactor: VOTING_THRESHOLD_FACTOR, minClaim: 0, minAccrual: 0, epochStart: uint256(block.timestamp) - EPOCH_DURATION, epochDuration: EPOCH_DURATION, epochVotingCutoff: EPOCH_VOTING_CUTOFF});
    governance = new GovernanceTester(address(lqty), address(lusd), address(stakingV1), address(lusd), config, address(this), new address[](0));
    baseInitiative1 = address(new BribeInitiative(address(governance), address(lusd), address(lqty)));
    baseInitiative2 = address(new BribeInitiative(address(governance), address(lusd), address(lqty)));
    address[] memory initiatives = new address[](1);
    initiatives[0] = baseInitiative1;
    governance.registerInitialInitiatives(initiatives);
    vm.prank(lusdHolder);
    lusd.transfer(user, REGISTRATION_FEE);
    vm.startPrank(user);
    {
        uint256 lqtyAmount = 1 ether;
        lqty.approve(governance.deriveUserProxyAddress(user), lqtyAmount);
        governance.depositLQTY(lqtyAmount);
        address[] memory initiativesToReset;
        int256[] memory votes = new int256[](1);
        int256[] memory vetos = new int256[](1);
        votes[0] = int256(lqtyAmount);
        governance.allocateLQTY(initiativesToReset, initiatives, votes, vetos);
        vm.warp((governance.epochStart() + EPOCH_DURATION) + 6 hours);
        lusd.approve(address(governance), REGISTRATION_FEE);
        governance.registerInitiative(baseInitiative2);
    }
    vm.stopPrank();
    governance.claimForInitiative(baseInitiative1);
    assertEqDecimal(lusd.balanceOf(baseInitiative1), 0, 18, "baseInitiative1 shouldn't have received LUSD yet");
    vm.warp(block.timestamp + EPOCH_DURATION);
    governance.claimForInitiative(baseInitiative1);
    assertEqDecimal(lusd.balanceOf(baseInitiative1), REGISTRATION_FEE, 18, "baseInitiative1 should have received the registration fee");
}
```

## Related Implementations

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

## External Calls

- **GovernanceTester::registerInitialInitiatives(address[])**
- **Vm::prank(address)**
- **ILUSD::transfer(address,uint256)**
- **Vm::startPrank(address)**
- **ILQTY::approve(address,uint256)**
- **GovernanceTester::deriveUserProxyAddress(address)**
- **GovernanceTester::depositLQTY(uint256)**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**
- **Vm::warp(uint256)**
- **GovernanceTester::epochStart()**
- **ILUSD::approve(address,uint256)**
- **GovernanceTester::registerInitiative(address)**
- **Vm::stopPrank()**
- **GovernanceTester::claimForInitiative(address)**
- **ILUSD::balanceOf(address)**

## Native Transfers

- **lusd** (computed)

## State Variable Reads

- **REGISTRATION_FEE** (`uint256`)
- **REGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_THRESHOLD_FACTOR** (`uint256`)
- **UNREGISTRATION_AFTER_EPOCHS** (`uint256`)
- **VOTING_THRESHOLD_FACTOR** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **EPOCH_VOTING_CUTOFF** (`uint32`)
- **lqty** (`contract ILQTY`) [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **lusd** (`contract ILUSD`) [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **stakingV1** (`contract ILQTYStaking`) [src/interfaces/ILQTYStaking.sol/interface_ILQTYStaking.md]
- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **baseInitiative1** (`address`)
- **lusdHolder** (`address`)
- **user** (`address`)
- **baseInitiative2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## State Variable Writes

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]
- **baseInitiative1** (`address`)
- **baseInitiative2** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_RegistrationFeesAreUsedAsRewardInNextEpoch() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 1)
  │   💬 Args: [lusd.balanceOf(baseInitiative1), 0, 18, "baseInitiative1 shouldn't have received LUSD yet"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 2)
      💬 Args: [lusd.balanceOf(baseInitiative1), REGISTRATION_FEE, 18, "baseInitiative1 should have received the registration fee"]
      👁️  Def: internal
```
