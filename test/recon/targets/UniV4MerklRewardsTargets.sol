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

import {MockUniV4MerklRewards} from "../../mocks/MockUniV4MerklRewards.sol";
import {IGovernance} from "src/interfaces/IGovernance.sol";

abstract contract UniV4MerklRewardsTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here //

    function uniV4MerklRewards_getCampaignData_clamped() public asActor {
        uniV4MerklRewards.getCampaignData();
    }

    function uniV4MerklRewards_onRegisterInitiative_clamped(uint256 _atEpoch) public asActor {
        _atEpoch %= governance.epoch() + 10; // Allow future epochs
        uniV4MerklRewards.onRegisterInitiative(_atEpoch);
    }

    function uniV4MerklRewards_onUnregisterInitiative_clamped(uint256 _atEpoch) public asActor {
        _atEpoch %= governance.epoch() + 10; // Allow future epochs
        uniV4MerklRewards.onUnregisterInitiative(_atEpoch);
    }

    function uniV4MerklRewards_onAfterAllocateLQTY_clamped() public asActor {
        uint256 currentEpoch = governance.epoch();
        address user = _getActor();
        
        // Simplified call with minimal parameters
        uniV4MerklRewards.onAfterAllocateLQTY(currentEpoch, user, 
            IGovernance.UserState(0, 0, 0, 0), 
            IGovernance.Allocation(0, 0, 0, 0, currentEpoch), 
            IGovernance.InitiativeState(0, 0, 0, 0, 0)
        );
    }

    function uniV4MerklRewards_onClaimForInitiative_clamped(uint256 _claimEpoch, uint256 _bold) public asActor {
        _claimEpoch %= governance.epoch() + 1;
        _bold %= bold.balanceOf(address(uniV4MerklRewards)) + 1;
        uniV4MerklRewards.onClaimForInitiative(_claimEpoch, _bold);
    }

function uniV4MerklRewards_claimForInitiative_clamped() public asActor {
        // Need to ensure that contract has some BOLD balance first
        uint256 balance = bold.balanceOf(address(uniV4MerklRewards));
        if (balance == 0) {
            // Transfer some BOLD to contract
            vm.prank(_getActor());
            bold.transfer(address(uniV4MerklRewards), 1000e18);
        }
        
        uniV4MerklRewards.claimForInitiative();
    }

    function uniV4MerklRewards_claimForInitiativeAboveThreshold_clamped() public asActor {
        // Transfer enough BOLD to be above threshold
        uint256 thresholdAmount = 2000e18; // Above the 1000e18 threshold
        uint256 available = bold.balanceOf(_getActor());
        if (available >= thresholdAmount) {
            vm.prank(_getActor());
            bold.transfer(address(uniV4MerklRewards), thresholdAmount);
            uniV4MerklRewards.claimForInitiative();
        }
    }

    function uniV4MerklRewards_claimForInitiativeBelowThreshold_clamped() public asActor {
        // Transfer small amount below threshold
        uint256 smallAmount = 500e18; // Below the 1000e18 threshold
        uint256 available = bold.balanceOf(_getActor());
        if (available >= smallAmount) {
            vm.prank(_getActor());
            bold.transfer(address(uniV4MerklRewards), smallAmount);
            uniV4MerklRewards.claimForInitiative();
        }
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function uniV4MerklRewards_getCampaignData() public asActor {
        uniV4MerklRewards.getCampaignData();
    }

    function uniV4MerklRewards_onRegisterInitiative(uint256 _atEpoch) public asActor {
        uniV4MerklRewards.onRegisterInitiative(_atEpoch);
    }

    function uniV4MerklRewards_onUnregisterInitiative(uint256 _atEpoch) public asActor {
        uniV4MerklRewards.onUnregisterInitiative(_atEpoch);
    }

    function uniV4MerklRewards_onAfterAllocateLQTY(
        uint256 _currentEpoch,
        address _user,
        IGovernance.UserState memory _userState,
        IGovernance.Allocation memory _allocation,
        IGovernance.InitiativeState memory _initiativeState
    ) public asActor {
        uniV4MerklRewards.onAfterAllocateLQTY(_currentEpoch, _user, _userState, _allocation, _initiativeState);
    }

    function uniV4MerklRewards_onClaimForInitiative(uint256 _claimEpoch, uint256 _bold) public asActor {
        uniV4MerklRewards.onClaimForInitiative(_claimEpoch, _bold);
    }

    function uniV4MerklRewards_claimForInitiative() public asActor {
        uniV4MerklRewards.claimForInitiative();
    }
}