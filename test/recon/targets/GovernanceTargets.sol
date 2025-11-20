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

    function governance_allocateLQTY_clamped(uint256 _voteAmount, uint256 _vetoAmount) public asActor {
        address actor = _getActor();
        
        // Get current user state to determine available LQTY
        IGovernance.UserState memory userState = governance.userStates(actor);
        uint256 availableLQTY = userState.lqtyDeposited;
        
        // Clamp vote and veto amounts to available LQTY
        if (availableLQTY > 0) {
            _voteAmount = _voteAmount % (availableLQTY + 1);
            _vetoAmount = _vetoAmount % (availableLQTY + 1);
        } else {
            _voteAmount = 0;
            _vetoAmount = 0;
        }
        
        // Create allocation arrays with bribe initiative
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        
        int256[] memory votes = new int256[](1);
        votes[0] = int256(_voteAmount);
        
        int256[] memory vetos = new int256[](1);
        vetos[0] = int256(_vetoAmount);
        
        address[] memory emptyArray = new address[](0);
        
        governance_allocateLQTY(emptyArray, initiatives, votes, vetos);
    }

    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public asActor {
        address actor = _getActor();
        uint256 maxBalance = lqty.balanceOf(actor);
        
        // Clamp to actor's balance, allowing full balance deposit
        if (maxBalance > 0) {
            _lqtyAmount = (_lqtyAmount % (maxBalance + 1));
        } else {
            _lqtyAmount = 0;
        }
        
        governance_depositLQTY(_lqtyAmount);
    }

    function governance_depositLQTY_max_clamped() public asActor {
        // Deposit maximum possible amount
        address actor = _getActor();
        uint256 balance = lqty.balanceOf(actor);
        
        governance_depositLQTY(balance);
    }

    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public asActor {
        address actor = _getActor();
        IGovernance.UserState memory userState = governance.userStates(actor);
        uint256 deposited = userState.lqtyDeposited;
        
        // Clamp to deposited amount
        if (deposited > 0) {
            _lqtyAmount = (_lqtyAmount % (deposited + 1));
        } else {
            _lqtyAmount = 0;
        }
        
        governance_withdrawLQTY(_lqtyAmount);
    }

    function governance_withdrawLQTY_all_clamped() public asActor {
        // Withdraw all deposited LQTY
        address actor = _getActor();
        IGovernance.UserState memory userState = governance.userStates(actor);
        
        governance_withdrawLQTY(userState.lqtyDeposited);
    }

    function governance_registerInitiative_clamped() public asActor {
        // Register the bribe initiative
        governance_registerInitiative(address(bribeInitiative));
    }

    function governance_claimForInitiative_clamped() public asActor {
        // Claim for bribe initiative
        governance_claimForInitiative(address(bribeInitiative));
    }

    function governance_unregisterInitiative_clamped() public asActor {
        // Unregister the bribe initiative
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
