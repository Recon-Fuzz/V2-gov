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
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit LQTY to have funds to allocate
        governance_depositLQTY(depositAmount);
        
        // Allocate LQTY to the registered initiative
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_claimBribes(uint256 boldAmount, uint256 bribeTokenAmount) public {
        // First ensure initiative is registered
        governance_registerInitiative(address(bribeInitiative));
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe(boldAmount, bribeTokenAmount, governance.epoch());
        
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
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_claimForInitiative(uint256 depositAmount, uint256 allocateAmount) public {
        // Set up the full sequence: register -> deposit -> allocate -> claim
        governance_registerInitiative(address(bribeInitiative));
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_fullVotingCycle(uint256 depositAmount, uint256 allocateAmount, uint256 boldAmount, uint256 bribeTokenAmount) public {
        // Complete voting and bribe cycle
        
        // 1. Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // 2. Deposit LQTY for voting
        governance_depositLQTY(depositAmount);
        
        // 3. Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe(boldAmount, bribeTokenAmount, governance.epoch());
        
        // 4. Switch back and allocate votes
        switchActor(0);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // 5. Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // 6. Claim for initiative (distributes bribes)
        governance_claimForInitiative(address(bribeInitiative));
        
        // 7. Claim the actual bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_resetAndReallocate(uint256 newDepositAmount, uint256 newAllocateAmount) public {
        // Reset existing allocations and create new ones
        
        // Ensure initiative exists
        governance_registerInitiative(address(bribeInitiative));
        
        // Reset any existing allocations
        governance_resetAllocations(new address[](0), false);
        
        // Deposit fresh LQTY
        governance_depositLQTY(newDepositAmount);
        
        // Allocate to initiative
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_unregisterAndReregister(uint256 depositAmount, uint256 allocateAmount) public {
        // Complete cycle: register → deposit → allocate → unregister → register again
        
        // Initial registration and setup
        governance_registerInitiative(address(bribeInitiative));
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for next epoch
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative to complete cycle
        governance_claimForInitiative(address(bribeInitiative));
        
        // Unregister the initiative
        governance_unregisterInitiative(address(bribeInitiative));
        
        // Register again with fresh setup
        governance_registerInitiative(address(bribeInitiative));
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_multiActorVoting(uint256 actor1Deposit, uint256 actor2Deposit, uint256 bribeAmount) public {
        // Multi-actor voting scenario with bribes
        
        // Actor 1: Register initiative and deposit bribe
        governance_registerInitiative(address(bribeInitiative));
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Actor 0: Deposit and allocate votes
        switchActor(0);
        governance_depositLQTY(actor1Deposit);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Actor 2: Also deposit and allocate votes
        switchActor(2);
        governance_depositLQTY(actor2Deposit);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative(address(bribeInitiative));
        
        // Both actors claim their bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        
        switchActor(0);
        bribeInitiative_claimBribes(claimData);
        
        switchActor(2);
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_withdrawAndRedeposit(uint256 withdrawAmount, uint256 redepositAmount) public {
        // Withdraw LQTY and immediately redeposit
        
        // Ensure we have an initiative and some allocation
        governance_registerInitiative(address(bribeInitiative));
        governance_depositLQTY(redepositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Withdraw some LQTY
        governance_withdrawLQTY(withdrawAmount);
        
        // Redeposit the withdrawn amount (or a different amount)
        governance_depositLQTY(redepositAmount);
        
        // Reallocate with the new balance
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_permitBasedFlow(uint256 lqtyAmount, uint256 allocateAmount) public {
        // Complete flow using permit-based deposit
        
        // Register initiative first
        governance_registerInitiative(address(bribeInitiative));
        
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
        governance_depositLQTYViaPermit(lqtyAmount, permitParams);
        
        // Allocate the deposited LQTY
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_snapshotVotes(uint256 depositAmount, uint256 allocateAmount) public {
        // Set up initiative with votes and then snapshot
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate LQTY
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Snapshot votes for the initiative
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    function shortcut_claimFromStakingV1(uint256 lqtyAmount) public {
        // Set up governance and claim from staking V1
        
        // Register initiative first
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit some LQTY to establish user state
        governance_depositLQTY(lqtyAmount);
        
        // Claim from staking V1
        governance_claimFromStakingV1(_getActor());
    }

    function shortcut_deployProxyAndVote(uint256 depositAmount, uint256 allocateAmount) public {
        // Deploy user proxy and then vote through it
        
        // Deploy user proxy for current actor
        governance_deployUserProxy();
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate LQTY
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_fullInitiativeLifecycle(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Complete lifecycle: register -> allocate -> claim -> unregister
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Switch back and allocate votes
        switchActor(0);
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        governance_claimForInitiative(address(bribeInitiative));
        
        // Claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
        
        // Unregister initiative
        governance_unregisterInitiative(address(bribeInitiative));
    }

    function shortcut_multiEpochVoting(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount, uint256 epochs) public {
        // Vote across multiple epochs with bribes
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        for (uint256 i = 0; i < epochs && i < 5; i++) { // Limit to 5 epochs for gas
            // Switch to different actor to deposit bribe for current epoch
            switchActor(1);
            bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
            
            // Switch back and allocate votes
            switchActor(0);
            if (i == 0) {
                governance_depositLQTY(depositAmount);
            }
            governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
            
            // Wait for epoch to end
            vm.warp(block.timestamp + 604800); // 1 week
            
            // Claim for initiative
            governance_claimForInitiative(address(bribeInitiative));
            
            // Claim bribes
            IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
            claimData[0] = IBribeInitiative.ClaimData({
                epoch: governance.epoch() - 1,
                prevLQTYAllocationEpoch: 0,
                prevTotalLQTYAllocationEpoch: 0
            });
            bribeInitiative_claimBribes(claimData);
        }
    }

    function shortcut_userProxyStaking(uint256 stakeAmount, bool doSendRewards, address recipient) public {
        // Complete flow through UserProxy for staking
        
        // Deploy user proxy for current actor if not already deployed
        governance_deployUserProxy();
        
        // Get the user proxy address
        address userProxy = governance.deriveUserProxyAddress(_getActor());
        
        // Approve LQTY to be spent by user proxy
        lqty.approve(userProxy, stakeAmount);
        
        // Call stake through the proxy (this would need to be exposed through governance)
        // For now, we'll simulate the direct call pattern
        governance_depositLQTY(stakeAmount, doSendRewards, recipient);
    }

    function shortcut_singleInitiativeMultipleBribes(uint256 depositAmount, uint256 bribeAmount1, uint256 bribeAmount2) public {
        // Scenario with multiple bribes for the same initiative from different actors
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit LQTY for voting
        governance_depositLQTY(depositAmount);
        
        // Switch to actor 1 to deposit first bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount1, bribeAmount1, governance.epoch());
        
        // Switch to actor 2 to deposit second bribe
        switchActor(2);
        bribeInitiative_depositBribe(bribeAmount2, bribeAmount2, governance.epoch());
        
        // Switch back to main actor and allocate votes
        switchActor(0);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        governance_claimForInitiative(address(bribeInitiative));
        
        // Claim bribes from multiple actors
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        
        switchActor(0);
        bribeInitiative_claimBribes(claimData);
        
        switchActor(1);
        bribeInitiative_claimBribes(claimData);
        
        switchActor(2);
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_emergencyUnregister(uint256 depositAmount, uint256 allocateAmount) public {
        // Emergency scenario: register -> allocate -> immediate unregister
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Immediately unregister (testing edge case)
        governance_unregisterInitiative(address(bribeInitiative));
        
        // Try to claim after unregister (should test behavior)
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_zeroAllocationScenario(uint256 depositAmount) public {
        // Test scenario with zero allocations
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit LQTY but don't allocate anything
        governance_depositLQTY(depositAmount);
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Try to claim with zero allocations
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_maxAllocationScenario(uint256 depositAmount) public {
        // Test scenario with maximum allocations
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit all available LQTY
        governance_depositLQTY(depositAmount);
        
        // Allocate all deposited LQTY
        int256[] memory votes = new int256[](1);
        votes[0] = int256(depositAmount);
        
        governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim maximum rewards
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_deployProxyAndStake(uint256 stakeAmount) public {
        // Deploy user proxy and stake through it
        
        // Deploy user proxy for current actor
        governance_deployUserProxy();
        
        // Get the user proxy address
        address userProxy = governance.deriveUserProxyAddress(_getActor());
        
        // Approve LQTY to be spent by user proxy
        lqty.approve(userProxy, stakeAmount);
        
        // Register initiative first
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate through governance
        governance_depositLQTY(stakeAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_multiDelegateWithVoting(uint256 depositAmount, uint256 allocateAmount) public {
        // Use multi-delegate call to perform voting operations
        
        // Register initiative first
        governance_registerInitiative(address(bribeInitiative));
        
        // Create multi-delegate call array
        bytes[] memory calls = new bytes[](2);
        
        // First call: deposit LQTY
        calls[0] = abi.encodeWithSignature(
            "depositLQTY(uint256)",
            depositAmount
        );
        
        // Second call: allocate LQTY
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(allocateAmount);
        int256[] memory vetos = new int256[](1);
        vetos[0] = int256(0);
        
        calls[1] = abi.encodeWithSelector(
            governance.allocateLQTY.selector,
            new address[](0),
            initiatives,
            votes,
            vetos
        );
        
        // Execute multi-delegate call
        governance_multiDelegateCall(calls);
    }

    function shortcut_proxyVotingWithBribes(uint256 stakeAmount, uint256 bribeAmount) public {
        // Complete flow: deploy proxy -> stake -> vote -> claim bribes
        
        // Deploy user proxy
        governance_deployUserProxy();
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Switch back and stake through proxy
        switchActor(0);
        address userProxy = governance.deriveUserProxyAddress(_getActor());
        lqty.approve(userProxy, stakeAmount);
        governance_depositLQTY(stakeAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        governance_claimForInitiative(address(bribeInitiative));
        
        // Claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_adminMultiDelegate(uint256 depositAmount) public {
        // Admin multi-delegate call scenario
        
        // Register initiative as admin
        governance_registerInitiative(address(bribeInitiative));
        
        // Create admin multi-delegate call
        bytes[] memory calls = new bytes[](2);
        
        // First call: register initial initiatives
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        calls[0] = abi.encodeWithSelector(
            governance.registerInitialInitiatives.selector,
            initiatives
        );
        
        // Second call: deposit LQTY (as regular actor)
        calls[1] = abi.encodeWithSignature(
            "depositLQTY(uint256)",
            depositAmount
        );
        
        // Execute admin multi-delegate call
        governance_multiDelegateCall(calls);
    }

    function shortcut_complexVotingWithThreshold(uint256 depositAmount, uint256 allocateAmount) public {
        // Complex voting scenario that tests voting threshold calculations
        
        // Register multiple initiatives to test threshold logic
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit substantial amount to affect threshold
        governance_depositLQTY(depositAmount);
        
        // Calculate and allocate based on voting threshold
        uint256 threshold = governance.calculateVotingThreshold();
        uint256 voteAmount = allocateAmount > threshold ? threshold : allocateAmount;
        
        int256[] memory votes = new int256[](1);
        votes[0] = int256(voteAmount);
        
        governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
        
        // Test threshold edge cases
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    function shortcut_withdrawalWithRewards(uint256 depositAmount, uint256 withdrawAmount, bool sendRewards, address recipient) public {
        // Deposit, allocate, then withdraw with rewards scenario
        
        // Register initiative and setup
        governance_registerInitiative(address(bribeInitiative));
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for epoch to potentially accrue rewards
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Withdraw with rewards parameters
        governance_withdrawLQTY(withdrawAmount, sendRewards, recipient);
    }

    function shortcut_permitBasedAllocation(uint256 lqtyAmount, uint256 allocateAmount) public {
        // Complete flow using permit-based deposit and allocation
        
        // Register initiative first
        governance_registerInitiative(address(bribeInitiative));
        
        // Create realistic permit parameters
        PermitParams memory permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: lqtyAmount,
            deadline: block.timestamp + 3600,
            v: 27,
            r: bytes32(uint256(keccak256("permit_signature"))),
            s: bytes32(uint256(keccak256("permit_signature_s")))
        });
        
        // Deposit using permit
        governance_depositLQTYViaPermit(lqtyAmount, permitParams);
        
        // Allocate the deposited LQTY
        int256[] memory votes = new int256[](1);
        votes[0] = int256(allocateAmount);
        governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
    }

    function shortcut_stakingV1Integration(uint256 lqtyAmount, uint256 allocateAmount) public {
        // Integration scenario with StakingV1
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit LQTY
        governance_depositLQTY(lqtyAmount);
        
        // Allocate votes
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Claim from StakingV1 (tests integration)
        governance_claimFromStakingV1(_getActor());
    }

    function shortcut_multiInitiativeVoting(uint256 depositAmount, uint256 allocateAmount1, uint256 allocateAmount2) public {
        // Voting across multiple initiatives (if available)
        
        // Register main initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit LQTY
        governance_depositLQTY(depositAmount);
        
        // Allocate to main initiative
        int256[] memory votes1 = new int256[](1);
        votes1[0] = int256(allocateAmount1);
        governance_allocateLQTY(new address[](0), new address[](1), votes1, new int256[](1));
        
        // Reset and reallocate to test different allocation patterns
        address[] memory initiativesToReset = new address[](1);
        initiativesToReset[0] = address(bribeInitiative);
        governance_resetAllocations(initiativesToReset, false);
        
        // Reallocate with different amounts
        int256[] memory votes2 = new int256[](1);
        votes2[0] = int256(allocateAmount2);
        governance_allocateLQTY(new address[](0), new address[](1), votes2, new int256[](1));
    }

    function shortcut_bribeWithEpochTransition(uint256 depositAmount, uint256 bribeAmount, uint256 epochSkip) public {
        // Bribe scenario with epoch transitions
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Skip multiple epochs
        for (uint256 i = 0; i < epochSkip && i < 3; i++) {
            vm.warp(block.timestamp + 604800); // 1 week
            
            // Switch to different actor to deposit bribe for each epoch
            switchActor(1);
            bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
            
            // Switch back and claim for initiative
            switchActor(0);
            governance_claimForInitiative(address(bribeInitiative));
        }
        
        // Claim all accumulated bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_emergencyScenarios(uint256 depositAmount, uint256 allocateAmount) public {
        // Test emergency and edge case scenarios
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Test immediate unregistration (emergency scenario)
        governance_unregisterInitiative(address(bribeInitiative));
        
        // Try to claim after unregistration
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
        
        // Test re-registration after emergency
        governance_registerInitiative(address(bribeInitiative));
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_proxyBasedMultiDelegate(uint256 depositAmount, uint256 allocateAmount) public {
        // Multi-delegate call through user proxy
        
        // Deploy user proxy
        governance_deployUserProxy();
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Get user proxy address
        address userProxy = governance.deriveUserProxyAddress(_getActor());
        
        // Create multi-delegate calls for proxy operations
        bytes[] memory calls = new bytes[](3);
        
        // Call 1: Deposit LQTY
        calls[0] = abi.encodeWithSignature("depositLQTY(uint256)", depositAmount);
        
        // Call 2: Allocate LQTY
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(allocateAmount);
        calls[1] = abi.encodeWithSelector(
            governance.allocateLQTY.selector,
            new address[](0),
            initiatives,
            votes,
            new int256[](1)
        );
        
        // Call 3: Snapshot votes
        calls[2] = abi.encodeWithSignature(
            "snapshotVotesForInitiative(address)",
            address(bribeInitiative)
        );
        
        // Execute multi-delegate call
        governance_multiDelegateCall(calls);
    }

    function shortcut_crossActorBribeCompetition(uint256 depositAmount, uint256 bribeAmount1, uint256 bribeAmount2, uint256 bribeAmount3) public {
        // Multiple actors competing with bribes for the same initiative
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Actor 0: Deposit and allocate votes
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Actor 1: Deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount1, bribeAmount1, governance.epoch());
        
        // Actor 2: Deposit larger bribe
        switchActor(2);
        bribeInitiative_depositBribe(bribeAmount2, bribeAmount2, governance.epoch());
        
        // Actor 3: Deposit even larger bribe
        switchActor(3);
        bribeInitiative_depositBribe(bribeAmount3, bribeAmount3, governance.epoch());
        
        // Wait for epoch to end
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative(address(bribeInitiative));
        
        // All actors claim their share of bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        
        for (uint256 i = 0; i < 4; i++) {
            switchActor(i);
            bribeInitiative_claimBribes(claimData);
        }
    }

    function shortcut_votingPowerManipulation(uint256 depositAmount1, uint256 depositAmount2, uint256 allocateAmount) public {
        // Test voting power dynamics across multiple actors
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Actor 0: Large deposit
        governance_depositLQTY(depositAmount1);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Actor 1: Smaller deposit
        switchActor(1);
        governance_depositLQTY(depositAmount2);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Actor 2: Deposit bribe to influence voting
        switchActor(2);
        bribeInitiative_depositBribe(allocateAmount, allocateAmount, governance.epoch());
        
        // Test voting power calculations
        switchActor(0);
        governance_snapshotVotesForInitiative(address(bribeInitiative));
        
        // Wait for epoch and test claim distribution
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
        
        // Test proportional bribe claims
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        
        switchActor(0);
        bribeInitiative_claimBribes(claimData);
        
        switchActor(1);
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_timelockAndEpochTransitions(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Test complex timing scenarios with epoch transitions
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate just before voting cutoff
        uint256 votingCutoff = governance.epochStart() + governance.EPOCH_VOTING_CUTOFF();
        vm.warp(votingCutoff - 100); // Just before cutoff
        
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Deposit bribe after voting cutoff
        vm.warp(votingCutoff + 100); // After cutoff
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Fast forward to next epoch
        vm.warp(governance.epochStart() + governance.EPOCH_DURATION());
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative(address(bribeInitiative));
        
        // Claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_adminRegistrationAndVoting(uint256 depositAmount, uint256 allocateAmount) public {
        // Admin registers initial initiatives, then regular users vote
        
        // Admin registers initial initiatives
        switchActor(0); // Ensure admin actor
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        governance_registerInitialInitiatives(initiatives);
        
        // Switch to regular user for voting
        switchActor(1);
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_multiDelegateVotingCycle(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Complete voting cycle using multi-delegate calls
        
        // Register initiative first
        governance_registerInitiative(address(bribeInitiative));
        
        // Switch to different actor for bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Switch back and create multi-delegate call for voting
        switchActor(0);
        bytes[] memory calls = new bytes[](2);
        
        // Deposit call
        calls[0] = abi.encodeWithSignature("depositLQTY(uint256)", depositAmount);
        
        // Allocate call
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(allocateAmount);
        calls[1] = abi.encodeWithSelector(
            governance.allocateLQTY.selector,
            new address[](0),
            initiatives,
            votes,
            new int256[](1)
        );
        
        // Execute multi-delegate call
        governance_multiDelegateCall(calls);
        
        // Wait for epoch and claim
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_proxyDeploymentAndStaking(uint256 stakeAmount, uint256 bribeAmount) public {
        // Deploy proxy, stake, and participate in bribe system
        
        // Deploy user proxy
        governance_deployUserProxy();
        
        // Get proxy address and approve
        address userProxy = governance.deriveUserProxyAddress(_getActor());
        lqty.approve(userProxy, stakeAmount);
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Switch to different actor for bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Switch back and stake through proxy
        switchActor(0);
        governance_depositLQTY(stakeAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait and claim
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_stakingV1ClaimAndVoting(uint256 lqtyAmount, uint256 allocateAmount) public {
        // Claim from StakingV1 and immediately participate in voting
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Claim from StakingV1 first
        governance_claimFromStakingV1(_getActor());
        
        // Deposit claimed LQTY
        governance_depositLQTY(lqtyAmount);
        
        // Allocate votes
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch to different actor for bribe
        switchActor(1);
        bribeInitiative_depositBribe(allocateAmount, allocateAmount, governance.epoch());
        
        // Wait and claim
        switchActor(0);
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_permitDepositAndVoting(uint256 lqtyAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Use permit-based deposit and participate in voting
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Create permit parameters
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
        governance_depositLQTYViaPermit(lqtyAmount, permitParams);
        
        // Allocate votes
        int256[] memory votes = new int256[](1);
        votes[0] = int256(allocateAmount);
        governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
        
        // Switch to different actor for bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Wait and claim
        switchActor(0);
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_votingThresholdScenario(uint256 depositAmount1, uint256 depositAmount2) public {
        // Test voting threshold calculations with multiple actors
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Actor 0: Large deposit to affect threshold
        governance_depositLQTY(depositAmount1);
        
        // Calculate threshold and allocate appropriately
        uint256 threshold = governance.calculateVotingThreshold();
        uint256 voteAmount = depositAmount1 > threshold ? threshold : depositAmount1;
        
        int256[] memory votes = new int256[](1);
        votes[0] = int256(voteAmount);
        governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
        
        // Actor 1: Also deposit to test threshold dynamics
        switchActor(1);
        governance_depositLQTY(depositAmount2);
        votes[0] = int256(depositAmount2);
        governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
        
        // Test snapshot functionality
        switchActor(0);
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    function shortcut_withdrawalDuringVoting(uint256 depositAmount, uint256 allocateAmount, uint256 withdrawAmount) public {
        // Test withdrawal scenarios during active voting
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch to different actor for bribe
        switchActor(1);
        bribeInitiative_depositBribe(allocateAmount, allocateAmount, governance.epoch());
        
        // Switch back and withdraw during voting period
        switchActor(0);
        governance_withdrawLQTY(withdrawAmount);
        
        // Reallocate with remaining balance
        (uint256 unallocatedLQTY,, uint256 allocatedLQTY,) = governance.userStates(_getActor());
        uint256 totalLQTY = unallocatedLQTY + allocatedLQTY;
        if (totalLQTY > 0) {
            int256[] memory votes = new int256[](1);
            votes[0] = int256(totalLQTY);
            governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
        }
        
        // Wait and claim
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_resetAndReallocation(uint256 depositAmount1, uint256 depositAmount2) public {
        // Test reset allocations and reallocation scenarios
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Initial deposit and allocation
        governance_depositLQTY(depositAmount1);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Reset allocations
        address[] memory initiativesToReset = new address[](1);
        initiativesToReset[0] = address(bribeInitiative);
        governance_resetAllocations(initiativesToReset, false);
        
        // Deposit more and reallocate
        governance_depositLQTY(depositAmount2);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(depositAmount1 + depositAmount2);
        governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
        
        // Switch to different actor for bribe
        switchActor(1);
        bribeInitiative_depositBribe(depositAmount2, depositAmount2, governance.epoch());
        
        // Wait and claim
        switchActor(0);
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_complexMultiDelegateSequence(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Complex multi-delegate call sequence with multiple operations
        
        // Register initiative first
        governance_registerInitiative(address(bribeInitiative));
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Switch back and create complex multi-delegate call
        switchActor(0);
        bytes[] memory calls = new bytes[](4);
        
        // Call 1: Deploy user proxy
        calls[0] = abi.encodeWithSignature("deployUserProxy()");
        
        // Call 2: Deposit LQTY
        calls[1] = abi.encodeWithSignature("depositLQTY(uint256)", depositAmount);
        
        // Call 3: Allocate LQTY
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(allocateAmount);
        int256[] memory vetos = new int256[](1);
        vetos[0] = int256(0);
        address[] memory emptyArray = new address[](0);
        
        calls[2] = abi.encodeWithSelector(
            governance.allocateLQTY.selector,
            emptyArray,
            initiatives,
            votes,
            vetos
        );
        
        // Call 4: Snapshot votes
        calls[3] = abi.encodeWithSignature(
            "snapshotVotesForInitiative(address)",
            address(bribeInitiative)
        );
        
        // Execute multi-delegate call
        governance_multiDelegateCall(calls);
        
        // Wait for epoch and claim
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_votingCutoffEdgeCase(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Test edge case around voting cutoff timing
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Get voting cutoff time
        uint256 votingCutoff = governance.epochStart() + governance.EPOCH_VOTING_CUTOFF();
        
        // Deposit and allocate just before cutoff
        vm.warp(votingCutoff - 10); // 10 seconds before cutoff
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch to different actor and try to deposit bribe after cutoff
        switchActor(1);
        vm.warp(votingCutoff + 10); // 10 seconds after cutoff
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Fast forward to next epoch
        vm.warp(governance.epochStart() + governance.EPOCH_DURATION());
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative(address(bribeInitiative));
        
        // Try to claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_registrationThresholdScenario(uint256 depositAmount1, uint256 depositAmount2) public {
        // Test registration threshold edge cases
        
        // Calculate registration threshold
        uint256 registrationThreshold = governance.calculateVotingThreshold() * 25; // Approximate registration threshold
        
        // Actor 0: Register initiative with minimal threshold
        governance_registerInitiative(address(bribeInitiative));
        
        // Actor 1: Deposit substantial amount to affect threshold calculations
        switchActor(1);
        governance_depositLQTY(depositAmount1);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Actor 0: Also deposit and allocate
        switchActor(0);
        governance_depositLQTY(depositAmount2);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Test threshold calculations
        governance_calculateVotingThreshold();
        governance_snapshotVotesForInitiative(address(bribeInitiative));
        
        // Wait and claim
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
    }

    function shortcut_unregistrationThresholdScenario(uint256 depositAmount, uint256 allocateAmount) public {
        // Test unregistration threshold scenarios
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate substantial amount
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch to different actor to also allocate
        switchActor(1);
        governance_depositLQTY(depositAmount / 2);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait for multiple epochs to test unregistration threshold
        for (uint256 i = 0; i < 5; i++) {
            vm.warp(block.timestamp + 604800); // 1 week
            switchActor(0);
            governance_claimForInitiative(address(bribeInitiative));
        }
        
        // Try to unregister after threshold period
        governance_unregisterInitiative(address(bribeInitiative));
    }

    function shortcut_minClaimEdgeCase(uint256 depositAmount, uint256 bribeAmount) public {
        // Test minimum claim edge cases
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit minimal amount
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch to different actor to deposit minimal bribe
        switchActor(1);
        uint256 minClaim = governance.MIN_CLAIM();
        uint256 adjustedBribeAmount = bribeAmount < minClaim ? minClaim : bribeAmount;
        bribeInitiative_depositBribe(adjustedBribeAmount, adjustedBribeAmount, governance.epoch());
        
        // Wait for epoch
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative(address(bribeInitiative));
        
        // Try to claim bribes (testing minimum claim logic)
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_minAccrualEdgeCase(uint256 depositAmount, uint256 bribeAmount) public {
        // Test minimum accrual edge cases
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Deposit and allocate
        governance_depositLQTY(depositAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        uint256 minAccrual = governance.MIN_ACCRUAL();
        uint256 adjustedBribeAmount = bribeAmount < minAccrual ? minAccrual : bribeAmount;
        bribeInitiative_depositBribe(adjustedBribeAmount, adjustedBribeAmount, governance.epoch());
        
        // Wait for epoch
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative(address(bribeInitiative));
        
        // Test accrual calculations
        governance_getInitiativeState(address(bribeInitiative));
    }

    function shortcut_proxyIntegrationWithBribes(uint256 stakeAmount, uint256 bribeAmount) public {
        // Test user proxy integration with bribe system
        
        // Deploy user proxy
        governance_deployUserProxy();
        
        // Get proxy address
        address userProxy = governance.deriveUserProxyAddress(_getActor());
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Switch back and stake through proxy
        switchActor(0);
        lqty.approve(userProxy, stakeAmount);
        governance_depositLQTY(stakeAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait and claim through proxy
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
        
        // Claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_stakingV1Migration(uint256 lqtyAmount, uint256 allocateAmount) public {
        // Test migration from StakingV1 to new governance system
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Claim from StakingV1 first
        governance_claimFromStakingV1(_getActor());
        
        // Deposit claimed LQTY
        governance_depositLQTY(lqtyAmount);
        
        // Allocate votes
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch to different actor to deposit bribe
        switchActor(1);
        bribeInitiative_depositBribe(allocateAmount, allocateAmount, governance.epoch());
        
        // Wait and claim
        switchActor(0);
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
        
        // Test migration state
        governance_getInitiativeState(address(bribeInitiative));
    }

    function shortcut_epochTransitionComplexity(uint256 depositAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Test complex epoch transition scenarios
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Create complex multi-epoch scenario
        for (uint256 i = 0; i < 3; i++) {
            // Switch to different actor for bribe each epoch
            switchActor((i + 1) % 4);
            bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
            
            // Switch back and allocate
            switchActor(0);
            if (i == 0) {
                governance_depositLQTY(depositAmount);
            }
            governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
            
            // Wait for epoch transition
            vm.warp(block.timestamp + 604800); // 1 week
            
            // Claim for initiative
            governance_claimForInitiative(address(bribeInitiative));
            
            // Test state after each epoch
            governance_getInitiativeState(address(bribeInitiative));
            governance_calculateVotingThreshold();
        }
        
        // Final claim of all accumulated bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    function shortcut_adminEmergencyActions(uint256 depositAmount, uint256 allocateAmount) public {
        // Admin emergency scenario with multi-delegate calls
        
        // Admin registers initial initiatives
        switchActor(0); // Ensure admin actor
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        governance_registerInitialInitiatives(initiatives);
        
        // Create emergency multi-delegate call
        bytes[] memory calls = new bytes[](3);
        
        // Call 1: Deploy user proxy for emergency operations
        calls[0] = abi.encodeWithSignature("deployUserProxy()");
        
        // Call 2: Deposit LQTY for emergency voting
        calls[1] = abi.encodeWithSignature("depositLQTY(uint256)", depositAmount);
        
        // Call 3: Allocate all votes to initiative
        address[] memory emptyArray = new address[](0);
        address[] memory targetInitiatives = new address[](1);
        targetInitiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(allocateAmount);
        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;
        
        calls[2] = abi.encodeWithSelector(
            governance.allocateLQTY.selector,
            emptyArray,
            targetInitiatives,
            votes,
            vetos
        );
        
        // Execute emergency multi-delegate call
        governance_multiDelegateCall(calls);
        
        // Switch to regular actor to test emergency effects
        switchActor(1);
        governance_depositLQTY(depositAmount / 2);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
    }

    function shortcut_complexBribeClaiming(uint256 depositAmount1, uint256 depositAmount2, uint256 bribeAmount) public {
        // Complex bribe claiming with multiple actors and epochs
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Actor 0: Initial setup
        governance_depositLQTY(depositAmount1);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Actor 1: Also participate
        switchActor(1);
        governance_depositLQTY(depositAmount2);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Actor 2: Deposit substantial bribe
        switchActor(2);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Wait for epoch
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Claim for initiative
        switchActor(0);
        governance_claimForInitiative(address(bribeInitiative));
        
        // All actors claim bribes with proper claim data
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        
        // Each actor claims their share
        for (uint256 i = 0; i < 3; i++) {
            switchActor(i);
            bribeInitiative_claimBribes(claimData);
        }
    }

    function shortcut_votingPowerReallocation(uint256 initialDeposit, uint256 newDeposit, uint256 reallocateAmount) public {
        // Test voting power reallocation scenarios
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Initial deposit and allocation
        governance_depositLQTY(initialDeposit);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch to different actor to add more voting power
        switchActor(1);
        governance_depositLQTY(newDeposit);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Switch back and reallocate
        switchActor(0);
        address[] memory initiativesToReset = new address[](1);
        initiativesToReset[0] = address(bribeInitiative);
        governance_resetAllocations(initiativesToReset, false);
        
        // Reallocate with new amounts
        int256[] memory votes = new int256[](1);
        votes[0] = int256(reallocateAmount);
        governance_allocateLQTY(new address[](0), new address[](1), votes, new int256[](1));
        
        // Test voting power after reallocation
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    function shortcut_permitAndMultiDelegate(uint256 lqtyAmount, uint256 allocateAmount) public {
        // Combine permit-based deposit with multi-delegate call
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Create permit parameters
        PermitParams memory permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: lqtyAmount,
            deadline: block.timestamp + 3600,
            v: 27,
            r: bytes32(uint256(keccak256("permit_signature"))),
            s: bytes32(uint256(keccak256("permit_signature_s")))
        });
        
        // Create multi-delegate call with permit
        bytes[] memory calls = new bytes[](2);
        
        // Call 1: Deposit using permit
        calls[0] = abi.encodeWithSelector(
            governance.depositLQTYViaPermit.selector,
            lqtyAmount,
            permitParams
        );
        
        // Call 2: Allocate LQTY
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(allocateAmount);
        int256[] memory vetos = new int256[](1);
        vetos[0] = 0;
        address[] memory emptyArray = new address[](0);
        
        calls[1] = abi.encodeWithSelector(
            governance.allocateLQTY.selector,
            emptyArray,
            initiatives,
            votes,
            vetos
        );
        
        // Execute multi-delegate call
        governance_multiDelegateCall(calls);
    }

    function shortcut_stakingV1IntegrationComplex(uint256 lqtyAmount, uint256 allocateAmount, uint256 bribeAmount) public {
        // Complex integration with StakingV1 including bribes
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Claim from StakingV1 for multiple actors
        for (uint256 i = 0; i < 3; i++) {
            switchActor(i);
            governance_claimFromStakingV1(_getActor());
        }
        
        // Main actor deposits and allocates
        switchActor(0);
        governance_depositLQTY(lqtyAmount);
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Other actors also participate
        for (uint256 i = 1; i < 3; i++) {
            switchActor(i);
            governance_depositLQTY(lqtyAmount / 2);
            governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        }
        
        // Switch to different actor to deposit bribe
        switchActor(3);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Wait and claim
        vm.warp(block.timestamp + 604800); // 1 week
        switchActor(0);
        governance_claimForInitiative(address(bribeInitiative));
        
        // All actors claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        
        for (uint256 i = 0; i < 3; i++) {
            switchActor(i);
            bribeInitiative_claimBribes(claimData);
        }
    }

    function shortcut_proxyBasedStakingFlow(uint256 stakeAmount, uint256 bribeAmount) public {
        // Complete staking flow through user proxy
        
        // Deploy user proxy
        governance_deployUserProxy();
        
        // Get proxy address and set up approvals
        address userProxy = governance.deriveUserProxyAddress(_getActor());
        lqty.approve(userProxy, stakeAmount);
        
        // Register initiative
        governance_registerInitiative(address(bribeInitiative));
        
        // Switch to different actor for bribe
        switchActor(1);
        bribeInitiative_depositBribe(bribeAmount, bribeAmount, governance.epoch());
        
        // Switch back and stake through proxy
        switchActor(0);
        governance_depositLQTY(stakeAmount, true, _getActor());
        governance_allocateLQTY(new address[](0), new address[](1), new int256[](1), new int256[](1));
        
        // Wait and claim through proxy
        vm.warp(block.timestamp + 604800); // 1 week
        governance_claimForInitiative(address(bribeInitiative));
        
        // Claim bribes
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative_claimBribes(claimData);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}