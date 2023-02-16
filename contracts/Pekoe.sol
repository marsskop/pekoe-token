// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "OpenZeppelin/openzeppelin-contracts@4.8.1/contracts/token/ERC20/ERC20.sol";
import "OpenZeppelin/openzeppelin-contracts@4.8.1/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "OpenZeppelin/openzeppelin-contracts@4.8.1/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "OpenZeppelin/openzeppelin-contracts@4.8.1/contracts/access/Ownable.sol";
import "OpenZeppelin/openzeppelin-contracts@4.8.1/contracts/security/Pausable.sol";
import "OpenZeppelin/openzeppelin-contracts@4.8.1/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";


/**
 * @dev {Pekoe} token for internal use in Web3 dApp PekoeTips. Based on {ERC20}, including:
 *
 * - Preminted initial supply
 * - Ability for holders to burn (destroy) their tokens, see {ERC20-Burnable}
 * - Minting and pausability for the owner
 * - Snapshot machanism, see {ERC20-Snapshot}
 * - Permit extension enabling approvals via signatures, see {ERC20-Permit}
 * 
 * ZKP implementation to be added.
 * 
 */
contract Pekoe is ERC20, ERC20Burnable, ERC20Snapshot, Ownable, Pausable, ERC20Permit {
    constructor(uint256 initialSupply) ERC20("Pekoe", "PKT") ERC20Permit("Pekoe") {
        _mint(msg.sender, initialSupply);
    }

    function snapshot() public onlyOwner {
        _snapshot();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override(ERC20, ERC20Snapshot)
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}