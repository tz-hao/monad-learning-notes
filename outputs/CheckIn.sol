// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CheckIn {
    mapping(address => uint256) public lastCheckInAt;
    mapping(address => uint256) public checkInCount;

    event CheckedIn(address indexed user, uint256 time, uint256 count);

    function checkIn() external {
        require(
            block.timestamp >= lastCheckInAt[msg.sender] + 1 days,
            "Already checked in today"
        );

        lastCheckInAt[msg.sender] = block.timestamp;
        checkInCount[msg.sender] += 1;

        emit CheckedIn(msg.sender, block.timestamp, checkInCount[msg.sender]);
    }
}
