// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import { AdminTargets } from "./targets/AdminTargets.sol";
import { BribeInitiativeTargets } from "./targets/BribeInitiativeTargets.sol";
import { DoomsdayTargets } from "./targets/DoomsdayTargets.sol";
import { GovernanceTargets } from "./targets/GovernanceTargets.sol";
import { ManagersTargets } from "./targets/ManagersTargets.sol";
import { UserProxyTargets } from "./targets/UserProxyTargets.sol";
import { UserProxyFactoryTargets } from "./targets/UserProxyFactoryTargets.sol";

abstract contract TargetFunctions is
    AdminTargets,
    BribeInitiativeTargets,
    DoomsdayTargets,
    GovernanceTargets,
    ManagersTargets,
    UserProxyTargets,
    UserProxyFactoryTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///


    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
