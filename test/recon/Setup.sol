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
import {IERC20} from "openzeppelin/contracts/interfaces/IERC20.sol";
import {ILiquidityGauge} from "src/interfaces/ILiquidityGauge.sol";

// Mocks
import {MockERC20Tester} from "../mocks/MockERC20Tester.sol";
import {MockStakingV1} from "../mocks/MockStakingV1.sol";
import {MockLiquidityGauge} from "../mocks/MockLiquidityGauge.sol";
import {MockDistributionCreator} from "../mocks/MockDistributionCreator.sol";
import {MockUniV4MerklRewards} from "../mocks/MockUniV4MerklRewards.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    // Configuration constants
    uint256 internal constant DECIMALS = 18;

    // Core contracts
    BribeInitiative bribeInitiative;
    CurveV2GaugeRewards curveV2GaugeRewards;
    Governance governance;
    MockUniV4MerklRewards uniV4MerklRewards;
    MockDistributionCreator mockDistributionCreator;

    // Token contracts
    MockERC20Tester lqty;
    MockERC20Tester lusd;
    MockERC20Tester bold;
    MockERC20Tester bribeToken;

    // Infrastructure contracts
    MockStakingV1 stakingV1;
    MockLiquidityGauge mockLiquidityGauge;

    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {}

    /// === MODIFIERS === ///
    /// Prank admin and actor

    modifier asAdmin() {
        vm.prank(address(this));
        _;
    }

    modifier asActor() {
        vm.prank(address(_getActor()));
        _;
    }
}
