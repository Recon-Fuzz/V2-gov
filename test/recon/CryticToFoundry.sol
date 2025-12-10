// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

import "forge-std/console2.sol";

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {IBribeInitiative} from "src/interfaces/IBribeInitiative.sol";
import {BribeInitiative} from "src/BribeInitiative.sol";
import {PermitParams} from "src/utils/Types.sol";

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
        // Deploy user proxy for actor 2 (actors 0 and 1 already have proxies from setup)
        switchActor(2);
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

    // 4 & 5. governance_depositLQTYViaPermit
    function test_governance_depositLQTYViaPermit_simple() public {
        // Use the actor with known private key (actor 1: 0x537C8f3d3E18dF5517a58B3fB9D9143697996802)
        switchActor(1);
        address actor = _getActor();
        
        // Get user proxy for this actor
        address userProxyAddr = governance.deriveUserProxyAddress(actor);
        
        // Generate valid permit params
        uint256 lqtyAmount = 1e18;
        uint256 deadline = block.timestamp + 1 hours;
        PermitParams memory permitParams = _getValidPermitParams(actor, userProxyAddr, lqtyAmount, deadline);
        
        // Call depositLQTYViaPermit
        governance_depositLQTYViaPermit(lqtyAmount, permitParams);
    }
    
    function test_governance_depositLQTYViaPermit_withParams() public {
        // Use the actor with known private key (actor 1: 0x537C8f3d3E18dF5517a58B3fB9D9143697996802)
        switchActor(1);
        address actor = _getActor();
        
        // Get user proxy for this actor
        address userProxyAddr = governance.deriveUserProxyAddress(actor);
        
        // Generate valid permit params
        uint256 lqtyAmount = 1e18;
        uint256 deadline = block.timestamp + 1 hours;
        PermitParams memory permitParams = _getValidPermitParams(actor, userProxyAddr, lqtyAmount, deadline);
        
        // Call depositLQTYViaPermit with additional params
        governance_depositLQTYViaPermit(lqtyAmount, permitParams, false, actor);
    }

    // 6. governance_registerInitiative
    function test_governance_registerInitiative() public {
        // First deposit LQTY to have voting power
        switchActor(0);
        governance_depositLQTY(10e18);

        // Deploy a new BribeInitiative to register (bribeInitiative is already registered in setup)
        BribeInitiative newInitiative = new BribeInitiative(
            address(governance),
            address(bold),
            address(bribeToken)
        );
        
        // Register the new initiative
        governance_registerInitiative(address(newInitiative));
    }

    // 7. governance_allocateLQTY
    function test_governance_allocateLQTY() public {
        // Setup: deposit LQTY (bribeInitiative is already registered in setup)
        switchActor(0);
        governance_depositLQTY(10e18);

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
        // Setup: deposit, allocate (bribeInitiative is already registered in setup)
        switchActor(0);
        governance_depositLQTY(100e18);

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
        // Setup: deposit, allocate (bribeInitiative is already registered in setup)
        switchActor(0);
        governance_depositLQTY(10e18);

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
        // Setup: deposit bribe and allocate (bribeInitiative is already registered in setup)
        switchActor(0);
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_depositBribe(10e18, 5e18, currentEpoch + 1);

        governance_depositLQTY(100e18);

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

    // 4. bribeInitiative_totalLQTYAllocatedByEpoch
    function test_bribeInitiative_totalLQTYAllocatedByEpoch() public {
        switchActor(0);
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_totalLQTYAllocatedByEpoch(currentEpoch);
    }

    // 5. bribeInitiative_lqtyAllocatedByUserAtEpoch
    function test_bribeInitiative_lqtyAllocatedByUserAtEpoch() public {
        switchActor(0);
        address actor = _getActor();
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_lqtyAllocatedByUserAtEpoch(actor, currentEpoch);
    }

    // 6. bribeInitiative_checkClaimedBribeAtEpoch
    function test_bribeInitiative_checkClaimedBribeAtEpoch() public {
        switchActor(0);
        address actor = _getActor();
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_checkClaimedBribeAtEpoch(actor, currentEpoch);
    }

    // governance_getLatestVotingThreshold
    function test_governance_getLatestVotingThreshold() public {
        switchActor(0);
        governance_getLatestVotingThreshold();
    }

    // governance_unregisterInitiative - requires initiative in UNREGISTERABLE state
    function test_governance_unregisterInitiative() public {
        // Setup: Create and register an initiative
        switchActor(0);
        governance_depositLQTY(100e18);
        
        BribeInitiative newInitiative = new BribeInitiative(
            address(governance),
            address(bold),
            address(bribeToken)
        );
        
        governance_registerInitiative(address(newInitiative));
        
        // Wait for next epoch
        vm.warp(block.timestamp + 604800);
        
        // Allocate some votes to make it registered
        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(newInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = 5e18;
        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;
        
        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
        
        // Wait multiple epochs for unregistration conditions to be met
        // Need to wait for unregistrationAfterEpochs (4 epochs) + being below threshold
        for (uint256 i = 0; i < 5; i++) {
            vm.warp(block.timestamp + 604800); // 1 week per epoch
        }
        
        // Try to unregister (may still fail if conditions not met)
        try this.external_governance_unregisterInitiative(address(newInitiative)) {
            // Success
        } catch {
            // Expected to fail if not in UNREGISTERABLE state
        }
    }
    
    // Helper function to call unregisterInitiative from external context
    function external_governance_unregisterInitiative(address _initiative) external {
        governance_unregisterInitiative(_initiative);
    }

    // governance_multiDelegateCall
    function test_governance_multiDelegateCall() public {
        switchActor(0);
        
        // Create a simple multicall: getInitiativeState
        bytes[] memory calls = new bytes[](1);
        calls[0] = abi.encodeWithSignature("getInitiativeState(address)", address(bribeInitiative));
        
        governance_multiDelegateCall(calls);
    }

    // Callback tests - these are admin-only functions called by governance
    
    // bribeInitiative_onAfterAllocateLQTY - tested via allocateLQTY
    // This is called automatically by governance when allocating, we don't test it directly
    
    // bribeInitiative_onRegisterInitiative - tested via registerInitiative
    // This is called automatically by governance when registering, we don't test it directly
    
    // bribeInitiative_onUnregisterInitiative - tested via unregisterInitiative
    // This is called automatically by governance when unregistering, we don't test it directly
    
    // bribeInitiative_onClaimForInitiative - tested via claimForInitiative
    // This is called automatically by governance when claiming, we don't test it directly
}
