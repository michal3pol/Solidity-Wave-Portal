// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;
import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves = 0;
    address previousWave;

    constructor() {
        console.log("Yo, hello smart contract");

    }

    function wave() public {
        totalWaves += 1;
        if(previousWave == address(0)) { //check if address is null
            console.log("FIRST WAVER ARRIVED!");
            console.log("%s waved!", msg.sender);
            previousWave = msg.sender;
            return;
        }
        console.log("%s waved!", msg.sender);
        console.log("Previous waver %s", previousWave);
        previousWave = msg.sender;
    }

    function getTotalWaves() public view returns (uint256) { // view -> do not modify state (kinda const)
        // :( console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    } 
}
