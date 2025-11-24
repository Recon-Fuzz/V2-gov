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

    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public asActor {
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;

        governance_depositLQTY(_lqtyAmount);
    }

    function governance_depositLQTYViaPermit_clamped(
        uint256 _lqtyAmount,
        PermitParams memory _permitParams
    ) public asActor {
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;

        governance_depositLQTYViaPermit(_lqtyAmount, _permitParams);
    }

    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public asActor {
        _lqtyAmount %= governance.userStates(_getActor()).unallocatedLQTY + 1;

        governance_withdrawLQTY(_lqtyAmount);
    }

    function governance_registerInitiative_clamped() public asActor {
        governance_registerInitiative(address(bribeInitiative));
    }

    function governance_allocateLQTY_clamped(
        address[] memory _initiativesToReset,
        address[] memory _initiatives,
        int256[] memory _absoluteLQTYVotes,
        int256[] memory _absoluteLQTYVetos
    ) public asActor {
        uint256 maxArraySize = 10;
        uint256 unallocatedLQTY = governance.userStates(_getActor()).unallocatedLQTY;

        if (_initiativesToReset.length > maxArraySize) {
            assembly { mstore(_initiativesToReset, maxArraySize) }
        }
        if (_initiatives.length > maxArraySize) {
            assembly { mstore(_initiatives, maxArraySize) }
        }
        if (_absoluteLQTYVotes.length > maxArraySize) {
            assembly { mstore(_absoluteLQTYVotes, maxArraySize) }
        }
        if (_absoluteLQTYVetos.length > maxArraySize) {
            assembly { mstore(_absoluteLQTYVetos, maxArraySize) }
        }

        for (uint256 i = 0; i < _absoluteLQTYVotes.length; i++) {
            _absoluteLQTYVotes[i] = int256(bound(uint256(_absoluteLQTYVotes[i]), 0, unallocatedLQTY));
        }
        for (uint256 i = 0; i < _absoluteLQTYVetos.length; i++) {
            _absoluteLQTYVetos[i] = int256(bound(uint256(_absoluteLQTYVetos[i]), 0, unallocatedLQTY));
        }

        governance_allocateLQTY(_initiativesToReset, _initiatives, _absoluteLQTYVotes, _absoluteLQTYVetos);
    }

    function governance_resetAllocations_clamped(
        address[] memory _initiativesToReset,
        bool checkAll
    ) public asActor {
        uint256 maxArraySize = 10;
        
        if (_initiativesToReset.length > maxArraySize) {
            assembly { mstore(_initiativesToReset, maxArraySize) }
        }

        governance_resetAllocations(_initiativesToReset, checkAll);
    }

    function governance_claimForInitiative_clamped() public asActor {
        governance_claimForInitiative(address(bribeInitiative));
    }

    function governance_unregisterInitiative_clamped() public asActor {
        governance_unregisterInitiative(address(bribeInitiative));
    }

    function governance_registerInitialInitiatives_clamped(
        address[] memory _initiatives
    ) public asActor {
        uint256 maxArraySize = 10;
        
        if (_initiatives.length > maxArraySize) {
            assembly { mstore(_initiatives, maxArraySize) }
        }

        governance_registerInitialInitiatives(_initiatives);
    }

    function governance_multiDelegateCall_clamped(
        bytes[] memory _calls
    ) public asActor {
        uint256 maxArraySize = 5;
        
        if (_calls.length > maxArraySize) {
            assembly { mstore(_calls, maxArraySize) }
        }

        governance_multiDelegateCall(_calls);
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
