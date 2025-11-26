# Coverage Phase 7 - Improvements Summary

## Analysis Date
November 26, 2025

## Coverage Issues Identified

Based on analysis of `functions-missing-covg-1764126453.json` and the coverage data from `echidna/covered.1764126453.lcov`, the following coverage blockages were identified:

### 1. BribeInitiative._claimBribe (Lines 104-155)
**Problem:** Lines 104-120 have 0 hits despite the function being called 73 times.

**Root Cause Analysis:**
- Line 98: 73 hits - function is being called
- Line 99: 31 hits - some calls pass the epoch check
- Line 102: 23 hits - some calls pass the "already claimed" check
- Lines 104+: 0 hits - execution never reaches these lines

**Blockage:** The `getBribeClaimData` helper function was providing incorrect `prevLQTYAllocationEpoch` and `prevTotalLQTYAllocationEpoch` values, causing the require statements at lines 107-117 to revert.

**Fix Implemented:**
- Enhanced `getBribeClaimData` in `test/recon/Properties.sol` to properly traverse the double-linked list structure
- Added helper functions `_findPrevUserEpoch` and `_findPrevTotalEpoch` to correctly identify the most recent allocation epoch that is <= the claim epoch
- Fixed the logic to only attempt claims for epochs where:
  - Bribes exist (remainingBold > 0 or remainingBribeToken > 0)
  - User hasn't already claimed
  - User had an allocation in that epoch
  - Proper prev epoch values are calculated

### 2. Governance.calculateVotingThreshold (Line 296)
**Problem:** Line 296 has 0 hits - conditional branch when `payoutPerVote != 0`.

**Root Cause Analysis:**
- Line 294: 17 hits - `payoutPerVote` is being calculated
- Line 295: 5 hits - condition is checked
- Line 296: 0 hits - branch never executed

**Blockage:** The condition `payoutPerVote != 0` is never true because `boldAccrued * WAD / _votes` equals 0 when `boldAccrued` is too small relative to `_votes`. This happens when insufficient BOLD has been accrued in the governance contract.

**Fix Implemented:**
- Added `governance_accrueBOLD_clamped` handler in `test/recon/targets/GovernanceTargets.sol` to transfer BOLD directly to governance
- Added `governance_setupVotingThreshold_clamped` shortcut function to set up the complete scenario:
  - Registers initiative
  - Deposits LQTY and allocates votes
  - Accrues BOLD to governance
  - Warps time and triggers calculateVotingThreshold

### 3. Governance.claimForInitiative (Line 908)
**Problem:** Line 908 has 0 hits - edge case where `claimableAmount > available`.

**Root Cause Analysis:**
- Line 906: 61 hits - function is being called
- Line 907: 7 hits - condition is checked
- Line 908: 0 hits - edge case never triggered

**Blockage:** The edge case requires the claimable amount to exceed the BOLD balance in the governance contract. This is difficult to trigger naturally because BOLD is typically sufficient for all claims.

**Fix Implemented:**
- Added `governance_multiClaim_clamped` handler to claim for multiple initiatives sequentially
- Added `shortcut_claimForInitiative_edgeCase` in `test/recon/TargetFunctions.sol` that:
  - Registers multiple initiatives
  - Allocates votes from different actors to each initiative
  - Deposits a limited amount of BOLD to governance
  - Warps time to make claims available
  - Claims sequentially so the second claim hits the edge case

### 4. Enhanced Bribe Claiming Shortcuts
**Additional Improvements:**
- Enhanced `shortcut_claimBribes` to properly sequence allocation before bribe deposit
- Added `shortcut_claimBribes_enhanced` with better epoch handling to ensure bribes are claimable

## Files Modified

1. **test/recon/Properties.sol**
   - Fixed `getBribeClaimData` function with proper double-linked list traversal
   - Added `_findPrevUserEpoch` helper function
   - Added `_findPrevTotalEpoch` helper function

2. **test/recon/targets/GovernanceTargets.sol**
   - Added `governance_accrueBOLD_clamped` handler
   - Added `governance_multiClaim_clamped` handler
   - Added `governance_setupVotingThreshold_clamped` shortcut

3. **test/recon/TargetFunctions.sol**
   - Enhanced `shortcut_claimBribes` function
   - Added `shortcut_claimBribes_enhanced` function
   - Added `shortcut_claimForInitiative_edgeCase` function

## Expected Coverage Improvements

After these changes, we expect to see:

1. **BribeInitiative._claimBribe**: Lines 104-155 should now be covered when bribes are properly set up and claimed
2. **Governance.calculateVotingThreshold**: Line 296 should be covered when BOLD is accrued before voting threshold calculation
3. **Governance.claimForInitiative**: Line 908 should be covered when multiple initiatives claim with limited BOLD available

## Testing Recommendations

To verify these improvements:

1. Run the fuzzer with the updated handlers
2. Check the new coverage report for the specific lines mentioned above
3. Verify that the `_claimBribe` function now executes past line 104
4. Verify that `calculateVotingThreshold` executes line 296
5. Verify that `claimForInitiative` executes line 908

## Technical Notes

### Double-Linked List Traversal
The BribeInitiative uses a double-linked list to track LQTY allocations by epoch. To claim bribes, we need to provide the "previous" epoch that is <= the claim epoch. The fix properly traverses this list backwards from the most recent epoch to find the correct previous epoch.

### BOLD Accrual
The governance contract accrues BOLD rewards that are distributed to initiatives. The `calculateVotingThreshold` function has a conditional branch that only executes when `payoutPerVote != 0`, which requires sufficient BOLD to be accrued. The new handler ensures BOLD is present before triggering this calculation.

### Edge Case Testing
The claimForInitiative edge case (line 908) is designed to handle situations where the calculated claimable amount exceeds the available BOLD balance. This is a safety check to prevent reverts. The new shortcut creates this scenario by having multiple initiatives with claims but limited BOLD available.
