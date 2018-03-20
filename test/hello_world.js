var HelloWorld = artifacts.require("./HelloWorld.sol");

it("HelloWorld should say hello", function() {
  HelloWorld.new().then(function(instance) {
      return instance.sayHello.call();
    }).then(function(eval) {
      assert.equal(eval, "Hello, World!", "should be a friendly contract")
    });
});
