pragma solidity ^0.8.9;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol';


contract GinoaToken is ERC20{
    constructor() ERC20('GinoaToken','GIN'){
        _mint(msg.sender, 16000000 * 10**18);
    }
}