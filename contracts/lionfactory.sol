pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";

contract LionFactory is Ownable {

    using SafeMath for uint256;

    event NewLion(uint lionId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint timeToReady = 1 days;

    struct Lion {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Lion[] public lions;

    mapping (uint => address) public lionToOwner;
    mapping (address => uint) ownerLionCount;

    function _createLion(string _name, uint _dna) internal {
        uint id = lions.push(Lion(_name, _dna, 1, uint32(now + timeToReady), 0, 0)) - 1;
        lionToOwner[id] = msg.sender;
        ownerLionCount[msg.sender]++;
        emit NewLion(id, _name, _dna);
    }

    function _generateDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomLion(string _name) public {
        require(ownerLionCount[msg.sender] == 0);
        uint randDna = _generateDna(_name);
        randDna = randDna - randDna % 100;
        _createLion(_name, randDna);
    }

}
