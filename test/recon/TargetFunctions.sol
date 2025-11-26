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
// import {
//     CurveV2GaugeRewardsTargets
// } from "./targets/CurveV2GaugeRewardsTargets.sol";
// import {DoomsdayTargets} from "./targets/DoomsdayTargets.sol";
import {GovernanceTargets} from "./targets/GovernanceTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";
// import {UserProxyTargets} from "./targets/UserProxyTargets.sol";
// import {UniV4MerklRewardsTargets} from "./targets/UniV4MerklRewardsTargets.sol";

abstract contract TargetFunctions is
    AdminTargets,
    BribeInitiativeTargets,
    GovernanceTargets,
    ManagersTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    /// @dev Shortcut to enable claiming bribes - deposits LQTY, registers initiative, allocates votes, and deposits bribes
    function shortcut_claimBribes(
        uint256 depositAmount,
        int256 voteAmount,
        uint256 boldBribeAmount,
        uint256 bribeTokenAmount,
        uint256 epoch
    ) public {
        // Deposit LQTY with actor 0
        governance_depositLQTY_clamped(depositAmount);
        
        // Register the bribe initiative to make it votable
        governance_registerInitiative_clamped();
        
        // Allocate LQTY votes to the initiative
        governance_allocateLQTY_clamped(voteAmount, 0);
        
        // Switch to different actor to deposit bribes
        switchActor(1);
        bribeInitiative_depositBribe_clamped(boldBribeAmount, bribeTokenAmount, epoch);
        
        // Switch back to actor 0 for potential claim
        switchActor(0);
    }

    /// @dev Shortcut to enable allocating LQTY - deposits LQTY and registers initiative before allocation
    function shortcut_allocateLQTY(
        uint256 depositAmount,
        int256 voteAmount,
        int256 vetoAmount
    ) public {
        // Deposit LQTY to have funds available
        governance_depositLQTY_clamped(depositAmount);
        
        // Register the initiative to make it votable
        governance_registerInitiative_clamped();
        
        // Allocate votes and vetos to the initiative
        governance_allocateLQTY_clamped(voteAmount, vetoAmount);
    }

    /// @dev Shortcut to enable unregistering initiatives - deposits LQTY, allocates vetos, waits, then unregisters
    function shortcut_unregisterInitiative(
        uint256 depositAmount,
        int256 vetoAmount
    ) public {
        // First register the initiative
        governance_registerInitiative_clamped();
        
        // Deposit LQTY to have voting power
        governance_depositLQTY_clamped(depositAmount);
        
        // Allocate vetos to the initiative to enable unregistration
        governance_allocateLQTY_clamped(0, vetoAmount);
        
        // Attempt to unregister (may fail if time/vote conditions not met)
        governance_unregisterInitiative_clamped();
    }

    /// @dev Shortcut to enable resetting allocations - deposits LQTY, allocates, then resets
    function shortcut_resetAllocations(
        uint256 depositAmount,
        int256 voteAmount,
        bool checkAll
    ) public {
        // Deposit LQTY
        governance_depositLQTY_clamped(depositAmount);
        
        // Register the initiative
        governance_registerInitiative_clamped();
        
        // Allocate to the initiative
        governance_allocateLQTY_clamped(voteAmount, 0);
        
        // Reset the allocations
        governance_resetAllocations_clamped(checkAll);
    }

    /// @dev Shortcut to enable claiming for initiative - deposits from multiple actors, allocates, deposits bribes
    function shortcut_claimForInitiative(
        uint256 depositAmount1,
        uint256 depositAmount2,
        int256 voteAmount1,
        int256 voteAmount2,
        uint256 boldBribeAmount,
        uint256 bribeTokenAmount,
        uint256 epoch
    ) public {
        // Actor 0: deposit LQTY and register initiative
        governance_depositLQTY_clamped(depositAmount1);
        governance_registerInitiative_clamped();
        governance_allocateLQTY_clamped(voteAmount1, 0);
        
        // Actor 1: deposit LQTY and allocate
        switchActor(1);
        governance_depositLQTY_clamped(depositAmount2);
        governance_allocateLQTY_clamped(voteAmount2, 0);
        
        // Deposit bribes for the epoch
        bribeInitiative_depositBribe_clamped(boldBribeAmount, bribeTokenAmount, epoch);
        
        // Claim for the initiative
        governance_claimForInitiative_clamped();
        
        // Switch back to actor 0
        switchActor(0);
    }

    /// @dev Shortcut to enable withdrawing LQTY - deposits LQTY, allocates, resets, then withdraws
    function shortcut_withdrawLQTY(
        uint256 depositAmount,
        int256 voteAmount,
        uint256 withdrawAmount
    ) public {
        // Deposit LQTY
        governance_depositLQTY_clamped(depositAmount);
        
        // Register and allocate
        governance_registerInitiative_clamped();
        governance_allocateLQTY_clamped(voteAmount, 0);
        
        // Reset allocations to free up LQTY
        governance_resetAllocations_clamped(false);
        
        // Withdraw the LQTY
        governance_withdrawLQTY_clamped(withdrawAmount);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
