# Interface: ILQTY

## Metadata

- **Name**: ILQTY
- **Type**: Interface
- **Path**: src/interfaces/ILQTY.sol

## Implements Interfaces

- **IERC20Permit** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol/interface_IERC20Permit.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## Events

### Transfer (inherited from IERC20)

```solidity
///  @dev Emitted when `value` tokens are moved from one account (`from`) to
///  another (`to`).
///  Note that `value` may be zero.
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval (inherited from IERC20)

```solidity
///  @dev Emitted when the allowance of a `spender` for an `owner` is set by
///  a call to {approve}. `value` is the new allowance.
event Approval(address indexed owner, address indexed spender, uint256 value);
```

## Public/External Functions

### domainSeparator()

- **Signature**: `domainSeparator()`
- **Visibility**: external
- **Source Range**: 268:59:77

**Signature:**
```solidity
function domainSeparator() external view returns (bytes32);;
```

### totalSupply() (inherited from IERC20)

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 774:55:37

**Signature:**
```solidity
///  @dev Returns the value of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address) (inherited from IERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 911:68:37

**Signature:**
```solidity
///  @dev Returns the value of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256) (inherited from IERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 1203:69:37

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from the caller's account to `to`.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transfer(address to, uint256 value) external returns (bool);;
```

### allowance(address,address) (inherited from IERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1547:83:37

**Signature:**
```solidity
///  @dev Returns the remaining number of tokens that `spender` will be
///  allowed to spend on behalf of `owner` through {transferFrom}. This is
///  zero by default.
///  This value changes when {approve} or {transferFrom} are called.
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256) (inherited from IERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 2308:73:37

**Signature:**
```solidity
///  @dev Sets a `value` amount of tokens as the allowance of `spender` over the
///  caller's tokens.
///  Returns a boolean value indicating whether the operation succeeded.
///  IMPORTANT: Beware that changing an allowance with this method brings the risk
///  that someone may use both the old and the new allowance by unfortunate
///  transaction ordering. One possible solution to mitigate this race
///  condition is to first reduce the spender's allowance to 0 and set the
///  desired value afterwards:
///  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
///  Emits an {Approval} event.
function approve(address spender, uint256 value) external returns (bool);;
```

### transferFrom(address,address,uint256) (inherited from IERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2689:87:37

**Signature:**
```solidity
///  @dev Moves a `value` amount of tokens from `from` to `to` using the
///  allowance mechanism. `value` is then deducted from the caller's
///  allowance.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transferFrom(address from, address to, uint256 value) external returns (bool);;
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from IERC20Permit)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: external
- **Source Range**: 2997:183:40

**Signature:**
```solidity
///  @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
///  given ``owner``'s signed approval.
///  IMPORTANT: The same issues {IERC20-approve} has related to transaction
///  ordering also apply here.
///  Emits an {Approval} event.
///  Requirements:
///  - `spender` cannot be the zero address.
///  - `deadline` must be a timestamp in the future.
///  - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
///  over the EIP712-formatted function arguments.
///  - the signature must use ``owner``'s current nonce (see {nonces}).
///  For more information on the signature format, see the
///  https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
///  section].
///  CAUTION: See Security Considerations above.
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;;
```

### nonces(address) (inherited from IERC20Permit)

- **Signature**: `nonces(address)`
- **Visibility**: external
- **Source Range**: 3485:63:40

**Signature:**
```solidity
///  @dev Returns the current nonce for `owner`. This value must be
///  included whenever a signature is generated for {permit}.
///  Every successful call to {permit} increases ``owner``'s nonce by one. This
///  prevents a signature from being used multiple times.
function nonces(address owner) external view returns (uint256);;
```

### DOMAIN_SEPARATOR() (inherited from IERC20Permit)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 3740:60:40

**Signature:**
```solidity
///  @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
function DOMAIN_SEPARATOR() external view returns (bytes32);;
```
