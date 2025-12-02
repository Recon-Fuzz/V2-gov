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
import {
    CurveV2GaugeRewardsTargets
} from "./targets/CurveV2GaugeRewardsTargets.sol";
import {DoomsdayTargets} from "./targets/DoomsdayTargets.sol";
import {GovernanceTargets} from "./targets/GovernanceTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";
import {UniV4MerklRewardsTargets} from "./targets/UniV4MerklRewardsTargets.sol";

abstract contract TargetFunctions is
    AdminTargets,
    BribeInitiativeTargets,
    CurveV2GaugeRewardsTargets,
    DoomsdayTargets,
    GovernanceTargets,
    ManagersTargets,
    UniV4MerklRewardsTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
    
    // Helper function to warp time forward by N epochs
    function _warpEpochs(uint256 _numEpochs) internal {
        vm.warp(block.timestamp + (604800 * _numEpochs)); // 604800 = 1 week
    }
    
    // Shortcut: Allocate LQTY to initiatives
    // Prerequisites: depositLQTY, registerInitiative(s), allocateLQTY
    function shortcut_allocateLQTY(
        uint256 _lqtyAmount,
        uint256 _numInitiatives,
        uint256 _voteAmount1,
        uint256 _voteAmount2,
        bool _isVeto1,
        bool _isVeto2
    ) public {
        // First deposit LQTY for the current actor
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register initiatives if needed (using different actor to have BOLD for fees)
        switchActor(1);
        governance_registerInitiative_clamped(0); // Register bribeInitiative
        governance_registerInitiative_clamped(1); // Register curveV2GaugeRewards
        
        // Switch back to original actor and allocate
        switchActor(0);
        governance_allocateLQTY_clamped(_numInitiatives, _voteAmount1, _voteAmount2, _isVeto1, _isVeto2);
    }
    
    // Shortcut: Claim bribes from BribeInitiative
    // Prerequisites: depositLQTY, registerInitiative, allocateLQTY, depositBribe, warp time, claimBribes
    function shortcut_claimBribes(
        uint256 _depositAmount,
        uint256 _allocAmount,
        uint256 _bribeAmount,
        uint256 _numClaims
    ) public {
        // Actor 0: Deposit LQTY and allocate to bribe initiative
        governance_depositLQTY_clamped(_depositAmount);
        
        // Register bribe initiative with actor 1 (needs BOLD)
        switchActor(1);
        governance_registerInitiative_clamped(0);
        
        // Switch back to actor 0 and allocate
        switchActor(0);
        governance_allocateLQTY_clamped(1, _allocAmount, 0, false, false);
        
        // Actor 1: Deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe_clamped(_bribeAmount, _bribeAmount, governance.epoch());
        
        // Warp to next epoch to allow claims
        _warpEpochs(1);
        
        // Switch back to actor 0 and claim bribes
        switchActor(0);
        bribeInitiative_claimBribes_clamped(_numClaims, governance.epoch() - 1, governance.epoch() - 1, 0, 0, 0, 0);
    }
    
    // Shortcut: Reset allocations and reallocate
    // Prerequisites: depositLQTY, registerInitiative, allocateLQTY, resetAllocations, allocateLQTY again
    function shortcut_resetAndReallocate(
        uint256 _initialDeposit,
        uint256 _initialAlloc1,
        uint256 _initialAlloc2,
        uint256 _newAlloc1,
        uint256 _newAlloc2
    ) public {
        // Deposit LQTY
        governance_depositLQTY_clamped(_initialDeposit);
        
        // Register initiatives with different actor
        switchActor(1);
        governance_registerInitiative_clamped(0);
        governance_registerInitiative_clamped(1);
        
        // Switch back and make initial allocation
        switchActor(0);
        governance_allocateLQTY_clamped(2, _initialAlloc1, _initialAlloc2, false, false);
        
        // Reset allocations
        governance_resetAllocations_clamped(2, false);
        
        // Reallocate with new amounts
        governance_allocateLQTY_clamped(2, _newAlloc1, _newAlloc2, false, false);
    }
    
    // Shortcut: Unregister initiative
    // Prerequisites: registerInitiative, allocateLQTY (to generate vetos), warp time, unregisterInitiative
    function shortcut_unregisterInitiative(
        uint256 _depositAmount,
        uint256 _vetoAmount,
        uint256 _initiativeIndex
    ) public {
        // Register initiative with actor 0
        governance_registerInitiative_clamped(_initiativeIndex);
        
        // Switch to actor 1, deposit and allocate vetos
        switchActor(1);
        governance_depositLQTY_clamped(_depositAmount);
        governance_allocateLQTY_clamped(1, _vetoAmount, 0, true, false); // Allocate vetos
        
        // Warp forward multiple epochs to make initiative unregisterable
        _warpEpochs(5);
        
        // Switch back to actor 0 and unregister
        switchActor(0);
        governance_unregisterInitiative_clamped(_initiativeIndex);
    }
    
    // Shortcut: Claim rewards for initiative
    // Prerequisites: registerInitiative, depositLQTY, allocateLQTY, deposit BOLD to governance, warp epoch, claimForInitiative
    function shortcut_claimForInitiative(
        uint256 _depositAmount,
        uint256 _allocAmount,
        uint256 _boldAmount,
        uint256 _initiativeIndex
    ) public {
        // Register initiative
        governance_registerInitiative_clamped(_initiativeIndex);
        
        // Deposit LQTY and allocate votes to initiative
        governance_depositLQTY_clamped(_depositAmount);
        governance_allocateLQTY_clamped(1, _allocAmount, 0, false, false);
        
        // Send BOLD to governance contract (simulating protocol revenue)
        switchActor(1);
        asset_mint(address(governance), uint128(_boldAmount));
        
        // Warp to next epoch
        _warpEpochs(1);
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative_clamped(_initiativeIndex);
    }
    
    // Shortcut: Withdraw LQTY after resetting allocations
    // Prerequisites: depositLQTY, allocateLQTY, resetAllocations, withdrawLQTY
    function shortcut_withdrawLQTY(
        uint256 _depositAmount,
        uint256 _allocAmount,
        uint256 _withdrawAmount
    ) public {
        // Deposit LQTY
        governance_depositLQTY_clamped(_depositAmount);
        
        // Register initiative with different actor
        switchActor(1);
        governance_registerInitiative_clamped(0);
        
        // Allocate some LQTY
        switchActor(0);
        governance_allocateLQTY_clamped(1, _allocAmount, 0, false, false);
        
        // Reset allocations to free up LQTY
        governance_resetAllocations_clamped(1, false);
        
        // Withdraw LQTY
        governance_withdrawLQTY_clamped(_withdrawAmount);
    }
    
    // Shortcut: Full voting cycle with snapshot and claim
    // Prerequisites: registerInitiative, depositLQTY, allocateLQTY, deposit BOLD, warp epoch, snapshotVotesForInitiative, claimForInitiative
    function shortcut_fullVotingCycle(
        uint256 _depositAmount,
        uint256 _allocAmount,
        uint256 _boldAmount,
        uint256 _initiativeIndex
    ) public {
        // Register initiative
        governance_registerInitiative_clamped(_initiativeIndex);
        
        // Multiple actors deposit and vote
        governance_depositLQTY_clamped(_depositAmount);
        governance_allocateLQTY_clamped(1, _allocAmount, 0, false, false);
        
        switchActor(1);
        governance_depositLQTY_clamped(_depositAmount);
        governance_allocateLQTY_clamped(1, _allocAmount, 0, false, false);
        
        // Add BOLD rewards to governance
        asset_mint(address(governance), uint128(_boldAmount));
        
        // Warp to next epoch
        _warpEpochs(1);
        
        // Snapshot votes for initiative
        switchActor(0);
        governance_snapshotVotesForInitiative_clamped(_initiativeIndex);
        
        // Claim rewards for initiative
        governance_claimForInitiative_clamped(_initiativeIndex);
    }
    
    // Shortcut: Multi-epoch bribe scenario
    // Prerequisites: registerInitiative, depositLQTY, allocateLQTY, depositBribe for multiple epochs, warp, claimBribes
    function shortcut_multiEpochBribes(
        uint256 _depositAmount,
        uint256 _allocAmount,
        uint256 _bribeAmount1,
        uint256 _bribeAmount2
    ) public {
        // Register initiative
        switchActor(1);
        governance_registerInitiative_clamped(0);
        
        // Actor 0: Deposit and allocate
        switchActor(0);
        governance_depositLQTY_clamped(_depositAmount);
        governance_allocateLQTY_clamped(1, _allocAmount, 0, false, false);
        
        // Actor 1: Deposit bribes for current and next epoch
        switchActor(1);
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_depositBribe_clamped(_bribeAmount1, _bribeAmount1, currentEpoch);
        bribeInitiative_depositBribe_clamped(_bribeAmount2, _bribeAmount2, currentEpoch + 1);
        
        // Warp forward 2 epochs
        _warpEpochs(2);
        
        // Actor 0: Claim bribes from both epochs
        switchActor(0);
        bribeInitiative_claimBribes_clamped(2, currentEpoch, currentEpoch + 1, 0, 0, 0, 0);
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
