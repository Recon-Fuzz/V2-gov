# Handler Redesign Summary - Phase 4

## Critical Issue Identified

The `allocateLQTY` function in Governance.sol has a strict requirement at line 611:
```solidity
require(userState.allocatedLQTY == 0, "must be a reset");
```

This means EVERY call to `allocateLQTY()` must include a reset of ALL existing allocations.

## Root Cause

**Problem**: Original handlers were returning early when actors had allocated LQTY
- First call: Actor allocates successfully (allocatedLQTY becomes > 0)
- Second call: Handler sees unallocatedLQTY == 0, returns early
- Result: Validation and state update code never executed

**Why it failed**:
```solidity
// OLD BROKEN PATTERN
if (unallocated == 0) return; // ❌ Misses that we need to RESET first!
```

## Solution

**Key Insight**: Always reset existing allocations, then total available = unallocated + allocated

```solidity
// NEW WORKING PATTERN
uint256 totalAvailable = unallocated + allocated; // ✅ Account for BOTH
if (totalAvailable == 0) return;

// ALWAYS reset first
address[] memory initiativesToReset = _buildResetArray(actor);

// Then allocate from totalAvailable
voteAmount = (voteAmount % totalAvailable) + 1;
```

## Handler Changes

### 1. Added Helper Function

**Purpose**: Build reset array by querying actual allocations

```solidity
function _buildResetArray(address actor) internal view returns (address[] memory) {
    uint256 resetCount = 0;
    address[] memory tempReset = new address[](2);

    // Check initiative 1
    (uint256 vote1,,,,uint256 veto1) = governance.lqtyAllocatedByUserToInitiative(actor, address(bribeInitiative));
    if (vote1 > 0 || veto1 > 0) {
        tempReset[resetCount++] = address(bribeInitiative);
    }

    // Check initiative 2
    (uint256 vote2,,,,uint256 veto2) = governance.lqtyAllocatedByUserToInitiative(actor, address(bribeInitiative2));
    if (vote2 > 0 || veto2 > 0) {
        tempReset[resetCount++] = address(bribeInitiative2);
    }

    // Return properly sized array
    address[] memory result = new address[](resetCount);
    for (uint256 i = 0; i < resetCount; i++) {
        result[i] = tempReset[i];
    }
    return result;
}
```

### 2. Redesigned governance_allocateLQTY_clamped()

**Before**:
```solidity
function governance_allocateLQTY_clamped(...) public asActor {
    (uint256 unallocated,,,) = governance.userStates(actor);
    if (unallocated == 0) return; // ❌ Problem!

    address[] memory initiativesToReset = new address[](0); // ❌ Never resets!
    // ... allocate
}
```

**After**:
```solidity
function governance_allocateLQTY_clamped(
    uint256 voteAmount,
    bool useVeto,
    bool useInitiative2
) public asActor {
    address actor = _getActor();
    (uint256 unallocated, uint256 allocated,,) = governance.userStates(actor);

    if (unallocated + allocated == 0) return; // ✅ Check total

    // ✅ ALWAYS reset first
    address[] memory initiativesToReset = _buildResetArray(actor);

    // ✅ Use total available
    uint256 totalAvailable = unallocated + allocated;

    address[] memory initiatives = new address[](1);
    initiatives[0] = useInitiative2 ? address(bribeInitiative2) : address(bribeInitiative);

    int256[] memory absoluteLQTYVotes = new int256[](1);
    int256[] memory absoluteLQTYVetos = new int256[](1);

    // ✅ Ensure non-zero from totalAvailable
    voteAmount = (voteAmount % totalAvailable) + 1;

    absoluteLQTYVotes[0] = useVeto ? int256(0) : int256(voteAmount);
    absoluteLQTYVetos[0] = useVeto ? int256(voteAmount) : int256(0);

    governance_allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
}
```

### 3. Added governance_allocateLQTY_multi_clamped()

**Purpose**: Test multi-initiative allocation paths

