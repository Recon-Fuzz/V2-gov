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

abstract contract BribeInitiativeTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function clamped_bribeInitiative_claimBribes() public asActor {
        address actor = _getActor();
        uint256 mostRecentEpoch = bribeInitiative.getMostRecentUserEpoch(actor);
        
        if (mostRecentEpoch > 0) {
            IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
            claimData[0] = IBribeInitiative.ClaimData({
                epoch: mostRecentEpoch,
                claimBold: true,
                claimBribeToken: true
            });
            bribeInitiative.claimBribes(claimData);
        }
    }

    function clamped_bribeInitiative_depositBribe() public asActor {
        address actor = _getActor();
        uint256 currentEpoch = governance.epoch();
        
        uint256 boldBalance = bold.balanceOf(actor);
        uint256 bribeTokenBalance = bribeToken.balanceOf(actor);
        
        if (boldBalance > 0 && bribeTokenBalance > 0) {
            uint256 boldAmount = _bound(boldBalance, 1, boldBalance);
            uint256 bribeTokenAmount = _bound(bribeTokenBalance, 1, bribeTokenBalance);
            
            bribeInitiative.depositBribe(boldAmount, bribeTokenAmount, currentEpoch);
        }
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
