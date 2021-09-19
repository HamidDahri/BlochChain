// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//NAME = HAMID MUSTAFA DAHRI
//ROLL NO = PIAIC 71456

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract Hamid is IERC20 {
    address public owner;
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 private _totalSupply;
    uint256 private _mintTokenLimit;
    uint256 private _circulatingSupply;
    uint256 private Now;
    uint256 private deadline;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor() public {
        name = "Hamid-TOKEN";
        symbol = "HMD";
        decimals = 18;
        owner = msg.sender;
        Now = block.timestamp;
        deadline = Now + (30 * 1 days);
        _mintTokenLimit = 1000000000 * 10**decimals;
        _circulatingSupply = 1000 * 10**decimals;
        _totalSupply = _mintTokenLimit;
        _balances[owner] = _totalSupply;
        emit Transfer(address(this), owner, _totalSupply);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can run this function");
        _;
    }

    function mint(uint256 addAmount) public onlyOwner returns (uint256) {
        require(
            _circulatingSupply + addAmount < _mintTokenLimit,
            "miniting limit exceded"
        );
        _balances[msg.sender] += addAmount;
        _circulatingSupply += addAmount;
        return _circulatingSupply;
    }

    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        address sender = msg.sender;
        require(
            sender != address(0),
            " YOU ARE TRANSFERING FROM THE ZERO ADDRESS"
        );
        require(
            recipient != address(0),
            "YOU ARE TRANSFERING TO THE ZERO ADDRESS"
        );
        require(_balances[sender] > amount, "INSUFFICIENT BALANCE");
        require(
            block.timestamp >= deadline,
            "CANNOT TRANSFER TOKEN UNTIL THE DEADLINE"
        );
        _balances[sender] = _balances[sender] - amount;
        _balances[recipient] = _balances[recipient] + amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        address tokenOwner = msg.sender;
        require(tokenOwner != address(0), "APPROVE FROM THE ZERO ADDRESS");
        require(spender != address(0), "APPROVE TO THE ZERO ADDRESS");
        _allowances[tokenOwner][spender] = amount;
        emit Approval(tokenOwner, spender, amount);
        return true;
    }

    function transferFrom(
        address tokenOwner,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = msg.sender;
        uint256 _allowance = _allowances[tokenOwner][spender];
        require(_allowance > amount, "TRANSFER AMMOUNT IS EXCEDED");
        _allowance = _allowance - amount;
        _balances[tokenOwner] = _balances[tokenOwner] - amount;
        _balances[recipient] = _balances[recipient] + amount;
        emit Transfer(tokenOwner, recipient, amount);
        _allowances[tokenOwner][spender] = _allowance;
        emit Approval(tokenOwner, spender, amount);
        return true;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function circulatingSupply() public view returns (uint256) {
        return _circulatingSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function allowance(address tokenOwner, address spender)
        public
        view
        virtual
        override
        returns (uint256)
    {
        return _allowances[tokenOwner][spender];
    }

    uint256 tokenPrice = 1 * 10**16;

    function viewPrice() public view returns (uint256, string memory) {
        return (tokenPrice, "Wei");
    }

    function setPrice(uint256 newPrice) public returns (uint256) {
        tokenPrice = newPrice;
        return (tokenPrice);
    }

    function buyToken() public payable returns (uint256, string memory) {
        require(
            msg.value > 0,
            "You have not specified any amount for investment."
        );
        uint256 value = msg.value;
        uint256 tokenQty = value / tokenPrice;
        _balances[owner] -= tokenQty * 1e18;
        _balances[msg.sender] += tokenQty * 1e18;
        return (tokenQty, "HMD tokens transferred to your account.");
    }

    receive() external payable {
        buyToken();
    }
}
