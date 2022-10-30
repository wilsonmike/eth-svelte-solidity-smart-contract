pragma solidity ^0.8.4;

import 'hardhat/console.sol';

contract TipJar {
    uint256 public totalTips;
    
    address payable owner;

    struct Tip {
        address sender;
        string message;
        string name;
        uint256 timestamp;
        uint256 amount;
    }

    Tip[] tips;

    event NewTip(address indexed from, string message, string name, uint256 amount);
    event NewWithdraw(uint256);

    constructor() {
        owner = payable(msg.sender);
    }

    function sendTip(string memory _message, string memory _name) public payable {
        require(msg.sender.balance >= msg.value, "Not enough funds");
        
        totalTips+= 1;
        tips.push(Tip(msg.sender, _message, _name, block.timestamp, msg.value));
        emit NewTip(msg.sender, _message, _name, msg.value);
    }

    function getAllTips() public view returns (Tip[] memory) {
        return tips;
    }

    modifier onlyOwner() { 
        require(owner == msg.sender, 'caller is not the owner');
        _;
    }

    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "You have no ether to withdraw");
        (bool success, ) = owner.call{value: amount}('');
        require(success, "Withdraw failed");
        emit NewWithdraw(amount);
    }
}