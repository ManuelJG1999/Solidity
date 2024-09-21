**NFT Marketplace**
This repository contains a Solidity smart contract for an NFT Marketplace. The contract is built using the ERC721 standard from OpenZeppelin, allowing users to mint, buy, list, and cancel the sale of NFTs. It also manages the lifecycle of NFTs in the marketplace.

**Features**
Minting NFTs: Users can create new NFTs with a price.
Buying NFTs: Users can purchase NFTs that are listed for sale.
Listing NFTs for Sale: Owners of NFTs can list them for sale at a specified price.
Cancelling Sales: Owners can remove their NFTs from sale.
Contract Details
Contract Name: NFTMarketplace
ERC721 Standard: The contract implements the ERC721 non-fungible token standard using OpenZeppelin libraries.
NFT Metadata: The token name is "MyNFT" and the symbol is "MNFT".
Functions
createNFT(uint256 price)
Mint a new NFT and list it for sale in the marketplace.

**Parameters:**
price: The initial price of the NFT.
Returns:
tokenId: The ID of the newly minted NFT.
buyNFT(uint256 tokenId)
Allows a user to purchase an NFT that is listed for sale.

**Parameters:**
tokenId: The ID of the NFT to purchase.
Requirements:
The NFT must be listed for sale.
The buyer must send enough Ether to cover the price.
listNFTForSale(uint256 tokenId, uint256 price)
List an owned NFT for sale with a specified price.

**Parameters:**
tokenId: The ID of the NFT to list for sale.
price: The price at which the NFT will be listed.
Requirements:
Only the owner of the NFT can list it for sale.
cancelNFTSale(uint256 tokenId)
Cancel the sale of an NFT, removing it from the marketplace.

**Parameters:**
tokenId: The ID of the NFT whose sale is being cancelled.
Requirements:
Only the owner of the NFT can cancel its sale.
**Events**
NFTCreated(uint256 indexed tokenId, address owner, uint256 price)
Emitted when a new NFT is created.

NFTBought(uint256 indexed tokenId, address buyer, uint256 price)
Emitted when an NFT is purchased.
