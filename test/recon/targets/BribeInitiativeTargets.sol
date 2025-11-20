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
        // Create a simple claim data with current epoch
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        uint256 currentEpoch = (block.timestamp - governance.EPOCH_START()) / governance.EPOCH_DURATION();
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: currentEpoch - 1, // Previous epoch to allow claiming
            prevLQTYAllocationEpoch: currentEpoch - 1,
            prevTotalLQTYAllocationEpoch: currentEpoch - 1
        });
        
        bribeInitiative_claimBribes(claimData);
    }

    function bribeInitiative_depositBribe_clamped(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount,
        uint256 _epoch
    ) public asActor {
        // Clamp amounts to actor's balances
        _boldAmount %= bold.balanceOf(_getActor()) + 1;
        _bribeTokenAmount %= bribeToken.balanceOf(_getActor()) + 1;
        // Clamp epoch to reasonable range (current epoch +/- 10)
        uint256 currentEpoch = (block.timestamp - governance.epochStart()) / governance.epochDuration();
        _epoch = currentEpoch + (_epoch % 21) - 10; // Range: currentEpoch-10 to currentEpoch+10
        
        bribeInitiative_depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
    }

    function bribeInitiative_onAfterAllocateLQTY_clamped() public asActor {
        // Use current actor and current epoch for meaningful values
        uint256 currentEpoch = (block.timestamp - governance.epochStart()) / governance.epochDuration();
        address user = _getActor();
        
        // Create minimal valid structs
        IGovernance.UserState memory userState = IGovernance.UserState({
            lqtyVotes: 0,
            lqtyVetos: 0,
            lastClaimEpoch: 0
        });
        
        IGovernance.Allocation memory allocation = IGovernance.Allocation({
            absoluteLQTYVotes: 0,
            absoluteLQTYVetos: 0
        });
        
        IGovernance.InitiativeState memory initiativeState = IGovernance.InitiativeState({
            totalLQTYVotes: 0,
            totalLQTYVetos: 0,
            lastClaimEpoch: 0,
            isRegistered: true
        });
        
        bribeInitiative_onAfterAllocateLQTY(currentEpoch, user, userState, allocation, initiativeState);
    }

    function bribeInitiative_onClaimForInitiative_clamped(
        uint256 _rewardAmount,
        uint256 _epoch
    ) public asActor {
        // Clamp reward amount to reasonable range
        _rewardAmount %= 10000e18; // Max 10k tokens
        // Clamp epoch to reasonable range (current epoch +/- 10)
        uint256 currentEpoch = (block.timestamp - governance.epochStart()) / governance.epochDuration();
        _epoch = currentEpoch + (_epoch % 21) - 10;
        
        bribeInitiative_onClaimForInitiative(_rewardAmount, _epoch);
    }

    function bribeInitiative_onRegisterInitiative_clamped(uint256 _epoch) public asActor {
        // Clamp epoch to reasonable range (current epoch +/- 10)
        uint256 currentEpoch = (block.timestamp - governance.epochStart()) / governance.epochDuration();
        _epoch = currentEpoch + (_epoch % 21) - 10;
        
        bribeInitiative_onRegisterInitiative(_epoch);
    }

    function bribeInitiative_onUnregisterInitiative_clamped(uint256 _epoch) public asActor {
        // Clamp epoch to reasonable range (current epoch +/- 10)
        uint256 currentEpoch = (block.timestamp - governance.epochStart()) / governance.epochDuration();
        _epoch = currentEpoch + (_epoch % 21) - 10;
        
        bribeInitiative_onUnregisterInitiative(_epoch);
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
