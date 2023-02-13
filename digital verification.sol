// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract digitalVerification {
    bytes32 hash;
    bytes32 s_hash;
    string data;
    // s_ stands for sumbitted
    string s_data;
    string qstn;
    string s_qstn;
    mapping(bytes32 => bool) hashes;
    mapping(bytes32 => bool) checkedHashes;
    event Document_Received(address issuing_authority);
    event Security_Qstn_set(address student);

    function receiveData(string memory _data) public {
        data = _data;
        emit Document_Received(msg.sender);
    }

    function receiveQstn(string memory _qstn) public {
        qstn = _qstn;
        emit Security_Qstn_set(msg.sender);
    }

    function generateHash() public {
        hash = keccak256(abi.encodePacked(data, qstn));
        hashes[hash] = true;
    }

    function getGeneratedHash() public view returns (bytes32) {
        return hash;
    }

    function s_receiveData(string memory _s_data) public {
        s_data = _s_data;
    }

    function s_receiveQstn(string memory _s_qstn) public {
        s_qstn = _s_qstn;
    }

    function generate_s_Hash() public {
        s_hash = keccak256(abi.encodePacked(s_data, s_qstn));
        bool val = hashes[s_hash];
        checkedHashes[s_hash] = val;
    }

    function getSubmittedHash() public view returns (bytes32) {
        return s_hash;
    }

    function isVerified(bytes32) public view returns (bool) {}
}
