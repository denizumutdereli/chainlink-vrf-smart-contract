// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";

contract RandomNumberConsumer is VRFConsumerBaseV2, ConfirmedOwner {
    bytes32 internal keyHash; // the oracle to use
    uint32 callbackGasLimit = 100000; // storing each word costs about 20,000 gas
    uint16 requestConfirmations = 3;
    uint32 numWords = 1; // cannot exceed VRFCoordinatorV2.MAX_NUM_WORDS
    uint256 internal fee; // LINK token required for the service
    uint256 public randomNumber;

    mapping(uint256 => RequestStatus)
    public s_requests; 
    VRFCoordinatorV2Interface COORDINATOR;

    uint64 s_subscriptionId;

    uint256[] public requestIds;
    uint256 public lastRequestId;

    event RequestSent(uint256 requestId, uint32 numWords);
    event RequestFulfilled(uint256 requestId, uint256[] randomWords);
    
    struct RequestStatus {
        bool fulfilled; 
        bool exists; 
        uint256[] randomWords;
    }

    constructor(
        uint64 subscriptionId
    )
        VRFConsumerBaseV2(0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625) 
        ConfirmedOwner(msg.sender)
    {
        COORDINATOR = VRFCoordinatorV2Interface(
            0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625 // Sepolia testnet VRF Coordinator
        );
        s_subscriptionId = subscriptionId;
    }

 function requestRandomWords()
        external
        onlyOwner
        returns (uint256 requestId)
    {
        // Will revert if subscription is not set and funded.
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        s_requests[requestId] = RequestStatus({
            randomWords: new uint256[](0),
            exists: true,
            fulfilled: false
        });
        requestIds.push(requestId);
        lastRequestId = requestId;
        emit RequestSent(requestId, numWords);
        return requestId;
    }

    function fulfillRandomWords(
        uint256 _requestId,
        uint256[] memory _randomWords
    ) internal override {
        require(s_requests[_requestId].exists, "request not found");
        s_requests[_requestId].fulfilled = true;
        s_requests[_requestId].randomWords = _randomWords;
        emit RequestFulfilled(_requestId, _randomWords);
    }

    function getRequestStatus(
        uint256 _requestId
    ) external view returns (bool fulfilled, uint256[] memory randomWords) {
        require(s_requests[_requestId].exists, "request not found");
        RequestStatus memory request = s_requests[_requestId];
        return (request.fulfilled, request.randomWords);
    }

}
