// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AgentVault {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Function to deposit native gas token (BNB/tBNB) into the vault
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw a specific amount
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdraw amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Deduct balance before external call to prevent reentrancy attacks
        balances[msg.sender] -= amount;
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdraw failed");
        
        emit Withdraw(msg.sender, amount);
    }

    // Function to check the balance of the caller
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
