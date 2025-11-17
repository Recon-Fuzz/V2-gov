# Contract: MockERC20Tester

## Metadata

- **Name**: MockERC20Tester
- **Type**: Contract
- **Path**: test/mocks/MockERC20Tester.sol

## Implements Interfaces

- **IERC5267** [lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol/interface_IERC5267.md]
- **ILQTY** [src/interfaces/ILQTY.sol/interface_ILQTY.md]
- **ILUSD** [src/interfaces/ILUSD.sol/interface_ILUSD.md]
- **IERC20Permit** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol/interface_IERC20Permit.md]
- **IERC20Errors** [lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol/interface_IERC20Errors.md]
- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variables

### _balances (inherited from ERC20)

```solidity
mapping(address => uint256) private _balances
```

### _allowances (inherited from ERC20)

```solidity
mapping(address => mapping(address => uint256)) private _allowances
```

### _totalSupply (inherited from ERC20)

```solidity
uint256 private _totalSupply
```

### _name (inherited from ERC20)

```solidity
string private _name
```

### _symbol (inherited from ERC20)

```solidity
string private _symbol
```

### TYPE_HASH (inherited from EIP712)

```solidity
bytes32 private constant TYPE_HASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)")
```

### _cachedDomainSeparator (inherited from EIP712)

```solidity
bytes32 private immutable _cachedDomainSeparator
```

### _cachedChainId (inherited from EIP712)

```solidity
uint256 private immutable _cachedChainId
```

### _cachedThis (inherited from EIP712)

```solidity
address private immutable _cachedThis
```

### _hashedName (inherited from EIP712)

```solidity
bytes32 private immutable _hashedName
```

### _hashedVersion (inherited from EIP712)

```solidity
bytes32 private immutable _hashedVersion
```

### _name (inherited from EIP712)

```solidity
ShortString private immutable _name
```

### _version (inherited from EIP712)

```solidity
ShortString private immutable _version
```

### _nameFallback (inherited from EIP712)

```solidity
string private _nameFallback
```

### _versionFallback (inherited from EIP712)

```solidity
string private _versionFallback
```

### _nonces (inherited from Nonces)

```solidity
mapping(address => uint256) private _nonces
```

### PERMIT_TYPEHASH (inherited from ERC20Permit)

```solidity
bytes32 private constant PERMIT_TYPEHASH = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)")
```

### _owner (inherited from Ownable)

```solidity
address private _owner
```

### mock_isWildcardSpender

```solidity
mapping(address => bool) public mock_isWildcardSpender
```

## Errors

### ERC20InsufficientBalance (inherited from IERC20Errors)

```solidity
///  @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
///  @param sender Address whose tokens are being transferred.
///  @param balance Current balance for the interacting account.
///  @param needed Minimum amount required to perform a transfer.
error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);
```

### ERC20InvalidSender (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the token `sender`. Used in transfers.
///  @param sender Address whose tokens are being transferred.
error ERC20InvalidSender(address sender);
```

### ERC20InvalidReceiver (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the token `receiver`. Used in transfers.
///  @param receiver Address to which tokens are being transferred.
error ERC20InvalidReceiver(address receiver);
```

### ERC20InsufficientAllowance (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the `spender`’s `allowance`. Used in transfers.
///  @param spender Address that may be allowed to operate on tokens without being their owner.
///  @param allowance Amount of tokens a `spender` is allowed to operate with.
///  @param needed Minimum amount required to perform a transfer.
error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);
```

### ERC20InvalidApprover (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
///  @param approver Address initiating an approval operation.
error ERC20InvalidApprover(address approver);
```

### ERC20InvalidSpender (inherited from IERC20Errors)

```solidity
///  @dev Indicates a failure with the `spender` to be approved. Used in approvals.
///  @param spender Address that may be allowed to operate on tokens without being their owner.
error ERC20InvalidSpender(address spender);
```

### InvalidAccountNonce (inherited from Nonces)

```solidity
///  @dev The nonce used for an `account` is not the expected current nonce.
error InvalidAccountNonce(address account, uint256 currentNonce);
```

