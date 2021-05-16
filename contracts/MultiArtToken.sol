// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./EditionsExtension.sol";

/**
 * @dev ERC721 token with editions extension.
 */
contract MultiArtToken is EditionsExtension {

    /**
     * @dev Sets `address artist` as the original artist to the account deploying the NFT.
     */
     constructor (
        string memory _name, 
        string memory _symbol
    ) ERC721(_name, _symbol) {
        _designateArtist(msg.sender);

        DOMAIN_SEPARATOR = keccak256(abi.encode(
            EIP712DOMAIN_TYPEHASH,
            keccak256(bytes("Artist's Domain")),
            keccak256(bytes("1")),
            1,
            address(this)
        ));
    }
    
    /**
     * @dev Signs a `tokenId` representing a print.
     */
    function sign(uint256 tokenId, Signature memory message, bytes memory signature) public {
        _signEdition(tokenId, message, signature);
    }

    /**
     * @dev Signs a `tokenId` representing a print.
     */
    function mintEdition(string memory _tokenURI, uint _editionNumbers) public {
        _createEditions(_tokenURI, _editionNumbers);
    }
}