// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract PostContract {
    struct Post {
        address author; // Address of the post creator
        string title;   // Title of the post
        string content; // Content of the post
        uint256 timestamp; // Timestamp of when the post was created
    }

    // Array to store all posts
    Post[] private posts;

    // Mapping to store posts by author
    mapping(address => Post[]) private postsByAuthor;

    // Event for a new post
    event PostCreated(address indexed author, string title, string content, uint256 timestamp);


    // function to create a new post
    function createPost(string memory _title, string memory _content) external {
        require(bytes(_title).length > 0, "Please add a title");
        require(bytes(_content).length > 0, "Please add a content");

        // Create a new post
        Post memory newPost = Post({
            author: msg.sender,
            title: _title,
            content: _content,
            timestamp: block.timestamp
        });

        // Add the post to the array and mapping
        posts.push(newPost);
        postsByAuthor[msg.sender].push(newPost);

        // Emit an event for the created post
        emit PostCreated(msg.sender, _title, _content, block.timestamp);
    }

    // function to retrieve all posts
    function retrieveAllPosts() external view returns (Post[] memory) {
        return posts;
    }

    // function to retrieve all posts by the author's address
    function retrievePostsByAddress(address _author) external view returns (Post[] memory) {
        return postsByAuthor[_author];
    }
}