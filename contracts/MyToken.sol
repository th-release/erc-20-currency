// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, ERC20Burnable, ERC20Permit {
    uint256 private HardCap = 21000000;
    
    constructor(address initialOwner)
        ERC20("Currency", "CRY")
        ERC20Permit("Currency")
    {}

    function buy(address to, uint256 amount) 
        public 
    {
        if (totalSupply() + amount > HardCap) {
            revert("It can no longer be issued.");
        }

        _mint(to, amount);
    }

    function sell(address account, uint256 amount)
        public 
    {
        if (totalSupply() - amount < 0) {
            revert("It can no longer be incinerated.");
        }

        _burn(account, amount);
    }

    function send(address from, address to, uint256 value) 
        public
    {
        transfer(from, to, value);
    }
}
