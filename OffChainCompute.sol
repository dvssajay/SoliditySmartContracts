// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;


contract OffChainCompute{


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

    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
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