# Function: test_VoterGetsTheirFairShareOfBribes()

**Contract**: [test/BribeInitiative.t.sol/contract_BribeInitiativeTest.md]

## Metadata

- **Contract**: BribeInitiativeTest
- **Signature**: `test_VoterGetsTheirFairShareOfBribes()`
- **Visibility**: external
- **Source Range**: 36650:3016:92

## Implementation

```solidity
function test_VoterGetsTheirFairShareOfBribes() external {
    uint256 bribeAmount = 10_000 ether;
    uint256 voteAmount = 100_000 ether;
    address otherInitiative = makeAddr("otherInitiative");
    vm.warp(block.timestamp + (2 * EPOCH_DURATION));
    vm.startPrank(lusdHolder);
    {
        lusd.approve(address(governance), REGISTRATION_FEE);
        governance.registerInitiative(otherInitiative);
        lusd.approve(address(bribeInitiative), bribeAmount);
        lqty.approve(address(bribeInitiative), bribeAmount);
        bribeInitiative.depositBribe(bribeAmount, bribeAmount, governance.epoch() + 1);
    }
    vm.stopPrank();
    vm.warp(block.timestamp + EPOCH_DURATION);
    address[] memory initiativesToReset = new address[](0);
    address[] memory initiatives;
    int256[] memory votes;
    int256[] memory vetos;
    vm.startPrank(user1);
    {
        initiatives = new address[](2);
        votes = new int256[](2);
        vetos = new int256[](2);
        initiatives[0] = otherInitiative;
        initiatives[1] = address(bribeInitiative);
        votes[0] = int256(voteAmount);
        votes[1] = int256(voteAmount);
        lqty.approve(governance.deriveUserProxyAddress(user1), 2 * voteAmount);
        governance.depositLQTY(2 * voteAmount);
        governance.allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }
    vm.stopPrank();
    vm.startPrank(user2);
    {
        initiatives = new address[](1);
        votes = new int256[](1);
        vetos = new int256[](1);
        initiatives[0] = address(bribeInitiative);
        votes[0] = int256(voteAmount);
        lqty.approve(governance.deriveUserProxyAddress(user2), voteAmount);
        governance.depositLQTY(voteAmount);
        governance.allocateLQTY(initiativesToReset, initiatives, votes, vetos);
    }
    vm.stopPrank();
    vm.warp(block.timestamp + EPOCH_DURATION);
    IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1);
    claimData[0].epoch = governance.epoch() - 1;
    claimData[0].prevLQTYAllocationEpoch = governance.epoch() - 1;
    claimData[0].prevTotalLQTYAllocationEpoch = governance.epoch() - 1;
    vm.prank(user1);
    (uint256 lusdBribe, uint256 lqtyBribe) = bribeInitiative.claimBribes(claimData);
    assertEqDecimal(lusdBribe, bribeAmount / 2, 18, "user1 didn't get their fair share of LUSD");
    assertEqDecimal(lqtyBribe, bribeAmount / 2, 18, "user1 didn't get their fair share of LQTY");
}
```

## Related Implementations

### makeAddr(string)

- **Kind**: internal
- **Source**: 20454:125:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddr(string)`

```solidity
function makeAddr(string memory name) virtual internal returns (address addr) {
    (addr, ) = makeAddrAndKey(name);
}
```

### makeAddrAndKey(string)

- **Kind**: internal
- **Source**: 20173:242:11
- **Link**: `lib/forge-std/src/StdCheats.sol:StdCheatsSafe:makeAddrAndKey(string)`

```solidity
function makeAddrAndKey(string memory name) virtual internal returns (address addr, uint256 privateKey) {
    privateKey = uint256(keccak256(abi.encodePacked(name)));
    addr = vm.addr(privateKey);
    vm.label(addr, name);
}
```

### assertEqDecimal(uint256,uint256,uint256,string)

- **Kind**: internal
- **Source**: 2684:176:9
- **Link**: `lib/forge-std/src/StdAssertions.sol:StdAssertions:assertEqDecimal(uint256,uint256,uint256,string)`

```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) virtual internal pure {
    vm.assertEqDecimal(left, right, decimals, err);
}
```

## External Calls

- **Vm::warp(uint256)**
- **Vm::startPrank(address)**
- **MockERC20Tester::approve(address,uint256)**
- **Governance::registerInitiative(address)**
- **BribeInitiative::depositBribe(uint256,uint256,uint256)**
- **Governance::epoch()**
- **Vm::stopPrank()**
- **Governance::deriveUserProxyAddress(address)**
- **Governance::depositLQTY(uint256)**
- **Governance::allocateLQTY(address[],address[],int256[],int256[])**
- **Vm::prank(address)**
- **BribeInitiative::claimBribes(struct IBribeInitiative.ClaimData[])**

## State Variable Reads

- **EPOCH_DURATION** (`uint256`)
- **lusdHolder** (`address`)
- **lusd** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **governance** (`contract Governance`) [src/Governance.sol/contract_Governance.md]
- **REGISTRATION_FEE** (`uint256`)
- **bribeInitiative** (`contract BribeInitiative`) [src/BribeInitiative.sol/contract_BribeInitiative.md]
- **lqty** (`contract MockERC20Tester`) [test/mocks/MockERC20Tester.sol/contract_MockERC20Tester.md]
- **user1** (`address`)
- **user2** (`address`)
- **vm** (`contract Vm`) [lib/forge-std/src/Vm.sol/interface_Vm.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiativeTest.test_VoterGetsTheirFairShareOfBribes() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: StdCheatsSafe.makeAddr(string) (NodeID: 1)
  │   💬 Args: ["otherInitiative"]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: StdCheatsSafe.makeAddrAndKey(string) (NodeID: 2)
  │     💬 Args: [name]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 3)
  │   💬 Args: [lusdBribe, bribeAmount / 2, 18, "user1 didn't get their fair share of LUSD"]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: StdAssertions.assertEqDecimal(uint256,uint256,uint256,string) (NodeID: 4)
      💬 Args: [lqtyBribe, bribeAmount / 2, 18, "user1 didn't get their fair share of LQTY"]
      👁️  Def: internal
```
