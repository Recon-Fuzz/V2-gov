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
import {DoomsdayTargets} from "./targets/DoomsdayTargets.sol";
import {GovernanceTargets} from "./targets/GovernanceTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";

abstract contract TargetFunctions is
    AdminTargets,
    BribeInitiativeTargets,
    DoomsdayTargets,
    GovernanceTargets,
    ManagersTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function shortcut_allocateLQTY(
        uint256 _depositAmount,
        uint256 _numInitiatives,
        uint256 _voteAmount,
        uint256 _vetoAmount
    ) public {
        // Deposit LQTY first
        governance_depositLQTY_clamped(_depositAmount);
        
        // Create arrays for allocation
        uint256 numInit = (_numInitiatives % 3) + 1; // 1-3 initiatives
        address[] memory initiatives = new address[](numInit);
        int256[] memory votes = new int256[](numInit);
        int256[] memory vetos = new int256[](numInit);
        address[] memory initiativesToReset = new address[](0);
        
        // Fill with meaningful values
        for (uint256 i = 0; i < numInit; i++) {
            if (i == 0) {
                initiatives[i] = address(bribeInitiative);
            } else {
                // Use actor addresses as additional initiatives
                address[] memory actors = _getActors();
                initiatives[i] = actors[i % actors.length];
            }
            votes[i] = int256(_voteAmount % 1000); // Reasonable vote amounts
            vetos[i] = int256(_vetoAmount % 100);  // Smaller veto amounts
        }
        
        // Allocate LQTY to initiatives
        governance_allocateLQTY_clamped(initiativesToReset, initiatives, votes, vetos);
    }

    function shortcut_claimForInitiative(
        uint256 _bribeAmount,
        uint256 _bribeTokenAmount
    ) public {
        // Register initiative first
        governance_registerInitiative_clamped();
        
        // Switch to different actor to deposit bribes
        switchActor(1);
        bribeInitiative_depositBribe_clamped(_bribeAmount, _bribeTokenAmount, governance.epoch());
        
        // Switch back to claim
        switchActor(0);
        governance_claimForInitiative_clamped();
    }

    function shortcut_registerInitiative(uint256 _lqtyAmount) public {
        // Ensure actor has enough LQTY for registration fee
        // Registration fee is 1e18, so ensure we have at least that much
        uint256 minAmount = 1e18;
        if (_lqtyAmount < minAmount) {
            _lqtyAmount = minAmount;
        }
        
        // Mint additional LQTY if needed (using admin privileges)
        if (lqty.balanceOf(_getActor()) < _lqtyAmount) {
            vm.prank(address(this));
            lqty.mint(_getActor(), _lqtyAmount - lqty.balanceOf(_getActor()));
        }
        
        // Register initiative
        governance_registerInitiative_clamped();
    }

    function shortcut_claimBribes(
        uint256 _bribeAmount,
        uint256 _bribeTokenAmount,
        uint256 _numEpochs
    ) public {
        // Register initiative first
        governance_registerInitiative_clamped();
        
        // Switch to different actor to deposit bribes for multiple epochs
        switchActor(1);
        uint256 currentEpoch = governance.epoch();
        uint256 numEpochs = (_numEpochs % 3) + 1; // 1-3 epochs
        
        // Deposit bribes for current and future epochs
        for (uint256 i = 0; i < numEpochs; i++) {
            bribeInitiative_depositBribe_clamped(_bribeAmount, _bribeTokenAmount, currentEpoch + i);
        }
        
        // Switch back to claim bribes
        switchActor(0);
        
        // Create claim data for multiple epochs
        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](numEpochs);
        for (uint256 i = 0; i < numEpochs; i++) {
            claimData[i] = IBribeInitiative.ClaimData({
                epoch: currentEpoch + i,
                prevLQTYAllocationEpoch: 0, // Use 0 as default
                prevTotalLQTYAllocationEpoch: 0 // Use 0 as default
            });
        }
        
        bribeInitiative_claimBribes_clamped(claimData);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
