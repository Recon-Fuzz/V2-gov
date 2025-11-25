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
        // Step 1: Register initiative (using default actor)
        governance_registerInitiative_clamped();
        
        // Step 2: Deposit LQTY for voting (using default actor)
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Step 3: Allocate LQTY to the initiative (using default actor)
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(_voteAmount);
        int256[] memory vetos = new int256[](1);
        vetos[0] = int256(0);
        
        governance_allocateLQTY_clamped(new address[](0), initiatives, votes, vetos);
        
        // Step 4: Fast-forward to next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Step 5: Claim for initiative (using default actor)
        governance_claimForInitiative_clamped();
    }
    
    function shortcut_claimBribes(uint256 _lqtyAmount, uint256 _voteAmount, uint256 _boldAmount, uint256 _bribeTokenAmount) public {
        // Step 1: Register initiative (using default actor)
        governance_registerInitiative_clamped();
        
        // Step 2: Deposit LQTY for voting (using default actor)
        governance_depositLQTY_clamped(_lqtyAmount);
        
        // Step 3: Allocate LQTY to the initiative (using default actor)
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        int256[] memory votes = new int256[](1);
        votes[0] = int256(_voteAmount);
        int256[] memory vetos = new int256[](1);
        vetos[0] = int256(0);
        
        governance_allocateLQTY_clamped(new address[](0), initiatives, votes, vetos);
        
        // Step 4: Deposit bribes for the current epoch (using default actor)
        bribeInitiative_depositBribe_clamped(_boldAmount, _bribeTokenAmount, governance.epoch());
        
        // Step 5: Fast-forward to next epoch to enable claiming
        vm.warp(block.timestamp + 604800); // 1 week
        
        // Step 6: Claim bribes (using default actor)
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
        claimData[0] = IBribeInitiative.ClaimData({
            epoch: governance.epoch() - 1,
            prevUserEpoch: 0,
            prevTotalEpoch: 0
        });
        
        bribeInitiative_claimBribes_clamped(claimData);
    }
    
    function shortcut_unregisterInitiative() public {
        // Step 1: Register initiative (using default actor)
        governance_registerInitiative_clamped();
        
        // Step 2: Fast-forward through required epochs (UNREGISTRATION_AFTER_EPOCHS = 4)
        vm.warp(block.timestamp + (604800 * 5)); // 5 weeks to ensure unregisterable
        
        // Step 3: Unregister initiative (using default actor)
        governance_unregisterInitiative_clamped();
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
