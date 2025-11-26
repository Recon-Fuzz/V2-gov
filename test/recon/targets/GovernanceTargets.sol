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

    /// @dev Clamped version of governance_depositLQTY - clamps amount to actor's LQTY balance
    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public asActor {
        _lqtyAmount = _lqtyAmount % (lqty.balanceOf(_getActor()) + 1);
        governance_depositLQTY(_lqtyAmount);
    }

    /// @dev Clamped version of governance_depositLQTY with recipient - clamps amount to actor's LQTY balance
    function governance_depositLQTY_clamped(uint256 _lqtyAmount, bool _doSendRewards) public asActor {
        _lqtyAmount = _lqtyAmount % (lqty.balanceOf(_getActor()) + 1);
        governance_depositLQTY(_lqtyAmount, _doSendRewards, _getActor());
    }

    /// @dev Clamped version of governance_withdrawLQTY - clamps amount to actor's unallocated LQTY
    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public asActor {
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        _lqtyAmount = _lqtyAmount % (unallocatedLQTY + 1);
        governance_withdrawLQTY(_lqtyAmount);
    }

    /// @dev Clamped version of governance_withdrawLQTY with recipient - clamps amount to actor's unallocated LQTY
    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount, bool _doSendRewards) public asActor {
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        _lqtyAmount = _lqtyAmount % (unallocatedLQTY + 1);
        governance_withdrawLQTY(_lqtyAmount, _doSendRewards, _getActor());
    }

    /// @dev Clamped version of governance_registerInitiative - uses bribeInitiative address
    function governance_registerInitiative_clamped() public asActor {
        governance_registerInitiative(address(bribeInitiative));
    }

    /// @dev Clamped version of governance_allocateLQTY - uses bribeInitiative and clamps votes/vetos
    function governance_allocateLQTY_clamped(
        int256 _absoluteLQTYVote,
        int256 _absoluteLQTYVeto
    ) public asActor {
        address[] memory _initiativesToReset = new address[](0);
        address[] memory _initiatives = new address[](1);
        _initiatives[0] = address(bribeInitiative);
        
        int256[] memory _absoluteLQTYVotes = new int256[](1);
        int256[] memory _absoluteLQTYVetos = new int256[](1);
        
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        _absoluteLQTYVotes[0] = int256(uint256(_absoluteLQTYVote) % (unallocatedLQTY + 1));
        _absoluteLQTYVetos[0] = int256(uint256(_absoluteLQTYVeto) % (unallocatedLQTY + 1));
        
        governance_allocateLQTY(
            _initiativesToReset,
            _initiatives,
            _absoluteLQTYVotes,
            _absoluteLQTYVetos
        );
    }

    /// @dev Clamped version of governance_resetAllocations - uses bribeInitiative
    function governance_resetAllocations_clamped(bool checkAll) public asActor {
        address[] memory _initiativesToReset = new address[](1);
        _initiativesToReset[0] = address(bribeInitiative);
        governance_resetAllocations(_initiativesToReset, checkAll);
    }

    /// @dev Clamped version of governance_claimForInitiative - uses bribeInitiative
    function governance_claimForInitiative_clamped() public asActor {
        governance_claimForInitiative(address(bribeInitiative));
    }

    /// @dev Clamped version of governance_snapshotVotesForInitiative - uses bribeInitiative
    function governance_snapshotVotesForInitiative_clamped() public asActor {
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    /// @dev Clamped version of governance_unregisterInitiative - uses bribeInitiative
    function governance_unregisterInitiative_clamped() public asActor {
        governance_unregisterInitiative(address(bribeInitiative));
    }

    /// @dev Clamped version of governance_getInitiativeState - uses bribeInitiative
    function governance_getInitiativeState_clamped() public asActor {
        governance_getInitiativeState(address(bribeInitiative));
    }

    /// @dev Clamped version of governance_claimFromStakingV1 - uses actor as recipient
    function governance_claimFromStakingV1_clamped() public asActor {
        governance_claimFromStakingV1(_getActor());
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
