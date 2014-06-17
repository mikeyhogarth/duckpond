require "spec_helper"

module DuckPond
  describe "The Solution" do
    context 'when a method is called' do
      it 'pays to use duckpond' do

        #
        # First, declare a duck.
        #

        class ObjContract < DuckPond::Contract
          has_method :to_s
          has_method :length
        end

        #
        # Grab a pair of binoculars...
        #
        
        binoculars = DuckPond::Binoculars.new

        # 
        # Now, lets say you have an object...
        #

        obj = "Hello World"

        #
        # You can "spot" it with your binoculars...
        #

        sighting = binoculars.identify(obj)

        #
        # And now you can compare your sightings with your ducks!
        #

        result = sighting.quacks_like?(ObjContract)
        expect(result).to be true

        #
        # You could check all of this within a method:
        #

        binoculars = DuckPond::Binoculars.new
        sighting = binoculars.identify(obj)
        raise TypeError unless sighting.quacks_like?(ObjContract)
       
        #
        # But because this trio of lines are so common, a
        # convinience method exists to perform all three at
        # once:
        #

        result = DuckPond::Binoculars.confirm(obj, ObjContract)
        expect(result).to be true

        #
        # The "bang" version will raise an error if the object isn't the duck.
        #
        
        expect { DuckPond::Binoculars.confirm!(Object.new, ObjContract) }.to raise_error TypeError


        #
        # So, going back to that example from the problem_spec
        #
        
        class Foo
          def self.bar(obj)
            DuckPond::Binoculars.confirm!(obj,ObjConrtact) 

            obj.foo!
            fooinator = Test::Fooinator.new
            @fooified_obj = fooinator.foo(obj)
          end
        end


        #
        # Viola!
        #
        # Final Tips: 
        #
        # * Contracts should be commented liberally. They form the descripiton
        # of a contract just as interfaces would in strongly typed languages.
        # Developers will be prompted to consult the duck when they see a pair
        # of binoculars in your code, so make sure they find what they're looking
        # for.
        #
        # * Rather than writing the duckpond functionality directly within the methods
        # themselves, you could easily put them in hooks or method aliases. If you do this
        # though, remember that the point of this app is to make things *more* visible, not
        # less, so don't go tucking these duck checks too far away from where they are needed
        # or leave an obvious trail if you do!
        #

      end
    end
  end
end
