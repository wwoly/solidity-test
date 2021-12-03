// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract FunctionsExample {
    mapping(address => uint) public balanceReceived;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // Writing functions can call view and pure functions. 
    // View functions can call pure functions.
    // Cannot affect the state of the smart contract.
    // Does not cost gas.
    function getOwner() public view returns(address) {
        return owner;
    }

    // Pure function cannot interact with anything other than pure functions.
    // Cannot change the state of the smart contract.
    // Does not cost gas.
    function convertWeiToEth(uint amountInWei) public pure returns(uint) {
        return amountInWei / 1 ether;
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "you are not the owner");
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        // Make sure that wrap around does not happen.
        // Assert function is used to check the internal states.
        assert((balanceReceived[msg.sender] + msg.value) >= balanceReceived[msg.sender]);

        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable to, uint amount) public {
        // Require function is used to check inputs
        require (amount <= balanceReceived[msg.sender], "not enough money");
        // Check that balance is correctly reduced.
        assert((balanceReceived[msg.sender] - amount) <= balanceReceived[msg.sender]);

        balanceReceived[msg.sender] -= amount;
        to.transfer(amount);
    }

    // Fallback function that is called if no specific function is called.
    fallback() external payable {
        receiveMoney();
    }
    
    // New way of defining fallback for receiving ether.
    receive() external payable {
        receiveMoney();
    }
}