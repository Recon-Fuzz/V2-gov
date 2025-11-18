// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Interfaces
import {IBribeInitiative} from "src/interfaces/IBribeInitiative.sol";
import {PermitParams} from "src/utils/Types.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import {AdminTargets} from "./targets/AdminTargets.sol";
import {BribeInitiativeTargets} from "./targets/BribeInitiativeTargets.sol";
import {DoomsdayTargets} from "./targets/DoomsdayTargets.sol";
import {GovernanceTargets} from "./targets/GovernanceTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";

abstract contract TargetFunctions is
    AdminTargets,
    BribeInitiativeTargets,
    DoomsdayTargets,
    GovernanceTargets,
    ManagersTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function shortcut_governance_claimForInitiative() public asActor {
        // Step 1: Deposit LQTY to get voting power
        clamped_governance_depositLQTY(0, false, _getActor());

        // Step 2: Register the initiative (if not already registered)
        clamped_governance_registerInitiative(address(bribeInitiative));

        // Step 3: Allocate LQTY to the initiative
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Step 4: Claim rewards for the initiative
        governance.claimForInitiative(address(bribeInitiative));
    }

    function shortcut_bribeInitiative_claimBribes() public asActor {
        // Step 1: Deposit LQTY to get voting power
        clamped_governance_depositLQTY(0, false, _getActor());

        // Step 2: Register the initiative (if not already registered)
        clamped_governance_registerInitiative(address(bribeInitiative));

        // Step 3: Allocate LQTY to the initiative
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Step 4: Deposit bribes for the initiative
        clamped_bribeInitiative_depositBribe(0, 0, 0);

        // Step 5: Claim the bribes
        clamped_bribeInitiative_claimBribes(new IBribeInitiative.ClaimData[](1));
    }

    function shortcut_full_allocation_flow() public asActor {
        // Complete flow: deposit -> register -> allocate
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_registerInitiative(address(bribeInitiative));
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_reset_allocation_flow() public asActor {
        // Flow: deposit -> allocate -> reset
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        clamped_governance_resetAllocations(new address[](0), false);
    }

    function shortcut_withdrawLQTY_complete() public asActor {
        // Complete withdrawal flow: deposit -> allocate -> reset -> withdraw
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        clamped_governance_resetAllocations(new address[](0), false);
        clamped_governance_withdrawLQTY(0, false, _getActor());
    }

    function shortcut_registerInitiative_complete() public asActor {
        // Complete registration flow: deposit -> register initiative
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_registerInitiative(address(bribeInitiative));
    }

    function shortcut_deployUserProxy_withDeposit() public asActor {
        // Deploy proxy and deposit in one flow
        clamped_governance_deployUserProxy();
        clamped_governance_depositLQTY(0, false, _getActor());
    }

    function shortcut_multiDelegateCall_withAllocation() public asActor {
        // Multi-delegate call that includes allocation
        clamped_governance_depositLQTY(0, false, _getActor());

        // Create delegate call data for allocation
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory amounts = new int256[](1);
        amounts[0] = 1;

        bytes[] memory callData = new bytes[](1);
        callData[0] = abi.encodeWithSelector(
            governance.allocateLQTY.selector, new address[](0), initiatives, new int256[](1), amounts
        );

        clamped_governance_multiDelegateCall(callData);
    }

    function shortcut_unregisterInitiative_withAllocation() public asActor {
        // Complete flow: deposit -> register -> allocate -> unregister
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_registerInitiative(address(bribeInitiative));
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        clamped_governance_unregisterInitiative(address(bribeInitiative));
    }

    function shortcut_snapshotVotes_withAllocation() public asActor {
        // Complete flow: deposit -> allocate -> snapshot
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        clamped_governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    function shortcut_bribeInitiative_fullLifecycle() public asActor {
        // Complete bribe initiative lifecycle: deposit -> register -> allocate -> deposit bribe -> claim bribes
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_registerInitiative(address(bribeInitiative));
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        clamped_bribeInitiative_depositBribe(0, 0, 0);
        clamped_bribeInitiative_claimBribes(new IBribeInitiative.ClaimData[](1));
    }

    function shortcut_governance_claimFromStakingV1_withDeposit() public asActor {
        // Deposit LQTY and then claim from staking V1
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_claimFromStakingV1(_getActor());
    }

    function shortcut_registerInitialInitiatives_withDeposit() public {
        // Deposit LQTY and register initial initiatives (admin function)
        clamped_governance_depositLQTY(0, false, _getActor());
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        clamped_governance_registerInitialInitiatives();
    }

    function shortcut_calculateVotingThreshold_withState() public asActor {
        // Set up state with multiple users and allocations to make voting threshold meaningful
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Switch to different actor to add more voting power
        switchActor(1);
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Switch back and calculate threshold
        switchActor(0);
        clamped_governance_calculateVotingThreshold();
    }

    function shortcut_getInitiativeState_withAllocations() public asActor {
        // Complete flow to get meaningful initiative state
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_registerInitiative(address(bribeInitiative));
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Get the initiative state with meaningful data
        clamped_governance_getInitiativeState(address(bribeInitiative));
    }

    function shortcut_depositLQTYViaPermit_complete() public asActor {
        // Complete permit flow: approve parameters -> deposit via permit
        clamped_governance_depositLQTYViaPermit(
            0,
            PermitParams({
                owner: _getActor(),
                spender: address(governance),
                value: 1e18,
                deadline: block.timestamp + 1 days,
                v: 27,
                r: bytes32(uint256(1)),
                s: bytes32(uint256(1))
            }),
            false,
            _getActor()
        );
    }

    function shortcut_multiActorAllocation() public asActor {
        // Multiple actors allocating to same initiative for complex state
        // Actor 0: deposit and allocate
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Actor 1: deposit and allocate
        switchActor(1);
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Actor 2: deposit and allocate
        switchActor(2);
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Switch back to actor 0 for final operations
        switchActor(0);
    }

    function shortcut_epochTransition_flow() public asActor {
        // Flow that prepares for epoch transition: deposit -> register -> allocate -> snapshot
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_registerInitiative(address(bribeInitiative));
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        clamped_governance_snapshotVotesForInitiative(address(bribeInitiative));

        // Switch to another actor to add more allocations before epoch transition
        switchActor(1);
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_complexMultiDelegateCall() public asActor {
        // Complex multi-delegate call with multiple operations
        clamped_governance_depositLQTY(0, false, _getActor());

        // Create delegate call data for multiple operations
        bytes[] memory callData = new bytes[](3);

        // Operation 1: Register initiative
        callData[0] = abi.encodeWithSelector(governance.registerInitiative.selector, address(bribeInitiative));

        // Operation 2: Allocate LQTY
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory amounts = new int256[](1);
        amounts[0] = 1;
        callData[1] = abi.encodeWithSelector(
            governance.allocateLQTY.selector, new address[](0), initiatives, new int256[](1), amounts
        );

        // Operation 3: Snapshot votes
        callData[2] = abi.encodeWithSelector(governance.snapshotVotesForInitiative.selector, address(bribeInitiative));

        clamped_governance_multiDelegateCall(callData);
    }

    function shortcut_governance_fullLifecycle() public asActor {
        // Complete governance lifecycle: deposit -> register -> allocate -> claim -> unregister
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_registerInitiative(address(bribeInitiative));
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        clamped_governance_claimForInitiative(address(bribeInitiative));
        clamped_governance_unregisterInitiative(address(bribeInitiative));
    }

    function shortcut_bribeInitiative_multiEpoch() public asActor {
        // Multi-epoch bribe flow: deposit -> register -> allocate -> deposit bribe for multiple epochs
        clamped_governance_depositLQTY(0, false, _getActor());
        clamped_governance_registerInitiative(address(bribeInitiative));
        clamped_governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));

        // Deposit bribes for current epoch
        clamped_bribeInitiative_depositBribe(0, 0, 0);

        // Switch actor and deposit for next epoch
        switchActor(1);
        clamped_bribeInitiative_depositBribe(0, 0, governance.epoch() + 1);

        // Switch back and claim
        switchActor(0);
        clamped_bribeInitiative_claimBribes(new IBribeInitiative.ClaimData[](1));
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
