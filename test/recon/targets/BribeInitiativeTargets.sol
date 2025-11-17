// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/BribeInitiative.sol";

abstract contract BribeInitiativeTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function clamped_bribeInitiative_depositBribe() public asActor {
        uint256 maxBold = bold.balanceOf(_getActor());
        uint256 maxBribeToken = bribeToken.balanceOf(_getActor());
        uint256 boldAmount = maxBold > 0 ? maxBold : 1e18;
        uint256 bribeTokenAmount = maxBribeToken > 0 ? maxBribeToken : 1e18;
        uint256 epoch = governance.epoch();
        bribeInitiative.depositBribe(boldAmount, bribeTokenAmount, epoch);
    }

    function clamped_bribeInitiative_claimBribes() public asActor {
        IBribeInitiative.ClaimData[] memory _claimData = new IBribeInitiative.ClaimData[](1);
        _claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch(),
            prevLQTYAllocationEpoch: 0,
            prevTotalLQTYAllocationEpoch: 0
        });
        bribeInitiative.claimBribes(_claimData);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function bribeInitiative_claimBribes(IBribeInitiative.ClaimData[] memory _claimData) public asActor {
        bribeInitiative.claimBribes(_claimData);
    }

    function bribeInitiative_depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) public asActor {
        bribeInitiative.depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
    }

    function bribeInitiative_onAfterAllocateLQTY(uint256 _currentEpoch, address _user, IGovernance.UserState memory _userState, IGovernance.Allocation memory _allocation, IGovernance.InitiativeState memory _initiativeState) public asActor {
        bribeInitiative.onAfterAllocateLQTY(_currentEpoch, _user, _userState, _allocation, _initiativeState);
    }

    function bribeInitiative_onClaimForInitiative(uint256 , uint256 ) public asActor {
        bribeInitiative.onClaimForInitiative(0, 0);
    }

    function bribeInitiative_onRegisterInitiative(uint256 ) public asActor {
        bribeInitiative.onRegisterInitiative(0);
    }

    function bribeInitiative_onUnregisterInitiative(uint256 ) public asActor {
        bribeInitiative.onUnregisterInitiative(0);
    }
}