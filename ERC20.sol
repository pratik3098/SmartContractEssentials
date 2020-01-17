pragma solidity ^0.5.16;
interface IERC20 {
    // optional
    // function name() public view returns (string);
    //function symbol() public view returns (string);
    //function decimals() public view returns (uint8);

    // mandatory
    function totalSupply() external view returns (uint256);
    function balanceOf(address owner) external view returns (uint256 balance);
    function transfer(address recipient, uint256 amount) external returns (bool success);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool success);
    function approve(address spender, uint256 amount) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    event Transfer(address indexed sender, address indexed recipient, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
}



contract Token is IERC20{
    string  public  name;
    string  public  symbol;
    uint    public  decimals;
    uint    public  total_supply;
    address public  owner;
    mapping (address => uint)                       balances;
    mapping (address => mapping (address => uint)) approvals;
    

    constructor(uint total_balance) public {
        name = "George Brown Token";                                  
        symbol = "GBC";    
        decimals = 2; 
        owner=msg.sender;
        balances[msg.sender] = total_balance;               
        total_supply = total_balance;                       
           
    }
    
    function totalSupply() external view returns (uint256){    
        return total_supply;  
    }
    function balanceOf(address acc_owner) external view returns (uint256 balance){ 
        return balances[acc_owner]; 
    } 
    function transfer(address recipient, uint256 amount) external onlyOwner returns (bool success) 
    {  
        require(amount<=balances[owner],"Error: Insufficient amount.");
        require(recipient!=address(0),"Error: Invalid recipient.");
        balances[owner]=balances[owner] - amount; 
        balances[recipient]=balances[recipient]+amount;
        emit Transfer(msg.sender,recipient,amount);
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool success){
        require(approvals[sender][recipient]==amount,"Error: Transfer not approved.");
        balances[sender]-=amount;
        balances[recipient]+=amount;
        approvals[sender][recipient]=0;
        emit Transfer(sender,recipient,amount);
        return true;
    }
    function approve(address spender, uint256 amount) external returns (bool success){
          approvals[msg.sender][spender]=amount;
          emit Approval(msg.sender, spender, amount);
          return true;
    }
    function allowance(address _owner, address _spender) external view returns (uint256 remaining){
         return approvals[_owner][_spender];
    }
   
    modifier onlyOwner{
          require(msg.sender==owner,"Error: Only owner is allowed.");
          _;
    }
}
