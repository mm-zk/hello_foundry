// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/console.sol";
import "../lib/forge-std/src/Test.sol";

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}

contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        console.log("Inside setup");
        counter = new Counter();
        console.log("After setup");
    }

    function test_Increment() public {
        console.log("inside_first");
        assertEq(counter.number(), 0);
        counter.increment();
        assertEq(counter.number(), 1);
        console.log("value: ", counter.number());
        console.log("value2: ", uint256(counter.number()));
        console.log(counter.number());
        console.logInt(int256(counter.number()));
        console.logUint(counter.number());
        console.log("value3: ", "aa");
    }

    function test_Increment_twice() public {
        console.log("inside");
        assertEq(counter.number(), 0);
        counter.increment();
        assertEq(counter.number(), 1);
        counter.increment();
        assertEq(counter.number(), 7);
        console.log("value: ", counter.number());
    }
}

contract ContractBTest is Test {
    uint256 testNumber;

    function setUp() public {
        testNumber = 42;
    }

    function test_NumberIs42() public {
        assertEq(testNumber, 42);
    }

    function testFail_Subtract43() public {
        testNumber -= 43;
    }
}

error Unauthorized();

contract OwnerUpOnly {
    address public immutable owner;
    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    function increment() external {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        count++;
    }
}

contract OwnerUpOnlyTest is Test {
    OwnerUpOnly upOnly;

    function setUp() public {
        upOnly = new OwnerUpOnly();
    }

    function test_IncrementAsOwner() public {
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }
    function XtestFail_IncrementAsNotOwner() public {
        //vm.expectRevert(Unauthorized.selector);
        //vm.prank(address(0));
        upOnly.increment();
    }
}


contract EmitContractTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function Xtest_ExpectEmit() public {
        ExpectEmit emitter = new ExpectEmit();
        // Check that topic 1, topic 2, and data are the same as the following emitted event.
        // Checking topic 3 here doesn't matter, because `Transfer` only has 2 indexed topics.
        vm.expectEmit(true, true, false, true);
        // The event we expect
        emit Transfer(address(this), address(1337), 1337);
        // The event we get
        emitter.t();
    }

    function Xtest_ExpectEmit_DoNotCheckData() public {
        ExpectEmit emitter = new ExpectEmit();
        // Check topic 1 and topic 2, but do not check data
        vm.expectEmit(true, true, false, false);
        // The event we expect
        emit Transfer(address(this), address(1337), 1338);
        // The event we get
        emitter.t();
    }
}

contract ExpectEmit {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function t() public {
        emit Transfer(msg.sender, address(1337), 1337);
    }
}