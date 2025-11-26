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
    
    /// @dev Shortcut for allocateLQTY - deposits LQTY and allocates to bribeInitiative
    function shortcut_allocateLQTY_bribeInitiative(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative if needed
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(depositAmount);
        
        // Allocate to bribeInitiative
        governance_allocateLQTY_bribeInitiative_clamped(voteSeed, vetoSeed);
    }
    
    /// @dev Shortcut for allocateLQTY - deposits LQTY and allocates to curveV2GaugeRewards
    function shortcut_allocateLQTY_curveV2GaugeRewards(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative if needed
        governance_registerInitiative_curveV2GaugeRewards_clamped();
        
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(depositAmount);
        
        // Allocate to curveV2GaugeRewards
        governance_allocateLQTY_curveV2GaugeRewards_clamped(voteSeed, vetoSeed);
    }
    
    /// @dev Shortcut for allocateLQTY - deposits LQTY and allocates to uniV4MerklRewards
    function shortcut_allocateLQTY_uniV4MerklRewards(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative if needed
        governance_registerInitiative_uniV4MerklRewards_clamped();
        
        // Deposit LQTY for current actor
        governance_depositLQTY_clamped(depositAmount);
        
        // Allocate to uniV4MerklRewards
        governance_allocateLQTY_uniV4MerklRewards_clamped(voteSeed, vetoSeed);
    }
    
    /// @dev Shortcut for claimForInitiative - sets up voting power and claims rewards for bribeInitiative
    function shortcut_claimForInitiative_bribeInitiative(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Deposit LQTY and allocate votes to build up rewards
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_bribeInitiative_clamped(voteSeed, vetoSeed);
        
        // Switch to different actor to deposit BOLD for initiative to claim
        switchActor(1);
        asset_mint_clamped(type(uint88).max);
        
        // Warp time forward to accumulate rewards (1 epoch)
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        
        // Switch back and claim
        switchActor(0);
        governance_claimForInitiative_bribeInitiative_clamped();
    }
    
    /// @dev Shortcut for claimForInitiative - sets up voting power and claims rewards for curveV2GaugeRewards
    function shortcut_claimForInitiative_curveV2GaugeRewards(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative
        governance_registerInitiative_curveV2GaugeRewards_clamped();
        
        // Deposit LQTY and allocate votes to build up rewards
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_curveV2GaugeRewards_clamped(voteSeed, vetoSeed);
        
        // Switch to different actor to deposit BOLD for initiative to claim
        switchActor(1);
        asset_mint_clamped(type(uint88).max);
        
        // Warp time forward to accumulate rewards (1 epoch)
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        
        // Switch back and claim
        switchActor(0);
        governance_claimForInitiative_curveV2GaugeRewards_clamped();
    }
    
    /// @dev Shortcut for claimForInitiative - sets up voting power and claims rewards for uniV4MerklRewards
    function shortcut_claimForInitiative_uniV4MerklRewards(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative
        governance_registerInitiative_uniV4MerklRewards_clamped();
        
        // Deposit LQTY and allocate votes to build up rewards
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_uniV4MerklRewards_clamped(voteSeed, vetoSeed);
        
        // Switch to different actor to deposit BOLD for initiative to claim
        switchActor(1);
        asset_mint_clamped(type(uint88).max);
        
        // Warp time forward to accumulate rewards (1 epoch)
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        
        // Switch back and claim
        switchActor(0);
        governance_claimForInitiative_uniV4MerklRewards_clamped();
    }
    
    /// @dev Shortcut for claimBribes - sets up allocation and bribes, then claims
    function shortcut_claimBribes(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed, uint256 boldAmount, uint256 bribeTokenAmount) public {
        // Register initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Deposit LQTY and allocate first (in current epoch)
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_bribeInitiative_clamped(voteSeed, vetoSeed);
        
        // Switch to actor 1 to deposit bribes for current epoch
        switchActor(1);
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_depositBribe_clamped(boldAmount, bribeTokenAmount, currentEpoch);
        
        // Switch back to actor 0
        switchActor(0);
        
        // Warp time forward (1 epoch) to make bribes claimable
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        
        // Claim bribes
        bribeInitiative_claimBribes_clamped();
    }
    
    /// @dev Enhanced shortcut for claimBribes with proper epoch handling
    function shortcut_claimBribes_enhanced(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed, uint256 boldAmount, uint256 bribeTokenAmount) public {
        // Register initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        uint256 currentEpoch = governance.epoch();
        
        // Actor 0: Deposit LQTY and allocate to bribeInitiative
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_bribeInitiative_clamped(voteSeed, vetoSeed);
        
        // Actor 1: Deposit bribes for the current epoch
        switchActor(1);
        bribeInitiative_depositBribe_clamped(boldAmount, bribeTokenAmount, currentEpoch);
        switchActor(0);
        
        // Warp to next epoch to make bribes claimable
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        
        // Now claim the bribes
        bribeInitiative_claimBribes_clamped();
    }
    
    /// @dev Shortcut for snapshotVotesForInitiative - sets up votes and snapshots for bribeInitiative
    function shortcut_snapshotVotesForInitiative_bribeInitiative(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Deposit LQTY and allocate
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_bribeInitiative_clamped(voteSeed, vetoSeed);
        
        // Snapshot votes
        governance_snapshotVotesForInitiative_bribeInitiative_clamped();
    }
    
    /// @dev Shortcut for snapshotVotesForInitiative - sets up votes and snapshots for curveV2GaugeRewards
    function shortcut_snapshotVotesForInitiative_curveV2GaugeRewards(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative
        governance_registerInitiative_curveV2GaugeRewards_clamped();
        
        // Deposit LQTY and allocate
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_curveV2GaugeRewards_clamped(voteSeed, vetoSeed);
        
        // Snapshot votes
        governance_snapshotVotesForInitiative_curveV2GaugeRewards_clamped();
    }
    
    /// @dev Shortcut for snapshotVotesForInitiative - sets up votes and snapshots for uniV4MerklRewards
    function shortcut_snapshotVotesForInitiative_uniV4MerklRewards(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register initiative
        governance_registerInitiative_uniV4MerklRewards_clamped();
        
        // Deposit LQTY and allocate
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_uniV4MerklRewards_clamped(voteSeed, vetoSeed);
        
        // Snapshot votes
        governance_snapshotVotesForInitiative_uniV4MerklRewards_clamped();
    }
    
    /// @dev Shortcut to trigger edge case where claimableAmount > available BOLD (line 908)
    /// Sets up multiple initiatives with votes, then has them claim sequentially to drain BOLD
    function shortcut_claimForInitiative_edgeCase(uint256 depositAmount, uint256 voteSeed, uint256 vetoSeed) public {
        // Register all initiatives
        governance_registerInitiative_bribeInitiative_clamped();
        governance_registerInitiative_curveV2GaugeRewards_clamped();
        governance_registerInitiative_uniV4MerklRewards_clamped();
        
        // Actor 0: Allocate to bribeInitiative
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_bribeInitiative_clamped(voteSeed, vetoSeed);
        
        // Actor 1: Allocate to curveV2GaugeRewards
        switchActor(1);
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_curveV2GaugeRewards_clamped(voteSeed, vetoSeed);
        
        // Deposit a limited amount of BOLD to governance
        uint256 limitedBold = 1000e18; // Small amount
        bold.transfer(address(governance), limitedBold);
        
        // Warp time forward to accumulate rewards (1 epoch)
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        
        // First claim drains most of the BOLD
        switchActor(0);
        governance_claimForInitiative_bribeInitiative_clamped();
        
        // Second claim should hit the edge case where claimable > available
        switchActor(1);
        governance_claimForInitiative_curveV2GaugeRewards_clamped();
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
