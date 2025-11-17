# Function: setUp()

**Contract**: [script/DeploySepolia.s.sol/contract_DeploySepoliaScript.md]

## Metadata

- **Contract**: DeploySepoliaScript
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 2160:171:61

## Implementation

```solidity
function setUp() public {
    privateKey = vm.envUint("PRIVATE_KEY");
    deployer = vm.createWallet(privateKey).addr;
    nonce = vm.getNonce(deployer);
}
```

## External Calls

- **Vm::envUint(string)**
- **Vm::createWallet(uint256)**
- **Vm::getNonce(address)**

## State Variable Reads

- **privateKey** (`uint256`)
- **deployer** (`address`)

## State Variable Writes

- **privateKey** (`uint256`)
- **deployer** (`address`)
- **nonce** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DeploySepoliaScript.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
