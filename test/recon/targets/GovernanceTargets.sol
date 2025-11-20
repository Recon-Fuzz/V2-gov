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
        (uint256 unallocatedLQTY,, uint256 allocatedLQTY,) = governance.userStates(actor);
        uint256 availableLQTY = unallocatedLQTY + allocatedLQTY;
        
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
        (uint256 unallocatedLQTY,, uint256 allocatedLQTY,) = governance.userStates(actor);
        uint256 deposited = unallocatedLQTY + allocatedLQTY;
        
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
        (uint256 unallocatedLQTY,, uint256 allocatedLQTY,) = governance.userStates(actor);
        uint256 totalLQTY = unallocatedLQTY + allocatedLQTY;
        
        governance_withdrawLQTY(totalLQTY);
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

    function governance_calculateVotingThreshold_clamped() public asActor {
        // Calculate voting threshold with current parameters
        governance_calculateVotingThreshold();
    }

    function governance_claimFromStakingV1_clamped() public asActor {
        // Claim from staking V1 for current actor
        address actor = _getActor();
        governance_claimFromStakingV1(actor);
    }

    function governance_deployUserProxy_clamped() public asActor {
        // Deploy user proxy for current actor
        governance_deployUserProxy();
    }

    function governance_getInitiativeState_clamped() public asActor {
        // Get initiative state for bribe initiative
        governance_getInitiativeState(address(bribeInitiative));
    }

    function governance_multiDelegateCall_clamped() public asActor {
        // Create a simple multi-delegate call with deposit and allocate
        address actor = _getActor();
        uint256 lqtyBalance = lqty.balanceOf(actor);
        
        if (lqtyBalance > 0) {
            // Use 10% of balance for operations
            uint256 depositAmount = lqtyBalance / 10;
            
            // Create call data for depositLQTY (simple version)
            bytes memory depositCall = abi.encodeWithSignature(
                "depositLQTY(uint256)",
                depositAmount
            );
            
            // Create call data for allocateLQTY
            address[] memory initiatives = new address[](1);
            initiatives[0] = address(bribeInitiative);
            int256[] memory votes = new int256[](1);
            votes[0] = int256(depositAmount);
            int256[] memory vetos = new int256[](1);
            vetos[0] = 0;
            address[] memory emptyArray = new address[](0);
            
            bytes memory allocateCall = abi.encodeWithSelector(
                governance.allocateLQTY.selector,
                emptyArray,
                initiatives,
                votes,
                vetos
            );
            
            bytes[] memory calls = new bytes[](2);
            calls[0] = depositCall;
            calls[1] = allocateCall;
            
            governance.multiDelegateCall(calls);
        }
    }

    function governance_registerInitialInitiatives_clamped() public asActor {
        // Register bribe initiative as initial initiative
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        
        governance.registerInitialInitiatives(initiatives);
    }

    function governance_resetAllocations_clamped() public asActor {
        // Reset allocations for bribe initiative
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        
        governance.resetAllocations(initiatives, false);
    }

    function governance_resetAllocations_all_clamped() public asActor {
        // Reset all allocations
        address[] memory emptyArray = new address[](0);
        
        governance.resetAllocations(emptyArray, true);
    }

    function governance_snapshotVotesForInitiative_clamped() public asActor {
        // Snapshot votes for bribe initiative
        governance.snapshotVotesForInitiative(address(bribeInitiative));
    }

    function governance_depositLQTY_withPermit_clamped(uint256 _lqtyAmount) public asActor {
        // Deposit LQTY with permit parameters
        address actor = _getActor();
        uint256 maxBalance = lqty.balanceOf(actor);
        
        // Clamp to actor's balance
        if (maxBalance > 0) {
            _lqtyAmount = (_lqtyAmount % (maxBalance + 1));
        } else {
            _lqtyAmount = 0;
        }
        
        // Create permit parameters (using mock values)
        PermitParams memory permitParams = PermitParams({
            owner: actor,
            spender: address(governance),
            value: _lqtyAmount,
            deadline: block.timestamp + 3600,
            v: 27,
            r: bytes32(uint256(1)),
            s: bytes32(uint256(1))
        });
        
        governance.depositLQTYViaPermit(_lqtyAmount, permitParams);
    }

    function governance_depositLQTY_withPermitAndRewards_clamped(uint256 _lqtyAmount) public asActor {
        // Deposit LQTY with permit and rewards
        address actor = _getActor();
        uint256 maxBalance = lqty.balanceOf(actor);
        
        // Clamp to actor's balance
        if (maxBalance > 0) {
            _lqtyAmount = (_lqtyAmount % (maxBalance + 1));
        } else {
            _lqtyAmount = 0;
        }
        
        // Create permit parameters
        PermitParams memory permitParams = PermitParams({
            owner: actor,
            spender: address(governance),
            value: _lqtyAmount,
            deadline: block.timestamp + 3600,
            v: 27,
            r: bytes32(uint256(1)),
            s: bytes32(uint256(1))
        });
        
        governance.depositLQTYViaPermit(_lqtyAmount, permitParams, true, actor);
    }

    function governance_withdrawLQTY_withRewards_clamped(uint256 _lqtyAmount) public asActor {
        // Withdraw LQTY with rewards
        address actor = _getActor();
        (uint256 unallocatedLQTY,, uint256 allocatedLQTY,) = governance.userStates(actor);
        uint256 deposited = unallocatedLQTY + allocatedLQTY;
        
        // Clamp to deposited amount
        if (deposited > 0) {
            _lqtyAmount = (_lqtyAmount % (deposited + 1));
        } else {
            _lqtyAmount = 0;
        }
        
        governance.withdrawLQTY(_lqtyAmount, true, actor);
    }

    function governance_depositLQTY_withRewards_clamped(uint256 _lqtyAmount) public asActor {
        // Deposit LQTY with rewards enabled
        address actor = _getActor();
        uint256 maxBalance = lqty.balanceOf(actor);
        
        // Clamp to actor's balance
        if (maxBalance > 0) {
            _lqtyAmount = (_lqtyAmount % (maxBalance + 1));
        } else {
            _lqtyAmount = 0;
        }
        
        governance.depositLQTY(_lqtyAmount, true, actor);
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
