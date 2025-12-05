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
    
    // ========== GOVERNANCE SHORTCUTS ==========
    
    /// @dev Shortcut to allocate LQTY to bribeInitiative
    /// Prerequisites: depositLQTY -> registerInitiative -> allocateLQTY
    function shortcut_allocateLQTY_bribeInitiative(
        uint256 _lqtyAmount,
        uint256 _voteSeed,
        uint256 _vetoSeed
    ) public {
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register the bribe initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Warp time to make initiative votable (needs to be in SKIP state)
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Allocate LQTY to the initiative
        governance_allocateLQTY_bribeInitiative_clamped(_voteSeed, _vetoSeed);
    }
    
    /// @dev Shortcut to allocate LQTY to curveV2 initiative
    /// Prerequisites: depositLQTY -> registerInitiative -> allocateLQTY
    function shortcut_allocateLQTY_curveV2(
        uint256 _lqtyAmount,
        uint256 _voteSeed,
        uint256 _vetoSeed
    ) public {
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register the curve initiative
        governance_registerInitiative_curveV2_clamped();
        
        // Warp time to make initiative votable
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Allocate LQTY to the initiative
        governance_allocateLQTY_curveV2_clamped(_voteSeed, _vetoSeed);
    }
    
    /// @dev Shortcut to allocate LQTY to uniV4 initiative
    /// Prerequisites: depositLQTY -> registerInitiative -> allocateLQTY
    function shortcut_allocateLQTY_uniV4(
        uint256 _lqtyAmount,
        uint256 _voteSeed,
        uint256 _vetoSeed
    ) public {
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register the uniV4 initiative
        governance_registerInitiative_uniV4_clamped();
        
        // Warp time to make initiative votable
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Allocate LQTY to the initiative
        governance_allocateLQTY_uniV4_clamped(_voteSeed, _vetoSeed);
    }
    
    /// @dev Shortcut to allocate LQTY to all initiatives
    /// Prerequisites: depositLQTY -> registerInitiatives -> allocateLQTY
    function shortcut_allocateLQTY_allInitiatives(
        uint256 _lqtyAmount,
        uint256 _vote1Seed,
        uint256 _veto1Seed,
        uint256 _vote2Seed,
        uint256 _veto2Seed,
        uint256 _vote3Seed,
        uint256 _veto3Seed
    ) public {
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register all initiatives
        governance_registerInitiative_bribeInitiative_clamped();
        governance_registerInitiative_curveV2_clamped();
        governance_registerInitiative_uniV4_clamped();
        
        // Warp time to make initiatives votable
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Allocate LQTY to all initiatives
        governance_allocateLQTY_allInitiatives_clamped(_vote1Seed, _veto1Seed, _vote2Seed, _veto2Seed, _vote3Seed, _veto3Seed);
    }
    
    /// @dev Shortcut to claim for initiative after voting
    /// Prerequisites: depositLQTY -> registerInitiative -> allocateLQTY -> warp -> claimForInitiative
    function shortcut_claimForInitiative_bribeInitiative(
        uint256 _lqtyAmount,
        uint256 _voteSeed
    ) public {
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register the bribe initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Warp to next epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Allocate LQTY (only votes, no vetos)
        governance_allocateLQTY_bribeInitiative_clamped(_voteSeed, 0);
        
        // Warp to next epoch to make claims available
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Claim for initiative
        governance_claimForInitiative_bribeInitiative_clamped();
    }
    
    /// @dev Shortcut to unregister initiative
    /// Prerequisites: registerInitiative -> allocateLQTY (to set state) -> warp -> unregisterInitiative
    function shortcut_unregisterInitiative_bribeInitiative(
        uint256 _lqtyAmount,
        uint256 _vetoSeed
    ) public {
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register the bribe initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Warp to make initiative votable
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Allocate vetos to the initiative (high vetos to reach unregistration threshold)
        governance_allocateLQTY_bribeInitiative_clamped(0, _vetoSeed);
        
        // Warp enough epochs to allow unregistration
        vm.warp(block.timestamp + (governance.EPOCH_DURATION() * governance.UNREGISTRATION_AFTER_EPOCHS()) + 1);
        
        // Unregister the initiative
        governance_unregisterInitiative_bribeInitiative_clamped();
    }
    
    // ========== BRIBE INITIATIVE SHORTCUTS ==========
    
    /// @dev Shortcut to deposit bribe with approvals
    /// Prerequisites: approvals -> depositBribe
    function shortcut_depositBribe(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount,
        uint256 _epoch
    ) public {
        // Approve BOLD tokens for bribe initiative
        vm.prank(_getActor());
        bold.approve(address(bribeInitiative), _boldAmount);
        
        // Approve bribe tokens for bribe initiative
        vm.prank(_getActor());
        bribeToken.approve(address(bribeInitiative), _bribeTokenAmount);
        
        // Deposit bribe
        bribeInitiative_depositBribe_clamped(_boldAmount, _bribeTokenAmount, _epoch);
    }
    
    /// @dev Shortcut to claim bribes
    /// Prerequisites: depositLQTY -> registerInitiative -> allocateLQTY -> depositBribe -> warp -> claimBribes
    function shortcut_claimBribes(
        uint256 _lqtyAmount,
        uint256 _voteSeed,
        uint256 _boldAmount,
        uint256 _bribeTokenAmount
    ) public {
        // Actor 0: Deposit LQTY and allocate to bribe initiative
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Warp to next epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        uint256 currentEpoch = governance.epoch();
        
        // Allocate LQTY to initiative
        governance_allocateLQTY_bribeInitiative_clamped(_voteSeed, 0);
        
        // Switch to another actor to deposit bribe
        switchActor(1);
        
        // Deposit bribe for the current epoch
        shortcut_depositBribe(_boldAmount, _bribeTokenAmount, currentEpoch);
        
        // Switch back to original actor
        switchActor(0);
        
        // Warp to next epoch to enable claiming
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Claim bribes
        bribeInitiative_claimBribes_clamped(currentEpoch);
    }
    
    /// @dev Shortcut for snapshot and claim flow
    /// Prerequisites: depositLQTY -> registerInitiative -> allocateLQTY -> warp -> snapshotVotesForInitiative -> claimForInitiative
    function shortcut_snapshotAndClaim_bribeInitiative(
        uint256 _lqtyAmount,
        uint256 _voteSeed
    ) public {
        // Deposit LQTY
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Warp to next epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Allocate LQTY
        governance_allocateLQTY_bribeInitiative_clamped(_voteSeed, 0);
        
        // Warp to next epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // Snapshot votes for initiative
        governance_snapshotVotesForInitiative_bribeInitiative_clamped();
        
        // Claim for initiative
        governance_claimForInitiative_bribeInitiative_clamped();
    }
    
    // ========== COVERAGE GAP SHORTCUTS ==========
    
    /// @dev Shortcut to trigger allocateLQTY after voting cutoff with reset (covers lines 629-632)
    /// This creates a scenario where a user reallocates votes after the cutoff period
    function shortcut_allocateLQTY_afterCutoff_withReset(
        uint256 _lqtyAmount,
        uint256 _initialVoteSeed,
        uint256 _finalVoteSeed
    ) public {
        // 1. Deposit LQTY
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // 2. Register initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // 3. Warp to next epoch (to make initiative votable)
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // 4. Initial allocation (this will be in cachedData after reset)
        governance_allocateLQTY_bribeInitiative_clamped(_initialVoteSeed, 0);
        
        // 5. Warp past voting cutoff (but still in same epoch)
        // EPOCH_VOTING_CUTOFF is 6 days (518400 seconds), EPOCH_DURATION is 7 days (604800 seconds)
        vm.warp(block.timestamp + governance.EPOCH_VOTING_CUTOFF() + 100);
        
        // 6. Now reallocate after cutoff with reset (triggers lines 629-632)
        governance_allocateLQTY_afterCutoff_withReset_clamped(_finalVoteSeed, 0);
    }
    
    /// @dev Shortcut to trigger calculateVotingThreshold with non-zero payoutPerVote (covers line 296)
    /// This ensures BOLD is accrued in governance before calculating voting threshold
    function shortcut_calculateVotingThreshold_withBOLD(
        uint256 _lqtyAmount,
        uint256 _voteSeed,
        uint256 _boldAmount
    ) public {
        // 1. Fund governance with BOLD (this sets boldAccrued)
        governance_fundWithBOLD_clamped(_boldAmount);
        
        // 2. Deposit LQTY and vote to create voting power
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_bribeInitiative_clamped();
        
        // 3. Warp to next epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // 4. Allocate votes
        governance_allocateLQTY_bribeInitiative_clamped(_voteSeed, 0);
        
        // 5. Warp to next epoch to snapshot votes
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // 6. Call calculateVotingThreshold (should now have non-zero payoutPerVote)
        governance_calculateVotingThreshold();
    }
    
    /// @dev Shortcut to trigger claimForInitiative with insufficient BOLD (covers line 908)
    /// This creates a scenario where claimable amount exceeds available BOLD
    function shortcut_claimForInitiative_insufficientBOLD(
        uint256 _lqtyAmount,
        uint256 _voteSeed,
        uint256 _boldToFund,
        uint256 _boldToDrain
    ) public {
        // 1. Fund governance with some BOLD initially
        governance_fundWithBOLD_clamped(_boldToFund);
        
        // 2. Setup voting scenario
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_bribeInitiative_clamped();
        
        // 3. Warp to next epoch
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // 4. Allocate large amount of votes to maximize claimable amount
        governance_allocateLQTY_bribeInitiative_clamped(_voteSeed, 0);
        
        // 5. Warp to next epoch to enable claiming
        vm.warp(block.timestamp + governance.EPOCH_DURATION() + 1);
        
        // 6. Drain most of the BOLD from governance before claiming
        governance_drainBOLD_clamped(_boldToDrain);
        
        // 7. Claim (should hit line 908 if claimable > available)
        governance_claimForInitiative_bribeInitiative_clamped();
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
