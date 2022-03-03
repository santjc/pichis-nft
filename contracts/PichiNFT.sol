// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract PichiNFT is ERC721, Ownable, ERC721URIStorage{
    uint randNonce = 0;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    constructor() ERC721("MyPichi", "NFT"){
    }
    struct Pichi{
        uint256 id;
        string name;
        uint256 headAcc;
        uint256 bodyAcc;
        uint256 stainsColor;
        uint256 pawsColor;
    }

    
    mapping(uint256 => Pichi) public pichis;
    mapping(address => Pichi[]) public pichisAddress;
    mapping(string => bool) public pichiExists;
    Pichi[] public allPichis;



    event AddPichiEvent(uint _id, string _name, uint _headAcc, uint _bodyAcc, uint _stainsColor, uint _pawsColor);
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


    function mintPichi(string memory tokenURI) public onlyOwner{
        string memory _pichiName = randomName();
        Pichi memory currentPichi;
        uint256 newId = _tokenIds.current();
        require(!pichiExists[_pichiName], "Already exist");
        
        currentPichi.id = newId;
        currentPichi.name = _pichiName;
        currentPichi.headAcc = rand();
        currentPichi.bodyAcc = rand();
        currentPichi.stainsColor = rand();
        currentPichi.pawsColor = rand();
        pichis[newId] = currentPichi;
        
        _safeMint(msg.sender, newId);
        _setTokenURI(newId, tokenURI);
        allPichis.push(currentPichi);
        pichisAddress[msg.sender].push(currentPichi);
        pichiExists[_pichiName] = true;
        emit AddPichiEvent(currentPichi.id, currentPichi.name, currentPichi.headAcc, currentPichi.bodyAcc, currentPichi.stainsColor, currentPichi.pawsColor);
        _tokenIds.increment();
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