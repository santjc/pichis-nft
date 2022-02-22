// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract Characters{
    uint randNonce = 0;
    uint256 lastId = 0;
    
    struct Pichi{
        uint256 id;
        uint256 headAcc;
        uint256 bodyAcc;
        uint256 stainsColor;
        uint256 pawsColor;
    }

    
    mapping(uint256 => Pichi) public pichis;
    event AddPichiEvent(uint _id, uint _headAcc, uint _bodyAcc, uint _stainsColor, uint _pawsColor);
    event RandomGenerate(uint _seed);
    

    

    function addPichi() public{
        lastId++;
        Pichi memory currentPichi;
        currentPichi.id = lastId;
        currentPichi.headAcc = rand();
        currentPichi.bodyAcc = rand();
        currentPichi.stainsColor = rand();
        currentPichi.pawsColor = rand();
        pichis[lastId] = currentPichi;

        emit AddPichiEvent(currentPichi.id, currentPichi.headAcc, currentPichi.bodyAcc, currentPichi.stainsColor, currentPichi.pawsColor);
    }

    function getPichi(uint256 _id) public view returns(Pichi memory){
        return pichis[_id];
    }

    function rand() internal returns(uint)
    {
        randNonce++; 
        uint256 seed = uint256((keccak256(abi.encodePacked(block.timestamp, msg.sender,randNonce))));
        uint256 result = seed % 5 ;
        emit RandomGenerate(seed);
        return result;
    }
}