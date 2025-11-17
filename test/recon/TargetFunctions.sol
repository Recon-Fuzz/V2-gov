// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import { AdminTargets } from "./targets/AdminTargets.sol";
import { BribeInitiativeTargets } from "./targets/BribeInitiativeTargets.sol";
import { DoomsdayTargets } from "./targets/DoomsdayTargets.sol";
import { GovernanceTargets } from "./targets/GovernanceTargets.sol";
import { ManagersTargets } from "./targets/ManagersTargets.sol";

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
        clamped_governance_depositLQTY();
        
        // Step 2: Register the initiative (if not already registered)
        clamped_governance_registerInitiative();
        
        // Step 3: Allocate LQTY to the initiative
        clamped_governance_allocateLQTY();
        
        // Step 4: Claim rewards for the initiative
        governance.claimForInitiative(address(bribeInitiative));
    }

    function shortcut_bribeInitiative_claimBribes() public asActor {
        // Step 1: Deposit LQTY to get voting power
        clamped_governance_depositLQTY();
        
        // Step 2: Register the initiative (if not already registered)
        clamped_governance_registerInitiative();
        
        // Step 3: Allocate LQTY to the initiative
        clamped_governance_allocateLQTY();
        
        // Step 4: Deposit bribes for the initiative
        clamped_bribeInitiative_depositBribe();
        
        // Step 5: Claim the bribes
        clamped_bribeInitiative_claimBribes();
    }

    function shortcut_full_allocation_flow() public asActor {
        // Complete flow: deposit -> register -> allocate
        clamped_governance_depositLQTY();
        clamped_governance_registerInitiative();
        clamped_governance_allocateLQTY();
    }

    function shortcut_reset_allocation_flow() public asActor {
        // Flow: deposit -> allocate -> reset
        clamped_governance_depositLQTY();
        clamped_governance_allocateLQTY();
        clamped_governance_resetAllocations();
    }


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
