require "spec_helper"

module DuckPond
  describe "The Solution" do
    context 'when a method is called' do
      it 'pays to use duckpond' do

        #
        # First, declare a duck.
        #

        class ObjDuck < DuckPond::Duck
          quacks_like :to_s
          quacks_like :length
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

        result = sighting.quacks_like?(ObjDuck)
        expect(result).to be true

        #
        # You could check all of this within a method:
        #

        binoculars = DuckPond::Binoculars.new
        sighting = binoculars.identify(obj)
        raise TypeError unless sighting.quacks_like?(ObjDuck)
       
        #
        # But because this trio of lines are so common, a
        # convinience method exists to perform all three at
        # once:
        #

        result = DuckPond::Binoculars.confirm(obj, ObjDuck)
        expect(result).to be true

        #
        # The "bang" version will raise an error if the object isn't the duck.
        #
        
        expect { DuckPond::Binoculars.confirm!(Object.new, ObjDuck) }.to raise_error TypeError

      end
    end
  end
end
