pragma solidity ^0.4.19;

import "./lionattack.sol";
import "./erc721.sol";
import "./safemath.sol";

contract LionOwnership is LionAttack, ERC721 {

    using SafeMath for uint256;

    mapping (uint => address) lionApprovals;

    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerLionCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return lionToOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerLionCount[_to] = ownerLionCount[_to].add(1);
        ownerLionCount[msg.sender] = ownerLionCount[msg.sender].sub(1);
        lionToOwner[_tokenId] = _to;
        Transfer(_from, _to, _tokenId);
    }

    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        lionApprovals[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }

    function takeOwnership(uint256 _tokenId) public {
        require(lionApprovals[_tokenId] == msg.sender);
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }
}
