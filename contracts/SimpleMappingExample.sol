// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SimpleMappingExample {
    mapping (address => Balance) public myMapping;

    struct Payment {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping (uint => Payment) payments;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        myMapping[msg.sender].totalBalance += msg.value;
        
        addPayment(msg.sender, msg.value);

    }

    function withdraw(address from, uint amount) public {
        require(myMapping[from].totalBalance >= amount, "Get more money, plz.");
        require(address(this).balance >= amount, "No moar money, sry.");

        addPayment(from, amount);

        myMapping[from].totalBalance -= amount;
        payable(msg.sender).transfer(amount);
    }

    function addPayment(address _address, uint amount) private {
        Payment memory payment = Payment(amount, block.timestamp);
        myMapping[_address].payments[myMapping[_address].numPayments] = payment;
        myMapping[msg.sender].numPayments++;
    }
}