// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

import "forge-std/console2.sol";

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
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

    // ========== GOVERNANCE FUNCTION TESTS ==========

    // 1. governance_deployUserProxy
    function test_governance_deployUserProxy() public {
        switchActor(0);
        governance_deployUserProxy();
    }

    // 2. governance_depositLQTY(uint256 _lqtyAmount)
    function test_governance_depositLQTY_simple() public {
        switchActor(0);
        governance_depositLQTY(1e18);
    }

    // 3. governance_depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient)
    function test_governance_depositLQTY_withParams() public {
        switchActor(0);
        address actor = _getActor();
        governance_depositLQTY(1e18, false, actor);
    }

    // 4 & 5. governance_depositLQTYViaPermit (skipped - requires valid permit signature)
    // These functions require valid permit parameters which are complex to generate in tests
    // They will be tested via fuzzing but skipped in unit tests

    // 6. governance_registerInitiative
    function test_governance_registerInitiative() public {
        // First deposit LQTY to have voting power
        switchActor(0);
        governance_depositLQTY(10e18);

        // Register the bribeInitiative
        governance_registerInitiative(address(bribeInitiative));
    }

    // 7. governance_allocateLQTY
    function test_governance_allocateLQTY() public {
        // Setup: deposit LQTY and register initiative
        switchActor(0);
        governance_depositLQTY(10e18);
        governance_registerInitiative(address(bribeInitiative));

        // Wait for next epoch so initiative is no longer in WARM_UP
        vm.warp(block.timestamp + 604800); // 1 week

        // Allocate votes
        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = 5e18;
        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }

    // 8. governance_calculateVotingThreshold
    function test_governance_calculateVotingThreshold() public {
        switchActor(0);
        governance_calculateVotingThreshold();
    }

    // 9. governance_getInitiativeState
    function test_governance_getInitiativeState() public {
        switchActor(0);
        governance_getInitiativeState(address(bribeInitiative));
    }

    // 10. governance_snapshotVotesForInitiative
    function test_governance_snapshotVotesForInitiative() public {
        switchActor(0);
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    // 11. governance_claimForInitiative
    function test_governance_claimForInitiative() public {
        // Setup: deposit, register, allocate
        switchActor(0);
        governance_depositLQTY(100e18);
        governance_registerInitiative(address(bribeInitiative));

        // Wait for next epoch so initiative is no longer in WARM_UP
        vm.warp(block.timestamp + 604800); // 1 week

        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = 50e18;
        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);

        // Attempt to claim (may not succeed if conditions not met)
        governance_claimForInitiative(address(bribeInitiative));
    }

    // 12 & 13. governance_withdrawLQTY
    function test_governance_withdrawLQTY_simple() public {
        // Setup: deposit first
        switchActor(0);
        governance_depositLQTY(10e18);

        // Withdraw
        governance_withdrawLQTY(5e18);
    }

    function test_governance_withdrawLQTY_withParams() public {
        // Setup: deposit first
        switchActor(0);
        address actor = _getActor();
        governance_depositLQTY(10e18);

        // Withdraw with params
        governance_withdrawLQTY(5e18, false, actor);
    }

    // 14. governance_resetAllocations
    function test_governance_resetAllocations() public {
        // Setup: deposit, register, allocate
        switchActor(0);
        governance_depositLQTY(10e18);
        governance_registerInitiative(address(bribeInitiative));

        // Wait for next epoch so initiative is no longer in WARM_UP
        vm.warp(block.timestamp + 604800); // 1 week

        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = 5e18;
        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);

        // Reset allocations
        address[] memory toReset = new address[](1);
        toReset[0] = address(bribeInitiative);
        governance_resetAllocations(toReset, true);
    }

    // 15. governance_unregisterInitiative (complex - needs initiative in UNREGISTERABLE state)
    // Skipping for now as it requires specific FSM state

    // 16. governance_claimFromStakingV1
    function test_governance_claimFromStakingV1() public {
        switchActor(0);
        address actor = _getActor();
        // Deposit LQTY first to create stake in StakingV1 through user proxy
        governance_depositLQTY(10e18);
        // Now claim rewards from StakingV1
        governance_claimFromStakingV1(actor);
    }

    // 17. governance_multiDelegateCall (complex - depends on inputs)
    // Skipping for now as it requires specific input construction

    // 18. governance_registerInitialInitiatives (admin only - tested separately)
    function test_governance_registerInitialInitiatives() public {
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(0x999);
        governance.registerInitialInitiatives(initiatives);
    }

    // ========== BRIBE INITIATIVE FUNCTION TESTS ==========

    // 1. bribeInitiative_depositBribe
    function test_bribeInitiative_depositBribe() public {
        switchActor(0);
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_depositBribe(10e18, 5e18, currentEpoch + 1);
    }

    // 2. bribeInitiative_onAfterAllocateLQTY (callback - tested via allocateLQTY)
    // Skipping direct test as it's a callback

    // 3. bribeInitiative_claimBribes
    function test_bribeInitiative_claimBribes() public {
        // Setup: deposit bribe and allocate
        switchActor(0);
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_depositBribe(10e18, 5e18, currentEpoch + 1);

        governance_depositLQTY(100e18);
        governance_registerInitiative(address(bribeInitiative));

        // Wait for next epoch so initiative is no longer in WARM_UP
        vm.warp(block.timestamp + 604800); // 1 week

        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = 50e18;
        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);

        // Attempt to claim bribes (may not succeed if epoch conditions not met)
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](0);
        bribeInitiative_claimBribes(claimData);
    }

    // 4, 5, 6. Governance callbacks - tested via governance functions
    // Skipping direct tests as they are callbacks
}
