pragma solidity 0.8.1;

contract Allowance {
    
    event allowanceChanged(address _forWho, address _fromWho, uint _oldAmount, uint _newAmount);
    mapping(address => bool) public validateMapping;
    mapping(address => uint) public allowance;

    constructor() {
        validateMapping[msg.sender] = true;
    }

    function convertWeiToEther(uint _amountWei) public pure returns(uint) {
        return _amountWei / 1 ether;
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
        emit allowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] + _amount);
        allowance[_who] = convertWeiToEther(_amount);
    }

    function removeAllowance(address _who, uint _amount) public isAllowed {
        require(msg.sender != _who, "You cant remove allowance to yourself");
        emit allowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= convertWeiToEther(_amount);
    }

    function addressStatus(address _address) public view returns(bool) {
        return validateMapping[_address];
    }

    function addressAllowance(address _address) public view returns(uint){
        return allowance[_address];
    }

}