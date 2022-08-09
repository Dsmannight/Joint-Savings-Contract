/*
Joint Savings Account
---------------------
*/

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Varaibles
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastToWithdrawAmount;
    uint public contractBalance;

    /*
    Define a function named **withdraw** that will accept two arguments.
    - A `uint` variable named `amount`
    - A `payable address` named `recipient`
    */
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

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {
        // get new contractBalance
        contractBalance = address(this).balance;
    }

    /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{
        // Set the accountOne and accountTwo addresses
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    Finally, add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
    function() external payable {}
}
