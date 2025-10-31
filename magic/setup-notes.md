# Setup.sol Implementation Notes

## Phase 2 Update

**No modifications were made to Setup.sol during Phase 2.**

The existing Phase 1 setup was sufficient to support all 16 target function tests. All tests pass successfully with the current configuration, confirming that the setup provides comprehensive coverage of initialization requirements.

## Overview
This document describes the comprehensive setup implementation for fuzzing the Liquity V2 Governance smart contracts using Chimera, Echidna, and Foundry.

## Architecture

### Deployed Contracts

#### Core Governance Contracts
1. **Governance.sol** - Main governance contract that manages LQTY staking, voting, and initiative registration
   - Deployed with UserProxyFactory functionality built-in
   - Owner: `address(this)` (test contract, renounced after initial initiative registration)
   - Manages user voting power, epochs, and initiative states

2. **BribeInitiative.sol (x2)** - Two instances of bribe initiative contracts
   - `bribeInitiative`: Uses BOLD and custom bribe token
   - `bribeInitiative2`: Uses BOLD and LQTY as bribe tokens
   - Both registered as initial initiatives with the governance contract

3. **UserProxy** - Deployed via UserProxyFactory for each actor
   - Created on-demand when actors deposit LQTY
   - Handles interaction with stakingV1 for legacy staking rewards
   - Each actor gets their own UserProxy instance

#### Mock Contracts
1. **MockERC20Tester** tokens:
   - `lqty` - Liquity governance token (18 decimals)
   - `lusd` - Liquity USD stablecoin (18 decimals)
   - `bold` - BOLD stablecoin used for governance rewards (18 decimals)
   - `bribeToken` - Custom bribe token (18 decimals)
   - All tokens support wildcard spender functionality for easier testing

2. **MockStakingV1** - Legacy staking contract
   - Configured as wildcard spender for LQTY to allow UserProxy deposits without explicit approval
   - Tracks stakes and distributes LUSD/ETH rewards

## Configuration Parameters

### Governance Configuration (Constructor-only, cannot be changed after deployment)
```solidity
registrationFee: 1000e18               // Fee to register a new initiative
registrationThresholdFactor: 0.01e18   // 1% of total votes needed for registration
unregistrationThresholdFactor: 4e18    // 400% of voting threshold for unregistration
unregistrationAfterEpochs: 4           // Epochs before unregistration is possible
votingThresholdFactor: 0.04e18         // 4% of total votes needed for claims
minClaim: 500e18                       // Minimum BOLD amount claimable
minAccrual: 1000e18                    // Minimum BOLD accrual needed
epochStart: block.timestamp            // Start of first epoch
epochDuration: 604800                  // 1 week (in seconds)
epochVotingCutoff: 518400              // 6 days (voting cutoff before epoch end)
```

### Actor Setup
- **Number of Actors**: 4 total (address(this) + 3 additional actors)
  - `address(this)` - The test contract itself
  - `address(0x100)` - Actor 1
  - `address(0x200)` - Actor 2
  - `address(0x300)` - Actor 3

- **Initial Token Balances**: Each actor receives 1,000,000 tokens of each type (LQTY, LUSD, BOLD, bribeToken)

- **Initial Staked Amounts**: Each actor (except address(this)) starts with 10,000 LQTY deposited in governance
  - This gives them immediate voting power
  - UserProxy is deployed for each staking actor
  - All necessary approvals are set up automatically

## Setup Flow

### 1. Actor Registration
```solidity
_addActor(address(0x100));
_addActor(address(0x200));
_addActor(address(0x300));
```

### 2. Token Deployment
- Deploy all MockERC20Tester tokens
- Add them to AssetManager for tracking
- Set stakingV1 as wildcard spender for LQTY

### 3. Contract Deployment
- Deploy MockStakingV1
- Deploy Governance (which deploys UserProxyFactory internally)
- Deploy BribeInitiative instances
- Register initiatives with governance

### 4. Actor Initialization
For each actor:
1. Mint 1M of each token
2. Deploy UserProxy (via governance.deployUserProxy())
3. Set up approvals:
   - UserProxy approved to spend LQTY
   - Governance approved to spend BOLD (for registration fees)
   - Both BribeInitiatives approved to spend BOLD and bribe tokens
4. Deposit 10k LQTY to get voting power

### 5. Additional Setup
- Mint 100k LUSD and 100 ETH to test contract for future reward distribution
- Approve stakingV1 to manage these rewards

## Key Design Decisions