### ERC2612ExpiredSignature (inherited from ERC20Permit)

```solidity
///  @dev Permit deadline has expired.
error ERC2612ExpiredSignature(uint256 deadline);
```

### ERC2612InvalidSigner (inherited from ERC20Permit)

```solidity
///  @dev Mismatched signature.
error ERC2612InvalidSigner(address signer, address owner);
```

### OwnableUnauthorizedAccount (inherited from Ownable)

```solidity
///  @dev The caller account is not authorized to perform an operation.
error OwnableUnauthorizedAccount(address account);
```

### OwnableInvalidOwner (inherited from Ownable)

```solidity
///  @dev The owner is not a valid owner account. (eg. `address(0)`)
error OwnableInvalidOwner(address owner);
```

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

### EIP712DomainChanged (inherited from IERC5267)

```solidity
///  @dev MAY be emitted to signal that the domain could have changed.
event EIP712DomainChanged();
```

### OwnershipTransferred (inherited from Ownable)

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
```

## Public/External Functions

### constructor(string,string)

- **Signature**: `constructor(string,string)`
- **Visibility**: public
- **Source Range**: 694:114:110
- **Details**: [function_constructor_string_string.md](./function_constructor_string_string.md)

**Signature:**
```solidity
constructor(string memory name, string memory symbol) ERC20Permit(name) ERC20(name,symbol) Ownable(msg.sender);
```

### domainSeparator()

- **Signature**: `domainSeparator()`
- **Visibility**: external
- **Source Range**: 845:103:110
- **Details**: [function_domainSeparator.md](./function_domainSeparator.md)

**Signature:**
```solidity
function domainSeparator() external view returns (bytes32);
```

### nonces(address)

- **Signature**: `nonces(address)`
- **Visibility**: public
- **Source Range**: 954:148:110
- **Details**: [function_nonces_address.md](./function_nonces_address.md)

**Signature:**
```solidity
function nonces(address owner) virtual override(IERC20Permit, ERC20Permit) public view returns (uint256);
```

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 1108:222:110
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
function allowance(address owner, address spender) virtual override(IERC20, ERC20) public view returns (uint256);
```

### mint(address,uint256)

- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 1336:103:110
- **Details**: [function_mint_address_uint256.md](./function_mint_address_uint256.md)

**Signature:**
```solidity
function mint(address account, uint256 value) external onlyOwner();
```

### mock_setWildcardSpender(address,bool)

- **Signature**: `mock_setWildcardSpender(address,bool)`
- **Visibility**: external
- **Source Range**: 1445:141:110
- **Details**: [function_mock_setWildcardSpender_address_bool.md](./function_mock_setWildcardSpender_address_bool.md)

**Signature:**
```solidity
function mock_setWildcardSpender(address spender, bool allowed) external onlyOwner();
```

### name() (inherited from ERC20)

- **Signature**: `name()`
- **Visibility**: public
- **Source Range**: 2074:89:36
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() virtual public view returns (string memory);
```

### symbol() (inherited from ERC20)

- **Signature**: `symbol()`
- **Visibility**: public
- **Source Range**: 2276:93:36
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
///  @dev Returns the symbol of the token, usually a shorter version of the
///  name.
function symbol() virtual public view returns (string memory);
```

### decimals() (inherited from ERC20)

- **Signature**: `decimals()`
- **Visibility**: public
- **Source Range**: 3002:82:36
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
///  @dev Returns the number of decimals used to get its user representation.
///  For example, if `decimals` equals `2`, a balance of `505` tokens should
///  be displayed to a user as `5.05` (`505 / 10 ** 2`).
///  Tokens usually opt for a value of 18, imitating the relationship between
///  Ether and Wei. This is the default value returned by this function, unless
///  it's overridden.
///  NOTE: This information is only used for _display_ purposes: it in
///  no way affects any of the arithmetic of the contract, including
///  {IERC20-balanceOf} and {IERC20-transfer}.
function decimals() virtual public view returns (uint8);
```

### totalSupply() (inherited from ERC20)

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 3144:97:36
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
///  @dev See {IERC20-totalSupply}.
function totalSupply() virtual public view returns (uint256);
```

