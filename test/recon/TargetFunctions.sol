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
        governance_registerInitiative_clamped();
        
        // Deposit LQTY to have funds to allocate
        governance_depositLQTY_clamped(depositAmount);
        
        // Allocate LQTY to the registered initiative
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_claimBribes(uint256 boldAmount, uint256 bribeTokenAmount) public {
        // First ensure initiative is registered
        governance_registerInitiative_clamped();
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe_clamped(boldAmount, bribeTokenAmount, governance.epoch());
        
        // Switch back to main actor to allocate and claim
        switchActor(0);
        shortcut_allocateLQTY(0, 0);
        
        // Wait for next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes_clamped(claimData);
    }

    function shortcut_claimForInitiative(uint256 depositAmount, uint256 allocateAmount) public {
        // Set up the full sequence: register -> deposit -> allocate -> claim
        governance_registerInitiative_clamped();
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        governance_claimForInitiative_clamped();
    }

    function shortcut_fullVotingCycle(uint256 depositAmount, uint256 allocateAmount, uint256 boldAmount, uint256 bribeTokenAmount) public {
        // Complete voting and bribe cycle
        
        // 1. Register initiative
        governance_registerInitiative_clamped();
        
        // 2. Deposit LQTY for voting
        governance_depositLQTY_clamped(depositAmount);
        
        // 3. Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe_clamped(boldAmount, bribeTokenAmount, governance.epoch());
        
        // 4. Switch back and allocate votes
        switchActor(0);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // 5. Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // 6. Claim for initiative (distributes bribes)
        governance_claimForInitiative_clamped();
        
        // 7. Claim the actual bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes_clamped(claimData);
    }

    function shortcut_resetAndReallocate(uint256 newDepositAmount, uint256 newAllocateAmount) public {
        // Reset existing allocations and create new ones
        
        // Ensure initiative exists
        governance_registerInitiative_clamped();
        
        // Reset any existing allocations
        governance_resetAllocations_clamped();
        
        // Deposit fresh LQTY
        governance_depositLQTY_clamped(newDepositAmount);
        
        // Allocate to initiative
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }





    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}