# Dictionary Entries for Clamped Handlers - Phase 4

This document lists all meaningful values from the Setup contract, source contracts, and system configuration that should be used for clamping handler functions in Phase 4.

## Configuration Constants from Setup.sol

### Token Balances
- `INITIAL_LQTY_AMOUNT = 1000000e18` - Initial LQTY minted to each actor
- Initial stake per actor: `10000e18` - LQTY staked during setup

### Governance Configuration (from Setup.sol)
- `REGISTRATION_FEE = 1000e18` - Fee required to register an initiative
- `REGISTRATION_THRESHOLD_FACTOR = 0.01e18` - 1% of total votes
- `UNREGISTRATION_THRESHOLD_FACTOR = 4e18` - 400% of voting threshold
- `UNREGISTRATION_AFTER_EPOCHS = 4` - Epochs before unregistration possible
- `VOTING_THRESHOLD_FACTOR = 0.04e18` - 4% of total votes
- `MIN_CLAIM = 500e18` - Minimum claimable BOLD amount
- `MIN_ACCRUAL = 1000e18` - Minimum BOLD accrual for distribution
- `EPOCH_DURATION = 604800` - 1 week in seconds
- `EPOCH_VOTING_CUTOFF = 518400` - 6 days in seconds

## Dynamic Values from Setup

### Actors
- 3 actors created: `address(0x100)`, `address(0x200)`, `address(0x300)`
- Accessed via `_getActor()` from ActorManager

### Deployed Initiatives
- `bribeInitiative` - First BribeInitiative instance
- `bribeInitiative2` - Second BribeInitiative instance
- Both registered in `registeredInitiatives` mapping at epoch 1

### Token Addresses
- `lqty` - Governance token
- `lusd` - Legacy staking reward token
- `bold` - Governance reward token and registration fee token
- `bribeToken` - First bribe token
- `lqty` (reused) - Second bribe token for bribeInitiative2

## Important Values for Clamping

### For depositLQTY / withdrawLQTY
- Clamp `_lqtyAmount` by: `lqty.balanceOf(actor)` for deposits
- Clamp `_lqtyAmount` by: `userStates[actor].unallocatedLQTY` for withdrawals
- Maximum realistic deposit: `INITIAL_LQTY_AMOUNT` per actor

### For allocateLQTY
- Clamp arrays to reasonable lengths: 1-3 initiatives (avoid gas issues)
- Clamp `_absoluteLQTYVotes` by: `userStates[actor].unallocatedLQTY`
- Clamp `_absoluteLQTYVetos` by: `userStates[actor].unallocatedLQTY`
- Use deployed initiatives: `[address(bribeInitiative), address(bribeInitiative2)]`

### For registerInitiative
- Requires `REGISTRATION_FEE` (1000e18 BOLD) - ensure actor has sufficient balance
- Can only register after epoch 2: `epoch() > 2`
- Initiative must not already be registered

### For depositBribe
- Clamp `_boldAmount` by: `bold.balanceOf(actor)`
- Clamp `_bribeTokenAmount` by: `bribeToken.balanceOf(actor)` or `lqty.balanceOf(actor)`
- Clamp `_epoch` to current or future epochs: `epoch()` to `epoch() + 10`

### For claimBribes
- Requires proper ClaimData structure with:
  - `_user`: actor address
  - `_epoch`: past epoch (< current epoch)
  - `_prevLQTYAllocationEpoch`: valid allocation epoch
  - `_prevTotalLQTYAllocationEpoch`: valid total allocation epoch

## Clamping Strategy

### Amounts
- Always use modulo to constrain to available balance
- Add +1 when you want to allow maximum value to be included
- Example: `amount %= token.balanceOf(actor) + 1`

### Addresses
- Always use `_getActor()` for user addresses
- Use deployed initiative addresses from Setup for initiative parameters
- Never use random addresses

### Arrays
- Keep array lengths small (1-3 elements) to avoid gas issues
- Ensure parallel arrays have matching lengths
- Use deployed initiatives for initiative arrays

### Epochs
- Current epoch accessed via `governance.epoch()`
- Clamp past epochs: `(epoch % currentEpoch)`
- Clamp future epochs: `currentEpoch + (epoch % 10)`

## Functions Requiring Clamped Handlers

Based on the Phase 3 analysis, all 16 handler functions have line coverage. However, clamped handlers will help achieve deeper state coverage by:

1. **Reducing reverts** - Clamping amounts to valid ranges reduces wasted fuzzing iterations
2. **Exploring edge cases** - Clamping to exact boundaries (0, max, half) explores critical paths
3. **Achieving meaningful state transitions** - Ensuring valid parameters allows the fuzzer to reach deeper contract states

### Priority Handlers for Clamping

1. **governance_depositLQTY** - Clamp amount to actor balance
2. **governance_withdrawLQTY** - Clamp amount to unallocated LQTY
3. **governance_allocateLQTY** - Clamp arrays and amounts to valid initiatives and balances
4. **governance_registerInitiative** - Ensure sufficient BOLD balance for registration fee
5. **bribeInitiative_depositBribe** - Clamp amounts to token balances and epoch to valid range
6. **bribeInitiative_claimBribes** - Construct valid ClaimData with proper epochs

### Handlers Not Requiring Clamping

These handlers are already simple enough for Echidna to explore effectively:
- **governance_deployUserProxy** - No parameters
- **governance_calculateVotingThreshold** - No parameters
- **governance_getInitiativeState** - Address parameter (use deployed initiative)
- **governance_claimFromStakingV1** - Address parameter (use actor)
- **governance_snapshotVotesForInitiative** - Address parameter (use deployed initiative)
- **governance_unregisterInitiative** - Requires specific state (initiative must be unregisterable)
- **governance_resetAllocations** - Array of initiatives (similar to allocateLQTY but simpler)
- **governance_multiDelegateCall** - Complex bytes array (may not benefit from clamping)

## Notes

- All clamped handlers MUST call the corresponding unclamped handler
- Clamped handlers MUST use the `_clamped` postfix
- Never use hardcoded values unless they have special meaning in the codebase
- Never include require statements or early returns in clamped handlers
- Under-clamping is preferred to over-clamping (leave some randomness)
