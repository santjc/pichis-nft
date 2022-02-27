// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Characters is ERC721{
    uint randNonce = 0;
    uint256 lastId = 0;
    address public owner;
    uint256 tokenId = lastId;
    constructor() ERC721("NFT", "NFT"){
        owner = msg.sender;
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
    

    

    function addPichi(string memory _name) public returns(Pichi memory){
        
        Pichi memory currentPichi;
        currentPichi.id = lastId;
        currentPichi.name = _name;
        currentPichi.headAcc = rand();
        currentPichi.bodyAcc = rand();
        currentPichi.stainsColor = rand();
        currentPichi.pawsColor = rand();
        pichis[lastId] = currentPichi;
        lastId++;
        emit AddPichiEvent(currentPichi.id, currentPichi.name, currentPichi.headAcc, currentPichi.bodyAcc, currentPichi.stainsColor, currentPichi.pawsColor);
        return currentPichi;
    }

    function getPichi(uint256 _id) public view returns(Pichi memory){
        return pichis[_id];
    }

    function getAllPichis() public view returns(Pichi[] memory){
        return allPichis;
    }

    function getMyPichis() public view returns (Pichi[] memory){
        return pichisAddress[msg.sender];
    }


    function mintToken(string calldata _pichiName) public payable{
        require(!pichiExists[_pichiName], "Already exist");
        _safeMint(msg.sender, tokenId);
        allPichis.push(addPichi(_pichiName));
        pichisAddress[msg.sender].push(addPichi(_pichiName));

        pichiExists[_pichiName] = true;
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