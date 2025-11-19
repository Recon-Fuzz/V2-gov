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
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function bribeInitiative_claimBribes_clamped(
        IBribeInitiative.ClaimData[] memory _claimData
    ) public asActor {
        uint256 mostRecentEpoch = bribeInitiative.getMostRecentUserEpoch(_getActor());
        if (mostRecentEpoch > 0) {
            _claimData = new IBribeInitiative.ClaimData[](1);
            _claimData[0] = IBribeInitiative.ClaimData({
                epoch: mostRecentEpoch,
                prevLQTYAllocationEpoch: 0,
                prevTotalLQTYAllocationEpoch: 0
            });
        }
        
        bribeInitiative_claimBribes(_claimData);
    }

    function bribeInitiative_depositBribe_clamped(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount,
        uint256 _epoch
    ) public asActor {
        _boldAmount %= bold.balanceOf(_getActor()) + 1;
        _bribeTokenAmount %= bribeToken.balanceOf(_getActor()) + 1;
        _epoch = governance.epoch();
        
        bribeInitiative_depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
    }

    function bribeInitiative_onClaimForInitiative_clamped(
        uint256 _rewardAmount,
        uint256 _prevEpoch
    ) public asActor {
        _rewardAmount %= bold.balanceOf(address(bribeInitiative)) + 1;
        _prevEpoch = governance.epoch();
        
        bribeInitiative_onClaimForInitiative(_rewardAmount, _prevEpoch);
    }

    function bribeInitiative_onRegisterInitiative_clamped() public asActor {
        uint256 currentEpoch = governance.epoch();
        
        bribeInitiative_onRegisterInitiative(currentEpoch);
    }

    function bribeInitiative_onUnregisterInitiative_clamped() public asActor {
        uint256 currentEpoch = governance.epoch();
        
        bribeInitiative_onUnregisterInitiative(currentEpoch);
    }

    function bribeInitiative_onAfterAllocateLQTY_clamped() public asActor {
        uint256 currentEpoch = governance.epoch();
        address user = _getActor();
        
        (uint256 unallocatedLQTY,,,) = governance.userStates(user);
        IGovernance.UserState memory userState = IGovernance.UserState({
            unallocatedLQTY: unallocatedLQTY,
            unallocatedOffset: 0,
            allocatedLQTY: 0,
            allocatedOffset: 0
        });
        
        IGovernance.Allocation memory allocation = IGovernance.Allocation({
            voteLQTY: bound(unallocatedLQTY, 0, unallocatedLQTY),
            voteOffset: 0,
            vetoLQTY: bound(unallocatedLQTY, 0, unallocatedLQTY),
            vetoOffset: 0,
            atEpoch: currentEpoch
        });
        
        (,,,,uint256 lastEpochClaim) = governance.initiativeStates(address(bribeInitiative));
        IGovernance.InitiativeState memory initiativeState = IGovernance.InitiativeState({
            voteLQTY: 0,
            voteOffset: 0,
            vetoLQTY: 0,
            vetoOffset: 0,
            lastEpochClaim: lastEpochClaim
        });
        
        bribeInitiative_onAfterAllocateLQTY(currentEpoch, user, userState, allocation, initiativeState);
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
