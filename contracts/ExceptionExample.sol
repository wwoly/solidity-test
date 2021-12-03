// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ExceptionExample {
    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        // Make sure that wrap around does not happen.
        // Assert function is used to check the internal states.
        assert((balanceReceived[msg.sender] += msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable to, uint amount) public {
        // Require function is used to check inputs
        require (amount <= balanceReceived[msg.sender], "not enough money");
        // Check that balance is correctly reduced.
        assert((balanceReceived[msg.sender] -= amount) <= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] -= amount;

        to.transfer(amount);
    }
}