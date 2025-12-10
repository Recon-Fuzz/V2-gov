// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Interfaces
import {IGovernance} from "src/interfaces/IGovernance.sol";

abstract contract AdminTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function governance_registerInitialInitiatives(
        address[] memory _initiatives
    ) public asAdmin {
        governance.registerInitialInitiatives(_initiatives);
    }

    function bribeInitiative_onAfterAllocateLQTY(
        uint256 _currentEpoch,
        address _user,
        IGovernance.UserState memory _userState,
        IGovernance.Allocation memory _allocation,
        IGovernance.InitiativeState memory _initiativeState
    ) public asAdmin {
        bribeInitiative.onAfterAllocateLQTY(
            _currentEpoch,
            _user,
            _userState,
            _allocation,
            _initiativeState
        );
    }

    function bribeInitiative_onClaimForInitiative(
        uint256 _epoch,
        uint256 _amount
    ) public asAdmin {
        bribeInitiative.onClaimForInitiative(_epoch, _amount);
    }

    function bribeInitiative_onRegisterInitiative(uint256 _epoch) public asAdmin {
        bribeInitiative.onRegisterInitiative(_epoch);
    }

    function bribeInitiative_onUnregisterInitiative(uint256 _epoch) public asAdmin {
        bribeInitiative.onUnregisterInitiative(_epoch);
    }
}
