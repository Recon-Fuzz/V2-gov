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

    function shortcut_allocateLQTY(uint256 depositAmount, uint256 allocateAmount) public {
        // Ensure initiative is registered first
        clamped_governance_registerInitiative();
        
        // Deposit LQTY to have funds to allocate
        clamped_governance_depositLQTY();
        
        // Allocate LQTY to the registered initiative
        clamped_governance_allocateLQTY();
    }

    function shortcut_claimBribes(uint256 boldAmount, uint256 bribeTokenAmount) public {
        // First ensure initiative is registered
        clamped_governance_registerInitiative();
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        clamped_bribeInitiative_depositBribe();
        
        // Switch back to main actor to allocate and claim
        switchActor(0);
        shortcut_allocateLQTY(0, 0);
        
        // Wait for next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim bribes
        clamped_bribeInitiative_claimBribes();
    }

    function shortcut_claimForInitiative(uint256 depositAmount, uint256 allocateAmount) public {
        // Set up the full sequence: register -> deposit -> allocate -> claim
        clamped_governance_registerInitiative();
        clamped_governance_depositLQTY();
        clamped_governance_allocateLQTY();
        
        // Wait for next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        clamped_governance_claimForInitiative();
    }

    function shortcut_fullVotingCycle(uint256 depositAmount, uint256 allocateAmount, uint256 boldAmount, uint256 bribeTokenAmount) public {
        // Complete voting and bribe cycle
        
        // 1. Register initiative
        clamped_governance_registerInitiative();
        
        // 2. Deposit LQTY for voting
        clamped_governance_depositLQTY();
        
        // 3. Switch to different actor to deposit bribe
        switchActor(1);
        clamped_bribeInitiative_depositBribe();
        
        // 4. Switch back and allocate votes
        switchActor(0);
        clamped_governance_allocateLQTY();
        
        // 5. Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // 6. Claim for initiative (distributes bribes)
        clamped_governance_claimForInitiative();
        
        // 7. Claim the actual bribes
        clamped_bribeInitiative_claimBribes();
    }

    function shortcut_resetAndReallocate(uint256 newDepositAmount, uint256 newAllocateAmount) public {
        // Reset existing allocations and create new ones
        
        // Ensure initiative exists
        clamped_governance_registerInitiative();
        
        // Reset any existing allocations
        clamped_governance_resetAllocations();
        
        // Deposit fresh LQTY
        clamped_governance_depositLQTY();
        
        // Allocate to initiative
        clamped_governance_allocateLQTY();
    }

    // Override conflicting function from AdminTargets and GovernanceTargets
    function clamped_governance_multiDelegateCall() public override(AdminTargets, GovernanceTargets) asActor {
        bytes[] memory data = new bytes[](10);
        governance.multiDelegateCall(data);
    }



    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}