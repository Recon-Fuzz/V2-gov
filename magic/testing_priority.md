# Testing Priority

These functions are ranked in order of how they should be implemented in unit tests. When creating unit tests for `CryticToFoundry` test each of the functions in this order.

1. `governance_deployUserProxy`
   - no prerequisite

2. `governance_calculateVotingThreshold`
   - no prerequisite

3. `governance_getInitiativeState`
   - no prerequisite

4. `bribeInitiative_depositBribe`
   - no prerequisite

5. `governance_depositLQTY`
   - deployUserProxy must be called first

6. `governance_depositLQTYViaPermit`
   - deployUserProxy must be called first

7. `governance_withdrawLQTY`
   - depositLQTY must be called first

8. `governance_allocateLQTY`
   - depositLQTY must be called first

9. `governance_registerInitiative`
   - depositLQTY must be called first

10. `governance_unregisterInitiative`
    - registerInitiative must be called first

11. `governance_claimFromStakingV1`
    - stake in V1 must exist

12. `governance_resetAllocations`
    - depositLQTY must be called first
    - allocateLQTY must be called first

13. `governance_snapshotVotesForInitiative`
    - registerInitiative must be called first
    - allocateLQTY must be called first

14. `bribeInitiative_claimBribes`
    - depositBribe must be called first
    - allocateLQTY must be called first

15. `governance_claimForInitiative`
    - snapshotVotesForInitiative must be called first

16. `governance_multiDelegateCall`
    - depends on what calls are made