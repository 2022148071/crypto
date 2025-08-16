// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;


import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// able to accept some type of payment
contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    //func that can accept payment
    function fund() public payable{
        //$30
        uint256 minimumUSD = 30*(10**18);
        // 1gwei < $30
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        // what the ETH -> USD coinversion rate

        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); // ETH/USD on Sepolia testnet
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData(); //변수 5개인데 4개는 안 써서
        return uint256(answer);
        //4,663.03720859 * 10**8
    }
    //1000000000
    //converts value that they send to its USD equivalent
    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice*ethAmount) / (10**8);
        return ethAmountInUsd;
        // 0.000004433115724000
    }
    //Modifier?
        // Function: 클럽 내부
        // Modifier: 경호원
        // Function call: 클럽에 입장하려는 시도 
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not a contract owner"); // execute before function call
        _; // function call
        //{code here}: execute after function call
    }
    //whoever calls the function(msg sender) is going to transfer them all of our money
    function withdraw() payable onlyOwner public{
        //only want the contract admin/owner with modifier --> onlyOwner modifier
        // solodity 0.8.0 버전부터 일만 address타입이라 돈을 받을 수 없어 address payable 타입으로 바꿔줘야함
        payable(msg.sender).transfer(address(this).balance);

        //clear funding information to get next series funding
        for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }
}
