// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract StartStopUpdateExample {
    address payable owner;

    bool paused;

    constructor() {
        // msg.sender is the transaction sender when the smart contract is created.
        owner = payable(msg.sender);
    }

    function sendMoney() public payable {

    }

    function pause() public {
        require(msg.sender == owner, "Only owner can pause the contract");
        paused = !paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "Only owner can withdraw money");
        require(!paused, "Contract is paused");
        _to.transfer(address(this).balance);
    }

    function destroy() public {
        require(msg.sender == owner, "Only owner can destroy");
        selfdestruct(owner);
    }
}