// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract PichiNFT is ERC721{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("PichiNFT", "PichiNFT"){
    }

    struct Pichi{
        uint256 id;
        string name;
        uint256 friendId;
    }

    
    mapping(uint256 => Pichi) public pichis;
    mapping(address => Pichi[]) public pichisAddress;
    mapping(string => bool) public pichiExists;
    Pichi[] public allPichis;



    event AddPichiEvent(uint _id, string _name, uint _friendId);
    event RandomGenerate(uint _seed);
    


    function getPichi(uint256 _id) public view returns(Pichi memory){
        return pichis[_id];
    }

    function getAllPichis() public view returns(Pichi[] memory){
        return allPichis;
    }

    function getMyPichis() public view returns (Pichi[] memory){
        return pichisAddress[msg.sender];
    }


    function mintPichi(string memory _pichiName) public {
        require(!pichiExists[_pichiName], "Already exist");
        _tokenIds.increment();
        Pichi memory currentPichi;
        uint256 newId = _tokenIds.current();
        
        currentPichi.id = newId;
        currentPichi.name = _pichiName;
        currentPichi.friendId = rand();
        pichis[newId] = currentPichi;
        
        
        _mint(msg.sender, newId);//Mint to address
        allPichis.push(currentPichi); //save on all
        pichisAddress[msg.sender].push(currentPichi);//save on address
        pichiExists[_pichiName] = true;
        emit AddPichiEvent(currentPichi.id, currentPichi.name, currentPichi.friendId);
    }


    function rand() internal returns(uint)
    {
        uint randN = 1;
        uint256 seed = uint256((keccak256(abi.encodePacked(block.timestamp, msg.sender,randN))));
        uint256 result = seed % 5 ;
        emit RandomGenerate(seed);
        return result;
    }

}