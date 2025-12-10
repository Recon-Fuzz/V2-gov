// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {BaseSetup} from "@chimera/BaseSetup.sol";
import {vm} from "@chimera/Hevm.sol";

// Managers
import {ActorManager} from "@recon/ActorManager.sol";
import {AssetManager} from "@recon/AssetManager.sol";

// Helpers
import {Utils} from "@recon/Utils.sol";

// Your deps
import "src/BribeInitiative.sol";
import "src/CurveV2GaugeRewards.sol";
import "src/Governance.sol";
import "src/UniV4MerklRewards.sol";
import {IGovernance} from "src/interfaces/IGovernance.sol";
import {IBribeInitiative} from "src/interfaces/IBribeInitiative.sol";
import {IERC20} from "openzeppelin/contracts/interfaces/IERC20.sol";
import {ILiquidityGauge} from "src/interfaces/ILiquidityGauge.sol";
import {PermitParams} from "src/utils/Types.sol";

// Mocks
import {MockERC20Tester} from "../mocks/MockERC20Tester.sol";
import {MockStakingV1} from "../mocks/MockStakingV1.sol";
import {MockLiquidityGauge} from "../mocks/MockLiquidityGauge.sol";
import {MockDistributionCreator} from "../mocks/MockDistributionCreator.sol";
import {MockUniV4MerklRewards} from "../mocks/MockUniV4MerklRewards.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    // Configuration constants
    uint256 internal constant DECIMALS = 18;
    uint32 internal constant START_TIME = 1732873631;
    uint32 internal constant EPOCH_DURATION = 7 days;
    uint128 internal constant REGISTRATION_FEE = 1 ether;

    // Core contracts
    Governance governance;
    BribeInitiative bribeInitiative;
    CurveV2GaugeRewards curveV2GaugeRewards;
    MockUniV4MerklRewards uniV4MerklRewards;

    // Token contracts
    MockERC20Tester lqty;
    MockERC20Tester lusd;
    MockERC20Tester bold;
    MockERC20Tester bribeToken;

    // Infrastructure contracts
    MockStakingV1 stakingV1;
    MockLiquidityGauge mockLiquidityGauge;
    MockDistributionCreator mockDistributionCreator;

    // Dynamic deployments
    address[] internal deployedBribeInitiatives;

    // Proxy deployment
    address internal userProxy;

    // Private key for permit testing
    uint256 internal userPrivateKey =
        23868421370328131711506074113045611601786642648093516849953535378706721142721;

    // Struct parameters (single mode)
    PermitParams internal permitParams;
    IBribeInitiative.ClaimData internal claimData;
    IGovernance.UserState internal userState;
    IGovernance.Allocation internal allocation;
    IGovernance.InitiativeState internal initiativeState;

    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {}

    /// === Helper Functions === ///

    /// @notice Get a deployed BribeInitiative by index
    /// @param index Index to select from deployedBribeInitiatives array
    /// @return address of the selected BribeInitiative
    function _getDeployedBribeInitiative(
        uint8 index
    ) internal view returns (address) {
        return
            deployedBribeInitiatives[index % deployedBribeInitiatives.length];
    }

    /// @notice Get the current epoch number
    /// @return Current epoch from governance contract
    function _getCurrentEpoch() internal view returns (uint256) {
        return governance.epoch();
    }

    /// @notice Generate valid permit parameters for EIP-2612 permit
    /// @param owner Address that owns the tokens
    /// @param spender Address that will spend the tokens
    /// @param value Amount of tokens to permit
    /// @param deadline Permit expiration timestamp
    /// @return Valid PermitParams struct with signature
    function _getValidPermitParams(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline
    ) internal returns (PermitParams memory) {
        // Create the permit digest
        bytes32 permitTypeHash = keccak256(
            "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
        );
        bytes32 domainSeparator = lqty.DOMAIN_SEPARATOR();
        uint256 nonce = lqty.nonces(owner);

        bytes32 structHash = keccak256(
            abi.encode(permitTypeHash, owner, spender, value, nonce, deadline)
        );
        bytes32 digest = keccak256(
            abi.encodePacked("\x19\x01", domainSeparator, structHash)
        );

        // Sign with the known private key
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);

        return
            PermitParams({
                owner: owner,
                spender: spender,
                value: value,
                deadline: deadline,
                v: v,
                r: r,
                s: s
            });
    }

    /// === MODIFIERS === ///

    modifier asAdmin() {
        vm.prank(address(this));
        _;
    }

    modifier asActor() {
        vm.prank(address(_getActor()));
        _;
    }
}
