const { expect } = require("chai");
const { ethers} = require('hardhat');

describe("Pichi", function () {
    let pichis;
    beforeEach(async () => {
        const Pichis = await ethers.getContractFactory('PichiNFT');
        pichis = await Pichis.deploy();
        await pichis.deployed();
    });


    it('Testing contract mint', async () =>{
        await pichis.mintPichi('Pichiloca');
        const myPichis = await pichis.getMyPichis(); 
        console.log(myPichis);
    })
});
