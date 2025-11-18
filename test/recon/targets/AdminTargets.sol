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

    function clamped_governance_registerInitialInitiatives() public asAdmin {
        address[] memory _initiatives = new address[](1);
        _initiatives[0] = address(bribeInitiative);
        governance.registerInitialInitiatives(_initiatives);
    }

    function clamped_governance_multiDelegateCall() public virtual asAdmin {
        bytes[] memory data = new bytes[](10);
        governance.multiDelegateCall(data);
    }

    function governance_registerInitialInitiatives(address[] memory _initiatives) public asAdmin {
        governance.registerInitialInitiatives(_initiatives);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
