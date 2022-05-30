// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
import "erc721a/contracts/ERC721A.sol";  

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract NFT is ERC721, Ownable {

  using Strings for uint256;
  uint id=1;
  string baseURI;
  string public notRevealedUri;
  struct NftPro{
      uint tokenID;
      uint rarity;
      uint numberOfHead;
  }
    NftPro[] public nfts;

    mapping (uint => address) public nftToOwner;
    uint256 public constant Rock = 1;
    uint256 public constant Paper = 2;
    uint256 public constant Scissors = 3;
    constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI,
    string memory _initNotRevealedUri
  ) ERC721(_name, _symbol) {
    setBaseURI(_initBaseURI);
    setNotRevealedURI(_initNotRevealedUri);
  }
   function mint() public  {
        _safeMint(msg.sender,id);
         nfts.push(NftPro(id,Rock,5));
         nftToOwner[id]=msg.sender;
        id++;
    }
   function incremantHead(uint token) external {
    for(uint indexOfNfts=0;indexOfNfts<nfts.length;indexOfNfts++)
    if(nfts[indexOfNfts].tokenID==token)
    nfts[indexOfNfts].numberOfHead=nfts[indexOfNfts].numberOfHead-1;
   }

   function getNftProByTokenId(uint token) public view returns(NftPro memory){
        NftPro memory n;
        for(uint indexOfNfts=0;indexOfNfts<nfts.length;indexOfNfts++)
        if(nfts[indexOfNfts].tokenID==token)
         n= nfts[indexOfNfts];
         return n;
   }

    function st2num(string memory numString) public pure returns(uint) {
        uint  val=0;
        bytes   memory stringBytes = bytes(numString);
        for (uint  i =  0; i<stringBytes.length; i++) {
            uint exp = stringBytes.length - i;
            bytes1 ival = stringBytes[i];
            uint8 uval = uint8(ival);
            uint jval = uval - uint(0x30);
            val +=  (uint(jval) * (10**(exp-1))); 
        }
    return val;
   }
  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }
  function num2st(uint256 _uint) public pure returns(string memory){
    return Strings.toString(_uint);
  }
    function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
    notRevealedUri = _notRevealedURI;
  }
}
