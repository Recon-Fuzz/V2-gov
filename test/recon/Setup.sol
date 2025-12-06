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
import "src/UserProxyFactory.sol";
import {IGovernance} from "src/interfaces/IGovernance.sol";
import {MockERC20} from "test/mocks/MockERC20.sol";
import {MockStakingV1} from "test/mocks/MockStakingV1.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    BribeInitiative bribeInitiative;
    Governance governance;
    UserProxy userProxy;
    UserProxyFactory userProxyFactory;

    MockERC20 lqty;
    MockERC20 lusd;
    MockERC20 bold;
    MockERC20 bribeToken;
    MockStakingV1 stakingV1;

    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        // Deploy mock tokens
        lqty = new MockERC20("LQTY", "LQTY", 18);
        lusd = new MockERC20("LUSD", "LUSD", 18);
        bold = new MockERC20("BOLD", "BOLD", 18);
        bribeToken = new MockERC20("BRIBE", "BRIBE", 18);

        // Deploy mock staking
        stakingV1 = new MockStakingV1(address(lqty));

        // Deploy UserProxyFactory
        userProxyFactory = new UserProxyFactory(address(lqty), address(lusd), address(stakingV1));

        // Deploy UserProxy
        userProxy = new UserProxy(address(lqty), address(lusd), address(stakingV1));

        // Deploy Governance
        IGovernance.Configuration memory config = IGovernance.Configuration({
            registrationFee: 1e18,
            registrationThresholdFactor: 0.01e18,
            unregistrationThresholdFactor: 4e18,
            unregistrationAfterEpochs: 4,
            votingThresholdFactor: 0.04e18,
            minClaim: 500e18,
            minAccrual: 1000e18,
            epochStart: uint256(block.timestamp),
            epochDuration: 604800,
            epochVotingCutoff: 518400
        });
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

        // Deploy BribeInitiative
        bribeInitiative = new BribeInitiative(address(governance), address(bold), address(bribeToken));
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
