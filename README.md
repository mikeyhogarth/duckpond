# Duckpond

Explicit duck typing for ruby.


## Inspiration

Duck Typing can make code confusing and unreadable, particularly 
when multiple developers are working on the same project or when 
projects are inherited by new developers. 

The spec folder has two files that go through the purpose of this gem
in spec form. This would be a good place to start, although there is a crash 
course below.

* [the_problem_spec](spec/the_problem_spec.rb) - This outlines the problems with duck typing.

* [the_solution_spec](spec/the_solution_spec.rb) - This outlines how duckpond gets around these problems.


## Installation

Add this line to your application's Gemfile:

    gem 'duckpond'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install duckpond


## Usage

Usage is demonstrated in '[the_solution_spec](spec/the_solution_spec.rb)', but in a nutshell you can create 
"duck" classes by inheriting from DuckPond::Duck. This file should be commented
extensively as it describes the contract the duck represents. The "quacks_like" method
can be used to specify methods as symbols. 

    class MyDuck < DuckPond::Duck
      quacks_like :length  #indicates "length" as a mehtod this duck has
      quacks_like :to_s
    end

Once you've declared a duck, you can use "binoculars" to see if objects quack like
that duck:

    obj = "Hello World"
    sighting = DuckPond::Binoculars.identify(obj)
    sighting.quacks_like? MyDuck
    => true

There are other syntaxes:

    #This syntax gets all the comparison done in one line
    DuckPond::Binoculars.confirm(obj, MyDuck)
    => true

    #This syntax does the same thing, but raises an excaption instead of returning false 
    DuckPond::Binoculars.confirm!(obj, MyDuck)


Ducks can be combined into composite "super ducks" - ducks which are made up of various other ducks:

    class MySuperDuck < DuckPond::Duck
      quacks_like MyDuck
      quacks_like MyOtherDuck
    end

the "quacks_like" methods have been aliased to "looks_like" too - you can say something "looks_like" or "quacks_like" any item, 
whichever you prefer (in case you didn't want "quack" methods in your ever so serious project!). A *serious duck* might look like this:

    class IEmailable < DuckPond::Duck
      #send: should send the results of :message via email to :to
      looks_like :send

      #to: Should be an email address to which this will be sent
      looks_like :to

      #message: The message to send
      looks_like :message
    end

And then be implemented in a method like this:

    class Emailer
      def send(email)
        DuckPond::Binoculars.confirm!(email, IEmailable)
        email.send
      end
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
