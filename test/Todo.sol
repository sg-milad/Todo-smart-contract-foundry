// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Todos} from "../src/Todo.sol";
import {stdError} from "forge-std/StdError.sol";

error UnauthorizedAccount(address account);

contract TodosTest is Test {
    Todos public todos;

    address user1 = address(0x1);
    address user2 = address(0x2);

    function setUp() public {
        todos = new Todos();
    }

    function testCreateTodo() public {
        vm.startPrank(user1); // Start acting as user1
        todos.create(user1, "Buy groceries");

        (string memory text, bool completed) = todos.get(0);
        assertEq(text, "Buy groceries");
        assertEq(completed, false);
        vm.stopPrank();
    }

    function testCannotCreateTodoForAnotherUser() public {
        vm.startPrank(user1);
        vm.expectRevert(
            abi.encodeWithSelector(UnauthorizedAccount.selector, user1)
        );
        todos.create(user2, "Buy groceries");
        vm.stopPrank();
    }

    function testUpdateTodoText() public {
        vm.startPrank(user1);
        todos.create(user1, "Buy groceries");

        todos.updateText(0, "Buy fruits");
        (string memory text, ) = todos.get(0);
        assertEq(text, "Buy fruits");
        vm.stopPrank();
    }

    function testToggleCompleted() public {
        vm.startPrank(user1);
        todos.create(user1, "Buy groceries");

        (, bool completedBefore) = todos.get(0);
        assertEq(completedBefore, false);

        todos.toggleCompleted(0);
        (, bool completedAfter) = todos.get(0);
        assertEq(completedAfter, true);

        todos.toggleCompleted(0);
        (, bool completedAgain) = todos.get(0);
        assertEq(completedAgain, false);
        vm.stopPrank();
    }

    function testTodoCount() public {
        vm.startPrank(user1);
        todos.create(user1, "Task 1");
        todos.create(user1, "Task 2");

        uint256 count = todos.getTodoCount();
        assertEq(count, 2);
        vm.stopPrank();
    }

    function testCannotAccessOtherUserTodos() public {
        vm.startPrank(user1);
        todos.create(user1, "User1 Task");
        vm.stopPrank();

        vm.startPrank(user2);
        vm.expectRevert(); // Should revert since user2 has no todos
        todos.get(0);
        vm.stopPrank();
    }
}
