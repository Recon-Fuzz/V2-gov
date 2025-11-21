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

import "src/CurveV2GaugeRewards.sol";

abstract contract CurveV2GaugeRewardsTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here //

    function curveV2GaugeRewards_onClaimForInitiative_clamped(uint256 _claimEpoch, uint256 _bold) public asActor {
        // Clamp the bold amount to be reasonable
        _bold %= bold.balanceOf(address(curveV2GaugeRewards)) + 1;
        _claimEpoch %= governance.epoch() + 1;
        
        curveV2GaugeRewards_onClaimForInitiative(_claimEpoch, _bold);
    }

    function curveV2GaugeRewards_depositIntoGauge_clamped(uint256 _amount) public asActor {
        // Clamp amount to available balance
        _amount %= bold.balanceOf(_getActor()) + 1;
        
        // First transfer bold to the contract
        vm.prank(_getActor());
        bold.transfer(address(curveV2GaugeRewards), _amount);
        
        // Then call the internal function via governance
        governance.claimForInitiative(address(curveV2GaugeRewards));
    }

    function curveV2GaugeRewards_triggerSmallDeposit_clamped() public asActor {
        // Deposit small amount to test the remainder logic
        uint256 smallAmount = 100; // Small amount to trigger remainder logic
        uint256 available = bold.balanceOf(_getActor());
        if (available >= smallAmount) {
            vm.prank(_getActor());
            bold.transfer(address(curveV2GaugeRewards), smallAmount);
            governance.claimForInitiative(address(curveV2GaugeRewards));
        }
    }

    function curveV2GaugeRewards_triggerLargeDeposit_clamped() public asActor {
        // Deposit large amount to test the main deposit logic
        uint256 largeAmount = 100000e18; // Large amount to bypass remainder logic
        uint256 available = bold.balanceOf(_getActor());
        if (available >= largeAmount) {
            vm.prank(_getActor());
            bold.transfer(address(curveV2GaugeRewards), largeAmount);
            governance.claimForInitiative(address(curveV2GaugeRewards));
        }
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function curveV2GaugeRewards_onClaimForInitiative(uint256 _claimEpoch, uint256 _bold) public asActor {
        curveV2GaugeRewards.onClaimForInitiative(_claimEpoch, _bold);
    }
}