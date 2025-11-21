// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {IDistributionCreator} from "src/interfaces/IDistributionCreator.sol";

contract MockDistributionCreator is IDistributionCreator {
    function acceptConditions() external override {
        // Mock implementation - does nothing
    }
    
    function createCampaign(CampaignParameters memory /*params*/) external override returns (bytes32) {
        // Return a mock campaign ID
        return bytes32(0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890);
    }
    
    function campaignId(CampaignParameters memory /*params*/) external view override returns (bytes32) {
        // Return a mock campaign ID
        return bytes32(0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef);
    }
    
    function distributor() external view override returns (address) {
        return address(this);
    }
    
    function campaign(bytes32 /*_campaignId*/) external view override returns (CampaignParameters memory) {
        // Return empty campaign parameters
        return CampaignParameters({
            campaignId: bytes32(0),
            creator: address(0),
            rewardToken: address(0),
            amount: 0,
            campaignType: 0,
            startTimestamp: 0,
            duration: 0,
            campaignData: ""
        });
    }
    
    function campaignLookup(bytes32 /*_campaignId*/) external view override returns (uint256) {
        return 0;
    }
}