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

    function clamped_governance_allocateLQTY() public asActor {
        address[] memory _initiativesToReset = new address[](0);
        address[] memory _initiatives = new address[](1);
        _initiatives[0] = address(bribeInitiative);
        (,uint256 unallocatedLQTY,,) = governance.userStates(_getActor());
        int256 maxAmount = int256(unallocatedLQTY);
        int256[] memory _absoluteLQTYVotes = new int256[](1);
        _absoluteLQTYVotes[0] = maxAmount > 0 ? maxAmount : int256(1);
        int256[] memory _absoluteLQTYVetos = new int256[](1);
        _absoluteLQTYVetos[0] = 0;
        governance.allocateLQTY(_initiativesToReset, _initiatives, _absoluteLQTYVotes, _absoluteLQTYVetos);
    }

    function clamped_governance_depositLQTY() public asActor {
        uint256 maxAmount = lqty.balanceOf(_getActor());
        uint256 amount = maxAmount > 0 ? maxAmount : 1e18;
        governance.depositLQTY(amount, false, _getActor());
    }

    function clamped_governance_depositLQTYViaPermit() public asActor {
        uint256 maxAmount = lqty.balanceOf(_getActor());
        uint256 amount = maxAmount > 0 ? maxAmount : 1e18;
        PermitParams memory _permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: amount,
            deadline: block.timestamp + 1 days,
            v: 27,
            r: bytes32(uint256(1)),
            s: bytes32(uint256(1))
        });
        governance.depositLQTYViaPermit(amount, _permitParams, false, _getActor());
    }

    function clamped_governance_registerInitiative() public asActor {
        governance.registerInitiative(address(bribeInitiative));
    }

    function clamped_governance_withdrawLQTY() public asActor {
        (,uint256 unallocatedLQTY,,) = governance.userStates(_getActor());
        uint256 maxAmount = unallocatedLQTY;
        uint256 amount = maxAmount > 0 ? maxAmount : 1e18;
        governance.withdrawLQTY(amount, false, _getActor());
    }

    function clamped_governance_resetAllocations() public asActor {
        address[] memory _initiativesToReset = new address[](0);
        governance.resetAllocations(_initiativesToReset, false);
    }

    function clamped_governance_multiDelegateCall() public asActor {
        bytes[] memory inputs = new bytes[](0);
        governance.multiDelegateCall(inputs);
    }

    function clamped_governance_claimFromStakingV1() public asActor {
        governance.claimFromStakingV1(_getActor());
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