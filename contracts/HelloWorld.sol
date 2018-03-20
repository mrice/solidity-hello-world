pragma solidity ^0.4.19;

contract HelloWorld {
  address public owner;

  function HelloWorld() public {
    owner = msg.sender;
  }

  function sayHello() view public returns (string) {
    return "Hello, World!";
  }

  function kill() public {
    if (msg.sender == owner) {
      selfdestruct(owner);
    }
  }

}