### balanceOf(address) (inherited from ERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 3299:116:36
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
///  @dev See {IERC20-balanceOf}.
function balanceOf(address account) virtual public view returns (uint256);
```

### transfer(address,uint256) (inherited from ERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 3610:178:36
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-transfer}.
///  Requirements:
///  - `to` cannot be the zero address.
///  - the caller must have a balance of at least `value`.
function transfer(address to, uint256 value) virtual public returns (bool);
```

### approve(address,uint256) (inherited from ERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 4293:186:36
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-approve}.
///  NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
///  `transferFrom`. This is semantically equivalent to an infinite approval.
///  Requirements:
///  - `spender` cannot be the zero address.
function approve(address spender, uint256 value) virtual public returns (bool);
```

### transferFrom(address,address,uint256) (inherited from ERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 5039:244:36
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
///  @dev See {IERC20-transferFrom}.
///  Emits an {Approval} event indicating the updated allowance. This is not
///  required by the EIP. See the note at the beginning of {ERC20}.
///  NOTE: Does not update the allowance if the current allowance
///  is the maximum `uint256`.
///  Requirements:
///  - `from` and `to` cannot be the zero address.
///  - `from` must have a balance of at least `value`.
///  - the caller must have allowance for ``from``'s tokens of at least
///  `value`.
function transferFrom(address from, address to, uint256 value) virtual public returns (bool);
```

### eip712Domain() (inherited from EIP712)

- **Signature**: `eip712Domain()`
- **Visibility**: public
- **Source Range**: 5144:557:50
- **Details**: [function_eip712Domain.md](./function_eip712Domain.md)

**Signature:**
```solidity
///  @dev See {IERC-5267}.
function eip712Domain() virtual public view returns (bytes1 fields, string memory name, string memory version, uint256 chainId, address verifyingContract, bytes32 salt, uint256[] memory extensions);
```

### permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (inherited from ERC20Permit)

- **Signature**: `permit(address,address,uint256,uint256,uint8,bytes32,bytes32)`
- **Visibility**: public
- **Source Range**: 1680:672:38
- **Details**: [function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md](./function_permit_address_address_uint256_uint256_uint8_bytes32_bytes32.md)

**Signature:**
```solidity
///  @inheritdoc IERC20Permit
function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) virtual public;
```

### DOMAIN_SEPARATOR() (inherited from ERC20Permit)

- **Signature**: `DOMAIN_SEPARATOR()`
- **Visibility**: external
- **Source Range**: 2656:112:38
- **Details**: [function_DOMAIN_SEPARATOR.md](./function_DOMAIN_SEPARATOR.md)

**Signature:**
```solidity
///  @inheritdoc IERC20Permit
function DOMAIN_SEPARATOR() virtual external view returns (bytes32);
```

### owner() (inherited from Ownable)

- **Signature**: `owner()`
- **Visibility**: public
- **Source Range**: 1638:85:31
- **Details**: [function_owner.md](./function_owner.md)

**Signature:**
```solidity
///  @dev Returns the address of the current owner.
function owner() virtual public view returns (address);
```

### renounceOwnership() (inherited from Ownable)

- **Signature**: `renounceOwnership()`
- **Visibility**: public
- **Source Range**: 2293:101:31
- **Details**: [function_renounceOwnership.md](./function_renounceOwnership.md)

**Signature:**
```solidity
///  @dev Leaves the contract without owner. It will not be possible to call
///  `onlyOwner` functions. Can only be called by the current owner.
///  NOTE: Renouncing ownership will leave the contract without an owner,
///  thereby disabling any functionality that is only available to the owner.
function renounceOwnership() virtual public onlyOwner();
```

### transferOwnership(address) (inherited from Ownable)

- **Signature**: `transferOwnership(address)`
- **Visibility**: public
- **Source Range**: 2543:215:31
- **Details**: [function_transferOwnership_address.md](./function_transferOwnership_address.md)

**Signature:**
```solidity
///  @dev Transfers ownership of the contract to a new account (`newOwner`).
///  Can only be called by the current owner.
function transferOwnership(address newOwner) virtual public onlyOwner();
```
