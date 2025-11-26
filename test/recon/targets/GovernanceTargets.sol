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

    // === CLAMPED HANDLERS === //

    /// @dev Clamped version of depositLQTY - clamps amount to actor's LQTY balance
    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public asActor {
        _lqtyAmount = _lqtyAmount % (lqty.balanceOf(_getActor()) + 1);
        governance_depositLQTY(_lqtyAmount);
    }

    /// @dev Clamped version of withdrawLQTY - clamps amount to actor's unallocated LQTY
    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public asActor {
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        _lqtyAmount = _lqtyAmount % (unallocatedLQTY + 1);
        governance_withdrawLQTY(_lqtyAmount);
    }

    /// @dev Clamped version of registerInitiative using bribeInitiative
    function governance_registerInitiative_bribeInitiative_clamped() public asActor {
        governance_registerInitiative(address(bribeInitiative));
    }

    /// @dev Clamped version of registerInitiative using curveV2GaugeRewards
    function governance_registerInitiative_curveV2GaugeRewards_clamped() public asActor {
        governance_registerInitiative(address(curveV2GaugeRewards));
    }

    /// @dev Clamped version of registerInitiative using uniV4MerklRewards
    function governance_registerInitiative_uniV4MerklRewards_clamped() public asActor {
        governance_registerInitiative(address(uniV4MerklRewards));
    }

    /// @dev Clamped version of unregisterInitiative using bribeInitiative
    function governance_unregisterInitiative_bribeInitiative_clamped() public asActor {
        governance_unregisterInitiative(address(bribeInitiative));
    }

    /// @dev Clamped version of unregisterInitiative using curveV2GaugeRewards
    function governance_unregisterInitiative_curveV2GaugeRewards_clamped() public asActor {
        governance_unregisterInitiative(address(curveV2GaugeRewards));
    }

    /// @dev Clamped version of unregisterInitiative using uniV4MerklRewards
    function governance_unregisterInitiative_uniV4MerklRewards_clamped() public asActor {
        governance_unregisterInitiative(address(uniV4MerklRewards));
    }

    /// @dev Clamped version of claimForInitiative using bribeInitiative
    function governance_claimForInitiative_bribeInitiative_clamped() public asActor {
        governance_claimForInitiative(address(bribeInitiative));
    }

    /// @dev Clamped version of claimForInitiative using curveV2GaugeRewards
    function governance_claimForInitiative_curveV2GaugeRewards_clamped() public asActor {
        governance_claimForInitiative(address(curveV2GaugeRewards));
    }

    /// @dev Clamped version of claimForInitiative using uniV4MerklRewards
    function governance_claimForInitiative_uniV4MerklRewards_clamped() public asActor {
        governance_claimForInitiative(address(uniV4MerklRewards));
    }

    /// @dev Clamped version of snapshotVotesForInitiative using bribeInitiative
    function governance_snapshotVotesForInitiative_bribeInitiative_clamped() public asActor {
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    /// @dev Clamped version of snapshotVotesForInitiative using curveV2GaugeRewards
    function governance_snapshotVotesForInitiative_curveV2GaugeRewards_clamped() public asActor {
        governance_snapshotVotesForInitiative(address(curveV2GaugeRewards));
    }

    /// @dev Clamped version of snapshotVotesForInitiative using uniV4MerklRewards
    function governance_snapshotVotesForInitiative_uniV4MerklRewards_clamped() public asActor {
        governance_snapshotVotesForInitiative(address(uniV4MerklRewards));
    }

    /// @dev Clamped version of getInitiativeState using bribeInitiative
    function governance_getInitiativeState_bribeInitiative_clamped() public asActor {
        governance_getInitiativeState(address(bribeInitiative));
    }

    /// @dev Clamped version of getInitiativeState using curveV2GaugeRewards
    function governance_getInitiativeState_curveV2GaugeRewards_clamped() public asActor {
        governance_getInitiativeState(address(curveV2GaugeRewards));
    }

    /// @dev Clamped version of getInitiativeState using uniV4MerklRewards
    function governance_getInitiativeState_uniV4MerklRewards_clamped() public asActor {
        governance_getInitiativeState(address(uniV4MerklRewards));
    }

    /// @dev Clamped version of allocateLQTY using bribeInitiative - allocates all unallocated LQTY
    function governance_allocateLQTY_bribeInitiative_clamped(uint256 voteSeed, uint256 vetoSeed) public asActor {
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        
        address[] memory initiativesToReset = getInitiativesWithAllocation(_getActor());
        
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        
        int256[] memory votes = new int256[](1);
        votes[0] = int256(voteSeed % (unallocatedLQTY + 1));
        
        int256[] memory vetos = new int256[](1);
        vetos[0] = int256(vetoSeed % (unallocatedLQTY + 1));
        
        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }

    /// @dev Clamped version of allocateLQTY using curveV2GaugeRewards - allocates all unallocated LQTY
    function governance_allocateLQTY_curveV2GaugeRewards_clamped(uint256 voteSeed, uint256 vetoSeed) public asActor {
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        
        address[] memory initiativesToReset = getInitiativesWithAllocation(_getActor());
        
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(curveV2GaugeRewards);
        
        int256[] memory votes = new int256[](1);
        votes[0] = int256(voteSeed % (unallocatedLQTY + 1));
        
        int256[] memory vetos = new int256[](1);
        vetos[0] = int256(vetoSeed % (unallocatedLQTY + 1));
        
        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }

    /// @dev Clamped version of allocateLQTY using uniV4MerklRewards - allocates all unallocated LQTY
    function governance_allocateLQTY_uniV4MerklRewards_clamped(uint256 voteSeed, uint256 vetoSeed) public asActor {
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        
        address[] memory initiativesToReset = getInitiativesWithAllocation(_getActor());
        
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(uniV4MerklRewards);
        
        int256[] memory votes = new int256[](1);
        votes[0] = int256(voteSeed % (unallocatedLQTY + 1));
        
        int256[] memory vetos = new int256[](1);
        vetos[0] = int256(vetoSeed % (unallocatedLQTY + 1));
        
        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }

    /// @dev Clamped version of resetAllocations - resets all current allocations
    function governance_resetAllocations_clamped() public asActor {
        address[] memory initiativesToReset = getInitiativesWithAllocation(_getActor());
        governance_resetAllocations(initiativesToReset, false);
    }

    /// @dev Helper to ensure BOLD is accrued in governance - deposits BOLD to governance contract
    /// This helps reach line 296 in calculateVotingThreshold where payoutPerVote != 0
    function governance_accrueBOLD_clamped(uint256 _boldAmount) public asActor {
        // Clamp to actor's BOLD balance
        _boldAmount = _boldAmount % (bold.balanceOf(_getActor()) + 1);
        
        // Transfer BOLD directly to governance to accrue rewards
        if (_boldAmount > 0) {
            bold.transfer(address(governance), _boldAmount);
        }
    }

    /// @dev Helper to create edge case where claimableAmount > available BOLD
    /// This helps reach line 908 in claimForInitiative by having multiple initiatives claim
    function governance_multiClaim_clamped() public asActor {
        // Try to claim for all registered initiatives to drain BOLD
        governance_claimForInitiative_bribeInitiative_clamped();
        governance_claimForInitiative_curveV2GaugeRewards_clamped();
        governance_claimForInitiative_uniV4MerklRewards_clamped();
    }

    /// @dev Shortcut to set up scenario for calculateVotingThreshold edge case
    /// Ensures BOLD is accrued and votes are allocated
    function governance_setupVotingThreshold_clamped(uint256 depositAmount, uint256 boldAmount) public asActor {
        // Register initiative
        governance_registerInitiative_bribeInitiative_clamped();
        
        // Deposit LQTY and allocate votes
        governance_depositLQTY_clamped(depositAmount);
        governance_allocateLQTY_bribeInitiative_clamped(depositAmount, 0);
        
        // Accrue BOLD
        governance_accrueBOLD_clamped(boldAmount);
        
        // Trigger snapshot which calls calculateVotingThreshold
        vm.warp(block.timestamp + governance.EPOCH_DURATION());
        governance_calculateVotingThreshold();
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
