# Remaining Uncovered Functions

This file tracks functions and code paths that lack coverage in the most recent Echidna fuzzing run (covered.1761813285.txt from Oct 30 01:34).

## Coverage Analysis Summary

**Latest Coverage Report**: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/echidna/covered.1761813285.txt`
**Report Generated**: October 30, 2025 at 01:34
**Analysis Date**: October 30, 2025 at 19:50
**Phase**: Phase 5 - Second Coverage Assessment
**Status**: NO PROGRESS - Same 29 functions remain uncovered

## Core Contracts

### Governance.sol

#### Uncovered Functions
1. **`_requireNoNOP(int256[] memory, int256[] memory)`** (Line 928)
   - **Purpose**: Validates that at least one vote or veto is non-zero for each initiative
   - **Called from**: `allocateLQTY()` at line 603
   - **Impact**: HIGH - This is a critical validation function that prevents no-op allocations
   - **Status**: NOT COVERED (line 603 shows no `*` prefix)

2. **`_requireNoSimultaneousVoteAndVeto(int256[] memory, int256[] memory)`** (Line 934)
   - **Purpose**: Validates that users cannot vote and veto the same initiative simultaneously
   - **Called from**: `allocateLQTY()` at line 604
   - **Impact**: HIGH - This is a critical validation function preventing conflicting allocations
   - **Status**: NOT COVERED (line 604 shows no `*` prefix)

#### Partially Covered Code Paths in allocateLQTY()
The following lines in `allocateLQTY()` are NOT covered (missing `*` prefix):
- Lines 600-604: Validation checks including `_requireNoNegatives()`, `_requireNoNOP()`, `_requireNoSimultaneousVoteAndVeto()`
- Lines 747-752: Adding votes/vetos to initiative state using `add()` function
- Lines 798-806: Updating user's allocated/unallocated LQTY and offset using `add()`/`sub()` functions

**Root Cause**: The `allocateLQTY()` handler is not reaching these specific code paths, suggesting:
1. The clamped handler may be bypassing these validation checks
2. The fuzzer is not generating inputs that trigger allocation updates

### BribeInitiative.sol

#### Uncovered Functions
1. **`totalLQTYAllocatedByEpoch(uint256) external view`** (Line 56)
   - **Purpose**: View function to query total LQTY allocated by epoch
   - **Impact**: LOW - View function, not critical for state changes
   - **Status**: NOT COVERED

2. **`onUnregisterInitiative(uint256) external virtual`** (Line 167)
   - **Purpose**: Hook called when initiative is unregistered (empty implementation in base)
   - **Impact**: MEDIUM - Should be called during initiative lifecycle
   - **Status**: NOT COVERED

3. **`_setTotalLQTYAllocationByEpoch(uint256, uint256, uint256, bool) private`** (Line 169)
   - **Purpose**: Internal function to update total LQTY allocation tracking
   - **Impact**: HIGH - Core accounting function
   - **Status**: NOT COVERED

## Additional Initiative Implementations

### CurveV2GaugeRewards.sol

#### Uncovered Functions
1. **`onClaimForInitiative(uint256, uint256) external`** (Line 26)
   - **Purpose**: Hook that deposits claimed BOLD into Curve gauge
   - **Impact**: HIGH - Core functionality of this initiative type
   - **Status**: NOT COVERED - Initiative not deployed in Setup

2. **`_depositIntoGauge(uint256) internal`** (Line 30)
   - **Purpose**: Internal function to deposit BOLD into Curve gauge
   - **Impact**: HIGH - Core functionality
   - **Status**: NOT COVERED - Initiative not deployed in Setup

**Note**: CurveV2GaugeRewards is not deployed in current Setup.sol, so these functions cannot be covered without deploying the contract and adding handlers.

### UniV4MerklRewards.sol

#### Uncovered Functions
1. **`getCampaignData() external view`** (Line 71)
   - **Purpose**: View function to get campaign configuration
   - **Impact**: LOW - View function
   - **Status**: NOT COVERED - Initiative not deployed in Setup

2. **`onRegisterInitiative(uint256) external`** (Line 100)
   - **Purpose**: Hook called on registration (empty implementation)
   - **Impact**: LOW - Empty implementation
   - **Status**: NOT COVERED - Initiative not deployed in Setup

3. **`onUnregisterInitiative(uint256) external`** (Line 104)
   - **Purpose**: Hook called on unregistration (empty implementation)
   - **Impact**: LOW - Empty implementation
   - **Status**: NOT COVERED - Initiative not deployed in Setup

4. **`onAfterAllocateLQTY(...) external`** (Line 112)
   - **Purpose**: Hook called after LQTY allocation (empty implementation)
   - **Impact**: LOW - Empty implementation
   - **Status**: NOT COVERED - Initiative not deployed in Setup

5. **`onClaimForInitiative(uint256, uint256) external`** (Line 124)
   - **Purpose**: Hook that creates Merkl distribution campaign
   - **Impact**: HIGH - Core functionality of this initiative type
   - **Status**: NOT COVERED - Initiative not deployed in Setup

6. **`_createCampaign(uint256) internal`** (Line 126)
   - **Purpose**: Internal function to create Merkl campaign
   - **Impact**: HIGH - Core functionality
   - **Status**: NOT COVERED - Initiative not deployed in Setup

7. **`claimForInitiative() external`** (Line 151)
   - **Purpose**: External wrapper to claim and create campaign
   - **Impact**: HIGH - Core functionality
   - **Status**: NOT COVERED - Initiative not deployed in Setup

**Note**: UniV4MerklRewards is not deployed in current Setup.sol, so these functions cannot be covered without deploying the contract and adding handlers.

## Utility Contracts

### Math.sol

#### Uncovered Functions
1. **`add(uint256, int256) pure`** (Line 4)
   - **Purpose**: Add signed int to unsigned int
   - **Called from**: Governance.sol multiple times (lines 747-752, 804-806)
   - **Impact**: HIGH - Core math operation used in allocations
   - **Status**: NOT COVERED (caller lines show no `*` prefix)

2. **`sub(uint256, int256) pure`** (Line 11)
   - **Purpose**: Subtract signed int from unsigned int
   - **Called from**: Governance.sol lines 798-800
   - **Impact**: HIGH - Core math operation used in allocations
   - **Status**: NOT COVERED (caller lines show no `*` prefix)

3. **`max(uint256, uint256) pure`** (Line 18)
   - **Purpose**: Return maximum of two values
   - **Called from**: Governance.sol line 298
   - **Impact**: LOW - Helper function
   - **Status**: COVERED (line 298 has `*` prefix)

4. **`abs(int256) pure`** (Line 22)
   - **Purpose**: Return absolute value
   - **Called from**: Math.sol internally by add/sub
   - **Impact**: MEDIUM - Used by other math functions
   - **Status**: NOT COVERED (depends on add/sub coverage)

### UniqueArray.sol

#### Uncovered Functions
1. **`_requireNoNegatives(int256[] memory) pure`** (Line 26)
   - **Purpose**: Validate array has no negative values
   - **Called from**: Governance.sol lines 600-601
   - **Impact**: HIGH - Critical validation function
   - **Status**: NOT COVERED (caller lines show no `*` prefix)

### DoubleLinkedList.sol

#### Uncovered Functions
All the following are view/getter functions with LOW impact:

1. **`getHead(Data storage) internal view`** (Line 27)
2. **`getTail(Data storage) internal view`** (Line 34)
3. **`getNext(Data storage, uint256) internal view`** (Line 42)
4. **`getPrev(Data storage, uint256) internal view`** (Line 50)
5. **`getLQTYAndOffset(Data storage, uint256) internal view`** (Line 59)
6. **`getItem(Data storage, uint256) internal view`** (Line 67)
7. **`contains(Data storage, uint256) internal view`** (Line 75)
8. **`should(Data storage, uint256, uint256, uint256) internal view`** (Line 82)
9. **`insert(Data storage, uint256, uint256, uint256, uint256) internal`** (Line 88)

**Note**: These are mostly view functions that provide read access to the linked list structure. The `insert` function is used by BribeInitiative's `_setTotalLQTYAllocationByEpoch` which is also uncovered.

## Summary of Critical Gaps

### High Priority (Core Functionality Not Covered)
1. **Governance.sol - allocateLQTY validation paths**: The fuzzer is reaching `allocateLQTY()` but not hitting the critical validation functions and state update logic
2. **Math.sol - add/sub functions**: Core arithmetic operations used in allocation logic
3. **UniqueArray.sol - _requireNoNegatives**: Critical validation function
4. **BribeInitiative.sol - _setTotalLQTYAllocationByEpoch**: Core accounting function

### Medium Priority (Lifecycle Hooks)
1. **BribeInitiative.sol - onUnregisterInitiative**: Should be called during initiative lifecycle
2. **BribeInitiative.sol - totalLQTYAllocatedByEpoch**: View function for state inspection

### Low Priority (View Functions & Empty Implementations)
1. **DoubleLinkedList.sol - Various getters**: View functions
2. **UniV4MerklRewards.sol - Empty hooks**: onRegisterInitiative, onUnregisterInitiative, onAfterAllocateLQTY

### Cannot Be Covered Without Deployment
1. **CurveV2GaugeRewards.sol - All functions**: Contract not deployed in Setup
2. **UniV4MerklRewards.sol - All functions**: Contract not deployed in Setup

## Recommendations for Phase 4 Iteration

### Fix allocateLQTY_clamped Handler
The primary issue is that `allocateLQTY_clamped` is not triggering the deeper code paths in `allocateLQTY()`. The handler needs to:
1. Generate inputs that pass the initial checks (array length matching, uniqueness)
2. Generate non-zero vote/veto values to trigger `_requireNoNOP` and `_requireNoSimultaneousVoteAndVeto`
3. Generate valid allocation state that triggers the `add()`/`sub()` operations on lines 747-752 and 798-806

### Deploy Additional Initiatives (Optional)
If full coverage is required:
1. Deploy CurveV2GaugeRewards in Setup.sol with mock Curve gauge
2. Deploy UniV4MerklRewards in Setup.sol with mock Merkl integration
3. Add handlers for these contracts

### Add Targeted Test Cases
Consider adding specific handlers that:
1. Call `allocateLQTY` with arrays that trigger all validation paths
2. Call `unregisterInitiative` to trigger the `onUnregisterInitiative` hook
3. Query view functions to ensure they're exercised

## Coverage Metrics

**Total Functions Identified as Uncovered**: 29
- **HIGH Impact**: 10 functions
- **MEDIUM Impact**: 2 functions
- **LOW Impact**: 17 functions (mostly view functions)

**Functions Requiring Deployment**: 9 (CurveV2GaugeRewards + UniV4MerklRewards)
**Functions Requiring Handler Fixes**: 10 (Governance validation + Math + UniqueArray)
**Functions Nice-to-Have**: 10 (View functions + empty hooks)
