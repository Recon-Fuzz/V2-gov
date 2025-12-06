// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ILQTYStaking} from "src/interfaces/ILQTYStaking.sol";
import {IERC20} from "openzeppelin/contracts/interfaces/IERC20.sol";

contract MockStakingV1 is ILQTYStaking {
    IERC20 public lqtyToken;

    mapping(address => uint256) public override stakes;
    uint256 public override totalLQTYStaked;

    uint256 public F_ETH;
    uint256 public F_LUSD;

    mapping(address => uint256) public pendingETHGain;
    mapping(address => uint256) public pendingLUSDGain;

    constructor(address _lqtyToken) {
        lqtyToken = IERC20(_lqtyToken);
    }

    function setAddresses(
        address,
        address,
        address,
        address,
        address
    ) external override {}

    function stake(uint256 _LQTYamount) external override {
        lqtyToken.transferFrom(msg.sender, address(this), _LQTYamount);
        stakes[msg.sender] += _LQTYamount;
        totalLQTYStaked += _LQTYamount;
        emit StakeChanged(msg.sender, stakes[msg.sender]);
    }

    function unstake(uint256 _LQTYamount) external override {
        require(stakes[msg.sender] >= _LQTYamount, "Insufficient stake");
        stakes[msg.sender] -= _LQTYamount;
        totalLQTYStaked -= _LQTYamount;
        lqtyToken.transfer(msg.sender, _LQTYamount);
        emit StakeChanged(msg.sender, stakes[msg.sender]);
    }

    function increaseF_ETH(uint256 _ETHFee) external override {
        F_ETH += _ETHFee;
        emit F_ETHUpdated(F_ETH);
    }

    function increaseF_LUSD(uint256 _LUSDFee) external override {
        F_LUSD += _LUSDFee;
        emit F_LUSDUpdated(F_LUSD);
    }

    function getPendingETHGain(address _user) external view override returns (uint256) {
        return pendingETHGain[_user];
    }

    function getPendingLUSDGain(address _user) external view override returns (uint256) {
        return pendingLUSDGain[_user];
    }

    // Helper functions for testing
    function setPendingETHGain(address _user, uint256 _amount) external {
        pendingETHGain[_user] = _amount;
    }

    function setPendingLUSDGain(address _user, uint256 _amount) external {
        pendingLUSDGain[_user] = _amount;
    }
}
