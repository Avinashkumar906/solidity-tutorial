// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hellow{
    string public greet;

    constructor(string memory _greet){
        greet = _greet;
    }

    function setGreet(string memory _greet) public {
        greet = _greet;
    }

}