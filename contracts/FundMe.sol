// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;


import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
// able to accept some type of payment
contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;

    //func that can accept payment
    function fund() public payable{
        addressToAmountFunded[msg.sender] += msg.value;
        // what the ETH -> USD coinversion rate
    }

    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); // ETH/USD on Sepolia testnet
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (
            uint80 roundId, 
            int256 answer, 
            uint256 startedAt, 
            uint256 updatedAt, 
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return uint256(answer);
        //4,663.03720859 * 10**8
    }

}
