// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";
import {IBribeInitiative} from "src/interfaces/IBribeInitiative.sol";

abstract contract Properties is BeforeAfter, Asserts {
    // Simple coverage optimization property
    function optimize_coverage() public returns (uint256) {
        return 0;
    }

    /// === HELPER FUNCTIONS FOR CLAMPING === ///

    /// @dev Returns initiatives with allocation for a given user
    /// This is used for clamping allocateLQTY and resetAllocations functions
    function getInitiativesWithAllocation(address user) internal view returns (address[] memory) {
        // Create a fixed size array - we know we have 3 initiatives
        address[] memory allInitiatives = new address[](3);
        allInitiatives[0] = address(bribeInitiative);
        allInitiatives[1] = address(curveV2GaugeRewards);
        allInitiatives[2] = address(uniV4MerklRewards);
        
        // Count initiatives with allocations
        uint256 count = 0;
        for (uint256 i = 0; i < allInitiatives.length; i++) {
            (uint256 voteLQTY,,uint256 vetoLQTY,,) = governance.lqtyAllocatedByUserToInitiative(user, allInitiatives[i]);
            if (voteLQTY > 0 || vetoLQTY > 0) {
                count++;
            }
        }
        
        // Create result array with exact size
        address[] memory result = new address[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < allInitiatives.length; i++) {
            (uint256 voteLQTY,,uint256 vetoLQTY,,) = governance.lqtyAllocatedByUserToInitiative(user, allInitiatives[i]);
            if (voteLQTY > 0 || vetoLQTY > 0) {
                result[index] = allInitiatives[i];
                index++;
            }
        }
        
        return result;
    }

    /// @dev Returns bribe claim data for a given user
    /// This is used for clamping claimBribes function
    function getBribeClaimData(address user) internal view returns (IBribeInitiative.ClaimData[] memory) {
        uint256 currentEpoch = governance.epoch();
        
        // We'll create claim data for epochs where the user has allocations
        // For simplicity, we'll check the last few epochs
        uint256 maxEpochs = currentEpoch > 10 ? 10 : currentEpoch;
        
        // Count valid epochs
        uint256 count = 0;
        for (uint256 i = 0; i < maxEpochs; i++) {
            uint256 epoch = currentEpoch - i;
            if (epoch == 0) break;
            
            (uint256 allocation,,,) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user, epoch);
            bool claimed = bribeInitiative.claimedBribeAtEpoch(user, epoch);
            
            if (allocation > 0 && !claimed) {
                count++;
            }
        }
        
        // Create result array
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](count);
        uint256 index = 0;
        
        for (uint256 i = 0; i < maxEpochs; i++) {
            uint256 epoch = currentEpoch - i;
            if (epoch == 0) break;
            
            (uint256 allocation,,,) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user, epoch);
            bool claimed = bribeInitiative.claimedBribeAtEpoch(user, epoch);
            
            if (allocation > 0 && !claimed) {
                claimData[index] = IBribeInitiative.ClaimData({
                    epoch: uint16(epoch),
                    prevLQTYAllocationEpoch: uint16(epoch > 0 ? epoch - 1 : 0),
                    prevTotalLQTYAllocationEpoch: uint16(epoch > 0 ? epoch - 1 : 0)
                });
                index++;
            }
        }
        
        return claimData;
    }
}
