// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

import "forge-std/console2.sol";

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {BribeInitiative} from "src/BribeInitiative.sol";
import {IBribeInitiative} from "src/interfaces/IBribeInitiative.sol";


// forge test --match-contract CryticToFoundry -vv
contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();

        targetContract(address(this));
    }

    // forge test --match-test test_crytic -vvv
    function test_crytic() public {
        // TODO: add failing property tests here for debugging
    }

    // ============ PHASE 2 TESTS ============
    // Tests implemented in order from testing_priority.md

    // Test 1: governance_deployUserProxy
    function test_governance_deployUserProxy() public {
        // Use a completely new address that's not in setup
        address newActor = address(0x999);

        vm.prank(newActor);
        governance.deployUserProxy();

        // Verify proxy was deployed
        address userProxy = governance.deriveUserProxyAddress(newActor);
        assertTrue(userProxy.code.length > 0, "UserProxy should be deployed");
    }

    // Test 2: governance_calculateVotingThreshold
    function test_governance_calculateVotingThreshold() public {
        // Should be callable by anyone, no special setup needed
        governance_calculateVotingThreshold();
    }

    // Test 3: governance_getInitiativeState
    function test_governance_getInitiativeState() public {
        // Query state of an already registered initiative
        governance_getInitiativeState(address(bribeInitiative));
    }

    // Test 4: bribeInitiative_depositBribe
    function test_bribeInitiative_depositBribe() public {
        // Switch to an actor with tokens
        switchActor(1);

        // Deposit bribes for the current epoch
        uint256 epoch = governance.epoch();
        bribeInitiative_depositBribe(100e18, 100e18, epoch);
    }

    // Test 5: governance_depositLQTY
    function test_governance_depositLQTY() public {
        // Use a new actor with fresh tokens
        address newActor = address(0x888);
        lqty.mint(newActor, 10000e18);

        // Deploy user proxy first
        vm.prank(newActor);
        governance.deployUserProxy();

        // Approve LQTY
        address userProxy = governance.deriveUserProxyAddress(newActor);
        vm.prank(newActor);
        lqty.approve(userProxy, type(uint256).max);

        // Deposit LQTY
        vm.prank(newActor);
        governance.depositLQTY(1000e18);
    }

    // Test 6: governance_depositLQTYViaPermit
    // Note: Skipping this as it requires signature generation which is complex in testing
    // The underlying depositLQTY is tested above

    // Test 7: governance_withdrawLQTY
    function test_governance_withdrawLQTY() public {
        // Switch to an actor that already has deposited LQTY (from setup)
        switchActor(1);

        // Withdraw some LQTY
        governance_withdrawLQTY(1000e18);
    }

    // Test 8: governance_allocateLQTY
    function test_governance_allocateLQTY() public {
        // Switch to an actor that already has deposited LQTY (from setup)
        switchActor(1);

        // Need to warp to the next epoch to be able to allocate
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);

        // Allocate to the bribe initiative
        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);

        int256[] memory votes = new int256[](1);
        votes[0] = 1000e18;

        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }

    // Test 9: governance_registerInitiative
    function test_governance_registerInitiative() public {
        // Deploy a new BribeInitiative to register
        BribeInitiative newInitiative = new BribeInitiative(
            address(governance),
            address(bold),
            address(bribeToken)
        );

        // Switch to an actor with enough LQTY deposited
        switchActor(1);

        // Need to warp forward 4 epochs for registration to be enabled
        vm.warp(block.timestamp + (governance.EPOCH_DURATION() * 4) + 1);

        // Register the initiative
        governance_registerInitiative(address(newInitiative));
    }

    // Test 10: governance_unregisterInitiative
    function test_governance_unregisterInitiative() public {
        // First register an initiative
        BribeInitiative newInitiative = new BribeInitiative(
            address(governance),
            address(bold),
            address(bribeToken)
        );

        switchActor(1);
        vm.warp(block.timestamp + (governance.EPOCH_DURATION() * 4) + 1);
        governance_registerInitiative(address(newInitiative));

        // Warp forward enough epochs without claiming to make it unregisterable
        // Need to wait UNREGISTRATION_AFTER_EPOCHS + 2 to ensure the condition is met
        vm.warp(block.timestamp + (governance.EPOCH_DURATION() * (governance.UNREGISTRATION_AFTER_EPOCHS() + 2)) + 1);

        // Unregister the initiative
        governance_unregisterInitiative(address(newInitiative));
    }

    // Test 11: governance_claimFromStakingV1
    function test_governance_claimFromStakingV1() public {
        // Setup: Add gains to staking V1
        lusd.mint(address(this), 1000e18);
        lusd.approve(address(stakingV1), type(uint256).max);
        stakingV1.mock_addLUSDGain(1000e18);

        vm.deal(address(this), 10 ether);
        stakingV1.mock_addETHGain{value: 1 ether}();

        // Switch to an actor with staked LQTY in V1
        switchActor(1);

        // Claim from staking V1
        governance_claimFromStakingV1(_getActor());
    }

    // Test 12: governance_resetAllocations
    function test_governance_resetAllocations() public {
        // First allocate to an initiative
        switchActor(1);
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);

        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);

        int256[] memory votes = new int256[](1);
        votes[0] = 1000e18;

        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);

        // Move to next epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);

        // Reset allocations
        address[] memory initToReset = new address[](1);
        initToReset[0] = address(bribeInitiative);
        governance_resetAllocations(initToReset, false);
    }

    // Test 13: governance_snapshotVotesForInitiative
    function test_governance_snapshotVotesForInitiative() public {
        // First allocate to an initiative
        switchActor(1);
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);

        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);

        int256[] memory votes = new int256[](1);
        votes[0] = 1000e18;

        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);

        // Move to next epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);

        // Snapshot votes for the initiative
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    // Test 14: bribeInitiative_claimBribes
    function test_bribeInitiative_claimBribes() public {
        // Switch to actor with voting power
        switchActor(1);

        // Move to next epoch to start allocating
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        uint256 allocationEpoch = governance.epoch();

        // Deposit bribe for the current epoch
        bribeInitiative_depositBribe(100e18, 100e18, allocationEpoch);

        // Allocate votes to the initiative in this epoch
        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);

        int256[] memory votes = new int256[](1);
        votes[0] = 1000e18;

        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);

        // Move to next epoch so we can claim bribes for the allocation epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);

        // Prepare claim data for the allocation epoch
        // Both prev epochs should be the allocation epoch since that's when the allocation was recorded
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: allocationEpoch,
            prevLQTYAllocationEpoch: allocationEpoch,
            prevTotalLQTYAllocationEpoch: allocationEpoch
        });

        bribeInitiative_claimBribes(claimData);
    }

    // Test 15: governance_claimForInitiative
    function test_governance_claimForInitiative() public {
        // First allocate to an initiative and snapshot
        switchActor(1);
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);

        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);

        int256[] memory votes = new int256[](1);
        votes[0] = 1000e18;

        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);

        // Move to next epoch and snapshot
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        governance_snapshotVotesForInitiative(address(bribeInitiative));

        // Add BOLD to governance for rewards
        bold.mint(address(governance), 10000e18);

        // Claim for initiative
        governance_claimForInitiative(address(bribeInitiative));
    }

    // Test 16: governance_multiDelegateCall
    function test_governance_multiDelegateCall() public {
        switchActor(1);

        // Create calldata for a simple view function
        bytes[] memory calls = new bytes[](1);
        calls[0] = abi.encodeWithSignature("epoch()");

        governance_multiDelegateCall(calls);
    }
}