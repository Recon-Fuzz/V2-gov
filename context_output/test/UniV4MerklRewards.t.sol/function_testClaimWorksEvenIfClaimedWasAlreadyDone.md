# Function: testClaimWorksEvenIfClaimedWasAlreadyDone()

**Contract**: [test/UniV4MerklRewards.t.sol/contract_UniV4MerklE2ETests.md]

## Metadata

- **Contract**: UniV4MerklE2ETests
- **Signature**: `testClaimWorksEvenIfClaimedWasAlreadyDone()`
- **Visibility**: external
- **Source Range**: 8391:2543:104

## Implementation

```solidity
function testClaimWorksEvenIfClaimedWasAlreadyDone() external {
    vm.startPrank(LQTY_WHALE);
    uint256 lqtyAmount = lqty.balanceOf(LQTY_WHALE);
    _deposit(lqtyAmount);
    _allocate(address(uniV4MerklRewardsInitiative), lqtyAmount, 0);
    vm.stopPrank();
    vm.warp(block.timestamp + 30 days);
    (, , uint256 claimableAmount) = governance.getInitiativeState(address(uniV4MerklRewardsInitiative));
    uint256 epochEnd = EPOCH_START + ((governance.epoch() - 1) * EPOCH_DURATION);
    IDistributionCreator.CampaignParameters memory params = IDistributionCreator.CampaignParameters({campaignId: bytes32(0), creator: address(uniV4MerklRewardsInitiative), rewardToken: address(boldToken), amount: claimableAmount, campaignType: uniV4MerklRewardsInitiative.CAMPAIGN_TYPE(), startTimestamp: uint32(epochEnd), duration: uint32(EPOCH_DURATION), campaignData: uniV4MerklRewardsInitiative.getCampaignData()});
    bytes32 campaignId = merklDistributionCreator.campaignId(params);
    governance.claimForInitiative(address(uniV4MerklRewardsInitiative));
    vm.expectRevert(IDistributionCreator.CampaignDoesNotExist.selector);
    merklDistributionCreator.campaignLookup(campaignId);
    uniV4MerklRewardsInitiative.claimForInitiative();
    assertGt(merklDistributionCreator.campaignLookup(campaignId), 0, "Campaign should have been created");
    IDistributionCreator.CampaignParameters memory campaign = merklDistributionCreator.campaign(campaignId);
    assertEq(campaign.creator, params.creator, "creator");
    assertEq(campaign.rewardToken, params.rewardToken, "rewardToken");
    assertEq(campaign.amount, (params.amount * 97) / 100, "amount minus fees");
    assertEq(campaign.campaignType, params.campaignType, "campaignType");
    assertEq(campaign.startTimestamp, params.startTimestamp, "startTimestamp");
    assertEq(campaign.duration, params.duration, "duration");
    assertEq(campaign.campaignData, params.campaignData, "campaignData");
    assertGt(boldToken.balanceOf(address(merklDistributionCreator.distributor())), 0, "Merkl Distributor should have some BOLD");
}
```

## Related Implementations

### _deposit(uint256)

- **Kind**: internal
- **Source**: 10940:190:104
- **Link**: `test/UniV4MerklRewards.t.sol:UniV4MerklE2ETests:_deposit(uint256)`

```solidity
function _deposit(uint256 amt) internal {
    address userProxy = governance.deployUserProxy();
    lqty.approve(address(userProxy), amt);
    governance.depositLQTY(amt);
}
```

### _allocate(address,uint256,uint256)

- **Kind**: internal
- **Source**: 11136:543:104
- **Link**: `test/UniV4MerklRewards.t.sol:UniV4MerklE2ETests:_allocate(address,uint256,uint256)`

