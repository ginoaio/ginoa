// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Ginoa is ERC20, ERC20Burnable, Ownable {
    mapping (address=>uint) balances;
    mapping (address => uint) balance;
    uint public totalMint = 50000000;
    uint public maxSupply = 160000000 * 10 ** decimals();
    uint256 public tokenPerEther = 5000;
    constructor() ERC20("Ginoa", "GIN") {
        _mint(msg.sender, 50000000 * 10 ** decimals());
    }
    event Buy(address buyer, uint256 amountEther, uint256 amountToken);
    function checkTotalSupply(uint _amount) public view returns(bool){
        if (totalMint + _amount > maxSupply){
            return false;
        }else{
            return true;
        }
}
    function buy() payable public{
        uint256 amountToBuy = msg.value * tokenPerEther;
        require(msg.value > 0, "Send ETH to buy some tokens");
        require(checkTotalSupply(amountToBuy), 'Minting limit is reached');
        _mint(msg.sender, amountToBuy);
        totalMint += amountToBuy;
        emit Buy(msg.sender, msg.value, amountToBuy);
        
}
    function withdraw() public onlyOwner{
        uint256 ownerBalance = address(this).balance;
        require(ownerBalance > 0, "Owner has not balance to withdraw");

        (bool sent,) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send user balance back to the owner");
}
}