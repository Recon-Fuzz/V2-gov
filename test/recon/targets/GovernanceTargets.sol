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

abstract contract GovernanceTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function clamped_governance_allocateLQTY() public asActor {
        address actor = _getActor();
        uint256 unallocatedLQTY = governance.userStates(actor).unallocatedLQTY;
        
        if (unallocatedLQTY > 0 && governance.registeredInitiatives(address(bribeInitiative)) > 0) {
            address[] memory initiatives = new address[](1);
            initiatives[0] = address(bribeInitiative);
            
            int256[] memory votes = new int256[](1);
            votes[0] = int256(_bound(unallocatedLQTY, 1, unallocatedLQTY));
            
            int256[] memory vetos = new int256[](1);
            vetos[0] = 0;
            
            address[] memory initiativesToReset = new address[](0);
            
            governance.allocateLQTY(initiativesToReset, initiatives, votes, vetos);
        }
    }

    function clamped_governance_depositLQTY() public asActor {
        address actor = _getActor();
        uint256 lqtyBalance = lqty.balanceOf(actor);
        
        if (lqtyBalance > 0) {
            uint256 depositAmount = _bound(lqtyBalance, 1, lqtyBalance);
            governance.depositLQTY(depositAmount);
        }
    }

    function clamped_governance_depositLQTYViaPermit() public asActor {
        address actor = _getActor();
        uint256 lqtyBalance = lqty.balanceOf(actor);
        
        if (lqtyBalance > 0) {
            uint256 depositAmount = _bound(lqtyBalance, 1, lqtyBalance);
            
            IGovernance.PermitParams memory permitParams = IGovernance.PermitParams({
                owner: actor,
                spender: address(governance),
                value: depositAmount,
                deadline: block.timestamp + 3600,
                v: 27,
                r: bytes32(0),
                s: bytes32(0)
            });
            
            governance.depositLQTYViaPermit(depositAmount, permitParams);
        }
    }

    function clamped_governance_registerInitiative() public asActor {
        if (governance.registeredInitiatives(address(bribeInitiative)) == 0) {
            governance.registerInitiative(address(bribeInitiative));
        }
    }

    function clamped_governance_withdrawLQTY() public asActor {
        address actor = _getActor();
        uint256 unallocatedLQTY = governance.userStates(actor).unallocatedLQTY;
        
        if (unallocatedLQTY > 0) {
            uint256 withdrawAmount = _bound(unallocatedLQTY, 1, unallocatedLQTY);
            governance.withdrawLQTY(withdrawAmount);
        }
    }

    function clamped_governance_resetAllocations() public asActor {
        if (governance.registeredInitiatives(address(bribeInitiative)) > 0) {
            address[] memory initiativesToReset = new address[](1);
            initiativesToReset[0] = address(bribeInitiative);
            governance.resetAllocations(initiativesToReset, false);
        }
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
        bytes[] memory inputs
    ) public asActor {
        governance.multiDelegateCall(inputs);
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
