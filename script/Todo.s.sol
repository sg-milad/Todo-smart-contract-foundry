// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Todos} from "../src/Todo.sol";

contract TodosScript is Script {
    Todos public todos;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        todos = new Todos();

        vm.stopBroadcast();
    }
}
