[![Gem Version](https://badge.fury.io/rb/duckpond.svg)](http://badge.fury.io/rb/duckpond)
[![Build Status](https://travis-ci.org/mikeyhogarth/duckpond.svg?branch=master)](https://travis-ci.org/mikeyhogarth/duckpond)
[![Coverage Status](https://img.shields.io/coveralls/mikeyhogarth/duckpond.svg)](https://coveralls.io/r/mikeyhogarth/duckpond)

# Duckpond

Explicit duck typing for ruby.


## Introduction

Duck Typing can make code confusing and unreadable, particularly 
when multiple developers are working on the same project or when 
projects are inherited by new developers. 

* [the_problem](docs/the_problem.txt) - This outlines the problems with duck typing.

* [the_solution](docs/the_solution.txt) - This outlines how duckpond gets around these problems.


## Installation

Add this line to your application's Gemfile:

    gem 'duckpond'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install duckpond


## Usage

There is now a [screencast](https://www.youtube.com/watch?v=XTFigHzAfsk&feature=youtu.be) demonstrating the duckpond gem! 

Usage is demonstrated in '[the_solution](docs/the_solution.txt)', but in a nutshell you 
create "contract" classes by inheriting from DuckPond::Contract. These classes should 
be commented extensively. 

The "has_method" method is used to specify which methods the contract expects to see. The
following contract describes classes which respond to #length and #to_s

    class MyContract < DuckPond::Contract
      has_method :length
      has_method :to_s
    end

Once you've declared a contract, you can compare objects to it to see if the contract is 
fulfilled by the object:

    MyContract.fulfills? "Hello"
    => true
    MyContract.fulfills? 12
    => false

There is also a "bang" version of the #fulfills method, that raises an error instead 
of returning false. The error message details why it got raised.

    MyContract.fulfills! :foo 
    => DuckPond::Contract::ContractInfringementError:
       One or more clauses from MyContract were not fulfilled by :foo (Symbol) 
       Expected subject to respond to method 'length'


Contracts can be combined into composite "super contracts" - contracts which are made up of 
various other contracts. This ties in with the reccomendation of preferring composition over inheritance:

    class MyCompositeConrtact < DuckPond::Contract
      include_clauses_from MyContract
      include_clauses_from MyOtherContract
    end

Another feature of duckpond is the ability to specify what your expected result from a contract should be. For example,
the following contract expects a subject to have a method called "even" and for that method, when called, to return a 
true value:

    class MyEvenContract < DuckPond::Contract
      has_method :even?, responds_with: true
    end

If the method needs args, you can specify those too. This next contract will pass the string "Hell" to the #include? method,
and expect the value to be true. This contract will therefore be satisfied by strings containing the word "Hell" that are 
five characters long (such as the word "Hello"):

    class MyHellContract < DuckPond::Contract
      has_method :include?, responds_with: true, given_args: "Hell"
      has_method :length, responds_with: 5
    end

Finally, if you really want to get down and dirty with interrogating method results, you can use a block thusly (the result of calling the method will be yielded to the block):

    class MyBlockContract < DuckPond::Contract
      has_method :length do |method_result|
        method_result == 5
      end
    end

    class MyOtherBlockContract < DuckPond::Contract
      has_method :include?, given_args: "Hell" do |method_result|
        method_result == true
      end
    end

Note: The method will only be *called* if you use the :reponds_with option. Otherwise, it just tests for the method's existence.

In the real world, a contract might look like this:

    class IEmailable < DuckPond::Contract
      #send: should send the results of :message via email to :to
      has_method :send

      #to: Should be an email address to which this will be sent
      has_method :to

      #message: The message to send
      has_method :message
    end

And then be implemented in a method like this:

    class Emailer
      def send(email)
        IEmailable.fulfills! email
        email.send
      end
    end


## Compatibility

CI tests exist for the following rubies, so they definately work and there's no reason all 1.9.x rubies wouldnt' work either:

  - 1.9.3
  - 2.0.0
  - 2.1.1
  - jruby-19mode 


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
