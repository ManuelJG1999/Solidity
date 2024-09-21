// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

 /* 1. Constructor: Debe haber un constructor que inicialice el fee y el owner.
    2.	Struct: Crear una estructura User que contenga la información del usuario (nombre, apellido, saldo, estado de registro).
    3.	Mapping: Utilizar un mapping para asociar una dirección con la información del usuario.
    4.	Modifiers: Crear modificadores para asegurar que solo los usuarios registrados y el owner puedan ejecutar ciertas funciones.
    5.	Eventos: Emitir eventos cuando un usuario se registre, haga un depósito, realice un retiro y cuando el owner retire de la tesorería.*/

contract Module2Deliverable{

     // User structure
    struct User {
        string firstName;
        string lastName;
        uint256 balance;
        bool isRegistered;
    }

    address public owner;
    uint256 public fee;
    mapping(address => User) private users;

 
    event UserRegistered(address indexed userAddress, string firstName, string lastName);
    event Deposit(address indexed userAddress, uint256 amount);
    event Withdrawal(address indexed userAddress, uint256 amount, uint256 fee);
    event TreasuryWithdrawal(uint256 amount);

 
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner is allowed to perform this action");
        _;
    }

    modifier onlyRegisteredUsers() {
        require(users[msg.sender].isRegistered, "Only allowed for registered users");
        _;
    }

    constructor(uint256 _fee) {
        owner = msg.sender;
        fee = _fee;
    }

    function register(string calldata _firstName, string calldata _lastName) external {
        require(!users[msg.sender].isRegistered, "User is already registered");

        users[msg.sender] = User({
            firstName: _firstName,
            lastName: _lastName,
            balance: 0,
            isRegistered: true
        });

        emit UserRegistered(msg.sender, _firstName, _lastName);
    }

      function deposit() external payable onlyRegisteredUsers {
        require(msg.value > 0, "Must deposit enough funds");
        users[msg.sender].balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function getBalance() external view onlyRegisteredUsers returns (uint256) {
        return users[msg.sender].balance;
    }

    function withdrawTreasury(uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient funds in the contract");
        payable(owner).transfer(_amount);
        emit TreasuryWithdrawal(_amount);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

       // Function to withdraw funds  with a fee
    function withdraw(uint256 _amount) external onlyRegisteredUsers {
        require(users[msg.sender].balance >= _amount, "Not enough funds");

        uint256 feeAmount = (_amount * 2) / 100;  // 2% fee
        uint256 amountAfterFee = _amount - feeAmount;
        users[msg.sender].balance -= _amount;

        payable(msg.sender).transfer(amountAfterFee);
        emit Withdrawal(msg.sender, amountAfterFee, feeAmount);
    }

}
