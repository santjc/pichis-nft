const { expect } = require("chai");
const { ethers} = require('hardhat');

describe("Pichi", function () {
    let pichis;
    beforeEach(async () => {
        const Pichis = await ethers.getContractFactory('Characters');
        pichis = await Pichis.deploy();
        await pichis.deployed();
    });


    it('Pichis function', async () =>{
        await pichis.mintToken('Pichilandis');
        const result = await pichis.getAllPichis; 
        console.log(result);
    })
});
