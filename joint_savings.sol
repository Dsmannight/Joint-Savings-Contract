/*
Joint Savings Account
---------------------
*/

pragma solidity ^0.5.0;

contract JointSavings {

    // Varaibles
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastToWithdrawAmount;
    uint public contractBalance;

    // Withdraw function
    function withdraw(uint amount, address payable recipient) public {

        // Require the account making the function call to be the owner of accountOne or accountTwo
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Require the account to have enough to withdraw
        require(contractBalance >= amount, "Insufficient funds!");

        // Set the lastToWithdraw to the recipient
        if (lastToWithdraw != recipient){
            lastToWithdraw = recipient;
        }

        // transfer amount to the recipient
        recipient.transfer(amount);

        // Set lastWithdrawAmount equal to amount
        lastToWithdrawAmount = amount;

        // get new contractBalance
        contractBalance = address(this).balance;
    }
    
    // Deposit function
    function deposit() public payable {
        // get new contractBalance
        contractBalance = address(this).balance;
    }

    // SetAccounts of saving account
    function setAccounts(address payable account1, address payable account2) public{
        // Set the accountOne and accountTwo addresses
        accountOne = account1;
        accountTwo = account2;
    }

    // Default function
    function() external payable {}
}
