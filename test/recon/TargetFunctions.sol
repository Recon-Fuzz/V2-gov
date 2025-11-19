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
        calls[0] = abi.encodeWithSelector(
            governance.depositLQTY.selector,
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
        calls[1] = abi.encodeWithSelector(
            governance.depositLQTY.selector,
            depositAmount
        );
        
        // Execute admin multi-delegate call
        governance_multiDelegateCall(calls);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}