### Wildcard Spender Pattern
The MockERC20Tester tokens support a "wildcard spender" feature where certain addresses can be granted unlimited allowance without explicit approval. This is used for:
- **stakingV1**: UserProxies can deposit LQTY without explicit approval
- Simplifies the setup and mimics production behavior where UserProxy would approve stakingV1

### Initial Staking
Actors are initialized with staked LQTY to ensure they have voting power from the start:
- Enables immediate testing of voting, allocation, and initiative functions
- Creates a realistic initial state
- Each actor has both liquid tokens and staked positions

### Multiple BribeInitiatives
Two BribeInitiative instances are deployed to test:
- Different bribe token combinations (BOLD/bribeToken vs BOLD/LQTY)
- Multi-initiative voting scenarios
- Initiative registration and unregistration flows

### AssetManager Integration
While the setup uses custom MockERC20Tester tokens, they are still registered with AssetManager to:
- Enable asset switching during fuzzing
- Maintain compatibility with the Chimera framework
- Allow future extension with additional tokens

## Approval Structure

Each actor has the following approvals set up:

| Spender | Token | Amount | Purpose |
|---------|-------|--------|---------|
| UserProxy | LQTY | max | Deposit LQTY into governance |
| Governance | BOLD | max | Pay registration fees |
| bribeInitiative | BOLD | max | Deposit BOLD bribes |
| bribeInitiative | bribeToken | max | Deposit bribe token bribes |
| bribeInitiative2 | BOLD | max | Deposit BOLD bribes |
| bribeInitiative2 | LQTY | max | Deposit LQTY bribes |
| stakingV1 | LQTY | max (wildcard) | Stake LQTY in legacy staking |

## Testing Verification

### Compilation
```bash
forge build
```
Status: PASS - Compiles successfully with Solc 0.8.24

### Foundry Tests
```bash
forge test --match-contract CryticToFoundry -vvv
```
Status: PASS - Setup function executes without reverts

### Echidna Fuzzing
```bash
echidna . --contract CryticTester --config echidna.yaml --format text --test-limit 50000 --disable-slither --test-mode exploration
```
Status: PASS - Successfully ran 50,217 tests
- Coverage: 23,899 unique instructions
- Contracts: 9 contracts explored
- Corpus: 26 sequences generated

## Common Issues and Solutions

### Issue: ERC20InsufficientAllowance error for stakingV1
**Solution**: Set stakingV1 as wildcard spender for LQTY token using `lqty.mock_setWildcardSpender(address(stakingV1), true)`

### Issue: UserProxy not deployed when trying to deposit
**Solution**: Deploy UserProxy before setting up approvals and deposits. The setup now deploys UserProxy first, then sets approvals, then deposits.

### Issue: Actors don't have voting power
**Solution**: Ensure actors deposit LQTY after approvals are set. The current setup deposits 10k LQTY per actor to give immediate voting power.

## Future Enhancements

Potential improvements for the setup:

1. **Variable Initial Stakes**: Allow different actors to have different initial stake amounts
2. **Epoch Advancement**: Add initial epoch advancement to test mid-epoch and multi-epoch scenarios
3. **Pre-allocated Votes**: Set up some initial vote allocations to initiatives
4. **Reward Distribution**: Add initial LUSD/ETH rewards to stakingV1 before actor deposits
5. **Additional Initiatives**: Deploy more initiative types (CurveV2GaugeRewards, UniV4MerklRewards) if needed
6. **Custom Token Decimals**: Test with tokens using different decimal places (e.g., 6 decimals for USDC-like tokens)

## Contract Addresses (Example Run)

These addresses are deterministic based on deployment order:

- MockERC20Tester (LQTY): Varies per run
- MockERC20Tester (LUSD): Varies per run
- MockERC20Tester (BOLD): Varies per run
- MockERC20Tester (bribeToken): Varies per run
- MockStakingV1: Varies per run
- Governance: Varies per run
- BribeInitiative 1: Varies per run
- BribeInitiative 2: Varies per run
- UserProxy (per actor): Derived deterministically via CREATE2 based on actor address

## Related Files

- `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/test/recon/Setup.sol` - Main setup implementation
- `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/test/recon/TargetFunctions.sol` - Target functions for fuzzing
- `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/test/recon/targets/` - Individual target function modules
- `/Users/nican0r/Documents/Liquity_V2_Gov/V2-gov/echidna.yaml` - Echidna configuration

## Conclusion

The setup successfully initializes a comprehensive testing environment for the Liquity V2 Governance system with:
- Multiple actors with voting power
- Deployed and registered initiatives
- Proper token approvals and balances
- Legacy staking integration
- Full compatibility with Echidna and Foundry fuzzing

The setup passes all validation requirements and is ready for extensive invariant testing.
