pragma solidity 0.5.16;
// import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";

contract Bank {

    mapping(address=>uint) public balances;
    // using SafeMath for uint256;

    function deposit() public payable {
        require(balances[msg.sender] + msg.value >= balances[msg.sender]);
        balances[msg.sender] += msg.value;
        // balances[msg.sender] = balances[msg.sender].add(msg.value);
        
    }
   
    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount,"Error: Insufficient balance.");
        balances[msg.sender] = balances[msg.sender] - amount;
        msg.sender.transfer(amount);
    }
}

contract Customer {
    Bank public bank;
    uint public defaultWithdrawalAmount = 1;
    uint public try_count = 0;
    uint public max_try = 3;
   

    function setBank(address bankAddress) public {
        bank = Bank(bankAddress);
    }
   
   
    function deposit() public payable {
        bank.deposit.value(msg.value)();
    }
    
    
    function withdraw(uint amount) public {
        bank.withdraw(amount);
        assert(false);
    }
    
    function() external {
        require(try_count < max_try, "Error: Maximum try allowed (3)" );
        try_count=0;
    }
}