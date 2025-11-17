# Contract: MultiDelegateCall

## Metadata

- **Name**: MultiDelegateCall
- **Type**: Contract
- **Path**: src/utils/MultiDelegateCall.sol

## Implements Interfaces

- **IMultiDelegateCall** [src/interfaces/IMultiDelegateCall.sol/interface_IMultiDelegateCall.md]

## Public/External Functions

### multiDelegateCall(bytes[])

- **Signature**: `multiDelegateCall(bytes[])`
- **Visibility**: external
- **Source Range**: 226:698:86
- **Details**: [function_multiDelegateCall_bytes[].md](./function_multiDelegateCall_bytes[].md)

**Signature:**
```solidity
/// @inheritdoc IMultiDelegateCall
function multiDelegateCall(bytes[] calldata inputs) external returns (bytes[] memory returnValues);
```
