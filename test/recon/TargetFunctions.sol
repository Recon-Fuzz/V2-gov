// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Interfaces
import {IBribeInitiative} from "src/interfaces/IBribeInitiative.sol";
import {PermitParams} from "src/utils/Types.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import {AdminTargets} from "./targets/AdminTargets.sol";
import {BribeInitiativeTargets} from "./targets/BribeInitiativeTargets.sol";
// import {
//     CurveV2GaugeRewardsTargets
// } from "./targets/CurveV2GaugeRewardsTargets.sol";
// import {DoomsdayTargets} from "./targets/DoomsdayTargets.sol";
import {GovernanceTargets} from "./targets/GovernanceTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";
// import {UniV4MerklRewardsTargets} from "./targets/UniV4MerklRewardsTargets.sol";

abstract contract TargetFunctions is
    AdminTargets,
    BribeInitiativeTargets,
    // CurveV2GaugeRewardsTargets,
    // DoomsdayTargets,
    GovernanceTargets,
    ManagersTargets
    // UniV4MerklRewardsTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function shortcut_claimForInitiative(uint256 _lqtyAmount, uint256 _voteAmount) public {
        // First register the initiative
        governance_registerInitiative_clamped();
        
        // Deposit LQTY to have unallocated LQTY
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Allocate LQTY to bribe initiative
        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        int256[] memory votes = new int256[](1);
        int256[] memory vetos = new int256[](1);
        
        initiatives[0] = address(bribeInitiative);
        votes[0] = int256(_voteAmount);
        vetos[0] = int256(0);
        
        governance_allocateLQTY_clamped(initiativesToReset, initiatives, votes, vetos);
        
        // Fast forward time to next epoch to make claimable
        vm.warp(block.timestamp + 604800); // 1 week (epoch duration)
        
        // Claim for the initiative
        governance_claimForInitiative_clamped();
    }

    function shortcut_claimBribes(uint256 _lqtyAmount, uint256 _voteAmount, uint256 _boldAmount, uint256 _bribeTokenAmount) public {
        // Deposit LQTY to have unallocated LQTY
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Allocate LQTY to bribe initiative
        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        int256[] memory votes = new int256[](1);
        int256[] memory vetos = new int256[](1);
        
        initiatives[0] = address(bribeInitiative);
        votes[0] = int256(_voteAmount);
        vetos[0] = int256(0);
        
        governance_allocateLQTY_clamped(initiativesToReset, initiatives, votes, vetos);
        
        // Deposit bribe for current epoch
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_depositBribe_clamped(_boldAmount, _bribeTokenAmount, currentEpoch);
        
        // Fast forward time to next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week (epoch duration)
        
        // Claim bribes
        bribeInitiative_claimBribes_clamped();
    }

    function shortcut_fullVotingCycle(uint256 _lqtyAmount, uint256 _voteAmount, uint256 _boldAmount, uint256 _bribeTokenAmount) public {
        // Complete voting cycle: register -> allocate -> claim rewards -> claim bribes
        
        // 1. Deposit LQTY to have voting power
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // 2. Register initiative
        governance_registerInitiative_clamped();
        
        // 3. Allocate LQTY to initiative
        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](1);
        int256[] memory votes = new int256[](1);
        int256[] memory vetos = new int256[](1);
        
        initiatives[0] = address(bribeInitiative);
        votes[0] = int256(_voteAmount);
        vetos[0] = int256(0);
        
        governance_allocateLQTY_clamped(initiativesToReset, initiatives, votes, vetos);
        
        // 4. Deposit bribe
        uint256 currentEpoch = governance.epoch();
        bribeInitiative_depositBribe_clamped(_boldAmount, _bribeTokenAmount, currentEpoch);
        
        // 5. Fast forward to next epoch
        vm.warp(block.timestamp + 604800); // 1 week
        
        // 6. Claim initiative rewards
        governance_claimForInitiative_clamped();
        
        // 7. Claim bribes
        bribeInitiative_claimBribes_clamped();
    }
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
