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
import "src/Governance.sol";
import {IGovernance} from "src/interfaces/IGovernance.sol";
import {IERC20} from "openzeppelin/contracts/interfaces/IERC20.sol";

// Mocks
import {MockERC20Tester} from "../mocks/MockERC20Tester.sol";
import {MockStakingV1} from "../mocks/MockStakingV1.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    // Configuration constants
    uint256 internal constant DECIMALS = 18;

    // Core contracts
    BribeInitiative bribeInitiative;
    Governance governance;

    // Token contracts
    MockERC20Tester lqty;
    MockERC20Tester lusd;
    MockERC20Tester bold;
    MockERC20Tester bribeToken;

    // Infrastructure contracts
    MockStakingV1 stakingV1;

    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        // 1. Add actors
        _addActor(address(0x100)); // Actor 1
        _addActor(address(0x200)); // Actor 2

        // 2. Deploy tokens
        lqty = new MockERC20Tester("Liquity", "LQTY");
        lusd = new MockERC20Tester("Liquity USD", "LUSD");
        bold = new MockERC20Tester("BOLD Stablecoin", "BOLD");
        bribeToken = new MockERC20Tester("Bribe Token", "BRYB");

        // 3. Deploy MockStakingV1
        stakingV1 = new MockStakingV1(lqty, lusd);

        // Set wildcard spender for stakingV1 (like in real LQTYStaking)
        lqty.mock_setWildcardSpender(address(stakingV1), true);

        // 4. Create governance configuration
        // CONFIGURABLE: These parameters can be modified via governance functions
        IGovernance.Configuration memory config = IGovernance.Configuration({
            registrationFee: 1e18,
            registrationThresholdFactor: 0.01e18,
            unregistrationThresholdFactor: 4e18,
            unregistrationAfterEpochs: 4,
            votingThresholdFactor: 0.04e18,
            minClaim: 500e18,
            minAccrual: 1000e18,
            epochStart: block.timestamp - (604800 * 3), // 3 weeks ago (to enable registration)
            epochDuration: 604800, // 1 week
            epochVotingCutoff: 518400 // 6 days
        });

        // 5. Deploy governance
        address[] memory initialInitiatives = new address[](0);
        governance = new Governance(
            address(lqty),
            address(lusd),
            address(stakingV1),
            address(bold),
            config,
            address(this),
            initialInitiatives
        );

        // 6. Deploy bribe initiative
        bribeInitiative = new BribeInitiative(
            address(governance),
            address(bold),
            address(bribeToken)
        );

        // 7. Mint tokens to actors manually (MockERC20Tester has onlyOwner on mint)
        address[] memory actors = _getActors();
        uint256 mintAmount = type(uint88).max;

        for (uint256 i = 0; i < actors.length; i++) {
            lqty.mint(actors[i], mintAmount);
            lusd.mint(actors[i], mintAmount);
            bold.mint(actors[i], mintAmount);
            bribeToken.mint(actors[i], mintAmount);
        }

        // 8. Set up approvals for each actor to all relevant contracts
        // We need to approve: governance, bribeInitiative, stakingV1, and each actor's userProxy
        for (uint256 i = 0; i < actors.length; i++) {
            address userProxy = governance.deriveUserProxyAddress(actors[i]);

            address[] memory approvalArray = new address[](4);
            approvalArray[0] = address(governance);
            approvalArray[1] = address(bribeInitiative);
            approvalArray[2] = address(stakingV1);
            approvalArray[3] = userProxy;

            for (uint256 j = 0; j < approvalArray.length; j++) {
                vm.prank(actors[i]);
                lqty.approve(approvalArray[j], type(uint256).max);
                vm.prank(actors[i]);
                lusd.approve(approvalArray[j], type(uint256).max);
                vm.prank(actors[i]);
                bold.approve(approvalArray[j], type(uint256).max);
                vm.prank(actors[i]);
                bribeToken.approve(approvalArray[j], type(uint256).max);
            }
        }

        // 9. Add custom tokens to asset manager
        _addAsset(address(lqty));
        _addAsset(address(lusd));
        _addAsset(address(bold));
        _addAsset(address(bribeToken));
    }

    /// === MODIFIERS === ///
    /// Prank admin and actor

    modifier asAdmin {
        vm.prank(address(this));
        _;
    }

    modifier asActor {
        vm.prank(address(_getActor()));
        _;
    }
}
