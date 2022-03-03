const { expect } = require("chai");
const { ethers} = require('hardhat');

describe("Pichi", function () {
    let pichis;
    beforeEach(async () => {
        const Pichis = await ethers.getContractFactory('PichiNFT');
        pichis = await Pichis.deploy();
        await pichis.deployed();
    });


    it('Pichis function', async () =>{
        await pichis.mintPichi('A');
        const result = await pichis.getAllPichis; 
        console.log(result);
    })
});
