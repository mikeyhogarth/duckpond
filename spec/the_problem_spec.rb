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
        # method is a little vague in what it does, and that's just 
        # because we don't know what "fooing" is.
        # 
        # But there are a few other problems.
        #
        # You will often hear rubyists talking about the wonder of
        # "duck typing". Because ruby is not strongly typed, developers
        # can pass anything they want to the "bar" method above and it'll
        # still work so long as the parameter responds to certain methods
        # etc.
        #
        # You will almost as often hear programmers freaking out about how 
        # chaotic and crazy this approach is! Arguments about such matters usually
        # eventually will gravitate towards the problem being that ruby is not 
        # strongly typed. The knowledge about what "ducks" can be sent to the
        # :bar method is not stored anyway, it's implicit in obj's usage. Great if
        # you were the developer of the method and you understand it completely, 
        # but what if it's someone else?
        #
        # In the above example, in order to see which type of object they can 
        # pass to the "bar" method, a developer would at the very least need
        # to:
        #
        # * Grep for "foo!" to see what the hell it does
        # * Look at the fooinator#foo method to see what the hell THAT does
        # * Look for all instances of @fooified_obj and see what the hell THAT DOES
        #
        # And even if they do all that, there's a chance they might miss something.
        # If they do miss something, this will likely manifest itself in an error
        # further up the stack, such as a method missing exceptionis etc. The
        # developer is now in the unenviable position of having to unpick their 
        # code right back to the "bar" method above, which could be really elusive
        # and confusing. 
        # 
        # Wouldn't it be better if the "bar" method raised an exception when it
        # was passed an object that wasn't compatible with its functionality? You
        # could do this yourself manually:
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
        # obj is a "duck". It may be used in places other than this "bar" method
        # and they may want to check that obj is the right kind of duck before proceeding
        # too!
        #
        # Wouldn't it be nice if there was a neat way to store knowledge about all 
        # our ducks in one place, and to be able to reference them whenever we need to.
        #
        # Enter duckpond!
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