```solidity
function _allocate(address initiative, uint256 votes, uint256 vetos) internal {
    address[] memory initiativesToReset;
    address[] memory initiatives = new address[](1);
    initiatives[0] = initiative;
    int256[] memory absoluteLQTYVotes = new int256[](1);
    absoluteLQTYVotes[0] = int256(votes);
    int256[] memory absoluteLQTYVetos = new int256[](1);
    absoluteLQTYVetos[0] = int256(vetos);
    governance.allocateLQTY(initiativesToReset, initiatives, absoluteLQTYVotes, absoluteLQTYVetos);
}
```

### assertGt(uint256,uint256,string)

- **Kind**: internal
- **Source**: 13228:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertGt(uint256,uint256,string)`

```solidity
function assertGt(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertGt(left, right, err);
}
```

### assertEq(address,address,string)

- **Kind**: internal
- **Source**: 3570:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(address,address,string)`

```solidity
function assertEq(address left, address right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertEq(uint256,uint256,string)

- **Kind**: internal
- **Source**: 2386:134:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(uint256,uint256,string)`

```solidity
function assertEq(uint256 left, uint256 right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

### assertEq(bytes,bytes,string)

- **Kind**: internal
- **Source**: 4626:144:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEq(bytes,bytes,string)`

```solidity
function assertEq(bytes memory left, bytes memory right, string memory err) virtual internal pure {
    vm.assertEq(left, right, err);
}
```

## External Calls

- **Vm::startPrank(address)**
- **IERC20::balanceOf(address)**
- **Vm::stopPrank()**
- **Vm::warp(uint256)**
- **Governance::getInitiativeState(address)**
- **Governance::epoch()**
- **UniV4MerklRewards::CAMPAIGN_TYPE()**
- **UniV4MerklRewards::getCampaignData()**
- **IDistributionCreator::campaignId(struct IDistributionCreator.CampaignParameters)**
- **Governance::claimForInitiative(address)**
- **Vm::expectRevert(bytes4)**
- **IDistributionCreator::campaignLookup(bytes32)**
- **UniV4MerklRewards::claimForInitiative()**
- **IDistributionCreator::campaign(bytes32)**
- **IDistributionCreator::distributor()**

## State Variable Reads

- **LQTY_WHALE** (`address`)
- **lqty** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **uniV4MerklRewardsInitiative** (`contract UniV4MerklRewards`) [src/UniV4MerklRewards.sol/contract_UniV4MerklRewards.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **EPOCH_START** (`uint256`)
- **EPOCH_DURATION** (`uint256`)
- **boldToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **merklDistributionCreator** (`contract IDistributionCreator`) [src/interfaces/IDistributionCreator.sol/interface_IDistributionCreator.md]
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: UniV4MerklE2ETests.testClaimWorksEvenIfClaimedWasAlreadyDone() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: UniV4MerklE2ETests._deposit(uint256) (NodeID: 1)
  │   💬 Args: [lqtyAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UniV4MerklE2ETests._allocate(address,uint256,uint256) (NodeID: 2)
  │   💬 Args: [address(uniV4MerklRewardsInitiative), lqtyAmount, 0]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [merklDistributionCreator.campaignLookup(campaignId), 0, "Campaign should have been created"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 4)
  │   💬 Args: [campaign.creator, params.creator, "creator"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(address,address,string) (NodeID: 5)
  │   💬 Args: [campaign.rewardToken, params.rewardToken, "rewardToken"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 6)
  │   💬 Args: [campaign.amount, (params.amount * 97) / 100, "amount minus fees"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 7)
  │   💬 Args: [campaign.campaignType, params.campaignType, "campaignType"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 8)
  │   💬 Args: [campaign.startTimestamp, params.startTimestamp, "startTimestamp"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(uint256,uint256,string) (NodeID: 9)
  │   💬 Args: [campaign.duration, params.duration, "duration"]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEq(bytes,bytes,string) (NodeID: 10)
  │   💬 Args: [campaign.campaignData, params.campaignData, "campaignData"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertGt(uint256,uint256,string) (NodeID: 11)
      💬 Args: [boldToken.balanceOf(address(merklDistributionCreator.distributor())), 0, "Merkl Distributor should have some BOLD"]
      👁️  Def: internal
```
