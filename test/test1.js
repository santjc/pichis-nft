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
        await pichis.addPichi();
        const result = await pichis.getPichi(1); 
        console.log(result);
    })
});
