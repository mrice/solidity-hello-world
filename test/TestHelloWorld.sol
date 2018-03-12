pragma solidity ^0.4.19;

import "../contracts/HelloWorld.sol";
import "truffle/Assert.sol";

contract TestHelloWorld {

  function testSayHello() public {
    HelloWorld helloWorld = new HelloWorld();
    Assert.equal(helloWorld.sayHello(), "Hello, World!", "Hello world should say hello");
  }

}
