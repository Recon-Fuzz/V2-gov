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

    // Clamped handler for depositLQTY - constrains amount to actor's LQTY balance
    function governance_depositLQTY_clamped(uint256 _lqtyAmount) public asActor {
        address actor = _getActor();
        uint256 actorBalance = lqty.balanceOf(actor);

        // Clamp amount to available balance (0 to balance inclusive)
        _lqtyAmount = _lqtyAmount % (actorBalance + 1);
        governance_depositLQTY(_lqtyAmount);
    }

    // Clamped handler for withdrawLQTY - constrains amount to unallocated LQTY
    function governance_withdrawLQTY_clamped(uint256 _lqtyAmount) public asActor {
        address actor = _getActor();
        (uint256 unallocated,,,) = governance.userStates(actor);

        // Clamp amount to unallocated LQTY (0 to unallocated inclusive)
        _lqtyAmount = _lqtyAmount % (unallocated + 1);
        governance_withdrawLQTY(_lqtyAmount);
    }

    // FUNDAMENTAL REDESIGN: This handler ensures proper preconditions are met
    // Key insight: allocateLQTY REQUIRES allocatedLQTY == 0 (line 611 of Governance.sol)
    // This means we MUST reset ALL allocations before making new ones
    function governance_allocateLQTY_clamped(
        uint256 voteAmount,
        bool useVeto,
        bool useInitiative2
    ) public asActor {
        address actor = _getActor();
        (uint256 unallocated, uint256 allocated,,) = governance.userStates(actor);

        if (unallocated + allocated == 0) return;

        // CRITICAL FIX: Reset ALL allocations first
        address[] memory initiativesToReset = _buildResetArray(actor);

        // After reset, total available = current unallocated + allocated
        uint256 totalAvailable = unallocated + allocated;

        // Now allocate to a single initiative with non-zero amount
        address[] memory initiatives = new address[](1);
        initiatives[0] = useInitiative2 ? address(bribeInitiative2) : address(bribeInitiative);

        int256[] memory absoluteLQTYVotes = new int256[](1);
        int256[] memory absoluteLQTYVetos = new int256[](1);

        // Clamp vote amount (0 to totalAvailable inclusive)
        voteAmount = voteAmount % (totalAvailable + 1);

        absoluteLQTYVotes[0] = useVeto ? int256(0) : int256(voteAmount);
        absoluteLQTYVetos[0] = useVeto ? int256(voteAmount) : int256(0);

        governance_allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
    }

    // Handler that allocates to BOTH initiatives simultaneously
    // This ensures we test multi-initiative allocation paths
    function governance_allocateLQTY_multi_clamped(
        uint256 seed1,
        uint256 seed2,
        bool useVeto1,
        bool useVeto2
    ) public asActor {
        address actor = _getActor();
        (uint256 unallocated, uint256 allocated,,) = governance.userStates(actor);

        if (unallocated + allocated == 0) return;

        // Build reset array
        address[] memory initiativesToReset = _buildResetArray(actor);

        uint256 totalAvailable = unallocated + allocated;

        // Allocate to BOTH initiatives
        address[] memory initiatives = new address[](2);
        initiatives[0] = address(bribeInitiative);
        initiatives[1] = address(bribeInitiative2);

        int256[] memory absoluteLQTYVotes = new int256[](2);
        int256[] memory absoluteLQTYVetos = new int256[](2);

        // Calculate amounts - split between two initiatives
        // First amount: 0 to half of total available
        uint256 maxAmount1 = totalAvailable / 2;
        uint256 amount1 = seed1 % (maxAmount1 + 1);

        // Second amount: 0 to remaining after first allocation
        uint256 remaining = totalAvailable - amount1;
        uint256 amount2 = seed2 % (remaining + 1);

        // Set vote/veto for first initiative
        absoluteLQTYVotes[0] = useVeto1 ? int256(0) : int256(amount1);
        absoluteLQTYVetos[0] = useVeto1 ? int256(amount1) : int256(0);

        // Set vote/veto for second initiative
        absoluteLQTYVotes[1] = useVeto2 ? int256(0) : int256(amount2);
        absoluteLQTYVetos[1] = useVeto2 ? int256(amount2) : int256(0);

        governance_allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
    }

    // Helper to build reset array - reduces stack depth in handlers
    function _buildResetArray(address actor) internal view returns (address[] memory) {
        uint256 resetCount = 0;
        address[] memory tempReset = new address[](2);

        (uint256 vote1,,,,uint256 veto1) = governance.lqtyAllocatedByUserToInitiative(actor, address(bribeInitiative));
        if (vote1 > 0 || veto1 > 0) {
            tempReset[resetCount++] = address(bribeInitiative);
        }

        (uint256 vote2,,,,uint256 veto2) = governance.lqtyAllocatedByUserToInitiative(actor, address(bribeInitiative2));
        if (vote2 > 0 || veto2 > 0) {
            tempReset[resetCount++] = address(bribeInitiative2);
        }

        address[] memory result = new address[](resetCount);
        for (uint256 i = 0; i < resetCount; i++) {
            result[i] = tempReset[i];
        }
        return result;
    }

    // Handler that exercises ONLY reset without reallocation
    // This tests the reset path and ensures allocatedLQTY returns to 0
    function governance_allocateLQTY_resetOnly_clamped() public asActor {
        address actor = _getActor();
        (, uint256 allocated,,) = governance.userStates(actor);

        // Only proceed if user has allocations to reset
        if (allocated == 0) return;

        address[] memory initiativesToReset = _buildResetArray(actor);
        if (initiativesToReset.length == 0) return;

        // Empty arrays for new allocations - just reset
        address[] memory initiatives = new address[](0);
        int256[] memory absoluteLQTYVotes = new int256[](0);
        int256[] memory absoluteLQTYVetos = new int256[](0);

        governance_allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
    }

    // Handler for unregisterInitiative - needed to trigger onUnregisterInitiative hook
    // Note: This is a wrapper that doesn't add any clamping since the base handler
    // already properly selects initiatives. We include it for completeness.
    function governance_unregisterInitiative_clamped(bool useInitiative2) public asActor {
        address initiative = useInitiative2 ? address(bribeInitiative2) : address(bribeInitiative);

        // Attempt to unregister - will only succeed if conditions are met
        // (initiative must be old enough and meet unregistration threshold)
        governance_unregisterInitiative(initiative);
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

    function governance_registerInitialInitiatives(address[] memory _initiatives) public asActor {
        governance.registerInitialInitiatives(_initiatives);
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