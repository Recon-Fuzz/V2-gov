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

    /// @dev Helper to find previous allocation epoch for user
    function _findPrevUserEpoch(address user, uint256 epoch) internal view returns (uint256) {
        uint256 prevUserEpoch = bribeInitiative.getMostRecentUserEpoch(user);
        if (prevUserEpoch > epoch) {
            (,, uint256 prev,) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user, prevUserEpoch);
            while (prev > epoch && prev != 0) {
                prevUserEpoch = prev;
                (,, prev,) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user, prevUserEpoch);
            }
            if (prevUserEpoch > epoch) {
                prevUserEpoch = epoch;
            }
        } else if (prevUserEpoch == 0) {
            prevUserEpoch = epoch;
        }
        return prevUserEpoch;
    }

    /// @dev Helper to find previous total allocation epoch
    function _findPrevTotalEpoch(uint256 epoch) internal view returns (uint256) {
        uint256 prevTotalEpoch = bribeInitiative.getMostRecentTotalEpoch();
        if (prevTotalEpoch > epoch) {
            (,, uint256 prev,) = bribeInitiative.totalLQTYAllocatedByEpoch(prevTotalEpoch);
            while (prev > epoch && prev != 0) {
                prevTotalEpoch = prev;
                (,, prev,) = bribeInitiative.totalLQTYAllocatedByEpoch(prevTotalEpoch);
            }
            if (prevTotalEpoch > epoch) {
                prevTotalEpoch = epoch;
            }
        } else if (prevTotalEpoch == 0) {
            prevTotalEpoch = epoch;
        }
        return prevTotalEpoch;
    }

    /// @dev Returns bribe claim data for a given user
    /// This is used for clamping claimBribes function
    function getBribeClaimData(address user) internal view returns (IBribeInitiative.ClaimData[] memory) {
        uint256 currentEpoch = governance.epoch();
        
        // Can only claim for past epochs
        if (currentEpoch == 0) {
            return new IBribeInitiative.ClaimData[](0);
        }
        
        // We'll create claim data for epochs where the user has allocations
        // For simplicity, we'll check the last few epochs
        uint256 maxEpochs = currentEpoch > 10 ? 10 : currentEpoch;
        
        // Count valid epochs
        uint256 count = 0;
        for (uint256 i = 1; i < maxEpochs; i++) {
            uint256 epoch = currentEpoch - i;
            if (epoch == 0) break;
            
            // Check if there's a bribe for this epoch
            (uint256 remainingBold, uint256 remainingBribeToken,) = bribeInitiative.bribeByEpoch(epoch);
            if (remainingBold == 0 && remainingBribeToken == 0) continue;
            
            // Check if user already claimed
            bool claimed = bribeInitiative.claimedBribeAtEpoch(user, epoch);
            if (claimed) continue;
            
            // Check if user had allocation in this epoch
            (uint256 allocation,,,) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user, epoch);
            if (allocation > 0) {
                count++;
            }
        }
        
        // Create result array
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](count);
        uint256 index = 0;
        
        for (uint256 i = 1; i < maxEpochs; i++) {
            uint256 epoch = currentEpoch - i;
            if (epoch == 0) break;
            
            // Check if there's a bribe for this epoch
            (uint256 remainingBold, uint256 remainingBribeToken,) = bribeInitiative.bribeByEpoch(epoch);
            if (remainingBold == 0 && remainingBribeToken == 0) continue;
            
            // Check if user already claimed
            bool claimed = bribeInitiative.claimedBribeAtEpoch(user, epoch);
            if (claimed) continue;
            
            // Check if user had allocation in this epoch
            (uint256 allocation,,,) = bribeInitiative.lqtyAllocatedByUserAtEpoch(user, epoch);
            
            if (allocation > 0) {
                uint256 prevUserEpoch = _findPrevUserEpoch(user, epoch);
                uint256 prevTotalEpoch = _findPrevTotalEpoch(epoch);
                
                claimData[index] = IBribeInitiative.ClaimData({
                    epoch: uint16(epoch),
                    prevLQTYAllocationEpoch: uint16(prevUserEpoch),
                    prevTotalLQTYAllocationEpoch: uint16(prevTotalEpoch)
                });
                index++;
            }
        }
        
        return claimData;
    }
}
