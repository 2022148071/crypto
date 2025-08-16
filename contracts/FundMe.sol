// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;


import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// able to accept some type of payment
contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;

    //func that can accept payment
    function fund() public payable{
        //$5
        uint256 minimumUSD = 5*(10**18);
        // 1gwei < $5
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        // what the ETH -> USD coinversion rate
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
}
