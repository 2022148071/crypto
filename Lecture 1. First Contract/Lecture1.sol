// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract SimpleStorage{
    uint256 favoriteNumber;
    
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    //dynamic array, 1h 54m55s
    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNubmer) public {
        favoriteNumber = _favoriteNubmer;
    }


    //view, pure --> 거래에 영향 안 미침, 똑같이 파란색 버튼은 거래 영향 X
    // view --> read some state of the blockchain
    
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
    // solidity에서 정보를 저장하는 두 가지 방법이 있는데, memory 와 storage임
    // memory --> only be stored during execution of the function | contract call
    // storage --> persist after function
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People( _favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
