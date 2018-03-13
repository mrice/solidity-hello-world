# solidity-hello-world

Personally, I struggled to find a simple Solidity **Hello, World** example on the internet to demonstrate the Solidity language. It's not surprising since writing anything in Solidity implies that you need to get your head around lots of complex topics, namely smart contracts and the Ethereum network.

##A little context before we start

I'm a programmer at heart so I  wanted something to get me going on the Solidity programming language itself -- nothing else. That is, I want language constructs first and more complex subjects (e.g., the blockchain) later. To do this, I try to eliminate as many dependencies and complications as possible, which is particularly hard to do in the smart contracts world since Solidity code ultimately runs on the big, complex, and global Ethereum virtual machine.

Fortunately there's a lightweight framework to help smooth things out: the [Truffle Framework](http://truffleframework.com). Get it running on your machine to save some headaches and reduce your learning curve. Start by making sure you have node.js installed (you'll find a lot of Solidity development also implies a lot of Javascript development, just get used to it). Then follow Truffle's super simple npm-based install instructions.

From there, it's as easy as typing truffle compile, truffle test, and etc.

##Start with the tests

Usually hello, world examples write to the console. But Solidity-based smart contracts aren't really, you know, console-based applications. So let's do treat it as a TDD opportunity.

After bumping around in the language a bit I settled on the following test. Create a file in the test folder called HelloWorldTest.sol with the following contents.

```solidity
pragma solidity ^0.4.19;

import "../contracts/HelloWorld.sol";
import "truffle/Assert.sol";

contract TestHelloWorld {

  function testSayHello() public {
    HelloWorld helloWorld = new HelloWorld();
    Assert.equal(helloWorld.sayHello(), "Hello, World!", "Hello world should say hello");
  }

}
```

You can see, we want to create a contract called HelloWorld and have it return the familiar and comforting text universal to all programming languages.

Without going in the details, it should look pretty familiar to an experienced programmer. We create a new contract (sorta like a class) called TestHelloWord with a function following the test.... naming pattern. We instantiate a new HelloWorld contract and call sayHello() to get a return string.

Using the simple Truffle framework we can try to test it:

```bash
truffle test
```

Which, as expected fails since we didn't create the implementation yet (remember, TDD).

##Write the hello, world implementation

Now create a new file in the contracts folder called HelloWorld.sol. In it, we'll write the following:

```solidity
pragma solidity ^0.4.19;

contract HelloWorld {
  function sayHello() public returns (bytes32) {
    return "Hello, World!";
  }
}
```

If you've never seen Solidity code before some of the keywords -- and their placements -- will seem a little odd but likely make some sense if you're an experienced programmer.

Now try the test again and it should pass with a satisfying check mark.

```bash
truffle test
```

## Recap

There's a lot to learn in this example. One call out I'll make now is to notice that the return type isn't string in this example. This is important to note because code running on the Ethereum virtual machine needs to be completely predictable. If we were to return something other than the fixed length byte array of byte32, we could end up with a variable length string, which breaks the model.

True, we could have returned a smaller array and save a few ETH in the process, but that's all something for a later example.
