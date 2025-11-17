# Interface: IDistributionCreator

## Metadata

- **Name**: IDistributionCreator
- **Type**: Interface
- **Path**: src/interfaces/IDistributionCreator.sol

## Structs

### CampaignParameters

```solidity
struct CampaignParameters {
    bytes32 campaignId;
    address creator;
    address rewardToken;
    uint256 amount;
    uint32 campaignType;
    uint32 startTimestamp;
    uint32 duration;
    bytes campaignData;
}
```

## Errors

### CampaignDoesNotExist

```solidity
error CampaignDoesNotExist();
```

### CampaignAlreadyExists

```solidity
error CampaignAlreadyExists();
```

## Public/External Functions

### distributor()

- **Signature**: `distributor()`
- **Visibility**: external
- **Source Range**: 1314:55:74

**Signature:**
```solidity
function distributor() external view returns (address);;
```

### campaign(bytes32)

- **Signature**: `campaign(bytes32)`
- **Visibility**: external
- **Source Range**: 1374:89:74

**Signature:**
```solidity
function campaign(bytes32 _campaignId) external view returns (CampaignParameters memory);;
```

### campaignLookup(bytes32)

- **Signature**: `campaignLookup(bytes32)`
- **Visibility**: external
- **Source Range**: 1468:77:74

**Signature:**
```solidity
function campaignLookup(bytes32 _campaignId) external view returns (uint256);;
```

### acceptConditions()

- **Signature**: `acceptConditions()`
- **Visibility**: external
- **Source Range**: 1551:37:74

**Signature:**
```solidity
function acceptConditions() external;;
```

### campaignId(struct IDistributionCreator.CampaignParameters)

- **Signature**: `campaignId(struct IDistributionCreator.CampaignParameters)`
- **Visibility**: external
- **Source Range**: 1593:87:74

**Signature:**
```solidity
function campaignId(CampaignParameters memory campaignData) external returns (bytes32);;
```

### createCampaign(struct IDistributionCreator.CampaignParameters)

- **Signature**: `createCampaign(struct IDistributionCreator.CampaignParameters)`
- **Visibility**: external
- **Source Range**: 1685:90:74

**Signature:**
```solidity
function createCampaign(CampaignParameters memory newCampaign) external returns (bytes32);;
```
