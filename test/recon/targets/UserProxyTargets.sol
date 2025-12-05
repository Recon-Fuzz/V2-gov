// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/UserProxy.sol";

abstract contract UserProxyTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function userProxy_stake(uint256 _amount, address _lqtyFrom, bool _doSendRewards, address _recipient) public asActor {
        userProxy.stake(_amount, _lqtyFrom, _doSendRewards, _recipient);
    }

    function userProxy_stakeViaPermit(uint256 _amount, address _lqtyFrom, PermitParams memory _permitParams, bool _doSendRewards, address _recipient) public asActor {
        userProxy.stakeViaPermit(_amount, _lqtyFrom, _permitParams, _doSendRewards, _recipient);
    }

    function userProxy_unstake(uint256 _amount, bool _doSendRewards, address _recipient) public asActor {
        userProxy.unstake(_amount, _doSendRewards, _recipient);
    }
}