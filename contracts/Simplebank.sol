// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
 
contract Simplebank {
uint public numberOfFunders ; 
mapping (address => bool) private funders; 
mapping (uint => address) private lutFunders;
mapping (address => uint) private lastSum ;
address public owner ; 

constructor(){
   owner = msg.sender;
}

modifier onlyOwner(){
   require(msg.sender == owner , "only the owner can di that");
   _;
}

function transferOwnerShip(address newOwner) external onlyOwner{
   owner = newOwner ;
}

 function addFunds() external payable{
      address funder = msg.sender ; 
      if(!funders[funder]){
         funders[funder] = true ;
         uint index = numberOfFunders ++ ; 
         lutFunders[index] = funder;
         lastSum[funder] = msg.value;
      }
      else{
         lastSum[funder] += msg.value;
      } 
 }

 function getAllFunders() external view returns(address[] memory) {
   address[] memory _funders = new address[](numberOfFunders);
   for(uint i=0 ; i < numberOfFunders ; i++){
      _funders[i] = lutFunders[i] ; 
   }
   return _funders ; 
 }

 function withdraw(uint withdawAmount) external {
   require(withdawAmount < 1000000000000000000 || msg.sender == owner, "you can't withdraw mor than 1 ether");
   payable (msg.sender).transfer(withdawAmount);
 }

}


//const instance = await Simplebank.deployed()
//instance.addFunds({value:"500000000000000000" , from: accounts[0]})
//instance.addFunds({value:"500000000000000000" , from: accounts[1]})
// const funds = instance.funds()
// instance.getAllFunders()
// instance.withdraw("1000000000000000000")
//instance.transferOwnerShip("0x1e60F8CC99025E75239BE69AAa58BCc11bb1e2cE")