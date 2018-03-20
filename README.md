# solidity-hello-world

Personally, I struggled to find a simple Solidity **Hello, World** example on the internet to demonstrate the Solidity language. It's not surprising since writing anything in Solidity implies that you need to get your head around lots of complex topics, namely smart contracts and the Ethereum network.

## A little context before we start

I'm a programmer at heart so I  wanted something to get me going on the Solidity programming language itself -- nothing else.

That is, I want language constructs first and more complex subjects (e.g., the blockchain) later. To do this, I try to eliminate as many dependencies and complications as possible, which is particularly hard to do in the smart contracts world since Solidity code ultimately runs on the big, complex, and global Ethereum virtual machine.

Fortunately there's a lightweight framework to help smooth things out: the [Truffle Framework](http://truffleframework.com). Get it running on your machine to save some headaches and reduce your learning curve.

Start by making sure you have node.js installed (you'll find a lot of Solidity development also implies a lot of Javascript development; just get used to it). Then follow Truffle's super simple npm-based install instructions.

From there, it's as easy as typing truffle compile, truffle test, and etc.

## Start with the tests

Truffle lets you implement two different types of tests: Javascript/Mocha tests or tests written in the Solidity language itself.

```Javascript
var HelloWorld = artifacts.require("./HelloWorld.sol");

it("HelloWorld should say hello", function() {
  HelloWorld.new().then(function(instance) {
      return instance.sayHello.call();
    }).then(function(eval) {
      assert.equal(eval, "Hello, World!", "should be a friendly contract")
    });
});
```

That's quite a bit of code, unfortunately. But if you're familiar with Javascript and frameworks like Mocha, it might seem a little more reasonable. The important pieces are creating a new() instance of HelloWorld, getting access to the sayHello function, and then evaluating the results of the call to make sure they say "Hello, World!"

To run it, first make sure you start a local instance of Ethereum by running testrpc.

```bash
testrpc
```

Using the Truffle framework we can run the tests:

```bash
truffle test
```

Which, as expected should fail since we didn't create the implementation yet (remember, TDD).

## Write the hello, world implementation

Now create a new file in the contracts folder called HelloWorld.sol. In it, we'll write the following:

```solidity
pragma solidity ^0.4.19;

contract HelloWorld {
  function sayHello() view public returns (string) {
    return "Hello, World!";
  }
}
```

If you've never seen Solidity code before some of the keywords (especially "view") -- and their placements -- will seem a little odd yet familiar if you're an experienced programmer.

Now try the test again and it should pass with a satisfying check mark.

```bash
truffle test
```

## Why I didn't build the tests in Solidity

My first version of this repo did, in fact, implement the hello world tests in Solidity (see the history if you want to review).

It had an interesting quirk to make it work. In that example, return type of sayHello had to be a byte32 instead of a string. This is important to note because code running on the Ethereum virtual machine needs to be completely predictable from contract to contract. If we were to return something other than the fixed length byte array of byte32, we could end up with a variable length string, which breaks the model.

The Javascript example, since it's not passing a string from one contract to another, let's us do this a little more naturally and supports a contract that we can deploy and get a human readable string from (more on that later). And since the Javascript framework can actually run the contracts on real networks, it comes with many other benefits too.

Of course the drawback is that you have to write in two different languages at once.
