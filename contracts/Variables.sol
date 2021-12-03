// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract WorkingWithVariables {
    uint256 public myUint;
    bool public myBool;
    uint8 public myUint8;
    string public myString = "Hello world!";

    address public myAddress;

    function setMyUint(uint _myUint) public {
        if (myBool) {
            myUint = _myUint;
        }
    }

    function allowInteraction() public {
        myBool = !myBool;
    }

    function incrementUint8() public {
        unchecked {
            myUint8++;
        }
    }
    
    function decrementUint8() public {
        unchecked {
            myUint8--;
        }
    }

    function maxMyUint8() public {
        myUint8 = 255;
    }

    function setAddress(address _address) public {
        if (myBool) {
            myAddress = _address;
        }
    }

    function getBalance() public view returns(uint) {
        return myAddress.balance;
    }

    function setMyString(string memory _myString) public {
        if (myBool) {
            myString = _myString;
        }
    }
}