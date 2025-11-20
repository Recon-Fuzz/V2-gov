// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";
import {bound} from "../../util/Random.sol";

import "src/BribeInitiative.sol";

abstract contract BribeInitiativeTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here //

    function bribeInitiative_claimBribes_clamped() public asActor {
        // Create a simple claim for current epoch - 1 (previous epoch)
        uint256 currentEpoch = governance.epoch();
        uint256 claimEpoch = currentEpoch == 0 ? 0 : currentEpoch - 1;
        
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: claimEpoch,
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        
        bribeInitiative_claimBribes(claimData);
    }

    function bribeInitiative_depositBribe_clamped(uint256 _boldAmount, uint256 _bribeTokenAmount) public asActor {
        // Clamp amounts to reasonable values that won't revert
        uint256 currentEpoch = governance.epoch();
        address actor = _getActor();
        
        // Use actor's token balances as upper bounds
        uint256 maxBold = bold.balanceOf(actor);
        uint256 maxBribeToken = bribeToken.balanceOf(actor);
        
        // Clamp amounts to available balances + 1 to allow full balance
        _boldAmount = maxBold > 0 ? (_boldAmount % (maxBold + 1)) : 0;
        _bribeTokenAmount = maxBribeToken > 0 ? (_bribeTokenAmount % (maxBribeToken + 1)) : 0;
        
        bribeInitiative_depositBribe(_boldAmount, _bribeTokenAmount, currentEpoch);
    }

    function bribeInitiative_depositBribe_currentEpoch_clamped() public asActor {
        // Deposit bribe for current epoch with reasonable amounts
        address actor = _getActor();
        uint256 currentEpoch = governance.epoch();
        
        uint256 boldBalance = bold.balanceOf(actor);
        uint256 bribeTokenBalance = bribeToken.balanceOf(actor);
        
        // Use 10% of balance as a reasonable bribe amount
        uint256 boldAmount = boldBalance / 10;
        uint256 bribeTokenAmount = bribeTokenBalance / 10;
        
        bribeInitiative_depositBribe(boldAmount, bribeTokenAmount, currentEpoch);
    }

    function bribeInitiative_onAfterAllocateLQTY_clamped() public asActor {
        // Call onAfterAllocateLQTY with realistic parameters
        address actor = _getActor();
        uint256 currentEpoch = governance.epoch();
        
        // Get user state from governance
        (uint256 unallocatedLQTY,, uint256 allocatedLQTY,) = governance.userStates(actor);
        
        // Create allocation for bribe initiative
        IGovernance.Allocation memory allocation = IGovernance.Allocation({
            voteLQTY: allocatedLQTY,
            voteOffset: 0,
            vetoLQTY: 0,
            vetoOffset: 0,
            atEpoch: currentEpoch
        });
        
        // Create user state
        IGovernance.UserState memory userState = IGovernance.UserState({
            unallocatedLQTY: unallocatedLQTY,
            unallocatedOffset: 0,
            allocatedLQTY: allocatedLQTY,
            allocatedOffset: 0
        });
        
        // Get initiative state for bribe initiative
        (uint256 voteLQTY, uint256 voteOffset, uint256 vetoLQTY, uint256 vetoOffset, uint256 lastEpochClaim) = governance.initiativeStates(address(bribeInitiative));
        
        IGovernance.InitiativeState memory initiativeState = IGovernance.InitiativeState({
            voteLQTY: voteLQTY,
            voteOffset: voteOffset,
            vetoLQTY: vetoLQTY,
            vetoOffset: vetoOffset,
            lastEpochClaim: lastEpochClaim
        });
        
        bribeInitiative_onAfterAllocateLQTY(currentEpoch, actor, userState, allocation, initiativeState);
    }

    function bribeInitiative_onClaimForInitiative_clamped() public asActor {
        // Call onClaimForInitiative with current epoch and reasonable amount
        uint256 currentEpoch = governance.epoch();
        uint256 claimAmount = 1000e18; // Reasonable claim amount
        
        bribeInitiative_onClaimForInitiative(currentEpoch, claimAmount);
    }

    function bribeInitiative_onRegisterInitiative_clamped() public asActor {
        // Call onRegisterInitiative with current epoch
        uint256 currentEpoch = governance.epoch();
        
        bribeInitiative_onRegisterInitiative(currentEpoch);
    }

    function bribeInitiative_onUnregisterInitiative_clamped() public asActor {
        // Call onUnregisterInitiative with current epoch
        uint256 currentEpoch = governance.epoch();
        
        bribeInitiative_onUnregisterInitiative(currentEpoch);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function bribeInitiative_claimBribes(
        IBribeInitiative.ClaimData[] memory _claimData
    ) public asActor {
        bribeInitiative.claimBribes(_claimData);
    }

    function bribeInitiative_depositBribe(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount,
        uint256 _epoch
    ) public asActor {
        bribeInitiative.depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
    }

    function bribeInitiative_onAfterAllocateLQTY(
        uint256 _currentEpoch,
        address _user,
        IGovernance.UserState memory _userState,
        IGovernance.Allocation memory _allocation,
        IGovernance.InitiativeState memory _initiativeState
    ) public asActor {
        bribeInitiative.onAfterAllocateLQTY(
            _currentEpoch,
            _user,
            _userState,
            _allocation,
            _initiativeState
        );
    }

    function bribeInitiative_onClaimForInitiative(
        uint256,
        uint256
    ) public asActor {
        bribeInitiative.onClaimForInitiative(0, 0);
    }

    function bribeInitiative_onRegisterInitiative(uint256) public asActor {
        bribeInitiative.onRegisterInitiative(0);
    }

    function bribeInitiative_onUnregisterInitiative(uint256) public asActor {
        bribeInitiative.onUnregisterInitiative(0);
    }
}
