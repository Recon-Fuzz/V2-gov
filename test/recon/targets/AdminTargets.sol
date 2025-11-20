// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

abstract contract AdminTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function governance_registerInitialInitiatives_clamped(uint256 _numInitiatives) public asAdmin {
        // Limit number of initiatives to reasonable range
        uint256 numInitiatives = (_numInitiatives % 3) + 1; // 1-3 initiatives
        address[] memory initiatives = new address[](numInitiatives);
        
        // Use bribe initiative and actors as meaningful values
        initiatives[0] = address(bribeInitiative);
        address[] memory actors = _getActors();
        for (uint256 i = 1; i < numInitiatives; i++) {
            initiatives[i] = actors[i % actors.length];
        }
        
        governance_registerInitialInitiatives(initiatives);
    }

    function governance_multiDelegateCall_clamped(uint256 _numCalls) public asAdmin {
        // Limit number of delegate calls to reasonable range
        uint256 numCalls = (_numCalls % 3) + 1; // 1-3 calls
        bytes[] memory calls = new bytes[](numCalls);
        
        // Create simple delegate calls for common functions
        for (uint256 i = 0; i < numCalls; i++) {
            // Simple call to calculateVotingThreshold (no parameters needed)
            calls[i] = abi.encodeWithSignature("calculateVotingThreshold()");
        }
        
        governance_multiDelegateCall(calls);
    }

    function governance_registerInitialInitiatives(
        address[] memory _initiatives
    ) public asAdmin {
        governance.registerInitialInitiatives(_initiatives);
    }

    function governance_multiDelegateCall(
        bytes[] memory inputs
    ) public asAdmin {
        governance.multiDelegateCall(inputs);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
