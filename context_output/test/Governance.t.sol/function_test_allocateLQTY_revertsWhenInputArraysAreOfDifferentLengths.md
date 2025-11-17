# Function: test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths()

**Contract**: [test/Governance.t.sol/contract_ForkedGovernanceTest.md]

## Metadata

- **Contract**: ForkedGovernanceTest
- **Signature**: `test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths()`
- **Visibility**: external
- **Source Range**: 39821:784:99
- **Inherited From**: GovernanceTest

## Implementation

```solidity
function test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths() external {
    address[] memory initiativesToReset = new address[](0);
    address[][2] memory initiatives = [new address[](2), new address[](3)];
    int256[][2] memory votes = [new int256[](2), new int256[](3)];
    int256[][2] memory vetos = [new int256[](2), new int256[](3)];
    for (uint256 i = 0; i < 2; ++i) {
        for (uint256 j = 0; j < 2; ++j) {
            for (uint256 k = 0; k < 2; ++k) {
                if ((i == j) && (j == k)) continue;
                vm.expectRevert("Governance: array-length-mismatch");
                governance.allocateLQTY(initiativesToReset, initiatives[i], votes[j], vetos[k]);
            }
        }
    }
}
```

## External Calls

- **Vm::expectRevert(bytes)**
- **GovernanceTester::allocateLQTY(address[],address[],int256[],int256[])**

## State Variable Reads

- **governance** (`contract GovernanceTester`) [test/Governance.t.sol/contract_GovernanceTester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GovernanceTest.test_allocateLQTY_revertsWhenInputArraysAreOfDifferentLengths() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
