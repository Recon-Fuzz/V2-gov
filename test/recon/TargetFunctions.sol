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
    
    // === SHORTCUT FUNCTIONS === //
    // These shortcuts combine multiple function calls to help the fuzzer reach complex states faster
    
    /// @dev Shortcut for claiming bribes - sets up full bribe claiming flow
    /// Sequence: deposit LQTY → allocate to initiative → deposit bribe → warp time → claim bribes
    function shortcut_claimBribes(
        uint256 lqtyAmount,
        uint256 absoluteLQTYVote,
        uint256 boldBribeAmount,
        uint256 bribeTokenAmount,
        uint256 warpEpochs
    ) public {
        // 1. Deposit LQTY for the actor to get voting power
        governance_depositLQTY_clamped(lqtyAmount);
        
        // 2. Warp time to accrue some voting power
        vm.warp(block.timestamp + 7 days);
        
        // 3. Allocate LQTY to the bribe initiative
        governance_allocateLQTY_clamped(int256(absoluteLQTYVote), 0);
        
        // 4. Switch to different actor to deposit bribes
        switchActor(1);
        
        // 5. Deposit bribes for a future epoch
        uint256 targetEpoch = governance.epoch() + (warpEpochs % 3) + 1;
        bribeInitiative_depositBribe_clamped(boldBribeAmount, bribeTokenAmount, targetEpoch);
        
        // 6. Warp to the target epoch + 1 to make bribes claimable
        vm.warp(block.timestamp + ((warpEpochs % 3) + 2) * 7 days);
        
        // 7. Switch back to original actor and claim bribes
        switchActor(0);
        bribeInitiative_claimBribes_clamped(targetEpoch);
    }
    
    /// @dev Shortcut for claiming for initiative - sets up full claiming flow
    /// Sequence: register initiative → deposit LQTY → allocate votes → warp → snapshot → claim
    function shortcut_claimForInitiative(
        uint256 lqtyAmount,
        uint256 absoluteLQTYVote,
        uint256 boldAmount
    ) public {
        // 1. Register the bribe initiative if not already registered
        try governance.registeredInitiatives(address(bribeInitiative)) returns (uint256 regEpoch) {
            if (regEpoch == 0) {
                governance_registerInitiative_clamped();
            }
        } catch {
            governance_registerInitiative_clamped();
        }
        
        // 2. Deposit LQTY to get voting power
        governance_depositLQTY_clamped(lqtyAmount);
        
        // 3. Warp to accrue voting power
        vm.warp(block.timestamp + 7 days);
        
        // 4. Allocate votes to the initiative
        governance_allocateLQTY_clamped(int256(absoluteLQTYVote), 0);
        
        // 5. Transfer BOLD to governance contract to accrue rewards
        bold.transfer(address(governance), boldAmount % (bold.balanceOf(_getActor()) + 1));
        
        // 6. Warp to next epoch to make snapshot available
        vm.warp(block.timestamp + 7 days);
        
        // 7. Take snapshot
        governance_snapshotVotesForInitiative_clamped();
        
        // 8. Claim for the initiative
        governance_claimForInitiative_clamped();
    }
    
    /// @dev Shortcut for unregistering initiative via veto threshold
    /// Sequence: register → deposit LQTY → allocate large veto → unregister
    function shortcut_unregisterInitiative_veto(
        uint256 lqtyAmount,
        uint256 absoluteLQTYVeto
    ) public {
        // 1. Register the initiative if not already registered
        try governance.registeredInitiatives(address(bribeInitiative)) returns (uint256 regEpoch) {
            if (regEpoch == 0) {
                governance_registerInitiative_clamped();
            }
        } catch {
            governance_registerInitiative_clamped();
        }
        
        // 2. Deposit LQTY with first actor
        governance_depositLQTY_clamped(lqtyAmount);
        
        // 3. Warp to accrue voting power
        vm.warp(block.timestamp + 14 days);
        
        // 4. Allocate large veto amount
        governance_allocateLQTY_clamped(0, int256(absoluteLQTYVeto));
        
        // 5. Warp to next epoch
        vm.warp(block.timestamp + 7 days);
        
        // 6. Take snapshot
        governance_snapshotVotesForInitiative_clamped();
        
        // 7. Attempt to unregister
        governance_unregisterInitiative_clamped();
    }
    
    /// @dev Shortcut for unregistering initiative via SKIP epochs
    /// Sequence: register → wait epochs → unregister
    function shortcut_unregisterInitiative_skip() public {
        // 1. Register the initiative
        try governance.registeredInitiatives(address(bribeInitiative)) returns (uint256 regEpoch) {
            if (regEpoch == 0) {
                governance_registerInitiative_clamped();
            }
        } catch {
            governance_registerInitiative_clamped();
        }
        
        // 2. Warp through UNREGISTRATION_AFTER_EPOCHS + 1 epochs without voting
        // This should put initiative in SKIP state for enough epochs
        uint256 unregEpochs = governance.UNREGISTRATION_AFTER_EPOCHS();
        vm.warp(block.timestamp + (unregEpochs + 1) * 7 days);
        
        // 3. Take snapshot
        governance_snapshotVotesForInitiative_clamped();
        
        // 4. Attempt to unregister
        governance_unregisterInitiative_clamped();
    }
    
    /// @dev Shortcut for testing voting power allocation and deallocation
    /// Sequence: deposit LQTY → allocate → warp → reallocate → reset
    function shortcut_allocateAndReset(
        uint256 lqtyAmount,
        uint256 absoluteLQTYVote1,
        uint256 absoluteLQTYVote2
    ) public {
        // 1. Register initiative if needed
        try governance.registeredInitiatives(address(bribeInitiative)) returns (uint256 regEpoch) {
            if (regEpoch == 0) {
                governance_registerInitiative_clamped();
            }
        } catch {
            governance_registerInitiative_clamped();
        }
        
        // 2. Deposit LQTY
        governance_depositLQTY_clamped(lqtyAmount);
        
        // 3. Warp to accrue voting power
        vm.warp(block.timestamp + 7 days);
        
        // 4. First allocation
        governance_allocateLQTY_clamped(int256(absoluteLQTYVote1), 0);
        
        // 5. Warp more time
        vm.warp(block.timestamp + 7 days);
        
        // 6. Reallocate with different amount
        governance_allocateLQTY_clamped(int256(absoluteLQTYVote2), 0);
        
        // 7. Warp more time
        vm.warp(block.timestamp + 7 days);
        
        // 8. Reset allocations
        governance_resetAllocations_clamped(false);
    }
    
    /// @dev Shortcut for testing withdrawal after allocation reset
    /// Sequence: deposit → allocate → reset → withdraw
    function shortcut_withdrawAfterReset(
        uint256 depositAmount,
        uint256 allocateAmount,
        uint256 withdrawAmount
    ) public {
        // 1. Register initiative if needed
        try governance.registeredInitiatives(address(bribeInitiative)) returns (uint256 regEpoch) {
            if (regEpoch == 0) {
                governance_registerInitiative_clamped();
            }
        } catch {
            governance_registerInitiative_clamped();
        }
        
        // 2. Deposit LQTY
        governance_depositLQTY_clamped(depositAmount);
        
        // 3. Warp to accrue voting power
        vm.warp(block.timestamp + 7 days);
        
        // 4. Allocate votes
        governance_allocateLQTY_clamped(int256(allocateAmount), 0);
        
        // 5. Warp more time
        vm.warp(block.timestamp + 7 days);
        
        // 6. Reset allocations to free up LQTY
        governance_resetAllocations_clamped(false);
        
        // 7. Withdraw LQTY
        governance_withdrawLQTY_clamped(withdrawAmount);
    }
    
    /// @dev Shortcut for testing multiple actors voting on same initiative
    /// Sequence: actor1 deposits/votes → actor2 deposits/votes → warp → claim
    function shortcut_multiActorVoting(
        uint256 lqty1,
        uint256 vote1,
        uint256 lqty2,
        uint256 vote2,
        uint256 boldAmount
    ) public {
        // 1. Register initiative
        try governance.registeredInitiatives(address(bribeInitiative)) returns (uint256 regEpoch) {
            if (regEpoch == 0) {
                governance_registerInitiative_clamped();
            }
        } catch {
            governance_registerInitiative_clamped();
        }
        
        // 2. Actor 0 deposits and allocates
        switchActor(0);
        governance_depositLQTY_clamped(lqty1);
        vm.warp(block.timestamp + 7 days);
        governance_allocateLQTY_clamped(int256(vote1), 0);
        
        // 3. Actor 1 deposits and allocates
        switchActor(1);
        governance_depositLQTY_clamped(lqty2);
        vm.warp(block.timestamp + 7 days);
        governance_allocateLQTY_clamped(int256(vote2), 0);
        
        // 4. Accrue BOLD rewards
        switchActor(0);
        bold.transfer(address(governance), boldAmount % (bold.balanceOf(_getActor()) + 1));
        
        // 5. Warp to next epoch
        vm.warp(block.timestamp + 7 days);
        
        // 6. Claim for initiative
        governance_claimForInitiative_clamped();
    }
    
    /// @dev Shortcut for testing bribe deposit and immediate claim attempt
    /// Sequence: allocate → deposit bribe → warp → claim
    function shortcut_bribeDepositAndClaim(
        uint256 lqtyAmount,
        uint256 voteAmount,
        uint256 boldBribe,
        uint256 bribeTokenBribe
    ) public {
        // 1. Deposit LQTY and allocate
        governance_depositLQTY_clamped(lqtyAmount);
        vm.warp(block.timestamp + 7 days);
        governance_allocateLQTY_clamped(int256(voteAmount), 0);
        
        // 2. Get current epoch for bribe
        uint256 currentEpoch = governance.epoch();
        
        // 3. Deposit bribe for next epoch
        bribeInitiative_depositBribe_clamped(boldBribe, bribeTokenBribe, currentEpoch + 1);
        
        // 4. Warp through that epoch
        vm.warp(block.timestamp + 14 days);
        
        // 5. Try to claim bribes
        bribeInitiative_claimBribes_clamped(currentEpoch + 1);
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
