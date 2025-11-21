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
import {CurveV2GaugeRewardsTargets} from "./targets/CurveV2GaugeRewardsTargets.sol";
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
    
    function shortcut_allocateLQTY(uint256 _lqtyAmount, uint256 _voteAmount, uint256 _vetoAmount) public {
        // Switch to actor 0 and deposit LQTY to have voting power
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Register the bribe initiative with actor 0
        governance_registerInitiative_clamped();
        
        // Allocate LQTY to the bribe initiative
        governance_allocateLQTY_clamped(_voteAmount, _vetoAmount);
    }
    
    function shortcut_claimForInitiative(uint256 _lqtyAmount, uint256 _voteAmount) public {
        // Switch to actor 0 and set up the initiative
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_clamped();
        governance_allocateLQTY_clamped(_voteAmount, 0);
        
        // Fast forward time to complete the epoch and make claimable
        vm.warp(block.timestamp + 7 days + 1 hours);
        
        // Claim for the initiative
        governance_claimForInitiative_clamped();
    }
    
    function shortcut_claimBribes(uint256 _lqtyAmount, uint256 _voteAmount, uint256 _boldAmount, uint256 _bribeTokenAmount) public {
        // Switch to actor 0 and set up the initiative with voting power
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_clamped();
        governance_allocateLQTY_clamped(_voteAmount, 0);
        
        // Switch to actor 1 to deposit bribes
        switchActor(1);
        bribeInitiative_depositBribe_clamped(_boldAmount, _bribeTokenAmount);
        
        // Fast forward time to complete the epoch
        vm.warp(block.timestamp + 7 days + 1 hours);
        
        // Claim bribes with actor 0 (the voter)
        switchActor(0);
        bribeInitiative_claimBribes_clamped();
    }
    
    function shortcut_registerInitiative(uint256 _lqtyAmount) public {
        // Switch to actor 0 and deposit LQTY for voting power
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Wait a bit to ensure voting power has age
        vm.warp(block.timestamp + 1 hours);
        
        // Register the initiative
        governance_registerInitiative_clamped();
    }
    
    function shortcut_unregisterInitiative(uint256 _lqtyAmount, uint256 _voteAmount) public {
        // Switch to actor 0 and set up an initiative that will become unregisterable
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_clamped();
        governance_allocateLQTY_clamped(_voteAmount, 0);
        
        // Fast forward multiple epochs to make it unregisterable (after UNREGISTRATION_AFTER_EPOCHS)
        vm.warp(block.timestamp + (7 days * 5) + 1 hours);
        
        // Unregister the initiative
        governance_unregisterInitiative(address(bribeInitiative));
    }
    
    function shortcut_resetAllocations(uint256 _lqtyAmount, uint256 _voteAmount) public {
        // Switch to actor 0 and set up allocations to reset
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_clamped();
        governance_allocateLQTY_clamped(_voteAmount, 0);
        
        // Reset the allocations
        governance_resetAllocations_clamped();
    }
    
    function shortcut_snapshotVotesForInitiative(uint256 _lqtyAmount, uint256 _voteAmount) public {
        // Switch to actor 0 and set up voting activity
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_clamped();
        governance_allocateLQTY_clamped(_voteAmount, 0);
        
        // Take a snapshot of votes for the initiative
        governance_snapshotVotesForInitiative_clamped();
    }
    
    function shortcut_multiDelegateCall(uint256 _lqtyAmount, uint256 _voteAmount, uint256 _withdrawAmount) public {
        // Switch to actor 0 and set up governance state
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        governance_registerInitiative_clamped();
        governance_allocateLQTY_clamped(_voteAmount, 0);
        
        // Create a multi-delegate call sequence: deposit more LQTY, then withdraw
        bytes[] memory calls = new bytes[](2);
        calls[0] = abi.encodeWithSignature("depositLQTY(uint256)", uint256(100));
        calls[1] = abi.encodeWithSignature("withdrawLQTY(uint256)", _withdrawAmount);
        
        governance_multiDelegateCall(calls);
    }
    
    function shortcut_claimFromStakingV1(uint256 _lqtyAmount) public {
        // Switch to actor 0 and deposit LQTY to establish a connection to staking V1
        switchActor(0);
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Claim from staking V1
        governance_claimFromStakingV1_clamped();
    }
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
