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

    function shortcut_unregisterAndReregister(uint256 depositAmount, uint256 allocateAmount) public {
        // Complete cycle: register → deposit → allocate → unregister → register again
        
        // Initial registration and setup
        governance_registerInitiative_clamped();
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for next epoch
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative to complete cycle
        governance_claimForInitiative_clamped();
        
        // Unregister the initiative
        governance_unregisterInitiative_clamped();
        
        // Register again with fresh setup
        governance_registerInitiative_clamped();
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_multiActorVoting(uint256 actor1Deposit, uint256 actor2Deposit, uint256 bribeAmount) public {
        // Multi-actor voting scenario with bribes
        
        // Actor 1: Register initiative and deposit bribe
        governance_registerInitiative_clamped();
        switchActor(1);
        bribeInitiative_depositBribe_clamped(bribeAmount, bribeAmount, governance.epoch());
        
        // Actor 0: Deposit and allocate votes
        switchActor(0);
        governance_depositLQTY_clamped(actor1Deposit);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Actor 2: Also deposit and allocate votes
        switchActor(2);
        governance_depositLQTY_clamped(actor2Deposit);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative_clamped();
        
        // Both actors claim their bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        
        switchActor(0);
        bribeInitiative_claimBribes_clamped(claimData);
        
        switchActor(2);
        bribeInitiative_claimBribes_clamped(claimData);
    }

    function shortcut_withdrawAndRedeposit(uint256 withdrawAmount, uint256 redepositAmount) public {
        // Withdraw LQTY and immediately redeposit
        
        // Ensure we have an initiative and some allocation
        governance_registerInitiative_clamped();
        governance_depositLQTY_clamped(redepositAmount);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Withdraw some LQTY
        governance_withdrawLQTY_clamped(withdrawAmount);
        
        // Redeposit the withdrawn amount (or a different amount)
        governance_depositLQTY_clamped(redepositAmount);
        
        // Reallocate with the new balance
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_permitBasedFlow(uint256 lqtyAmount, uint256 allocateAmount) public {
        // Complete flow using permit-based deposit
        
        // Register initiative first
        governance_registerInitiative_clamped();
        
        // Create permit parameters (using dummy values for testing)
        PermitParams memory permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: lqtyAmount,
            deadline: block.timestamp + 3600,
            v: 27,
            r: bytes32(uint256(1)),
            s: bytes32(uint256(1))
        });
        
        // Deposit using permit
        governance_depositLQTYViaPermit_clamped(lqtyAmount, permitParams);
        
        // Allocate the deposited LQTY
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_snapshotVotes(uint256 depositAmount, uint256 allocateAmount) public {
        // Set up initiative with votes and then snapshot
        
        // Register initiative
        governance_registerInitiative_clamped();
        
        // Deposit and allocate LQTY
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Snapshot votes for the initiative
        governance_snapshotVotesForInitiative_clamped();
    }

    function shortcut_claimFromStakingV1(uint256 lqtyAmount) public {
        // Set up governance and claim from staking V1
        
        // Register initiative first
        governance_registerInitiative_clamped();
        
        // Deposit some LQTY to establish user state
        governance_depositLQTY_clamped(lqtyAmount);
        
        // Claim from staking V1
        governance_claimFromStakingV1_clamped();
    }

    function shortcut_deployProxyAndVote(uint256 depositAmount, uint256 allocateAmount) public {
        // Deploy user proxy and then vote through it
        
        // Deploy user proxy for current actor
        governance_deployUserProxy();
        
        // Register initiative
        governance_registerInitiative_clamped();
        
        // Deposit and allocate LQTY
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_fullInitiativeLifecycle(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Complete lifecycle: register -> allocate -> claim -> unregister
        
        // Register initiative
        governance_registerInitiative_clamped();
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe_clamped(bribeAmount, bribeAmount, governance.epoch());
        
        // Switch back and allocate votes
        switchActor(0);
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        governance_claimForInitiative_clamped();
        
        // Claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes_clamped(claimData);
        
        // Unregister initiative
        governance_unregisterInitiative_clamped();
    }

    function shortcut_multiEpochVoting(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount, uint256 epochs) public {
        // Vote across multiple epochs with bribes
        
        // Register initiative
        governance_registerInitiative_clamped();
        
        for (uint256 i = 0; i < epochs && i < 5; i++) { // Limit to 5 epochs for gas
            // Switch to different actor to deposit bribe for current epoch
            switchActor(1);
            bribeInitiative_depositBribe_clamped(bribeAmount, bribeAmount, governance.epoch());
            
            // Switch back and allocate votes
            switchActor(0);
            if (i == 0) {
                governance_depositLQTY_clamped(depositAmount);
            }
            governance_allocateLQTY_clamped(new address[](0), new address[](1), new int256[](1), new int256[](1));
            
            // Wait for epoch to end
            vm.warp(block.timestamp + 604800); // 1 week
            
            // Claim for initiative
            governance_claimForInitiative_clamped();
            
            // Claim bribes
            IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
            claimData[0] = IBribeInitiative.ClaimData({
                epoch: governance.epoch() - 1,
                prevLQTYAllocationEpoch: 0,
                prevTotalLQTYAllocationEpoch: 0
            });
            bribeInitiative_claimBribes_clamped(claimData);
        }
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}