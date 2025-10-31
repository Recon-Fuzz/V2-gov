# Phase 4 - Iteration 2: Improved Clamped Handlers

## Date
2025-10-30

## Objective
Improve clamped handlers based on Phase 5 coverage analysis, which identified 29 uncovered functions with 10 HIGH-priority gaps.

## Problem Analysis

### Critical Issue
The `allocateLQTY_clamped` handler was not exercising core allocation logic:

1. **Validation Functions NOT Reached**:
   - `_requireNoNOP()` at line 603
   - `_requireNoSimultaneousVoteAndVeto()` at line 604
   - `_requireNoNegatives()` from UniqueArray.sol at lines 600-601

2. **Math Operations NOT Reached**:
   - `add(uint256, int256)` used at lines 747-752, 798-806
   - `sub(uint256, int256)` used at lines 798-800
   - `abs(int256)` used internally by add/sub

3. **BribeInitiative Core Function NOT Reached**:
   - `_setTotalLQTYAllocationByEpoch()` - Critical accounting function

### Root Cause
The handler was generating inputs that either:
1. **Generated zero amounts** - When `maxPerInitiative` calculation resulted in 0, the modulo operation also yielded 0
2. **Bypassed validation** - Empty or all-zero arrays skipped validation checks
3. **Reverted early** - Prevented reaching deep math operations in state updates

## Solution Implementation

### 1. Improved `governance_allocateLQTY_clamped`

**Key Changes**:
- Added early return if `unallocated == 0` to avoid division by zero
- Changed clamping formula to **guarantee non-zero amounts**: `(voteAmount % maxPerInitiative) + 1`
- This ensures `_requireNoNOP` validation is always triggered (requires at least one vote/veto > 0)
- Ensures math operations `add()` and `sub()` are executed for state updates

**Before**:
```solidity
if (maxPerInitiative > 0) {
    voteAmount1 = voteAmount1 % (maxPerInitiative + 1);
} else {
    voteAmount1 = 0;
}
// Could result in zero amount, bypassing validation
```

**After**:
```solidity
if (unallocated == 0) return;

uint256 maxPerInitiative = unallocated / numInitiatives;
// CRITICAL: Ensure non-zero amounts to trigger validation functions
voteAmount1 = (voteAmount1 % maxPerInitiative) + 1;
// Always >= 1, guarantees validation and math operations execute
```

### 2. New Handler: `governance_allocateLQTY_reset_clamped`

**Purpose**: Exercise the reset logic path in `allocateLQTY()` which was previously not covered.

**Strategy**:
1. Check if user has existing allocations (`allocated > 0`)
2. Query actual allocation to a specific initiative
3. Build `initiativesToReset` array with that initiative
4. Calculate total available LQTY after reset: `unallocated + allocated`
5. Reallocate to a different initiative with guaranteed non-zero amount

**Benefits**:
- Exercises the `_resetInitiatives()` code path
- Tests the scenario where user reallocates voting power
- Ensures state transitions from allocated → unallocated → reallocated

**Code**:
```solidity
function governance_allocateLQTY_reset_clamped(
    uint256 voteAmount,
    bool useVeto
) public asActor {
    address actor = _getActor();
    (uint256 unallocated, uint256 allocated,,) = governance.userStates(actor);

    // Only makes sense if user has existing allocations
    if (allocated == 0) return;

    // Get user's current allocation to reset it
    (uint256 voteLQTY,,,, uint256 vetoLQTY) = governance.lqtyAllocatedByUserToInitiative(
        actor, address(bribeInitiative)
    );

    if (voteLQTY == 0 && vetoLQTY == 0) return;

    // Build reset array
    address[] memory initiativesToReset = new address[](1);
    initiativesToReset[0] = address(bribeInitiative);

    // After reset, all LQTY becomes unallocated
    uint256 totalAvailable = unallocated + allocated;

    // Reallocate to different initiative
    address[] memory initiatives = new address[](1);
    initiatives[0] = address(bribeInitiative2);

    // Clamp to available amount, ensure non-zero
    voteAmount = (voteAmount % totalAvailable) + 1;

    // Set vote or veto (mutually exclusive)
    if (!useVeto) {
        absoluteLQTYVotes[0] = int256(voteAmount);
        absoluteLQTYVetos[0] = 0;
    } else {
        absoluteLQTYVotes[0] = 0;
        absoluteLQTYVetos[0] = int256(voteAmount);
    }

    governance_allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
}
```

### 3. New Handler: `governance_allocateLQTY_single_clamped`

**Purpose**: Simplified handler that allocates to a single initiative with guaranteed non-zero amount.

