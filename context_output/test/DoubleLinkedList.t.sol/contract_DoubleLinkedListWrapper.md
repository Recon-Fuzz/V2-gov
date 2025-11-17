# Contract: DoubleLinkedListWrapper

## Metadata

- **Name**: DoubleLinkedListWrapper
- **Type**: Contract
- **Path**: test/DoubleLinkedList.t.sol

## State Variables

### list

```solidity
DoubleLinkedList.List internal list
```

## Public/External Functions

### getHead()

- **Signature**: `getHead()`
- **Visibility**: public
- **Source Range**: 303:87:97
- **Details**: [function_getHead.md](./function_getHead.md)

**Signature:**
```solidity
function getHead() public view returns (uint256);
```

### getTail()

- **Signature**: `getTail()`
- **Visibility**: public
- **Source Range**: 396:87:97
- **Details**: [function_getTail.md](./function_getTail.md)

**Signature:**
```solidity
function getTail() public view returns (uint256);
```

### getNext(uint256)

- **Signature**: `getNext(uint256)`
- **Visibility**: public
- **Source Range**: 489:99:97
- **Details**: [function_getNext_uint256.md](./function_getNext_uint256.md)

**Signature:**
```solidity
function getNext(uint256 id) public view returns (uint256);
```

### getPrev(uint256)

- **Signature**: `getPrev(uint256)`
- **Visibility**: public
- **Source Range**: 594:99:97
- **Details**: [function_getPrev_uint256.md](./function_getPrev_uint256.md)

**Signature:**
```solidity
function getPrev(uint256 id) public view returns (uint256);
```

### insert(uint256,uint256)

- **Signature**: `insert(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 699:93:97
- **Details**: [function_insert_uint256_uint256.md](./function_insert_uint256_uint256.md)

**Signature:**
```solidity
function insert(uint256 id, uint256 next) public;
```
