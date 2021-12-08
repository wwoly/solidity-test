// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract LibrariesExample {

    using SafeMath for uint;

    constructor() {
        tokenBalance[msg.sender] = 1;
    }

    mapping (address => uint) tokenBalance;


    function sendToken(address to, uint amount) public returns(bool) {
        tokenBalance[msg.sender] = tokenBalance[msg.sender].sub(amount);
        tokenBalance[to] = tokenBalance[to].add(amount);

        return true;
    }
}