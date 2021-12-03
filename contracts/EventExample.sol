// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Owned.sol";

contract EventExample is Owned {

    mapping(address => uint) public tokenBalance;
    
    event TokensSent(address from, address to, uint amount);

    constructor() {
        tokenBalance[owner] = 100;
    }

    function sendToken(address to, uint amount) public returns(bool, bool) {
        require(tokenBalance[msg.sender] >= amount, "not enought tokens");
        require(amount > 0, "amount not valid");

        // Validation for wrap around
        assert(tokenBalance[msg.sender] - amount <= tokenBalance[msg.sender]);
        assert(tokenBalance[to] + amount >= tokenBalance[to]);
        
        tokenBalance[msg.sender] -= amount;
        tokenBalance[to] += amount;

        emit TokensSent(msg.sender, to, amount);

        return (true, true);
    }

}