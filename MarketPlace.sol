// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ERC721 {
    // Incremental ID for minting NFTs
    uint256 private _nextTokenId = 1;
    
    // Struct to represent each item for sale
    struct NFTItem {
        uint256 tokenId;
        address owner;
        uint256 price;
        bool isForSale;
    }
    
    // Mapping of tokenId to NFTItem
    mapping(uint256 => NFTItem) public nftItems;
    
    // Event emitted when a new item is created
    event NFTCreated(uint256 indexed tokenId, address owner, uint256 price);
    
    // Event emitted when an item is bought
    event NFTBought(uint256 indexed tokenId, address buyer, uint256 price);
    
    constructor() ERC721("MyNFT", "MNFT") {}

    // Function to create a new NFT
    function createNFT(uint256 price) public returns (uint256) {
        require(price > 0, "Price must be greater than zero");

        uint256 newItemId = _nextTokenId;

        // Mint the NFT
        _mint(msg.sender, newItemId);

        // Add the NFT to the marketplace
        nftItems[newItemId] = NFTItem({
            tokenId: newItemId,
            owner: msg.sender,
            price: price,
            isForSale: true
        });

        emit NFTCreated(newItemId, msg.sender, price);

        // Increment the token ID for the next NFT
        _nextTokenId++;

        return newItemId;
    }

    // Function to buy an NFT
    function buyNFT(uint256 tokenId) public payable {
        NFTItem storage item = nftItems[tokenId];
        require(item.isForSale, "This NFT is not for sale");
        require(msg.value >= item.price, "Insufficient funds to buy this NFT");

        address previousOwner = item.owner;
        address newOwner = msg.sender;

        // Transfer ownership of the NFT
        _transfer(previousOwner, newOwner, tokenId);

        // Update the NFT item
        item.owner = newOwner;
        item.isForSale = false;

        // Transfer the funds to the previous owner
        payable(previousOwner).transfer(msg.value);

        emit NFTBought(tokenId, newOwner, item.price);
    }

    // Function to list an NFT for sale
    function listNFTForSale(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can list this NFT");
        require(price > 0, "Price must be greater than zero");

        NFTItem storage item = nftItems[tokenId];
        item.isForSale = true;
        item.price = price;
    }

    // Function to cancel the sale of an NFT
    function cancelNFTSale(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can cancel this sale");

        NFTItem storage item = nftItems[tokenId];
        item.isForSale = false;
    }
}
