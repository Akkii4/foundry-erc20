// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    Token public token;
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function setUp() public {}

    function run() public returns (Token) {
        vm.startBroadcast();

        token = new Token(INITIAL_SUPPLY);

        vm.stopBroadcast();
        return token;
    }
}
