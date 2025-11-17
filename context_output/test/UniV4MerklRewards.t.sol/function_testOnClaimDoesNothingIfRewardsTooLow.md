# Function: testOnClaimDoesNothingIfRewardsTooLow()

**Contract**: [test/UniV4MerklRewards.t.sol/contract_UniV4MerklE2ETests.md]

## Metadata

- **Contract**: UniV4MerklE2ETests
- **Signature**: `testOnClaimDoesNothingIfRewardsTooLow()`
- **Visibility**: external
- **Source Range**: 3149:326:104

## Implementation

```solidity
function testOnClaimDoesNothingIfRewardsTooLow() external {
    governance.claimForInitiative(address(uniV4MerklRewardsInitiative));
    assertEq(boldToken.balanceOf(address(merklDistributionCreator.distributor())), 0, "Merkl Distributor should not have any BOLD");
}
```

## Related Implementations

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Governance::claimForInitiative(address)**
- **IERC20::balanceOf(address)**
- **IDistributionCreator::distributor()**

## State Variable Reads

- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **uniV4MerklRewardsInitiative** (`contract UniV4MerklRewards`) [src/UniV4MerklRewards.sol/contract_UniV4MerklRewards.md]
- **boldToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **merklDistributionCreator** (`contract IDistributionCreator`) [src/interfaces/IDistributionCreator.sol/interface_IDistributionCreator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklE2ETests.testOnClaimDoesNothingIfRewardsTooLow() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 1)
      💬 Args: [boldToken.balanceOf(address(merklDistributionCreator.distributor())), 0, "Merkl Distributor should not have any BOLD"]
      👁️  Def: internal
```
