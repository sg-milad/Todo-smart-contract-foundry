// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

error UnauthorizedAccount(address account);

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }
    mapping(address => Todo[]) public users;

    // An array of 'Todo' structs
    Todo[] public todos;

    function create(address _user, string calldata _text) public {
        if (_user != msg.sender) {
            revert UnauthorizedAccount(msg.sender);
        }
        users[_user].push(Todo(_text, false));
    }

    // Get a specific todo by index for the sender
    function get(
        uint256 _index
    ) public view returns (string memory text, bool completed) {
        Todo storage todo = users[msg.sender][_index];
        return (todo.text, todo.completed);
    }

    // Update the text of a specific todo
    function updateText(uint256 _index, string calldata _text) public {
        Todo storage todo = users[msg.sender][_index];
        todo.text = _text;
    }

    // Toggle the completed status of a specific todo
    function toggleCompleted(uint256 _index) public {
        Todo storage todo = users[msg.sender][_index];
        todo.completed = !todo.completed;
    }

    // Get the total number of todos for the sender
    function getTodoCount() public view returns (uint256) {
        return users[msg.sender].length;
    }
}
