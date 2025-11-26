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

    // === CLAMPED HANDLERS === //

    /// @dev Clamped version of bribeInitiative_depositBribe - clamps amounts to actor's balances and epoch
    function bribeInitiative_depositBribe_clamped(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount,
        uint256 _epoch
    ) public asActor {
        _boldAmount = _boldAmount % (bold.balanceOf(_getActor()) + 1);
        _bribeTokenAmount = _bribeTokenAmount % (bribeToken.balanceOf(_getActor()) + 1);
        _epoch = _epoch % (governance.epoch() + 10 + 1);
        
        bribeInitiative_depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
    }

    /// @dev Clamped version of bribeInitiative_claimBribes - clamps epoch to current epoch
    function bribeInitiative_claimBribes_clamped(uint256 _epochEntropy, uint256 _prevEpochEntropy1, uint256 _prevEpochEntropy2) public asActor {
        uint256 currentEpoch = governance.epoch();
        
        // Create claim data for a single epoch
        IBribeInitiative.ClaimData[] memory _claimData = new IBribeInitiative.ClaimData[](1);
        
        // Clamp epoch to current epoch range
        uint256 claimEpoch = _epochEntropy % (currentEpoch + 1);
        
        _claimData[0] = IBribeInitiative.ClaimData({
            epoch: claimEpoch,
            prevLQTYAllocationEpoch: _prevEpochEntropy1 % (currentEpoch + 1),
            prevTotalLQTYAllocationEpoch: _prevEpochEntropy2 % (currentEpoch + 1)
        });
        
        bribeInitiative_claimBribes(_claimData);
    }

    /// @dev Clamped version of bribeInitiative_onAfterAllocateLQTY - clamps epoch to current epoch
    function bribeInitiative_onAfterAllocateLQTY_clamped(
        uint256 _currentEpoch,
        IGovernance.UserState memory _userState,
        IGovernance.Allocation memory _allocation,
        IGovernance.InitiativeState memory _initiativeState
    ) public asActor {
        _currentEpoch = _currentEpoch % (governance.epoch() + 1);
        
        bribeInitiative_onAfterAllocateLQTY(
            _currentEpoch,
            _getActor(),
            _userState,
            _allocation,
            _initiativeState
        );
    }

    /// @dev Clamped version of bribeInitiative_lqtyAllocatedByUserAtEpoch - uses actor and clamped epoch
    function bribeInitiative_lqtyAllocatedByUserAtEpoch_clamped(uint256 _epoch) public asActor {
        _epoch = _epoch % (governance.epoch() + 1);
        bribeInitiative_lqtyAllocatedByUserAtEpoch(_getActor(), _epoch);
    }

    /// @dev Clamped version of bribeInitiative_totalLQTYAllocatedByEpoch - clamps epoch
    function bribeInitiative_totalLQTYAllocatedByEpoch_clamped(uint256 _epoch) public asActor {
        _epoch = _epoch % (governance.epoch() + 1);
        bribeInitiative_totalLQTYAllocatedByEpoch(_epoch);
    }

    /// @dev Clamped version of bribeInitiative_checkClaimedBribeAtEpoch - uses actor and clamped epoch
    function bribeInitiative_checkClaimedBribeAtEpoch_clamped(uint256 _epoch) public asActor {
        _epoch = _epoch % (governance.epoch() + 1);
        bribeInitiative_checkClaimedBribeAtEpoch(_getActor(), _epoch);
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
