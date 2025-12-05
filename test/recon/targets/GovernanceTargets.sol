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
    
    // Clamped handler for depositLQTY (single parameter version)
    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public {
        // Clamp to actor's balance
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        governance_depositLQTY(_lqtyAmount);
    }
    
    // Clamped handler for depositLQTY (three parameter version)
    function governance_depositLQTY_clamped(
        uint256 _lqtyAmount,
        bool _doSendRewards,
        address _recipient
    ) public {
        // Clamp to actor's balance
        _lqtyAmount %= lqty.balanceOf(_getActor()) + 1;
        
        governance_depositLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }
    
    // Clamped handler for withdrawLQTY (single parameter version)
    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public {
        // Clamp to user's allocated LQTY
        (uint256 unallocatedLQTY, , uint256 allocatedLQTY, ) = governance.userStates(_getActor());
        _lqtyAmount %= (unallocatedLQTY + allocatedLQTY) + 1;
        
        governance_withdrawLQTY(_lqtyAmount);
    }
    
    // Clamped handler for withdrawLQTY (three parameter version)
    function governance_withdrawLQTY_clamped(
        uint256 _lqtyAmount,
        bool _doSendRewards,
        address _recipient
    ) public {
        // Clamp to user's allocated LQTY
        (uint256 unallocatedLQTY, , uint256 allocatedLQTY, ) = governance.userStates(_getActor());
        _lqtyAmount %= (unallocatedLQTY + allocatedLQTY) + 1;
        
        governance_withdrawLQTY(_lqtyAmount, _doSendRewards, _recipient);
    }
    
    // Clamped handlers for registerInitiative with specific initiatives
    function governance_registerInitiative_bribeInitiative_clamped() public {
        governance_registerInitiative(address(bribeInitiative));
    }
    
    function governance_registerInitiative_curveV2_clamped() public {
        governance_registerInitiative(address(curveV2GaugeRewards));
    }
    
    function governance_registerInitiative_uniV4_clamped() public {
        governance_registerInitiative(address(uniV4MerklRewards));
    }
    
    // Clamped handlers for claimForInitiative with specific initiatives
    function governance_claimForInitiative_bribeInitiative_clamped() public {
        governance_claimForInitiative(address(bribeInitiative));
    }
    
    function governance_claimForInitiative_curveV2_clamped() public {
        governance_claimForInitiative(address(curveV2GaugeRewards));
    }
    
    function governance_claimForInitiative_uniV4_clamped() public {
        governance_claimForInitiative(address(uniV4MerklRewards));
    }
    
    // Clamped handlers for getInitiativeState with specific initiatives
    function governance_getInitiativeState_bribeInitiative_clamped() public {
        governance_getInitiativeState(address(bribeInitiative));
    }
    
    function governance_getInitiativeState_curveV2_clamped() public {
        governance_getInitiativeState(address(curveV2GaugeRewards));
    }
    
    function governance_getInitiativeState_uniV4_clamped() public {
        governance_getInitiativeState(address(uniV4MerklRewards));
    }
    
    // Clamped handlers for snapshotVotesForInitiative with specific initiatives
    function governance_snapshotVotesForInitiative_bribeInitiative_clamped() public {
        governance_snapshotVotesForInitiative(address(bribeInitiative));
    }
    
    function governance_snapshotVotesForInitiative_curveV2_clamped() public {
        governance_snapshotVotesForInitiative(address(curveV2GaugeRewards));
    }
    
    function governance_snapshotVotesForInitiative_uniV4_clamped() public {
        governance_snapshotVotesForInitiative(address(uniV4MerklRewards));
    }
    
    // Clamped handlers for unregisterInitiative with specific initiatives
    function governance_unregisterInitiative_bribeInitiative_clamped() public {
        governance_unregisterInitiative(address(bribeInitiative));
    }
    
    function governance_unregisterInitiative_curveV2_clamped() public {
        governance_unregisterInitiative(address(curveV2GaugeRewards));
    }
    
    function governance_unregisterInitiative_uniV4_clamped() public {
        governance_unregisterInitiative(address(uniV4MerklRewards));
    }
    
    // Clamped handler for allocateLQTY with specific initiatives (single initiative)
    function governance_allocateLQTY_bribeInitiative_clamped(
        uint256 _voteSeed,
        uint256 _vetoSeed
    ) public {
        // Get user's unallocated LQTY
        (uint256 unallocatedLQTY, , uint256 allocatedLQTY, ) = governance.userStates(_getActor());
        uint256 maxAllocation = unallocatedLQTY + allocatedLQTY;
        
        // Clamp votes and vetos to reasonable values
        int256 vote = int256(_voteSeed % (maxAllocation + 1));
        int256 veto = int256(_vetoSeed % (maxAllocation + 1));
        
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        
        int256[] memory votes = new int256[](1);
        votes[0] = vote;
        
        int256[] memory vetos = new int256[](1);
        vetos[0] = veto;
        
        address[] memory emptyReset = new address[](0);
        
        governance_allocateLQTY(emptyReset, initiatives, votes, vetos);
    }
    
    function governance_allocateLQTY_curveV2_clamped(
        uint256 _voteSeed,
        uint256 _vetoSeed
    ) public {
        // Get user's unallocated LQTY
        (uint256 unallocatedLQTY, , uint256 allocatedLQTY, ) = governance.userStates(_getActor());
        uint256 maxAllocation = unallocatedLQTY + allocatedLQTY;
        
        // Clamp votes and vetos to reasonable values
        int256 vote = int256(_voteSeed % (maxAllocation + 1));
        int256 veto = int256(_vetoSeed % (maxAllocation + 1));
        
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(curveV2GaugeRewards);
        
        int256[] memory votes = new int256[](1);
        votes[0] = vote;
        
        int256[] memory vetos = new int256[](1);
        vetos[0] = veto;
        
        address[] memory emptyReset = new address[](0);
        
        governance_allocateLQTY(emptyReset, initiatives, votes, vetos);
    }
    
    function governance_allocateLQTY_uniV4_clamped(
        uint256 _voteSeed,
        uint256 _vetoSeed
    ) public {
        // Get user's unallocated LQTY
        (uint256 unallocatedLQTY, , uint256 allocatedLQTY, ) = governance.userStates(_getActor());
        uint256 maxAllocation = unallocatedLQTY + allocatedLQTY;
        
        // Clamp votes and vetos to reasonable values
        int256 vote = int256(_voteSeed % (maxAllocation + 1));
        int256 veto = int256(_vetoSeed % (maxAllocation + 1));
        
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(uniV4MerklRewards);
        
        int256[] memory votes = new int256[](1);
        votes[0] = vote;
        
        int256[] memory vetos = new int256[](1);
        vetos[0] = veto;
        
        address[] memory emptyReset = new address[](0);
        
        governance_allocateLQTY(emptyReset, initiatives, votes, vetos);
    }
    
    // Clamped handler for allocateLQTY with all three initiatives
    function governance_allocateLQTY_allInitiatives_clamped(
        uint256 _vote1Seed,
        uint256 _veto1Seed,
        uint256 _vote2Seed,
        uint256 _veto2Seed,
        uint256 _vote3Seed,
        uint256 _veto3Seed
    ) public {
        // Get user's unallocated LQTY
        (uint256 unallocatedLQTY, , uint256 allocatedLQTY, ) = governance.userStates(_getActor());
        uint256 maxAllocation = unallocatedLQTY + allocatedLQTY;
        
        // Clamp votes and vetos to reasonable values
        int256 vote1 = int256(_vote1Seed % (maxAllocation + 1));
        int256 veto1 = int256(_veto1Seed % (maxAllocation + 1));
        int256 vote2 = int256(_vote2Seed % (maxAllocation + 1));
        int256 veto2 = int256(_veto2Seed % (maxAllocation + 1));
        int256 vote3 = int256(_vote3Seed % (maxAllocation + 1));
        int256 veto3 = int256(_veto3Seed % (maxAllocation + 1));
        
        address[] memory initiatives = new address[](3);
        initiatives[0] = address(bribeInitiative);
        initiatives[1] = address(curveV2GaugeRewards);
        initiatives[2] = address(uniV4MerklRewards);
        
        int256[] memory votes = new int256[](3);
        votes[0] = vote1;
        votes[1] = vote2;
        votes[2] = vote3;
        
        int256[] memory vetos = new int256[](3);
        vetos[0] = veto1;
        vetos[1] = veto2;
        vetos[2] = veto3;
        
        address[] memory emptyReset = new address[](0);
        
        governance_allocateLQTY(emptyReset, initiatives, votes, vetos);
    }
    
    // Clamped handlers for resetAllocations with specific initiatives
    function governance_resetAllocations_bribeInitiative_clamped() public {
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);
        
        governance_resetAllocations(initiatives, false);
    }
    
    function governance_resetAllocations_curveV2_clamped() public {
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(curveV2GaugeRewards);
        
        governance_resetAllocations(initiatives, false);
    }
    
    function governance_resetAllocations_uniV4_clamped() public {
        address[] memory initiatives = new address[](1);
        initiatives[0] = address(uniV4MerklRewards);
        
        governance_resetAllocations(initiatives, false);
    }
    
    function governance_resetAllocations_allInitiatives_clamped() public {
        address[] memory initiatives = new address[](3);
        initiatives[0] = address(bribeInitiative);
        initiatives[1] = address(curveV2GaugeRewards);
        initiatives[2] = address(uniV4MerklRewards);
        
        governance_resetAllocations(initiatives, false);
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
