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
import "src/UserProxy.sol";
import {IGovernance} from "src/interfaces/IGovernance.sol";

// Mocks for testing
import {MockERC20Tester} from "test/mocks/MockERC20Tester.sol";
import {MockStakingV1} from "test/mocks/MockStakingV1.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    // Configuration constants
    uint256 internal constant DECIMALS = 18;
    uint256 internal constant INITIAL_LQTY_AMOUNT = 1000000e18; // 1M LQTY per actor

    // Core contracts
    BribeInitiative bribeInitiative;
    BribeInitiative bribeInitiative2;
    Governance governance;

    // Mock tokens and contracts
    MockERC20Tester lqty;
    MockERC20Tester lusd;
    MockERC20Tester bold;
    MockERC20Tester bribeToken;
    MockStakingV1 stakingV1;

    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        // 1. Add additional actors (3 actors for comprehensive testing)
        _addActor(address(0x100)); // Actor 1
        _addActor(address(0x200)); // Actor 2
        _addActor(address(0x300)); // Actor 3

        // 2. Deploy mock tokens (these will be used instead of AssetManager's tokens)
        lqty = new MockERC20Tester("Liquity", "LQTY");
        lusd = new MockERC20Tester("Liquity USD", "LUSD");
        bold = new MockERC20Tester("BOLD Stablecoin", "BOLD");
        bribeToken = new MockERC20Tester("Bribe Token", "BRIBE");

        // Add tokens to asset manager for tracking
        _addAsset(address(lqty));
        _addAsset(address(lusd));
        _addAsset(address(bold));
        _addAsset(address(bribeToken));

        // 3. Deploy mock staking V1
        stakingV1 = new MockStakingV1(lqty, lusd);

        // 3.1. Set stakingV1 as wildcard spender for LQTY so UserProxy doesn't need explicit approval
        lqty.mock_setWildcardSpender(address(stakingV1), true);

        // 4. Configure governance parameters
        // CONFIGURABLE: These parameters can be modified via governance configuration
        IGovernance.Configuration memory config = IGovernance.Configuration({
            registrationFee: 1000e18, // CONFIGURABLE: Can be changed at deployment only
            registrationThresholdFactor: 0.01e18, // CONFIGURABLE: Can be changed at deployment only
            unregistrationThresholdFactor: 4e18, // CONFIGURABLE: Can be changed at deployment only
            unregistrationAfterEpochs: 4, // CONFIGURABLE: Can be changed at deployment only
            votingThresholdFactor: 0.04e18, // CONFIGURABLE: Can be changed at deployment only
            minClaim: 500e18, // CONFIGURABLE: Can be changed at deployment only
            minAccrual: 1000e18, // CONFIGURABLE: Can be changed at deployment only
            epochStart: block.timestamp, // CONFIGURABLE: Can be changed at deployment only
            epochDuration: 604800, // 1 week - CONFIGURABLE: Can be changed at deployment only
            epochVotingCutoff: 518400 // 6 days - CONFIGURABLE: Can be changed at deployment only
        });

        // 5. Create array of initial initiatives to register
        address[] memory initialInitiatives = new address[](2);

        // 6. Deploy Governance contract (also deploys UserProxyFactory)
        governance = new Governance(
            address(lqty),
            address(lusd),
            address(stakingV1),
            address(bold),
            config,
            address(this), // owner (will be renounced after initial initiative registration)
            new address[](0) // empty array, will register initiatives separately
        );

        // 7. Deploy BribeInitiative contracts
        bribeInitiative = new BribeInitiative(
            address(governance),
            address(bold),
            address(bribeToken)
        );

        bribeInitiative2 = new BribeInitiative(
            address(governance),
            address(bold),
            address(lqty) // Using LQTY as second bribe token for variety
        );

        // 8. Register initiatives with governance
        initialInitiatives[0] = address(bribeInitiative);
        initialInitiatives[1] = address(bribeInitiative2);
        governance.registerInitialInitiatives(initialInitiatives);

        // 9. Mint tokens to all actors
        address[] memory actors = _getActors();
        for (uint256 i = 0; i < actors.length; i++) {
            // Mint LQTY (main governance token)
            lqty.mint(actors[i], INITIAL_LQTY_AMOUNT);
            // Mint LUSD (staking rewards)
            lusd.mint(actors[i], INITIAL_LQTY_AMOUNT);
            // Mint BOLD (governance rewards)
            bold.mint(actors[i], INITIAL_LQTY_AMOUNT);
            // Mint bribe tokens
            bribeToken.mint(actors[i], INITIAL_LQTY_AMOUNT);
        }

        // 10. Initialize some actors with staked LQTY for realistic testing
        // This gives actors voting power from the start
        uint256 initialStakeAmount = 10000e18; // 10k LQTY stake per actor
        for (uint256 i = 0; i < actors.length; i++) {
            if (actors[i] == address(this)) continue; // Skip the test contract itself

            // Deploy UserProxy for this actor first
            vm.prank(actors[i]);
            governance.deployUserProxy();

            // Get the deployed UserProxy address
            address userProxyAddress = governance.deriveUserProxyAddress(actors[i]);

            // Approve UserProxy to spend LQTY (for deposits)
            vm.prank(actors[i]);
            lqty.approve(userProxyAddress, type(uint256).max);

            // Approve governance to spend BOLD (for registration fees)
            vm.prank(actors[i]);
            bold.approve(address(governance), type(uint256).max);

            // Approve initiatives to spend tokens for bribes
            vm.prank(actors[i]);
            bold.approve(address(bribeInitiative), type(uint256).max);
            vm.prank(actors[i]);
            bribeToken.approve(address(bribeInitiative), type(uint256).max);
            vm.prank(actors[i]);
            bold.approve(address(bribeInitiative2), type(uint256).max);
            vm.prank(actors[i]);
            lqty.approve(address(bribeInitiative2), type(uint256).max);

            // Deposit LQTY to get voting power
            vm.prank(actors[i]);
            governance.depositLQTY(initialStakeAmount);
        }

        // 12. Set up mock staking V1 with some initial rewards
        lusd.mint(address(this), 100000e18);
        lusd.approve(address(stakingV1), type(uint256).max);
        vm.deal(address(this), 100 ether);

        // Note: We don't add gains yet as no one is staked in V1
        // This can be done via target functions during fuzzing
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
