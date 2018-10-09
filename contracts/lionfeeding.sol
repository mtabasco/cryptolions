pragma solidity ^0.4.19;

import "./lionfactory.sol";

contract CatInterface {
    function getCat(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes);
}

contract LionFeeding is LionFactory {

    CatInterface catContract;

    modifier onlyOwnerOf(uint _lionId) {
        require(msg.sender == lionToOwner[_lionId]);
        _;
    }

    function setCatContractAddress(address _address) external onlyOwner {
        catContract = CatInterface(_address);
    }

    function _upReadyTime(Lion storage _lion) internal {
        _lion.readyTime = uint32(now + timeToReady);
    }

    function _isReady(Lion storage _lion) internal view returns (bool) {
        return (_lion.readyTime <= now);
    }

    function feedAndGrow(uint _lionId, uint _targetDna, string _species) internal onlyOwnerOf(_lionId) {
        Lion storage myLion = lions[_lionId];
        require(_isReady(myLion));
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myLion.dna + _targetDna) / 2;
        if (keccak256(_species) == keccak256("tinyCat")) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createLion("NoName", newDna);
        _upReadyTime(myLion);
    }

    function feedOnCat(uint _lionId, uint _kittyId) public {
        uint CatDna;
        (,,,,,,,,,CatDna) = catContract.getCat(_kittyId);
        feedAndGrow(_lionId, CatDna, "tinyCat");
    }
}
