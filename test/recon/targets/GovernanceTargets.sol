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
        address[] memory _initiativesToReset,
        address[] memory _initiatives,
        int256[] memory _absoluteLQTYVotes,
        int256[] memory _absoluteLQTYVetos
    ) public asActor {
        // Clamp array lengths to 10 as per meaningful-values.json
        if (_initiativesToReset.length > 10) {
            assembly {
                mstore(_initiativesToReset, 10) // Set length to 10
            }
        }
        if (_initiatives.length > 10) {
            assembly {
                mstore(_initiatives, 10) // Set length to 10
            }
        }
        if (_absoluteLQTYVotes.length > 10) {
            assembly {
                mstore(_absoluteLQTYVotes, 10) // Set length to 10
            }
        }
        if (_absoluteLQTYVetos.length > 10) {
            assembly {
                mstore(_absoluteLQTYVetos, 10) // Set length to 10
            }
        }
        
        governance_allocateLQTY(_initiativesToReset, _initiatives, _absoluteLQTYVotes, _absoluteLQTYVetos);
    }

    function governance_claimForInitiative_clamped() public asActor {
        // Use bribeInitiative address as per meaningful-values.json
        governance_claimForInitiative(address(bribeInitiative));
    }

    function governance_claimFromStakingV1_clamped() public asActor {
        // Use actor address as per meaningful-values.json
        governance_claimFromStakingV1(_getActor());
    }

    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public asActor {
        // Clamp amount to actor balance + 1 to allow full balance
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        governance_depositLQTY(_lqtyAmount);
    }

    function governance_depositLQTY_clamped(
        uint256 _lqtyAmount,
        bool _doSendRewards,
        address _recipient
    ) public asActor {
        // Clamp amount to actor balance + 1 to allow full balance
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        // Use exact values as per meaningful-values.json
        _doSendRewards = false;
        _recipient = _getActor();
        
        governance_depositLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }

    function governance_depositLQTYViaPermit_clamped(
        uint256 _lqtyAmount,
        PermitParams memory _permitParams,
        bool _doSendRewards,
        address _recipient
    ) public asActor {
        // Clamp amount to actor balance + 1 to allow full balance
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        // Use exact values as per meaningful-values.json
        _permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: 1,
            deadline: block.timestamp + 1 hours,
            v: 27,
            r: bytes32(0),
            s: bytes32(0)
        });
        _doSendRewards = false;
        _recipient = _getActor();
        
        governance_depositLQTYViaPermit(_lqtyAmount, _permitParams, _doSendRewards, _recipient);
    }

    function governance_depositLQTYViaPermit_clamped(
        uint256 _lqtyAmount,
        PermitParams memory _permitParams
    ) public asActor {
        // Clamp amount to actor balance + 1 to allow full balance
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        // Use exact values as per meaningful-values.json
        _permitParams = PermitParams({
            owner: _getActor(),
            spender: address(governance),
            value: 1,
            deadline: block.timestamp + 1 hours,
            v: 27,
            r: bytes32(0),
            s: bytes32(0)
        });
        
        governance_depositLQTYViaPermit(_lqtyAmount, _permitParams);
    }

    function governance_getInitiativeState_clamped() public asActor {
        // Use bribeInitiative address as per meaningful-values.json
        governance_getInitiativeState(address(bribeInitiative));
    }

    function governance_registerInitiative_clamped() public asActor {
        // Use bribeInitiative address as per meaningful-values.json
        governance_registerInitiative(address(bribeInitiative));
    }

    function governance_resetAllocations_clamped(
        address[] memory _initiativesToReset,
        bool checkAll
    ) public asActor {
        // Clamp array length to 10 as per meaningful-values.json
        if (_initiativesToReset.length > 10) {
            assembly {
                mstore(_initiativesToReset, 10) // Set length to 10
            }
        }
        
        // Use exact value as per meaningful-values.json
        checkAll = false;
        
        governance_resetAllocations(_initiativesToReset, checkAll);
    }

    function governance_snapshotVotesForInitiative_clamped() public asActor {
        // Use bribeInitiative address as per meaningful-values.json
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }

    function governance_unregisterInitiative_clamped() public asActor {
        // Use bribeInitiative address as per meaningful-values.json
        governance_unregisterInitiative(address(bribeInitiative));
    }

    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public asActor {
        // Get unallocatedLQTY from user state tuple
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        
        // Clamp amount to unallocatedLQTY + 1 to allow full withdrawal
        _lqtyAmount %= unallocatedLQTY + 1;
        
        governance_withdrawLQTY(_lqtyAmount);
    }

    function governance_withdrawLQTY_clamped(
        uint256 _lqtyAmount,
        bool _doSendRewards,
        address _recipient
    ) public asActor {
        // Get unallocatedLQTY from user state tuple
        (uint256 unallocatedLQTY,,,) = governance.userStates(_getActor());
        
        // Clamp amount to unallocatedLQTY + 1 to allow full withdrawal
        _lqtyAmount %= unallocatedLQTY + 1;
        
        // Use exact values as per meaningful-values.json
        _doSendRewards = false;
        _recipient = _getActor();
        
        governance_withdrawLQTY(_lqtyAmount, _doSendRewards, _recipient);
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
