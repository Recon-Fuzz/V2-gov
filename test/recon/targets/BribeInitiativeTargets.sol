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
        // Clamp array size to maximum of 10
        if (_claimData.length > 10) {
            assembly {
                mstore(_claimData, 10)
            }
        }
        
        bribeInitiative_claimBribes(_claimData);
    }

    function bribeInitiative_depositBribe_clamped(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount,
        uint256 _epoch
    ) public asActor {
        // Clamp amounts to actor's balances
        _boldAmount %= bold.balanceOf(_getActor()) + 1;
        _bribeTokenAmount %= bribeToken.balanceOf(_getActor()) + 1;
        // Use exact current epoch
        _epoch = governance.epoch();
        
        bribeInitiative_depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
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
