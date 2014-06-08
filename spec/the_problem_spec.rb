require 'spec_helper'

module Duckpond
  describe 'The Problem' do
    context 'when a method is called' do
      it 'is often difficult to see what parameters are allowed' do

        # 
        # Take this class for instance...
        #
        # It has a single method which;
        #
        # * Calls an instance method on its parameter.
        # * Sends its parameter off to some other object.
        # * Creates an instance variable with the result.
        #

        class Foo
          def self.bar(obj)
            obj.foo!
            fooinator = Test::Fooinator.new
            @fooified_obj = fooinator.foo(obj)
          end
        end

        # 
        # From an architectural perspective, there is really nothing
        # wrong with this class/method. Even from a design perspective
        # the only thing that you can really criticize is that the 
        # method is a little vague in terms of what it does, and that's just 
        # because we don't know what "fooing" is.
        # 
        # But there are a few other problems.
        #
        # You will often hear rubyists talking about the wonder of
        # "duck typing". Developers can pass anything they want to the "bar" 
        # method above and it'll still work so long as the parameter responds 
        # to certain methods etc.
        #
        # You will almost as often hear programmers freaking out about how 
        # chaotic and crazy this approach is! Arguments about such matters usually
        # eventually gravitate towards the problem being that ruby is not 
        # strongly typed. The knowledge about what "ducks" can be sent to the
        # :bar method is not stored anywhere: it's implicit in obj's usage. Great if
        # you were the developer of the method and you understand it completely, 
        # but what if it's someone else?
        #
        # In the above example, in order to see which type of object they can 
        # pass to the "bar" method, a developer would at the very least need
        # to:
        #
        # * Grep for "foo!" to see what the hell it does
        # * See what the hell a "Fooinator" does
        # * Look at the fooinator#foo method to see what the hell THAT does
        # * Look for all instances of @fooified_obj and see what the hell THOSE DO
        #
        # And even if they do all that, there's a chance they might miss something.
        # If they do miss something, this will likely manifest itself in an error
        # further up the stack, such as method missing exceptions etc., in places
        # OTHER than where the actual mistake was made. 
        #
        # Nightmare!
        #
        # Wouldn't it be nice if the "bar" method did a check or two, or even  raised 
        # an exception when it was passed an object that wasn't compatible with its 
        # functionality? You could do this yourself manually:
        #
        
        class Foo
          def self.bar(obj)
            raise TypeError unless obj.respond_to?(:foo!) && obj.respond_to?(:chunky_bacon)

            obj.foo!
            fooinator = Test::Fooinator.new
            @fooified_obj = fooinator.foo(obj)
          end
        end

        # 
        # But now you've got more problems!
        #
        # * The method is now becoming longer and messier.
        # * The "knowledge" about what :bar can receive is stored within the
        # :bar method itself, but that knowledge may be needed elsewhere. 
        #
        # Wouldn't it be nice if there was a neat way to store knowledge about all 
        # our ducks in one place, and to be able to reference them whenever we need to.
        #
        # Although duck typing is seen as a ruby technique, it is actually 
        # used in other languages too but the contract in strongly typed languages
        # is made explicit through the use of interfaces. In c#, for example:
        #
        # public string foo(IMyInterface interface)
        # {
        #   //your implementation here. A confused developer
        #   //could go off and look in IMyInterface to see what
        #   //this "duck" is meant to do. 
        # }
        #
        # As ruby is not strongly typed, you don't have this reference and the code
        # becomes impossible for other developers to use!
        #
        # This is the problem duckpond hopes to solve.
        #

        class Reader
          def intrigued?
            true
          end
        end

        the_reader = Reader.new
        expect(the_reader).to be_intrigued

      end
    end
  end
end


