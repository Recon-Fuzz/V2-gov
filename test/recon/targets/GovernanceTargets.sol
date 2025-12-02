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

    // Clamped handler for depositLQTY
    function governance_depositLQTY_clamped(
        uint256 _lqtyAmount
    ) public asActor {
        address actor = _getActor();
        uint256 balance = lqty.balanceOf(actor);
        
        // Bound to reasonable deposit amounts
        _lqtyAmount = bound(_lqtyAmount, 1e18, balance > 0 ? balance / 2 : 1e18);
        
        governance.depositLQTY(_lqtyAmount);
    }

    // Clamped handler for withdrawLQTY
    function governance_withdrawLQTY_clamped(
        uint256 _lqtyAmount
    ) public asActor {
        address actor = _getActor();
        (uint256 unallocated,,,) = governance.userStates(actor);
        
        if (unallocated == 0) return;
        
        // Bound to available unallocated LQTY
        _lqtyAmount = bound(_lqtyAmount, 1e18, unallocated);
        
        governance.withdrawLQTY(_lqtyAmount);
    }

    // Clamped handler for allocateLQTY
    function governance_allocateLQTY_clamped(
        uint256 _numInitiatives,
        uint256 _voteAmount1,
        uint256 _voteAmount2,
        bool _isVeto1,
        bool _isVeto2
    ) public asActor {
        address actor = _getActor();
        (uint256 unallocated,,,) = governance.userStates(actor);
        
        if (unallocated == 0) return;
        
        // Limit number of initiatives
        _numInitiatives = bound(_numInitiatives, 1, 2);
        
        address[] memory initiativesToReset = new address[](0);
        address[] memory initiatives = new address[](_numInitiatives);
        int256[] memory absoluteLQTYVotes = new int256[](_numInitiatives);
        int256[] memory absoluteLQTYVetos = new int256[](_numInitiatives);
        
        // Use bribeInitiative as one initiative
        initiatives[0] = address(bribeInitiative);
        
        if (_numInitiatives > 1) {
            // Use curveV2GaugeRewards as second initiative
            initiatives[1] = address(curveV2GaugeRewards);
        }
        
        // Distribute unallocated LQTY between initiatives
        uint256 amount1 = bound(_voteAmount1, 0, unallocated);
        uint256 amount2 = 0;
        
        if (_numInitiatives > 1 && unallocated > amount1) {
            amount2 = bound(_voteAmount2, 0, unallocated - amount1);
        }
        
        if (_isVeto1) {
            absoluteLQTYVotes[0] = 0;
            absoluteLQTYVetos[0] = int256(amount1);
        } else {
            absoluteLQTYVotes[0] = int256(amount1);
            absoluteLQTYVetos[0] = 0;
        }
        
        if (_numInitiatives > 1) {
            if (_isVeto2) {
                absoluteLQTYVotes[1] = 0;
                absoluteLQTYVetos[1] = int256(amount2);
            } else {
                absoluteLQTYVotes[1] = int256(amount2);
                absoluteLQTYVetos[1] = 0;
            }
        }
        
        governance.allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
    }

    // Clamped handler for resetAllocations
    function governance_resetAllocations_clamped(
        uint256 _numToReset,
        bool _checkAll
    ) public asActor {
        address actor = _getActor();
        (,, uint256 allocated,) = governance.userStates(actor);
        
        if (allocated == 0) return;
        
        // Limit number of initiatives to reset
        _numToReset = bound(_numToReset, 1, 2);
        
        address[] memory initiativesToReset = new address[](_numToReset);
        initiativesToReset[0] = address(bribeInitiative);
        
        if (_numToReset > 1) {
            initiativesToReset[1] = address(curveV2GaugeRewards);
        }
        
        governance.resetAllocations(initiativesToReset, _checkAll);
    }

    // Clamped handler for registerInitiative  
    function governance_registerInitiative_clamped(
        uint256 _initiativeIndex
    ) public asActor {
        address initiative;
        
        // Cycle through different initiatives
        if (_initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (_initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        
        // Check if already registered
        if (governance.registeredInitiatives(initiative) != 0) return;
        
        address actor = _getActor();
        uint256 boldBalance = bold.balanceOf(actor);
        
        // Check if actor has enough BOLD for registration fee
        uint256 regFee = governance.REGISTRATION_FEE();
        if (boldBalance < regFee) return;
        
        governance.registerInitiative(initiative);
    }

    // Clamped handler for unregisterInitiative
    function governance_unregisterInitiative_clamped(
        uint256 _initiativeIndex
    ) public asActor {
        address initiative;
        
        // Cycle through different initiatives
        if (_initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (_initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        
        governance.unregisterInitiative(initiative);
    }

    // Clamped handler for claimForInitiative
    function governance_claimForInitiative_clamped(
        uint256 _initiativeIndex
    ) public asActor {
        address initiative;
        
        // Cycle through different initiatives
        if (_initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (_initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        
        governance.claimForInitiative(initiative);
    }

    // Clamped handler for snapshotVotesForInitiative
    function governance_snapshotVotesForInitiative_clamped(
        uint256 _initiativeIndex
    ) public asActor {
        address initiative;
        
        // Cycle through different initiatives
        if (_initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (_initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        
        governance.snapshotVotesForInitiative(initiative);
    }

    // Clamped handler for getInitiativeState
    function governance_getInitiativeState_clamped(
        uint256 _initiativeIndex
    ) public asActor {
        address initiative;
        
        // Cycle through different initiatives
        if (_initiativeIndex % 3 == 0) {
            initiative = address(bribeInitiative);
        } else if (_initiativeIndex % 3 == 1) {
            initiative = address(curveV2GaugeRewards);
        } else {
            initiative = address(uniV4MerklRewards);
        }
        
        governance.getInitiativeState(initiative);
    }

    // Clamped handler for claimFromStakingV1
    function governance_claimFromStakingV1_clamped(
        uint256 _recipientIndex
    ) public asActor {
        address[] memory actors = _getActors();
        require(actors.length > 0, "No actors");
        
        _recipientIndex = bound(_recipientIndex, 0, actors.length - 1);
        address recipient = actors[_recipientIndex];
        
        governance.claimFromStakingV1(recipient);
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
