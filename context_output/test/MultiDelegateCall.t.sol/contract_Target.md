# Contract: Target

## Metadata

- **Name**: Target
- **Type**: Contract
- **Path**: test/MultiDelegateCall.t.sol

## Implements Interfaces

- **IMultiDelegateCall** [src/interfaces/IMultiDelegateCall.sol/interface_IMultiDelegateCall.md]

## Errors

### CustomError

```solidity
error CustomError(string);
```

## Public/External Functions

### id(bytes)

- **Signature**: `id(bytes)`
- **Visibility**: external
- **Source Range**: 294:94:102
- **Details**: [function_id_bytes.md](./function_id_bytes.md)

**Signature:**
```solidity
function id(bytes calldata x) external pure returns (bytes calldata);
```

### revertWithMessage(string)

- **Signature**: `revertWithMessage(string)`
- **Visibility**: external
- **Source Range**: 394:98:102
- **Details**: [function_revertWithMessage_string.md](./function_revertWithMessage_string.md)

**Signature:**
```solidity
function revertWithMessage(string calldata message) external pure;
```

### revertWithCustomError(string)

- **Signature**: `revertWithCustomError(string)`
- **Visibility**: external
- **Source Range**: 498:114:102
- **Details**: [function_revertWithCustomError_string.md](./function_revertWithCustomError_string.md)

**Signature:**
```solidity
function revertWithCustomError(string calldata message) external pure;
```

### panicWithArithmeticError()

- **Signature**: `panicWithArithmeticError()`
- **Visibility**: external
- **Source Range**: 618:108:102
- **Details**: [function_panicWithArithmeticError.md](./function_panicWithArithmeticError.md)

**Signature:**
```solidity
function panicWithArithmeticError() external pure returns (int256);
```

### multiDelegateCall(bytes[]) (inherited from MultiDelegateCall)

- **Signature**: `multiDelegateCall(bytes[])`
- **Visibility**: external
- **Source Range**: 226:698:86
- **Details**: [function_multiDelegateCall_bytes[].md](./function_multiDelegateCall_bytes[].md)

**Signature:**
```solidity
/// @inheritdoc IMultiDelegateCall
function multiDelegateCall(bytes[] calldata inputs) external returns (bytes[] memory returnValues);
```
