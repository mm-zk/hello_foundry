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
