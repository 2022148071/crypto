
contract SimpleStorage{
    uint256 favoriteNumber;
    
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    //dynamic array, 1h 54m55s
    People[] public people;

    People public person =  People({favoriteNumber: 2, name:"Alex"});
    function store(uint256 _favoriteNubmer) public {
        favoriteNumber = _favoriteNubmer;
    }


    //view, pure -> 거래에 영향 안 미침, 똑같이 파란색 버튼은 거래 영향 X
    // view -> read some state of the blockchain
    
    function retrieve() public view returns(uint256) {
        return person.favoriteNumber;
    }
}
