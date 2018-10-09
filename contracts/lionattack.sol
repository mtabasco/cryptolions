pragma solidity ^0.4.19;

import "./lionhelper.sol";

contract LionAttack is LionHelper {
    uint nonce = 0;
    uint pointsToWin = 80;

    function randMod(uint _modulus) internal returns(uint) {
        nonce++;
        return uint(keccak256(now, msg.sender, nonce)) % _modulus;
    }

    function attack(uint _lionId, uint _targetId) external onlyOwnerOf(_lionId) {
        Lion storage myLion = lions[_lionId];
        Lion storage enemyLion = lions[_targetId];
        uint rand = randMod(100);
        if (rand <= pointsToWin) {
            myLion.winCount++;
            myLion.level++;
            enemyLion.lossCount++;
            feedOnCat(_lionId, enemyLion.dna);
        } else {
            myLion.lossCount++;
            enemyLion.winCount++;
            _upReadyTime(myLion);
        }
    }
}
