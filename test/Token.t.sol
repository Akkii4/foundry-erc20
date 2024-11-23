// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TokenScript} from "../script/Token.s.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token public token;
    TokenScript public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 constant INITIAL_SUPPLY = 1000 ether;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function setUp() public {
        deployer = new TokenScript();
        token = deployer.run();
        vm.prank(msg.sender);
        token.transfer(address(this), INITIAL_SUPPLY);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), INITIAL_SUPPLY);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY);
    }

    function testMetadata() public {
        assertEq(token.name(), "Token");
        assertEq(token.symbol(), "TKN");
        assertEq(token.decimals(), 18);
    }

    function testTransfer() public {
        uint256 amount = 1000 * 1e18;

        // Test successful transfer
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), bob, amount);

        bool success = token.transfer(bob, amount);
        assertTrue(success);
        assertEq(token.balanceOf(bob), amount);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY - amount);
    }

    function testTransferFail() public {
        uint256 amount = INITIAL_SUPPLY + 1;

        // Should fail when trying to transfer more than balance
        vm.expectRevert();
        token.transfer(bob, amount);
    }

    function testApproveAndTransferFrom() public {
        uint256 amount = 1000 * 1e18;

        // Test approval
        vm.expectEmit(true, true, false, true);
        emit Approval(address(this), alice, amount);

        bool success = token.approve(alice, amount);
        assertTrue(success);
        assertEq(token.allowance(address(this), alice), amount);

        // Test transferFrom
        vm.prank(alice);
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), bob, amount);

        success = token.transferFrom(address(this), bob, amount);
        assertTrue(success);
        assertEq(token.balanceOf(bob), amount);
        assertEq(token.allowance(address(this), alice), 0);
    }

    function testTransferFromFail() public {
        uint256 amount = 1000 * 1e18;

        // Should fail without approval
        vm.prank(alice);
        vm.expectRevert();
        token.transferFrom(address(this), bob, amount);
    }

    function testTransferZeroAddress() public {
        uint256 amount = 1000 * 1e18;

        // Should fail when transferring to zero address
        vm.expectRevert();
        token.transfer(address(0), amount);
    }

    function testFuzzingTransfer(uint256 amount) public {
        // Bound the amount to be within the total supply
        amount = bound(amount, 0, INITIAL_SUPPLY);

        bool success = token.transfer(bob, amount);
        assertTrue(success);
        assertEq(token.balanceOf(bob), amount);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY - amount);
    }

    function testFuzzingApproveAndTransferFrom(uint256 amount) public {
        // Bound the amount to be within the total supply
        amount = bound(amount, 0, INITIAL_SUPPLY);

        bool success = token.approve(alice, amount);
        assertTrue(success);

        vm.prank(alice);
        success = token.transferFrom(address(this), bob, amount);
        assertTrue(success);

        assertEq(token.balanceOf(bob), amount);
        assertEq(token.allowance(address(this), alice), 0);
    }
}
