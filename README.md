[![Gem Version](https://badge.fury.io/rb/duckpond.svg)](http://badge.fury.io/rb/duckpond)
[![Build Status](https://travis-ci.org/mikeyhogarth/duckpond.svg?branch=master)](https://travis-ci.org/mikeyhogarth/duckpond)
[![Coverage Status](https://img.shields.io/coveralls/mikeyhogarth/duckpond.svg)](https://coveralls.io/r/mikeyhogarth/duckpond)

# Duckpond

Explicit duck typing for ruby.


## Inspiration

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

    MyContract.fulfilled_by? "Hello"
    => true
    MyContract.fulfilled_by? 12
    => false

There is also a "bang" version of the fulfilled_by method, that raises an error instead 
of returning false.

    MyContract.fulfilled_by! 12
    => RAISES ERROR!!

Contracts can be combined into composite "super contracts" - contracts which are made up of 
various other contracts. This ties in with the reccomendation of preferring composition over inheritance:

    class MyCompositeConrtact < DuckPond::Contract
      include_methods_from MyContract
      include_methods_from MyOtherContract
    end


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
        IEmailable.fulfilled_by! email
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
