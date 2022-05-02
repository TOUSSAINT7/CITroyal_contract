// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.5.0/security/Pausable.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.5.0/utils/Counters.sol";

contract CIT_royal is ERC721, ERC721Enumerable, Pausable, Ownable {

//(1)property variables //

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint256 public mintPrice = 1000000000000000000 wei;//mint price//
    uint256 public maxSuply  = 10000; //the maximum suply of our nfts//
    
//(2)life cycle methods//
    //our token ID start at 1 but by default 0
    constructor() ERC721("CIT_royal", "CITr") {

        _tokenIdCounter.increment();
    }
    //withdrawal function//
  //  function withdrawal() public onlyOwner{

      //  require(address(this).balance>0, "your balance is too low!");//

       // payable(owner()).transfer(address(this).balance);
   // }///

//(3)pausable functions== X===onlyowner// 
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
//(4)minting functions(only owner trmnated! anyone can call safemints)//
   
//revise section//
    function safeMint(address to) public payable {
        
        require(totalSupply()< maxSuply, "Your mints have reached the maximum"); 

        require(msg.value >= mintPrice,"Not enough ether sent!");//if ether is lessthan the mint price//

        uint256 tokenId = _tokenIdCounter.current();
    
        _tokenIdCounter.increment();
    
        _safeMint(to, tokenId);
    }

//(5)other fuctions// 
   function _baseURI() internal pure override returns (string memory) {
    
        return "ipfs//happyMonkeyBaseURI/";
    }
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    //(6) The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}


//(1)---owner--address: 0x029290c564Ef921c56a784AA16C97E930dAF7372//
//(2)---receiver---0x029290c564Ef921c56a784AA16C97E930dAF7372//
