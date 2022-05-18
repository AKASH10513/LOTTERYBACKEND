// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Lottery{
    address public manager;
    address payable[] public players;
    constructor()
    {
        manager = msg.sender;
    }
    function alreadyEntered () view private returns(bool)
    {
        for(uint i =0;i<players.length;i++)
        {
            if(players[i]==msg.sender) return true;
        }
        return false;
    }
    function enter() payable public
    {
      //  require(msg.sender!=manager,"manager can not psrticipate in");
     //require(alreadyEntered() == false,"allready registered");
    // require(msg.value==1,"pay 1 ether"); 
     players.push(payable(msg.sender));
    }
    function random() view private returns(uint)
    {
  return uint(sha256(abi.encodePacked(block.difficulty,block.number,players)));
    }
    function pickWinner() public
    {
        //require(msg.sender == manager,"you are not authorized to pick only manager can pick");
        uint index = random()%players.length;
        players[index].transfer((address(this).balance));
        delete players;
    } 
   function getplayers() public view returns(address payable [] memory)
   {
        return players;
        
   }
}