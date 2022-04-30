pragma solidity 0.8.1;

contract Allowance {
    
    event allowanceChanged(address _forWho, address _fromWho, uint _oldAmount, uint _newAmount);
    mapping(address => bool) public validateMapping;
    mapping(address => uint) public allowance;

    constructor() {
        validateMapping[msg.sender] = true;
    }

    modifier isAllowed {
        require(validateMapping[msg.sender] == true, "You are not allowed to access such feature");
        _;
    }

    function validateAddress(address _address) public isAllowed  {
        validateMapping[_address] = true;
    }

    function unvalidateAddress(address _address) public isAllowed {
        validateMapping[_address] = false;
    }

    function addAllowance(address _who, uint _amount) public isAllowed {
        require(msg.sender != _who, "You cant give allowance to yourself");
        uint oldAmount = allowance[_who] + _amount;
        emit allowanceChanged(_who, msg.sender, allowance[_who], oldAmount);
        allowance[_who] += _amount;
    }

        function removeAllowance(address _who, uint _amount) public isAllowed {
        require(msg.sender != _who, "You cant remove allowance to yourself");
        uint oldAmount = allowance[_who] - _amount;
        emit allowanceChanged(_who, msg.sender, allowance[_who], oldAmount);
        allowance[_who] -= _amount;
    }



    //@dev return an status of an address

    function addressStatus(address _address) public view returns(bool) {
        return validateMapping[_address];
    }

    //@dev modfiers to filter the access of a function


}