```solidity
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

    // Split amounts ensuring both can be non-zero
    uint256 amount1 = ((seed1 % totalAvailable) / 2) + 1;
    if (amount1 > totalAvailable / 2) amount1 = totalAvailable / 2;

    uint256 remaining = totalAvailable - amount1;
    uint256 amount2 = remaining > 0 ? ((seed2 % remaining) + 1) : 0;
    if (amount2 > remaining) amount2 = remaining;

    absoluteLQTYVotes[0] = useVeto1 ? int256(0) : int256(amount1);
    absoluteLQTYVetos[0] = useVeto1 ? int256(amount1) : int256(0);

    absoluteLQTYVotes[1] = useVeto2 ? int256(0) : int256(amount2);
    absoluteLQTYVetos[1] = useVeto2 ? int256(amount2) : int256(0);

    governance_allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
}
```

### 4. Added governance_allocateLQTY_resetOnly_clamped()

**Purpose**: Test reset-only path (no reallocation)

```solidity
function governance_allocateLQTY_resetOnly_clamped() public asActor {
    address actor = _getActor();
    (, uint256 allocated,,) = governance.userStates(actor);

    if (allocated == 0) return;

    address[] memory initiativesToReset = _buildResetArray(actor);
    if (initiativesToReset.length == 0) return;

    // Empty arrays for new allocations - just reset
    address[] memory initiatives = new address[](0);
    int256[] memory absoluteLQTYVotes = new int256[](0);
    int256[] memory absoluteLQTYVetos = new int256[](0);

    governance_allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
}
```

## Key Design Patterns

### 1. Reset-First Pattern
```solidity
// ALWAYS build reset array first
address[] memory initiativesToReset = _buildResetArray(actor);
```

### 2. Total Available Pattern
```solidity
// Account for BOTH unallocated and allocated LQTY
uint256 totalAvailable = unallocated + allocated;
```

### 3. Non-Zero Guarantee Pattern
```solidity
// Modulo + 1 ensures non-zero amounts
voteAmount = (voteAmount % totalAvailable) + 1;
```

### 4. Proper Precondition Check
```solidity
// Check total, not just unallocated
if (unallocated + allocated == 0) return;
```

## Results

### Coverage Improvements
- **Math.sol**: 0% → 100% ✅
- **Validation functions**: 0% → 100% ✅
- **State update logic**: 0% → 100% ✅
- **Total instructions**: 25,731 → 33,401 (+30%) ✅

### Functions Now Covered
1. ✅ `_requireNoNOP()` - Governance.sol:928
2. ✅ `_requireNoNegatives()` - UniqueArray.sol:26
3. ✅ `_requireNoSimultaneousVoteAndVeto()` - Governance.sol:934
4. ✅ `add()` - Math.sol:4
5. ✅ `sub()` - Math.sol:11
6. ✅ `abs()` - Math.sol:22
7. ✅ `_setTotalLQTYAllocationByEpoch()` - BribeInitiative.sol:168
8. ✅ All state update lines in `_allocateLQTY()` - Governance.sol:747-806

## Lessons Learned

1. **Read Contract Requirements**: The `require(userState.allocatedLQTY == 0)` line was the key
2. **Check Coverage Reports**: Early returns prevent deep coverage
3. **Design for Preconditions**: Handlers must satisfy ALL function preconditions
4. **Query Actual State**: Use contract state queries to build proper inputs
5. **Avoid Early Returns**: Use modulo clamping instead of if-return patterns

## Stack Depth Optimization

**Problem**: Original multi handler had "stack too deep" error

**Solution**: Extract reset logic into helper function
```solidity
// Instead of inline reset logic in every handler
address[] memory initiativesToReset = _buildResetArray(actor); // ✅ Reuse helper
```

## Files Modified

- **File**: `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/test/recon/targets/GovernanceTargets.sol`
- **Changes**:
  - Added `_buildResetArray()` helper
  - Redesigned `governance_allocateLQTY_clamped()`
  - Added `governance_allocateLQTY_multi_clamped()`
  - Added `governance_allocateLQTY_resetOnly_clamped()`
  - Added `governance_unregisterInitiative_clamped()`
  - Removed old broken handlers

## Testing Verification

**Command Used**:
```bash
echidna . --contract CryticTester --config echidna.yaml --format text --timeout 7200 --test-limit 99999999999999999999 --disable-slither
```

**Duration**: 2 hours 1 minute

**Results**:
- ✅ Compilation successful
- ✅ All handlers executed
- ✅ Coverage increased 30%
- ✅ All critical functions covered
