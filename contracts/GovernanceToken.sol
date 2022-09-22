// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract GovernanceToken is ERC20, Ownable, ERC20Permit, ERC20Votes {

    uint256 public _price = 0.1 ether;
    address public _treasury;

    constructor() ERC20("GovernanceToken", "GOV") ERC20Permit("GovernanceToken") {}

    function setTreasury(address treasury) public onlyOwner{
        _treasury = treasury;
    }

    function mint() public payable {
        require(_treasury != address(0), "GOV: Treasury not set");
        _mint(msg.sender, msg.value/_price * (10**decimals()));
        payable(_treasury).transfer(msg.value);
    }

    // The following functions are overrides required by Solidity.

    function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._burn(account, amount);
    }
}