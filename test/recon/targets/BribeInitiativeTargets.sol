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
        uint256 mostRecentEpoch = bribeInitiative.getMostRecentUserEpoch(_getActor());
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: mostRecentEpoch,
            prevLQTYAllocationEpoch: mostRecentEpoch,
            prevTotalLQTYAllocationEpoch: mostRecentEpoch
        });
        
        bribeInitiative_claimBribes(claimData);
    }

    function bribeInitiative_depositBribe_clamped(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount
    ) public asActor {
        _boldAmount %= bold.balanceOf(_getActor()) + 1;
        _bribeTokenAmount %= bribeToken.balanceOf(_getActor()) + 1;
        uint256 currentEpoch = governance.epoch();
        
        bribeInitiative_depositBribe(_boldAmount, _bribeTokenAmount, currentEpoch);
    }

    function bribeInitiative_onAfterAllocateLQTY_clamped() public asActor {
        uint256 currentEpoch = governance.epoch();
        address user = _getActor();
        (uint256 unallocatedLQTY, uint256 unallocatedOffset, uint256 allocatedLQTY, uint256 allocatedOffset) = governance.userStates(user);
        IGovernance.UserState memory userState = IGovernance.UserState({
            unallocatedLQTY: unallocatedLQTY,
            unallocatedOffset: unallocatedOffset,
            allocatedLQTY: allocatedLQTY,
            allocatedOffset: allocatedOffset
        });
        IGovernance.Allocation memory allocation = IGovernance.Allocation({
            voteLQTY: 0,
            voteOffset: 0,
            vetoLQTY: 0,
            vetoOffset: 0,
            atEpoch: currentEpoch
        });
        (uint256 voteLQTY, uint256 voteOffset, uint256 vetoLQTY, uint256 vetoOffset, uint256 lastEpochClaim) = governance.initiativeStates(address(bribeInitiative));
        IGovernance.InitiativeState memory initiativeState = IGovernance.InitiativeState({
            voteLQTY: voteLQTY,
            voteOffset: voteOffset,
            vetoLQTY: vetoLQTY,
            vetoOffset: vetoOffset,
            lastEpochClaim: lastEpochClaim
        });
        
        bribeInitiative_onAfterAllocateLQTY(currentEpoch, user, userState, allocation, initiativeState);
    }

    function bribeInitiative_onClaimForInitiative_clamped() public asActor {
        uint256 currentEpoch = governance.epoch();
        uint256 claimAmount = 0;
        
        bribeInitiative_onClaimForInitiative(currentEpoch, claimAmount);
    }

    function bribeInitiative_onRegisterInitiative_clamped() public asActor {
        uint256 currentEpoch = governance.epoch();
        
        bribeInitiative_onRegisterInitiative(currentEpoch);
    }

    function bribeInitiative_onUnregisterInitiative_clamped() public asActor {
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
