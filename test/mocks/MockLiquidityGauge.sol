// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ILiquidityGauge} from "src/interfaces/ILiquidityGauge.sol";
import {IERC20} from "openzeppelin/contracts/interfaces/IERC20.sol";

contract MockLiquidityGauge is ILiquidityGauge {
    IERC20 public rewardToken;
    
    constructor(address _rewardToken) {
        rewardToken = IERC20(_rewardToken);
    }
    
    function add_reward(address /*_reward_token*/, address /*_distributor*/) external override {
        // Mock implementation - does nothing
    }
    
    function deposit_reward_token(address /*_rewardToken*/, uint256 /*_amount*/, uint256 /*_epoch*/) external override {
        // Mock implementation - does nothing
    }
}