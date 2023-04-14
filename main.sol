// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

contract marketplace {

    uint256 AppID;

    // This is a comment!
    struct Catalog {
        uint256 AppID;
        string AppHash;
        string AppTrailFee;
        string ComputeFee;
        string AppOwner;


    }

    Catalog[] public catalog;
    mapping(string => uint256) public AppHashToAppID;
    mapping(string => string) public AppHashToAppTrailFee;
    mapping(string => string) public AppHashToComputeFee;
    mapping(string => string) public AppHashToAppOwner;

    function RegisterAIApp(string memory _AppHash, string memory _AppTrailFee, string memory _ComputeFee, uint256 _AppID, string memory _AppOwner) public {
        catalog.push(Catalog(_AppID, _AppHash, _AppTrailFee, _ComputeFee, _AppOwner));
        AppHashToAppID[_AppHash] = _AppID;
        AppHashToAppTrailFee[_AppHash] = _AppTrailFee;
        AppHashToComputeFee[_AppHash] = _ComputeFee;
        AppHashToAppOwner[_AppHash] = _AppOwner;


    }

}