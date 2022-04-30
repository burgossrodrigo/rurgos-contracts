pragma solidity ^0.5.13;


contract Owned {
    address owner;

    constructor() public{ 
        owner = msg.sender;
     }

     modifier onlyOwner { 
         require(msg.sender == owner, "Only the owner of the contract can acess this functionality");
         _;   
      }

        function isOwner(address _address)internal view returns(bool){
            return owner == _address;
        }
      
}