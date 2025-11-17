# Function: test_bribeToken_cannot_be_BOLD()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_bribeToken_cannot_be_BOLD()`
- **Visibility**: external
- **Source Range**: 3347:245:92

## Implementation

```solidity
function test_bribeToken_cannot_be_BOLD() external {
    vm.expectRevert("BribeInitiative: bribe-token-cannot-be-bold");
    new BribeInitiative({_governance: address(governance), _bold: address(lusd), _bribeToken: address(lusd)});
}
```

## External Calls

- **Vm::expectRevert(bytes)**

## State Variable Reads

- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_bribeToken_cannot_be_BOLD() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
