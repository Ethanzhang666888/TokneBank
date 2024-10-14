// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface BaseERC20 {

        function balanceOf(address _owner) external  view returns (uint256 balance) ;
        function transfer(address _to, uint256 _value) external  returns (bool success) ;
        function transferFrom(address _from, address _to, uint256 _value) external  returns (bool success) ;

}



contract TokenBank {

    BaseERC20 public token;
    mapping(address => uint256) private balances;

    constructor(address _tokenAddress) {
        token = BaseERC20(_tokenAddress);
    }

    // function deposit(uint256 _amount) public returns (bool){

    //     token.transferFrom(msg.sender, address(this), _amount);

    //     return true;

    // }

    // function withdraw(uint256 _amount) public returns (bool){

    //     token.transfer(msg.sender, _amount);

    //     return true;

    // }
        function deposit(uint256 _amount) public returns (bool) {
        require(_amount > 0, "Amount must be greater than 0");
        
        require(token.transferFrom(msg.sender, address(this), _amount),"fff ");

        balances[msg.sender] += _amount;

        return true;
    }

    function withdraw(uint256 _amount) public returns (bool) {

        require(_amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        require(token.transfer(msg.sender, _amount),"fff");

        return true;
    }

    function balanceOf(address user) public view returns (uint256) {
        return balances[user];
    }

}
