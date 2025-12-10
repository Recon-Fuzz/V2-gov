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
import {PermitParams} from "src/utils/Types.sol";

import "src/Governance.sol";

abstract contract GovernanceTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Helper function to get allocated initiatives for an actor
    function getAllocatedInitiatives(address user) internal view returns (address[] memory) {
        address[] memory initiatives = new address[](3);
        uint256 count = 0;
        
        (uint256 voteLQTY1, , uint256 vetoLQTY1, , ) = governance.lqtyAllocatedByUserToInitiative(user, address(bribeInitiative));
        (uint256 voteLQTY2, , uint256 vetoLQTY2, , ) = governance.lqtyAllocatedByUserToInitiative(user, address(curveV2GaugeRewards));
        (uint256 voteLQTY3, , uint256 vetoLQTY3, , ) = governance.lqtyAllocatedByUserToInitiative(user, address(uniV4MerklRewards));
        
        if (voteLQTY1 > 0 || vetoLQTY1 > 0) {
            initiatives[count++] = address(bribeInitiative);
        }
        if (voteLQTY2 > 0 || vetoLQTY2 > 0) {
            initiatives[count++] = address(curveV2GaugeRewards);
        }
        if (voteLQTY3 > 0 || vetoLQTY3 > 0) {
            initiatives[count++] = address(uniV4MerklRewards);
        }
        
        // Resize array to actual count
        address[] memory result = new address[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = initiatives[i];
        }
        return result;
    }

    // Clamped handler for depositLQTY
    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public {
        _lqtyAmount = _lqtyAmount % (lqty.balanceOf(_getActor()) + 1);
        governance_depositLQTY(_lqtyAmount);
    }

    // Clamped handler for withdrawLQTY
    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public {
        (uint256 unallocatedLQTY, , , ) = governance.userStates(_getActor());
        _lqtyAmount = _lqtyAmount % (unallocatedLQTY + 1);
        governance_withdrawLQTY(_lqtyAmount);
    }

    // Clamped handler for registerInitiative - cycles through the 3 known initiatives
    function governance_registerInitiative_clamped(uint8 initiativeIndex) public {
        address initiative;
        if (initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        governance_registerInitiative(initiative);
    }

    // Clamped handler for allocateLQTY with meaningful values
    function governance_allocateLQTY_clamped(uint8 initiativeIndex, int256 voteAmount, int256 vetoAmount) public {
        (uint256 unallocatedLQTY, , , ) = governance.userStates(_getActor());
        
        // Clamp to unallocated LQTY
        voteAmount = int256(uint256(voteAmount) % (unallocatedLQTY + 1));
        vetoAmount = int256(uint256(vetoAmount) % (unallocatedLQTY + 1));
        
        // Get initiative to reset (allocated initiatives)
        address[] memory initiativesToReset = getAllocatedInitiatives(_getActor());
        
        // Select initiative based on index
        address[] memory initiatives = new address[](1);
        if (initiativeIndex % 3 == 0) {
            initiatives[0] = address(bribeInitiative);
        } else if (initiativeIndex % 3 == 1) {
            initiatives[0] = address(curveV2GaugeRewards);
        } else {
            initiatives[0] = address(uniV4MerklRewards);
        }
        
        int256[] memory votes = new int256[](1);
        int256[] memory vetos = new int256[](1);
        votes[0] = voteAmount;
        vetos[0] = vetoAmount;
        
        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }

    // Clamped handler for resetAllocations
    function governance_resetAllocations_clamped() public {
        address[] memory initiativesToReset = getAllocatedInitiatives(_getActor());
        governance_resetAllocations(initiativesToReset, false);
    }

    // Clamped handler for claimForInitiative
    function governance_claimForInitiative_clamped(uint8 initiativeIndex) public {
        address initiative;
        if (initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        governance_claimForInitiative(initiative);
    }

    // Clamped handler for snapshotVotesForInitiative
    function governance_snapshotVotesForInitiative_clamped(uint8 initiativeIndex) public {
        address initiative;
        if (initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        governance_snapshotVotesForInitiative(initiative);
    }

    // Clamped handler for unregisterInitiative
    function governance_unregisterInitiative_clamped(uint8 initiativeIndex) public {
        address initiative;
        if (initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        governance_unregisterInitiative(initiative);
    }

    // Clamped handler for getInitiativeState
    function governance_getInitiativeState_clamped(uint8 initiativeIndex) public {
        address initiative;
        if (initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        governance_getInitiativeState(initiative);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function governance_allocateLQTY(
        address[] memory _initiativesToReset,
        address[] memory _initiatives,
        int256[] memory _absoluteLQTYVotes,
        int256[] memory _absoluteLQTYVetos
    ) public asActor {
        governance.allocateLQTY(
            _initiativesToReset,
            _initiatives,
            _absoluteLQTYVotes,
            _absoluteLQTYVetos
        );
    }

    function governance_calculateVotingThreshold() public asActor {
        governance.calculateVotingThreshold();
    }

    function governance_claimForInitiative(address _initiative) public asActor {
        governance.claimForInitiative(_initiative);
    }

    function governance_claimFromStakingV1(
        address _rewardRecipient
    ) public asActor {
        governance.claimFromStakingV1(_rewardRecipient);
    }

    function governance_deployUserProxy() public asActor {
        governance.deployUserProxy();
    }

    function governance_depositLQTY(uint256 _lqtyAmount) public asActor {
        governance.depositLQTY(_lqtyAmount);
    }

    function governance_depositLQTY(
        uint256 _lqtyAmount,
        bool _doSendRewards,
        address _recipient
    ) public asActor {
        governance.depositLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }

    function governance_depositLQTYViaPermit(
        uint256 _lqtyAmount,
        PermitParams memory _permitParams,
        bool _doSendRewards,
        address _recipient
    ) public asActor {
        governance.depositLQTYViaPermit(
            _lqtyAmount,
            _permitParams,
            _doSendRewards,
            _recipient
        );
    }

    function governance_depositLQTYViaPermit(
        uint256 _lqtyAmount,
        PermitParams memory _permitParams
    ) public asActor {
        governance.depositLQTYViaPermit(_lqtyAmount, _permitParams);
    }

    function governance_getInitiativeState(address _initiative) public asActor {
        governance.getInitiativeState(_initiative);
    }

    function governance_multiDelegateCall(
        bytes[] memory _calls
    ) public asActor {
        governance.multiDelegateCall(_calls);
    }

    function governance_registerInitialInitiatives(
        address[] memory _initiatives
    ) public asActor {
        governance.registerInitialInitiatives(_initiatives);
    }

    function governance_registerInitiative(address _initiative) public asActor {
        governance.registerInitiative(_initiative);
    }

    function governance_resetAllocations(
        address[] memory _initiativesToReset,
        bool checkAll
    ) public asActor {
        governance.resetAllocations(_initiativesToReset, checkAll);
    }

    function governance_snapshotVotesForInitiative(
        address _initiative
    ) public asActor {
        governance.snapshotVotesForInitiative(_initiative);
    }

    function governance_unregisterInitiative(
        address _initiative
    ) public asActor {
        governance.unregisterInitiative(_initiative);
    }

    function governance_withdrawLQTY(uint256 _lqtyAmount) public asActor {
        governance.withdrawLQTY(_lqtyAmount);
    }

    function governance_withdrawLQTY(
        uint256 _lqtyAmount,
        bool _doSendRewards,
        address _recipient
    ) public asActor {
        governance.withdrawLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }

    function governance_getLatestVotingThreshold() public asActor {
        governance.getLatestVotingThreshold();
    }

    // These are view functions that access state directly - no need for wrapper functions
}
