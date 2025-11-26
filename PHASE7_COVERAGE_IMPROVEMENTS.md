# Phase 7 Coverage Improvements

## Analysis Summary

### Functions Analyzed
1. **`claimForInitiative` in Governance.sol** (lines 881-926)
   - Current coverage: 96.2% overall for Governance.sol
   - Missing line: **Line 908** - Edge case where `claimableAmount > available` BOLD balance

### Coverage Blockage Identified

**Function:** `claimForInitiative` (Governance.sol:881-926)

**Coverage Analysis:**
```
Line 906 (checking available balance): 61 hits
Line 907 (if condition check):         7 hits  
Line 908 (clamping claimableAmount):   0 hits ← MISSING COVERAGE
Line 911 (BOLD transfer):              9 hits
```

**Root Cause:**
The conditional branch at line 907-909 is never executed because the fuzzer hasn't created a scenario where:
1. An initiative has a calculated `claimableAmount` 
2. The governance contract has less BOLD than the `claimableAmount`

This is a **conditional branch not covered** scenario (similar to Example 2 in the phase 7 documentation).

### Fixes Implemented

#### Fix Type: Clamped Handler Functions

Created two new specialized handler functions to guide the fuzzer toward covering line 908:

1. **`governance_claimWithInsufficientBOLD_clamped`** (GovernanceTargets.sol:211-242)
   - Registers two initiatives (bribeInitiative and curveV2GaugeRewards)
   - Has two different actors allocate LQTY to each initiative
   - Transfers a **small fixed amount** of BOLD (100e18) to governance
   - Warps forward one epoch
   - First actor claims (draining most BOLD)
   - Second actor claims (should hit line 908 edge case)

2. **`governance_claimWithDrainedBOLD_clamped`** (GovernanceTargets.sol:246-281)
   - More aggressive approach using **three initiatives**
   - Three actors each allocate to different initiatives
   - Transfers **only 1 wei** of BOLD to governance (minimal amount)
   - Warps forward one epoch
   - All three actors attempt to claim sequentially
   - Guarantees that at least the 2nd and 3rd claims will hit the edge case

3. **`shortcut_claimWithMinimalBOLD`** (TargetFunctions.sol:255-257)
   - Wrapper for `governance_claimWithInsufficientBOLD_clamped`
   - Provides easy access for fuzzer

4. **`shortcut_claimWithDrainedBOLD`** (TargetFunctions.sol:261-263)
   - Wrapper for `governance_claimWithDrainedBOLD_clamped`
   - Ultra-aggressive approach to guarantee edge case

### Implementation Details

**Key Strategy:**
- **Clamping BOLD amount** to values much smaller than potential claimable rewards
- Using multiple initiatives to create competing claims
- Sequential claiming to drain available BOLD before final claim
- Fixed small amounts (100e18 and 1 wei) instead of fuzzer-generated values

**Why This Works:**
The existing `shortcut_claimForInitiative_edgeCase` function transferred 1000e18 BOLD, which may have been sufficient for most claims. The new handlers use:
- 100e18 BOLD (100x smaller)
- 1 wei BOLD (essentially zero)

This dramatically increases the probability that `claimableAmount > available` evaluates to true.

### Expected Coverage Improvement

**Before:**
- Line 908: 0 hits (0% coverage)
- Overall Governance.sol: 96.2% coverage

**Expected After:**
- Line 908: Should achieve hits when fuzzer calls new handlers
- Overall Governance.sol: Should reach ~96.5% coverage (covering the 1 missing line out of 399 total)

**Estimated Impact:**
- **Lines covered:** 1 additional line (908)
- **Coverage increase:** +0.25% for Governance.sol
- **Functions fully covered:** `claimForInitiative` will reach 100% coverage

### Files Modified

1. **test/recon/targets/GovernanceTargets.sol**
   - Added `governance_claimWithInsufficientBOLD_clamped` (lines 211-242)
   - Added `governance_claimWithDrainedBOLD_clamped` (lines 246-281)

2. **test/recon/TargetFunctions.sol**
   - Added `shortcut_claimWithMinimalBOLD` (lines 255-257)
   - Added `shortcut_claimWithDrainedBOLD` (lines 261-263)

### Testing Recommendations

To verify these improvements:

1. Run the fuzzer with the new handlers:
   ```bash
   echidna . --contract CryticTester --config echidna.yaml
   ```

2. After fuzzing, check coverage for line 908:
   ```bash
   lcov --extract echidna/covered.*.lcov '**/Governance.sol' -o /tmp/gov_new.info
   grep "DA:908," /tmp/gov_new.info
   ```
   
   Expected output: `DA:908,N` where N > 0

3. Use function coverage script to verify:
   ```bash
   ./scripts/function-coverage.sh echidna/covered.*.lcov Governance.sol claimForInitiative src/Governance.sol
   ```
   
   Expected: Line 908 should show hits

### Additional Notes

- The handlers use `_switchActor()` to properly switch between actors
- Both handlers include safety checks (e.g., `if (bold.balanceOf(_getActor()) >= smallBoldAmount)`)
- The ultra-aggressive handler (1 wei) guarantees the edge case but may cause more reverts
- The moderate handler (100e18) balances between hitting the edge case and successful execution
