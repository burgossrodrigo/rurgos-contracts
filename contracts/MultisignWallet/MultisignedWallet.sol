pragma solidity 0.8.1;

import "./Allowance.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract MultigisnedWallet is Allowance, Ownable {

    event moneySent(address _forWho, uint _amount);
    event moneyReceived(address _from, uint _amount);

    struct Payment {
        uint amount;
        uint timestamp;
    }

    struct Balance{
        uint totalBalance;
        uint numPayments;
        mapping (uint => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived;

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawMoney(address payable _to, uint _amount) public isAllowed {
        require(balanceReceived[msg.sender].totalBalance >= _amount, "not enough funds to withdraw");
        require(allowance[_to] >= _amount, "The amount is higher then the address allowance");
        assert(balanceReceived[msg.sender].totalBalance >= balanceReceived[msg.sender].totalBalance - _amount);
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

   /* 
   function receiveMoney() public payable{
       balanceReceived[msg.sender].totalBalance += msg.value;
       Payment memory payment = Payment(msg.value, now);
       balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
       balanceReceived[msg.sender].numPayments++;
   }
   */

    receive() external payable {
        emit moneyReceived(msg.sender, msg.value);
    }
}