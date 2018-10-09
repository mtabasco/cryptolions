pragma solidity ^0.4.19;

import "./lionfeeding.sol";

contract LionHelper is LionFeeding {

    uint levelFee = 0.002 ether;

    modifier aboveLevel(uint _level, uint _lionId) {
        require(lions[_lionId].level >= _level);
        _;
    }

    function withdraw() external onlyOwner {
        owner.transfer(this.balance);
    }

    function setLevelFee(uint _fee) external onlyOwner {
        levelFee = _fee;
    }

    function levelUp(uint _lionId) external payable {
        require(msg.value == levelFee);
        lions[_lionId].level++;
    }

    function changeName(uint _lionId, string _newName) external aboveLevel(2, _lionId) onlyOwnerOf(_lionId) {
        lions[_lionId].name = _newName;
    }

    function changeDna(uint _lionId, uint _newDna) external aboveLevel(20, _lionId) onlyOwnerOf(_lionId) {
        lions[_lionId].dna = _newDna;
    }

    function getLionsByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerLionCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < lions.length; i++) {
            if (lionToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

}
