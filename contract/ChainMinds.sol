// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChainMinds {
    struct Idea {
        string description;
        address submitter;
        uint256 voteCount;
    }

    mapping(uint256 => Idea) public ideas;
    uint256 public ideaCount;

    event IdeaSubmitted(uint256 ideaId, string description, address submitter);
    event Voted(uint256 ideaId, address voter);

    // Core Function 1: Submit a new idea
    function submitIdea(string memory _description) public {
        require(bytes(_description).length > 0, "Description cannot be empty");
        ideaCount++;
        ideas[ideaCount] = Idea(_description, msg.sender, 0);
        emit IdeaSubmitted(ideaCount, _description, msg.sender);
    }

    // Core Function 2: Vote on an existing idea
    function voteOnIdea(uint256 _ideaId) public {
        require(_ideaId > 0 && _ideaId <= ideaCount, "Invalid idea ID");
        ideas[_ideaId].voteCount++;
        emit Voted(_ideaId, msg.sender);
    }

    // Core Function 3: Retrieve idea details
    function getIdea(uint256 _ideaId) public view returns (string memory, address, uint256) {
        require(_ideaId > 0 && _ideaId <= ideaCount, "Invalid idea ID");
        Idea memory idea = ideas[_ideaId];
        return (idea.description, idea.submitter, idea.voteCount);
    }
}
