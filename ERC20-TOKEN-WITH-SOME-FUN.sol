// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//NAME = HAMID MUSTAFA DAHRI
//ROLL NO = PIAIC 71456

interface IERC20 {
   
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Hamid is IERC20{

    address public owner; 
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 private _totalSupply; 
     
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    
    constructor () public {
        name = "Hamid-TOKEN";
        symbol = "HMD";
        decimals = 18;  
        owner = msg.sender;
        _totalSupply = 1000000 * 10**decimals;  
        _balances[owner] = _totalSupply;
        emit Transfer(address(this),owner,_totalSupply);
     }
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        address sender = msg.sender;
        require(sender != address(0), " YOU ARE TRANSFERING FROM THE ZERO ADDRESS");
        require(recipient != address(0), "YOU ARE TRANSFERING TO THE ZERO ADDRESS");
        require(_balances[sender] > amount,"INSUFFICIENT BALANCE");
        _balances[sender] = _balances[sender] - amount;
        _balances[recipient] = _balances[recipient] + amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address tokenOwner = msg.sender;
        require(tokenOwner != address(0), "APPROVE FROM THE ZERO ADDRESS");
        require(spender != address(0), "APPROVE TO THE ZERO ADDRESS");
        _allowances[tokenOwner][spender] = amount;
        emit Approval(tokenOwner, spender, amount);
        return true;
    }
    function transferFrom(address tokenOwner, address recipient, uint256 amount) public virtual override returns (bool) {
        address spender = msg.sender;
        uint256 _allowance = _allowances[tokenOwner][spender]; 
        require(_allowance > amount, "TRANSFER AMMOUNT IS EXCEDED");
        _allowance = _allowance - amount;
        _balances[tokenOwner] =_balances[tokenOwner] - amount; 
        _balances[recipient] = _balances[recipient] + amount;
        emit Transfer(tokenOwner, recipient, amount);
        _allowances[tokenOwner][spender] = _allowance;
        emit Approval(tokenOwner, spender, amount);
        return true;
    }
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
     function allowance(address tokenOwner, address spender) public view virtual override returns (uint256) {
        return _allowances[tokenOwner][spender]; 
    }
}