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

    // ========== HANDLERS FOR COVERAGE GAPS ==========

    // Handler to cover allocateLQTY lines 629-632: allocate after voting cutoff with reset
    // This triggers the conditional branch that checks if initiatives match cached data
    function governance_allocateLQTY_afterCutoff_withReset_clamped(
        uint256 _voteSeed,
        uint256 _vetoSeed
    ) public {
        // Get user's unallocated LQTY
        (uint256 unallocatedLQTY, , uint256 allocatedLQTY, ) = governance
            .userStates(_getActor());
        uint256 maxAllocation = unallocatedLQTY + allocatedLQTY;

        // Skip if no allocation available
        if (maxAllocation == 0) return;

        // Clamp votes to be less than or equal to current allocation (to satisfy "Cannot increase" check)
        // This ensures the fuzzer can successfully pass the require check at line 631
        int256 vote = int256(_voteSeed % (maxAllocation + 1));
        int256 veto = int256(_vetoSeed % (maxAllocation + 1));

        // Use bribeInitiative as the initiative to reallocate to
        address[] memory initiativesToReset = new address[](1);
        initiativesToReset[0] = address(bribeInitiative);

        address[] memory initiatives = new address[](1);
        initiatives[0] = address(bribeInitiative);

        int256[] memory votes = new int256[](1);
        votes[0] = vote;

        int256[] memory vetos = new int256[](1);
        vetos[0] = veto;

        governance_allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }

    // Handler to fund governance with BOLD tokens to trigger calculateVotingThreshold line 296
    function governance_fundWithBOLD_clamped(uint256 _boldAmount) public {
        // Clamp to actor's BOLD balance
        _boldAmount %= bold.balanceOf(_getActor()) + 1;

        // Skip if no BOLD available
        if (_boldAmount == 0) return;

        // Transfer BOLD to governance contract
        vm.prank(_getActor());
        bold.transfer(address(governance), _boldAmount);
    }

    // Handler for multiDelegateCall with valid calldata to cover line 24
    function governance_multiDelegateCall_depositAndWithdraw_clamped(
        uint256 _depositAmount,
        uint256 _withdrawAmount
    ) public {
        // Clamp deposit to actor's LQTY balance
        _depositAmount %= lqty.balanceOf(_getActor()) + 1;

        // Get user's deposited LQTY for withdrawal
        (uint256 unallocatedLQTY, , uint256 allocatedLQTY, ) = governance
            .userStates(_getActor());
        uint256 maxWithdraw = unallocatedLQTY + allocatedLQTY;
        _withdrawAmount %= (maxWithdraw + 1);

        // Create valid calldata for depositLQTY and withdrawLQTY
        bytes[] memory calls = new bytes[](2);
        calls[0] = abi.encodeWithSignature(
            "depositLQTY(uint256)",
            _depositAmount
        );
        calls[1] = abi.encodeWithSignature(
            "withdrawLQTY(uint256)",
            _withdrawAmount
        );

        governance_multiDelegateCall(calls);
    }

    // Handler for multiDelegateCall with single valid call
    function governance_multiDelegateCall_singleCall_clamped() public {
        // Create a single valid call (e.g., getLatestVotingThreshold which is a view function)
        bytes[] memory calls = new bytes[](1);
        calls[0] = abi.encodeWithSignature("getLatestVotingThreshold()");

        governance_multiDelegateCall(calls);
    }

    // Handler to drain BOLD from governance before claiming (to trigger claimForInitiative line 908)
    function governance_drainBOLD_clamped(uint256 _drainAmount) public {
        // Get governance BOLD balance
        uint256 govBalance = bold.balanceOf(address(governance));

        // Clamp drain amount to governance balance
        _drainAmount %= (govBalance + 1);

        // Skip if nothing to drain
        if (_drainAmount == 0) return;

        // Use a prank to transfer BOLD out of governance (simulating insufficient balance scenario)
        // Note: This may not be directly callable, but we can try to withdraw via other means
        // Alternative: We can call claimForInitiative when there's very little BOLD in governance
        vm.prank(address(governance));
        bold.transfer(_getActor(), _drainAmount);
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
