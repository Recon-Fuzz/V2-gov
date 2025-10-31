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

    // Clamped handler for depositBribe - constrains amounts to token balances and valid epochs
    function bribeInitiative_depositBribe_clamped(
        uint256 _boldAmount,
        uint256 _bribeTokenAmount,
        uint256 _epoch
    ) public asActor {
        address actor = _getActor();

        // Clamp BOLD amount to actor's balance (0 to balance inclusive)
        uint256 boldBalance = bold.balanceOf(actor);
        _boldAmount = _boldAmount % (boldBalance + 1);

        // Clamp bribe token amount to actor's balance (0 to balance inclusive)
        uint256 bribeTokenBalance = bribeToken.balanceOf(actor);
        _bribeTokenAmount = _bribeTokenAmount % (bribeTokenBalance + 1);

        // Clamp epoch to current or future (up to 10 epochs in future)
        uint256 currentEpoch = governance.epoch();
        _epoch = currentEpoch + (_epoch % 11); // 0-10 epochs in future

        bribeInitiative_depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
    }

    // Clamped handler for depositBribe on bribeInitiative2 - uses LQTY as bribe token
    function bribeInitiative2_depositBribe_clamped(
        uint256 _boldAmount,
        uint256 _lqtyAmount,
        uint256 _epoch
    ) public asActor {
        address actor = _getActor();

        // Clamp BOLD amount to actor's balance (0 to balance inclusive)
        uint256 boldBalance = bold.balanceOf(actor);
        _boldAmount = _boldAmount % (boldBalance + 1);

        // Clamp LQTY amount to actor's balance (0 to balance inclusive)
        uint256 lqtyBalance = lqty.balanceOf(actor);
        _lqtyAmount = _lqtyAmount % (lqtyBalance + 1);

        // Clamp epoch to current or future (up to 10 epochs in future)
        uint256 currentEpoch = governance.epoch();
        _epoch = currentEpoch + (_epoch % 11); // 0-10 epochs in future

        // Call depositBribe on bribeInitiative2
        vm.prank(_getActor());
        bribeInitiative2.depositBribe(_boldAmount, _lqtyAmount, _epoch);
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