// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./main.sol";


contract AIAppTrail  is marketplace {

    //mapping to store which address depositeded how much ETH
    mapping(address => uint256) public addressToTransactionAmount;
    // array of addresses who deposited
    address[] public transactions;
    //address of the owner (who deployed the contract)
    address public owner;

    // the first person to deploy the contract is
    // the owner
    constructor() public {
        owner = msg.sender;
    }

    function fund() public payable {

        //if not, add to mapping and transactions array
        addressToTransactionAmount[msg.sender] += msg.value;
        transactions.push(msg.sender);
    }


    uint256 EthPriceusd = 2076;


    // 1000000000
    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = EthPriceusd ;
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversation rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }


    function split() private {}

    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }


    modifier onlyOwner() {
        //is the message sender owner of the contract?
        require(msg.sender == owner);

        _;
    }

    // onlyOwner modifer will first check the condition inside it
    // and
    // if true, withdraw function will be executed
    function withdraw() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);

        //iterate through all the mappings and make them 0
        //since all the deposited amount has been withdrawn
        for (
            uint256 transactionIndex = 0;
            transactionIndex < transactions.length;
            transactionIndex++
        ) {
            address funder = transactions[transactionIndex];
            addressToTransactionAmount[funder] = 0;
        }
        //transactions array will be initialized to 0
        transactions = new address[](0);
    }



}

