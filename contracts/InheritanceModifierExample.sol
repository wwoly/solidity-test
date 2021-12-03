// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Owned.sol";

contract InheritanceModifierExample is Owned {
    mapping(address => uint) public tokenBalance;

    uint tokenPrice = 1 ether;

    constructor() {
        tokenBalance[owner] = 100;
    }


    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

    function purchaseToken() public payable {
        require(msg.value >= tokenPrice, "give more money");
        require(tokenBalance[owner] * tokenPrice / msg.value > 0, "not enough tokens");

        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;

        // Good guy would transfer rest back to sender
        // payable(msg.sender).transfer(msg.value % tokenPrice);
    }

    function sendToken(address to, uint amount) public {
        require(tokenBalance[msg.sender] >= amount, "not enought tokens");
        require(amount > 0, "amount not valid");

        // Validation for wrap around
        assert(tokenBalance[msg.sender] - amount <= tokenBalance[msg.sender]);
        assert(tokenBalance[to] + amount >= tokenBalance[to]);
        
        tokenBalance[msg.sender] -= amount;
        tokenBalance[to] += amount;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function scamEveryone() public {
        selfdestruct(owner);
    }
}