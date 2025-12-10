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

    // Clamped handler for depositBribe
    function bribeInitiative_depositBribe_clamped(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) public {
        // Clamp BOLD amount to actor's balance
        _boldAmount = _boldAmount % (bold.balanceOf(_getActor()) + 1);
        
        // Clamp bribe token amount to actor's balance
        _bribeTokenAmount = _bribeTokenAmount % (bribeToken.balanceOf(_getActor()) + 1);
        
        // Clamp epoch to a reasonable range: current epoch to current + 52 weeks
        uint256 currentEpoch = governance.epoch();
        _epoch = currentEpoch + (_epoch % 53); // 0 to 52 weeks ahead
        
        bribeInitiative_depositBribe(_boldAmount, _bribeTokenAmount, _epoch);
    }

    // Clamped handler for claimBribes
    function bribeInitiative_claimBribes_clamped(uint256 epoch) public {
        // Clamp epoch to valid range (should be in the past)
        uint256 currentEpoch = governance.epoch();
        if (currentEpoch > 0) {
            epoch = epoch % currentEpoch;
        } else {
            epoch = 0;
        }
        
        // Get the most recent user and total epochs
        uint256 prevLQTYAllocationEpoch = bribeInitiative.getMostRecentUserEpoch(_getActor());
        uint256 prevTotalLQTYAllocationEpoch = bribeInitiative.getMostRecentTotalEpoch();
        
        // Create ClaimData array
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: epoch,
            prevLQTYAllocationEpoch: prevLQTYAllocationEpoch,
            prevTotalLQTYAllocationEpoch: prevTotalLQTYAllocationEpoch
        });
        
        bribeInitiative_claimBribes(claimData);
    }

    // Note: onAfterAllocateLQTY is a hook function that is called by Governance during allocateLQTY
    // It's not meant to be called directly by fuzzers, so we don't create a clamped handler for it
    // The function will be tested indirectly through governance_allocateLQTY_clamped

    // Clamped handler for onClaimForInitiative - uses governance epoch - 1
    function bribeInitiative_onClaimForInitiative_clamped() public {
        uint256 claimEpoch = governance.epoch();
        if (claimEpoch > 0) {
            claimEpoch = claimEpoch - 1;
        }
        bribeInitiative_onClaimForInitiative(claimEpoch, 0);
    }

    // Clamped handler for onRegisterInitiative - uses current epoch
    function bribeInitiative_onRegisterInitiative_clamped() public {
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_onRegisterInitiative(currentEpoch);
    }

    // Clamped handler for onUnregisterInitiative - uses current epoch
    function bribeInitiative_onUnregisterInitiative_clamped() public {
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_onUnregisterInitiative(currentEpoch);
    }

    // Clamped handler for totalLQTYAllocatedByEpoch
    function bribeInitiative_totalLQTYAllocatedByEpoch_clamped(uint256 _epoch) public {
        // Clamp to reasonable epoch range
        uint256 currentEpoch = governance.epoch();
        _epoch = currentEpoch + (_epoch % 53); // Current to +52 weeks
        
        bribeInitiative_totalLQTYAllocatedByEpoch(_epoch);
    }

    // Clamped handler for lqtyAllocatedByUserAtEpoch
    function bribeInitiative_lqtyAllocatedByUserAtEpoch_clamped(uint256 _epoch) public {
        address user = _getActor();
        
        // Clamp to reasonable epoch range
        uint256 currentEpoch = governance.epoch();
        _epoch = currentEpoch + (_epoch % 53); // Current to +52 weeks
        
        bribeInitiative_lqtyAllocatedByUserAtEpoch(user, _epoch);
    }

    // Clamped handler for checkClaimedBribeAtEpoch
    function bribeInitiative_checkClaimedBribeAtEpoch_clamped(uint256 _epoch) public {
        address user = _getActor();
        
        // Clamp to reasonable epoch range
        uint256 currentEpoch = governance.epoch();
        _epoch = currentEpoch + (_epoch % 53); // Current to +52 weeks
        
        bribeInitiative_checkClaimedBribeAtEpoch(user, _epoch);
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
