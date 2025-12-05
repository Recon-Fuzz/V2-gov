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

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    BribeInitiative bribeInitiative;
    Governance governance;
    UserProxy userProxy;
    UserProxyFactory userProxyFactory;
    
    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        bribeInitiative = new BribeInitiative(); // TODO: Add parameters here
        governance = new Governance(); // TODO: Add parameters here
        userProxy = new UserProxy(); // TODO: Add parameters here
        userProxyFactory = new UserProxyFactory(); // TODO: Add parameters here
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
