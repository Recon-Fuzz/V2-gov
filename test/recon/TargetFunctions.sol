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

    /// @dev Shortcut to enable an actor to claim bribes from a registered initiative
    /// Prerequisites: deposit LQTY → register initiative → allocate LQTY → deposit bribes → advance epoch
    function shortcut_claimBribes(uint256 depositAmount, uint256 allocateAmount, uint256 boldBribeAmount, uint256 bribeTokenAmount, uint8 initiativeIndex) public {
        // 1. Deposit LQTY with current actor
        governance_depositLQTY_clamped(depositAmount);
        
        // 2. Register the initiative (requires BOLD registration fee)
        governance_registerInitiative_clamped(initiativeIndex);
        
        // 3. Allocate LQTY to the initiative
        governance_allocateLQTY_clamped(initiativeIndex, int256(allocateAmount), 0);
        
        // 4. Switch to different actor to deposit bribes
        switchActor(1);
        bribeInitiative_depositBribe_clamped(boldBribeAmount, bribeTokenAmount, governance.epoch() + 1);
        
        // 5. Advance time to next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week
        
        // 6. Switch back to original actor and claim bribes
        switchActor(0);
        bribeInitiative_claimBribes_clamped(governance.epoch() - 1);
    }

    /// @dev Shortcut to enable claiming BOLD rewards from governance for an initiative
    /// Prerequisites: deposit LQTY → register initiative → allocate LQTY → advance epoch → claim
    function shortcut_claimForInitiative(uint256 depositAmount, uint256 allocateAmount, uint8 initiativeIndex) public {
        // 1. Deposit LQTY with current actor
        governance_depositLQTY_clamped(depositAmount);
        
        // 2. Register the initiative
        governance_registerInitiative_clamped(initiativeIndex);
        
        // 3. Allocate LQTY to the initiative
        governance_allocateLQTY_clamped(initiativeIndex, int256(allocateAmount), 0);
        
        // 4. Advance time to next epoch
        vm.warp(block.timestamp + 604800); // 1 week
        
        // 5. Claim rewards for the initiative
        governance_claimForInitiative_clamped(initiativeIndex);
    }

    /// @dev Shortcut to enable allocation of LQTY to an initiative
    /// Prerequisites: deposit LQTY → register initiative → allocate
    function shortcut_allocateLQTY(uint256 depositAmount, uint256 voteAmount, uint256 vetoAmount, uint8 initiativeIndex) public {
        // 1. Deposit LQTY with current actor
        governance_depositLQTY_clamped(depositAmount);
        
        // 2. Register the initiative
        governance_registerInitiative_clamped(initiativeIndex);
        
        // 3. Allocate LQTY to the initiative
        governance_allocateLQTY_clamped(initiativeIndex, int256(voteAmount), int256(vetoAmount));
    }

    /// @dev Shortcut to enable snapshot voting for an initiative with existing allocations
    /// Prerequisites: deposit LQTY → register initiative → allocate LQTY → advance to voting cutoff → snapshot
    function shortcut_snapshotVotesForInitiative(uint256 depositAmount, uint256 allocateAmount, uint8 initiativeIndex) public {
        // 1. Deposit LQTY with current actor
        governance_depositLQTY_clamped(depositAmount);
        
        // 2. Register the initiative
        governance_registerInitiative_clamped(initiativeIndex);
        
        // 3. Allocate LQTY to the initiative
        governance_allocateLQTY_clamped(initiativeIndex, int256(allocateAmount), 0);
        
        // 4. Advance time to voting cutoff (6 days into epoch)
        vm.warp(block.timestamp + 518400); // 6 days
        
        // 5. Snapshot votes for the initiative
        governance_snapshotVotesForInitiative_clamped(initiativeIndex);
    }

    /// @dev Shortcut to enable withdrawing LQTY after resetting allocations
    /// Prerequisites: deposit LQTY → register initiative → allocate LQTY → reset allocations → withdraw
    function shortcut_withdrawLQTY(uint256 depositAmount, uint256 allocateAmount, uint256 withdrawAmount, uint8 initiativeIndex) public {
        // 1. Deposit LQTY with current actor
        governance_depositLQTY_clamped(depositAmount);
        
        // 2. Register the initiative
        governance_registerInitiative_clamped(initiativeIndex);
        
        // 3. Allocate LQTY to the initiative
        governance_allocateLQTY_clamped(initiativeIndex, int256(allocateAmount), 0);
        
        // 4. Reset allocations to free up LQTY
        governance_resetAllocations_clamped();
        
        // 5. Withdraw LQTY
        governance_withdrawLQTY_clamped(withdrawAmount);
    }

    /// @dev Shortcut to setup a complete bribe cycle with multiple actors
    /// Prerequisites: deposit LQTY (multiple actors) → register initiative → allocate LQTY → deposit bribes → advance epoch
    function shortcut_setupBribeCycle(uint256 deposit1, uint256 deposit2, uint256 allocate1, uint256 allocate2, uint256 boldBribe, uint256 tokenBribe, uint8 initiativeIndex) public {
        // 1. First actor deposits and allocates LQTY
        governance_depositLQTY_clamped(deposit1);
        governance_registerInitiative_clamped(initiativeIndex);
        governance_allocateLQTY_clamped(initiativeIndex, int256(allocate1), 0);
        
        // 2. Second actor deposits and allocates LQTY
        switchActor(1);
        governance_depositLQTY_clamped(deposit2);
        governance_allocateLQTY_clamped(initiativeIndex, int256(allocate2), 0);
        
        // 3. Second actor also deposits bribes for next epoch
        bribeInitiative_depositBribe_clamped(boldBribe, tokenBribe, governance.epoch() + 1);
        
        // 4. Advance to next epoch
        vm.warp(block.timestamp + 604800);
        
        // 5. Return to first actor
        switchActor(0);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
