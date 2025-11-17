// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/Governance.sol";

abstract contract GovernanceTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function clamped_governance_allocateLQTY(address[] memory _initiativesToReset, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory _absoluteLQTYVetos) public asActor {
        // Apply meaningful values from meaningful-values.json
        _initiativesToReset = new address[](0);
        _initiatives = new address[](1);
        _initiatives[0] = address(bribeInitiative);
        
        // Clamp amounts using modulo arithmetic
        (,uint256 unallocatedLQTY,,) = governance.userStates(_getActor());
        for(uint i = 0; i < _absoluteLQTYVotes.length; i++) {
            _absoluteLQTYVotes[i] = int256(uint256(_absoluteLQTYVotes[i]) % (unallocatedLQTY + 1));
        }
        for(uint i = 0; i < _absoluteLQTYVetos.length; i++) {
            _absoluteLQTYVetos[i] = int256(uint256(_absoluteLQTYVetos[i]) % (unallocatedLQTY + 1));
        }
        
        governance_allocateLQTY(_initiativesToReset, _initiatives, _absoluteLQTYVotes, _absoluteLQTYVetos);
    }

    function clamped_governance_depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor {
        // Apply meaningful values from meaningful-values.json
        _doSendRewards = false;
        _recipient = _getActor();
        
        // Clamp amount using modulo arithmetic
        _lqtyAmount %= (lqty.balanceOf(_getActor()) + 1);
        
        governance_depositLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }

    function clamped_governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams, bool _doSendRewards, address _recipient) public asActor {
        // Apply meaningful values from meaningful-values.json
        _doSendRewards = false;
        _recipient = _getActor();
        _permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: 1e18,
            deadline: block.timestamp + 1 days,
            v: 27,
            r: bytes32(uint256(1)),
            s: bytes32(uint256(1))
        });
        
        // Clamp amount using modulo arithmetic
        _lqtyAmount %= (lqty.balanceOf(_getActor()) + 1);
        _permitParams.value = _lqtyAmount;
        
        governance_depositLQTYViaPermit(_lqtyAmount, _permitParams, _doSendRewards, _recipient);
    }

    function clamped_governance_registerInitiative(address _initiative) public asActor {
        // Apply meaningful values from meaningful-values.json
        _initiative = address(bribeInitiative);
        
        governance_registerInitiative(_initiative);
    }

    function clamped_governance_withdrawLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor {
        // Apply meaningful values from meaningful-values.json
        _doSendRewards = false;
        _recipient = _getActor();
        
        // Clamp amount using modulo arithmetic
        (,uint256 unallocatedLQTY,,) = governance.userStates(_getActor());
        _lqtyAmount %= (unallocatedLQTY + 1);
        
        governance_withdrawLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }

    function clamped_governance_resetAllocations(address[] memory _initiativesToReset, bool checkAll) public asActor {
        // Apply meaningful values from meaningful-values.json
        _initiativesToReset = new address[](0);
        checkAll = false;
        
        governance_resetAllocations(_initiativesToReset, checkAll);
    }

    function clamped_governance_multiDelegateCall(bytes[] memory inputs) public asActor {
        // Apply meaningful values from meaningful-values.json
        inputs = new bytes[](0);
        
        governance_multiDelegateCall(inputs);
    }

    function clamped_governance_claimFromStakingV1(address _rewardRecipient) public asActor {
        // Apply meaningful values from meaningful-values.json
        _rewardRecipient = _getActor();
        
        governance_claimFromStakingV1(_rewardRecipient);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function governance_allocateLQTY(address[] memory _initiativesToReset, address[] memory _initiatives, int256[] memory _absoluteLQTYVotes, int256[] memory _absoluteLQTYVetos) public asActor {
        governance.allocateLQTY(_initiativesToReset, _initiatives, _absoluteLQTYVotes, _absoluteLQTYVetos);
    }

    function governance_calculateVotingThreshold() public asActor {
        governance.calculateVotingThreshold();
    }

    function governance_claimForInitiative(address _initiative) public asActor {
        governance.claimForInitiative(_initiative);
    }

    function governance_claimFromStakingV1(address _rewardRecipient) public asActor {
        governance.claimFromStakingV1(_rewardRecipient);
    }

    function governance_deployUserProxy() public asActor {
        governance.deployUserProxy();
    }

    function governance_depositLQTY(uint256 _lqtyAmount) public asActor {
        governance.depositLQTY(_lqtyAmount);
    }

    function governance_depositLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor {
        governance.depositLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }

    function governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams, bool _doSendRewards, address _recipient) public asActor {
        governance.depositLQTYViaPermit(_lqtyAmount, _permitParams, _doSendRewards, _recipient);
    }

    function governance_depositLQTYViaPermit(uint256 _lqtyAmount, PermitParams memory _permitParams) public asActor {
        governance.depositLQTYViaPermit(_lqtyAmount, _permitParams);
    }

    function governance_getInitiativeState(address _initiative) public asActor {
        governance.getInitiativeState(_initiative);
    }

    function governance_multiDelegateCall(bytes[] memory inputs) public asActor {
        governance.multiDelegateCall(inputs);
    }

    function governance_registerInitiative(address _initiative) public asActor {
        governance.registerInitiative(_initiative);
    }

    function governance_resetAllocations(address[] memory _initiativesToReset, bool checkAll) public asActor {
        governance.resetAllocations(_initiativesToReset, checkAll);
    }

    function governance_snapshotVotesForInitiative(address _initiative) public asActor {
        governance.snapshotVotesForInitiative(_initiative);
    }

    function governance_unregisterInitiative(address _initiative) public asActor {
        governance.unregisterInitiative(_initiative);
    }

    function governance_withdrawLQTY(uint256 _lqtyAmount) public asActor {
        governance.withdrawLQTY(_lqtyAmount);
    }

    function governance_withdrawLQTY(uint256 _lqtyAmount, bool _doSendRewards, address _recipient) public asActor {
        governance.withdrawLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }
}