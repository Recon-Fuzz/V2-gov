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

    // Clamped handler for claimBribes
    function bribeInitiative_claimBribes_clamped(
        uint256 _numClaims,
        uint256 _epoch1,
        uint256 _epoch2,
        uint256 _prevLQTYAlloc1,
        uint256 _prevTotalLQTYAlloc1,
        uint256 _prevLQTYAlloc2,
        uint256 _prevTotalLQTYAlloc2
    ) public asActor {
        // Limit number of claims
        _numClaims = bound(_numClaims, 1, 3);
        
        uint256 currentEpoch = governance.epoch();
        
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](_numClaims);
        
        for (uint256 i = 0; i < _numClaims; i++) {
            if (i == 0) {
                claimData[i].epoch = bound(_epoch1, 1, currentEpoch > 0 ? currentEpoch - 1 : 0);
                claimData[i].prevLQTYAllocationEpoch = bound(_prevLQTYAlloc1, 0, claimData[i].epoch);
                claimData[i].prevTotalLQTYAllocationEpoch = bound(_prevTotalLQTYAlloc1, 0, claimData[i].epoch);
            } else {
                claimData[i].epoch = bound(_epoch2, 1, currentEpoch > 0 ? currentEpoch - 1 : 0);
                claimData[i].prevLQTYAllocationEpoch = bound(_prevLQTYAlloc2, 0, claimData[i].epoch);
                claimData[i].prevTotalLQTYAllocationEpoch = bound(_prevTotalLQTYAlloc2, 0, claimData[i].epoch);
            }
        }
        
        bribeInitiative.claimBribes(claimData);
    }

    // Clamped handler for depositBribe
    function bribeInitiative_depositBribe_clamped(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount,
        uint256 _epoch
    ) public asActor {
        address actor = _getActor();
        
        // Bound amounts to reasonable values based on balance
        uint256 boldBalance = bold.balanceOf(actor);
        uint256 bribeBalance = bribeToken.balanceOf(actor);
        
        _boldAmount = bound(_boldAmount, 0, boldBalance > 0 ? boldBalance / 2 : 0);
        _bribeTokenAmount = bound(_bribeTokenAmount, 0, bribeBalance > 0 ? bribeBalance / 2 : 0);
        
        // Bound epoch to current or future epochs
        uint256 currentEpoch = governance.epoch();
        _epoch = bound(_epoch, currentEpoch, currentEpoch + 10);
        
        bribeInitiative.depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
    }

    // Clamped handler for totalLQTYAllocatedByEpoch
    function bribeInitiative_totalLQTYAllocatedByEpoch_clamped(
        uint256 _epoch
    ) public asActor {
        uint256 currentEpoch = governance.epoch();
        _epoch = bound(_epoch, 1, currentEpoch + 5);
        bribeInitiative.totalLQTYAllocatedByEpoch(_epoch);
    }

    // Clamped handler for lqtyAllocatedByUserAtEpoch
    function bribeInitiative_lqtyAllocatedByUserAtEpoch_clamped(
        uint256 _userIndex,
        uint256 _epoch
    ) public asActor {
        address[] memory actors = _getActors();
        require(actors.length > 0, "No actors");
        
        _userIndex = bound(_userIndex, 0, actors.length - 1);
        address user = actors[_userIndex];
        
        uint256 currentEpoch = governance.epoch();
        _epoch = bound(_epoch, 1, currentEpoch + 5);
        
        bribeInitiative.lqtyAllocatedByUserAtEpoch(user, _epoch);
    }

    // Clamped handler for claimedBribeAtEpoch
    function bribeInitiative_checkClaimedBribeAtEpoch_clamped(
        uint256 _userIndex,
        uint256 _epoch
    ) public asActor {
        address[] memory actors = _getActors();
        require(actors.length > 0, "No actors");
        
        _userIndex = bound(_userIndex, 0, actors.length - 1);
        address user = actors[_userIndex];
        
        uint256 currentEpoch = governance.epoch();
        _epoch = bound(_epoch, 1, currentEpoch + 5);
        
        bribeInitiative.claimedBribeAtEpoch(user, _epoch);
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

    function bribeInitiative_totalLQTYAllocatedByEpoch(
        uint256 _epoch
    ) public asActor {
        bribeInitiative.totalLQTYAllocatedByEpoch(_epoch);
    }

    function bribeInitiative_lqtyAllocatedByUserAtEpoch(
        address _user,
        uint256 _epoch
    ) public asActor {
        bribeInitiative.lqtyAllocatedByUserAtEpoch(_user, _epoch);
    }

    function bribeInitiative_checkClaimedBribeAtEpoch(
        address _user,
        uint256 _epoch
    ) public asActor {
        bribeInitiative.claimedBribeAtEpoch(_user, _epoch);
    }
}
