[![Gem Version](https://badge.fury.io/rb/duckpond.svg)](http://badge.fury.io/rb/duckpond)
[![Build Status](https://travis-ci.org/mikeyhogarth/duckpond.svg?branch=master)](https://travis-ci.org/mikeyhogarth/duckpond)
[![Coverage Status](https://img.shields.io/coveralls/mikeyhogarth/duckpond.svg)](https://coveralls.io/r/mikeyhogarth/duckpond)

# Duckpond

Explicit duck typing for ruby.


## Inspiration

Duck Typing can make code confusing and unreadable, particularly 
when multiple developers are working on the same project or when 
projects are inherited by new developers. 

The docs folder has two files that go through the purpose of this gem. 
This would be a good place to start, although there is a crash 
course below.

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

Usage is demonstrated in '[the_solution](docs/the_solution.txt)', but in a nutshell you can create 
"contract" classes by inheriting from DuckPond::Contract. This file should be commented
extensively as it describes the contract the duck represents. The "has_method" method
can be used to specify methods as symbols. 

    class MyContract < DuckPond::Contract
      has_method :length  
      has_method :to_s
    end

Once you've declared a contract, you can use "binoculars" to see if objects quack like
that duck:

    obj = "Hello World"
    sighting = DuckPond::Binoculars.identify(obj)
    sighting.quacks_like? MyContract
    => true

There are other syntaxes:

    #This syntax gets all the comparison done in one line
    DuckPond::Binoculars.confirm(obj, MyContract)
    => true

    #This syntax does the same thing, but raises an excaption instead of returning false 
    DuckPond::Binoculars.confirm!(obj, MyContract)


Ducks can be combined into composite "super contracts" - contracts which are made up of various other contracts. This ties in with the reccomendation of preferring composition over inheritance:

    class MyCompositeConrtact < DuckPond::Contract
      include_methods_from MyContract
      include_methods_from MyOtherContract
    end


A *serious duck* might look like this:

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
        DuckPond::Binoculars.confirm!(email, IEmailable)
        email.send
      end
    end



## Compatibility

Works in 1.9.x onwards


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
