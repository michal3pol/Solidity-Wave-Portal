// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message);

    mapping(address => uint256) public lastWavedAt;

    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    Wave[] waves;

    constructor() {
        console.log("Creating WavePortal!");
    }

    function wave(string memory _message) public {
        
        //prevent spamming
        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
                "Wait 15m");
        
        lastWavedAt[msg.sender] = block.timestamp;
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        // Optional: Add this line if you want to see the contract print the value!
        // We'll also print it over in run.js as well.
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}

/* MY PREVIOUS
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
*/
