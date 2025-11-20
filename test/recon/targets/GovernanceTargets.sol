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

    function governance_allocateLQTY_clamped(
        uint256 _numInitiativesToReset,
        uint256 _numInitiatives,
        uint256 _votesAmount,
        uint256 _vetosAmount
    ) public asActor {
        // Create arrays with bounded sizes
        uint256 maxInitiatives = 5; // Reasonable limit
        uint256 numToReset = (_numInitiativesToReset % (maxInitiatives + 1));
        uint256 numInits = (_numInitiatives % (maxInitiatives + 1));
        
        address[] memory initiativesToReset = new address[](numToReset);
        address[] memory initiatives = new address[](numInits);
        int256[] memory votes = new int256[](numInits);
        int256[] memory vetos = new int256[](numInits);
        
        // Get user's unallocated LQTY according to meaningful-values.json
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        
        // Fill arrays with actor addresses and bounded amounts
        address[] memory actors = _getActors();
        for (uint256 i = 0; i < numToReset; i++) {
            initiativesToReset[i] = actors[i % actors.length];
        }
        
        for (uint256 i = 0; i < numInits; i++) {
            initiatives[i] = actors[i % actors.length];
            // Clamp amounts to user's unallocated LQTY according to meaningful-values.json
            votes[i] = int256((_votesAmount % (unallocatedLQTY + 1)));
            vetos[i] = int256((_vetosAmount % (unallocatedLQTY + 1)));
        }
        
        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }

    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public asActor {
        // Clamp amount to actor's LQTY balance according to meaningful-values.json
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        governance_depositLQTY(_lqtyAmount);
    }

    function governance_depositLQTY_withRecipient_clamped(
        uint256 _lqtyAmount,
        bool _doSendRewards
    ) public asActor {
        // Clamp amount to actor's LQTY balance
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        // Use current actor as recipient
        address recipient = _getActor();
        
        governance_depositLQTY(_lqtyAmount, _doSendRewards, recipient);
    }

    function governance_depositLQTYViaPermit_clamped(
        uint256 _lqtyAmount,
        bool _doSendRewards
    ) public asActor {
        // Clamp amount to actor's LQTY balance according to meaningful-values.json
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        // Create minimal valid permit params
        PermitParams memory permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: _lqtyAmount,
            deadline: block.timestamp + 3600,
            v: 27,
            r: bytes32(0),
            s: bytes32(0)
        });
        
        address recipient = _getActor();
        governance_depositLQTYViaPermit(_lqtyAmount, permitParams, _doSendRewards, recipient);
    }

    function governance_depositLQTYViaPermit_simple_clamped(uint256 _lqtyAmount) public asActor {
        // Clamp amount to actor's LQTY balance according to meaningful-values.json
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        // Create minimal valid permit params
        PermitParams memory permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: _lqtyAmount,
            deadline: block.timestamp + 3600,
            v: 27,
            r: bytes32(0),
            s: bytes32(0)
        });
        
        governance_depositLQTYViaPermit(_lqtyAmount, permitParams);
    }

    function governance_registerInitiative_clamped() public asActor {
        // Register the bribe initiative according to meaningful-values.json
        governance_registerInitiative(address(bribeInitiative));
    }

    function governance_resetAllocations_clamped() public asActor {
        // Use exact array from meaningful-values.json containing bribe initiative
        address[] memory initiativesToReset = new address[](1);
        initiativesToReset[0] = address(bribeInitiative);
        
        governance_resetAllocations(initiativesToReset, false);
    }

    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public asActor {
        // Clamp amount to user's unallocated LQTY according to meaningful-values.json
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        _lqtyAmount %= (unallocatedLQTY + 1);
        
        governance_withdrawLQTY(_lqtyAmount);
    }

    function governance_withdrawLQTY_withRecipient_clamped(
        uint256 _lqtyAmount,
        bool _doSendRewards
    ) public asActor {
        // Clamp amount to user's unallocated LQTY according to meaningful-values.json
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        _lqtyAmount %= (unallocatedLQTY + 1);
        
        address recipient = _getActor();
        governance_withdrawLQTY(_lqtyAmount, _doSendRewards, recipient);
    }

    function governance_claimForInitiative_clamped() public asActor {
        // Claim for the bribe initiative according to meaningful-values.json
        governance_claimForInitiative(address(bribeInitiative));
    }

    function governance_calculateVotingThreshold_clamped() public asActor {
        // This function takes no parameters, just call it directly
        governance_calculateVotingThreshold();
    }

    function governance_claimFromStakingV1_clamped() public asActor {
        // Use current actor as reward recipient according to meaningful-values.json
        governance_claimFromStakingV1(_getActor());
    }

    function governance_deployUserProxy_clamped() public asActor {
        // This function takes no parameters, just call it directly
        governance_deployUserProxy();
    }

    function governance_getInitiativeState_clamped() public asActor {
        // Get state for the bribe initiative according to meaningful-values.json
        governance_getInitiativeState(address(bribeInitiative));
    }



    function governance_snapshotVotesForInitiative_clamped() public asActor {
        // Snapshot votes for the bribe initiative according to meaningful-values.json
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    function governance_unregisterInitiative_clamped() public asActor {
        // Unregister the bribe initiative according to meaningful-values.json
        governance_unregisterInitiative(address(bribeInitiative));
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
}
