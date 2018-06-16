pragma solidity ^0.4.18;

contract PaymentMilestone{

  // The owner is the person who publishes the contract
  address public owner; 
  // The recipient is the person to recieve the payments
  address public recipient;

  // This will send out a message to anyone who is listening to the contract that a transfer happened  
  event Sent(address from, address to, uint amount);

  // This is the default function that we will use to put in the deposit
  function() payable public {}

  // This function is called at the time that the contract is created
  function constructor(address payee) public {
	  // Set the pserson who paid to create the contract as the owner
      owner  = msg.sender;
	  // Set the person that the money is going to as the recipient
      recipient = payee;
  }

  // Time to pay out deposited funds
  function payout(uint amount) public {
	  // Only the owner can make a payment and they can't pay more than is in there
      if(msg.sender == owner && address(this).balance >= amount) recipient.transfer(amount);
	  // If the conditions are not matched then fail
      else revert();
  }
  
  // The owner can cancel the payments and all of the money reverts back to them
  function cancel() public {
	  // Only owner can transfer out the balance back to their account
      if(msg.sender == owner) owner.transfer(address(this).balance);
  }

}
