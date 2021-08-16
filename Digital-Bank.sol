// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 
 
 // Roll Number  PIAIC71456
 // Name Hamid Mustafa Dahri
 
contract Bank {
    uint public CapitalBank;
    address payable owner;
    event bankNotification(string);
    uint LuckyFive;
    mapping(address => uint256) accountBalance;
    address[] bonus;
    
    fallback() payable external {
        owner.transfer(msg.value);
    }
    
    receive() payable external {emit bankNotification("A amount of ether received");}
     
     
    modifier isOWNER (address _owner) {
        require(_owner == owner, "Run by Contract owner only");
        _;
    }
    
      function luckyFive(address _address) private view returns (bool pay){
        pay = true;
        for (uint8 i = 0 ; i <bonus.length ; i++){
            if(_address == bonus[i]){
                pay = false;
                break;
            }
        }
        return pay;
        
    }
    
    function accountBalances(address _address) public view returns (uint256 _balance) {
        return accountBalance[_address];
    }
    
   
    constructor() payable {
        require (msg.value >= 50 ether, "please send 50 ethers to start the bank");
        owner = payable(msg.sender);
        CapitalBank = msg.value;
        emit bankNotification("Bank is now started and fully functional");
    }
    
  
    
    function closeBank() payable public isOWNER(msg.sender) {
        selfdestruct(owner);
        emit bankNotification("bank is closed permanently");
    }
    
   
    
    function openAccount() payable public{
        require(msg.value >= 5 ether,"You need to deposit 5 ethers to open an account");
        require(accountBalance[msg.sender] == 0 , "You already have an account");
        accountBalance[msg.
        sender] = accountBalance[msg.sender] + msg.value;
     
        emit bankNotification("Account opened successfully");
        if(bonus.length < 5 && luckyFive(msg.sender)== true){
            bonus.push(msg.sender);
            accountBalance[msg.sender]+=1 ether;
            emit bankNotification("You got 1 ether as a bonus because you'r in our five lucky customers");
        }
    }
    
    
    function depositAmount(address _account) payable public {
        require(accountBalance[_account] > 0 ether,"you need to open account first by depositing 5 ethers");
        require(msg.value < 0 , "you need to deposit minimum 1 ether " );
        accountBalance[_account]+=msg.value;
        emit bankNotification("Balanced Updated and amount successfully deposited");
    }
    
    function withdraw(uint256 _amount) payable public {
        require(accountBalance[msg.sender] >= _amount , "Insufficient Balanace");
        accountBalance[msg.sender]-=_amount;
        payable(msg.sender).transfer(_amount);
        emit bankNotification("successfully withdraw and balanced updated");
    }
    
  
     
     
    function closeAccount() payable public {
        require(accountBalance[msg.sender] > 0 , "account closed");
        payable(msg.sender).transfer(accountBalance[msg.sender]);
        accountBalance[msg.sender]=0;
        emit bankNotification("ammount transfer backed and account closed successfully");
    } 
    
}