**Strategy**:
- Focus on single initiative allocation (reduces complexity)
- Guarantee non-zero amount: `(voteAmount % unallocated) + 1`
- Toggle between the two deployed initiatives
- Choose between vote or veto

**Benefits**:
- Maximizes probability of successful allocation (simpler state)
- Reduces likelihood of over-allocation errors
- Still exercises all validation and math operations
- Provides cleaner test cases for debugging

**Code**:
```solidity
function governance_allocateLQTY_single_clamped(
    uint256 voteAmount,
    bool useVeto,
    bool useInitiative2
) public asActor {
    address actor = _getActor();
    (uint256 unallocated,,,) = governance.userStates(actor);

    if (unallocated == 0) return;

    address[] memory initiativesToReset = new address[](0);
    address[] memory initiatives = new address[](1);
    initiatives[0] = useInitiative2 ? address(bribeInitiative2) : address(bribeInitiative);

    int256[] memory absoluteLQTYVotes = new int256[](1);
    int256[] memory absoluteLQTYVetos = new int256[](1);

    // Ensure non-zero amount (minimum 1, maximum unallocated)
    voteAmount = (voteAmount % unallocated) + 1;

    if (!useVeto) {
        absoluteLQTYVotes[0] = int256(voteAmount);
        absoluteLQTYVetos[0] = 0;
    } else {
        absoluteLQTYVotes[0] = 0;
        absoluteLQTYVetos[0] = int256(voteAmount);
    }

    governance_allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
}
```

## Expected Improvements

### Coverage Targets
With these improvements, we expect to cover:

1. **Governance.sol validation functions**:
   - ✓ `_requireNoNOP()` - Will be reached with non-zero vote/veto amounts
   - ✓ `_requireNoSimultaneousVoteAndVeto()` - Will be reached with mutually exclusive vote/veto
   - ✓ Lines 600-604 in `allocateLQTY()` - All validation checks

2. **Math.sol operations**:
   - ✓ `add(uint256, int256)` - Used at lines 747-752, 798-806 for state updates
   - ✓ `sub(uint256, int256)` - Used at lines 798-800 for unallocation
   - ✓ `abs(int256)` - Used internally by add/sub

3. **UniqueArray.sol**:
   - ✓ `_requireNoNegatives()` - Called at lines 600-601 with positive amounts

4. **BribeInitiative.sol**:
   - ✓ `_setTotalLQTYAllocationByEpoch()` - Should be triggered through successful allocations

## Handler Design Principles Applied

### 1. Guaranteed Non-Zero Inputs
All clamped handlers now use the pattern:
```solidity
amount = (amount % maximum) + 1  // Always >= 1
```

This ensures validation functions are always exercised rather than bypassed.

### 2. Early Returns for Invalid States
Handlers return early if preconditions aren't met:
```solidity
if (unallocated == 0) return;
```

This prevents reverts that don't provide coverage value.

### 3. Diverse Code Paths
Three handlers cover different scenarios:
- **Standard allocation**: New allocations to 1-2 initiatives
- **Reset + reallocation**: Exercises reset logic
- **Single allocation**: Simplified, high-success-rate path

### 4. Mutually Exclusive Vote/Veto
All handlers ensure either vote OR veto is set, never both:
```solidity
if (!useVeto) {
    absoluteLQTYVotes[0] = int256(voteAmount);
    absoluteLQTYVetos[0] = 0;
} else {
    absoluteLQTYVotes[0] = 0;
    absoluteLQTYVetos[0] = int256(voteAmount);
}
```

This satisfies `_requireNoSimultaneousVoteAndVeto()` validation.

## Compilation Status

✓ Code compiles successfully with no errors
✓ All new handlers follow the clamping conventions
✓ Handlers call unclamped base functions as required

## Next Steps

1. Run Echidna for 2 hours with the improved handlers
2. Analyze coverage report to verify improvements
3. Check if validation functions and math operations are now covered
4. Assess any remaining gaps

## Files Modified

- `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/test/recon/targets/GovernanceTargets.sol`
  - Improved `governance_allocateLQTY_clamped`
  - Added `governance_allocateLQTY_reset_clamped`
  - Added `governance_allocateLQTY_single_clamped`

## Success Criteria

This iteration will be considered successful if the 2-hour Echidna run shows:

1. Coverage of `_requireNoNOP()` function
2. Coverage of `_requireNoSimultaneousVoteAndVeto()` function
3. Coverage of `_requireNoNegatives()` function
4. Coverage of `add()` and `sub()` functions in Math.sol
5. Coverage of state update lines 747-752 and 798-806 in `allocateLQTY()`

The improvements specifically target the 10 HIGH-priority gaps identified in Phase 5 analysis.
