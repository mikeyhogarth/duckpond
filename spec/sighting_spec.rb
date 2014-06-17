require 'ostruct'

module DuckPond
  describe Sighting do

    describe '#initialize' do
      it 'is constructed using any ruby object' do
        obj = Object.new
        sighting = Sighting.new(obj)
        expect(sighting.sighted_object).to be obj
      end
    end

    describe '#quacks_like?' do

      class MyChunkyBaconContract < Contract
        has_method :chunky_bacon
      end

      context 'when the sighted object quacks like the duck' do
        it 'returns true' do
          obj = OpenStruct.new(:chunky_bacon => :mmm)
          sighting = Sighting.new(obj)
          expect(sighting.quacks_like? MyChunkyBaconContract).to be true
        end
      end

      context 'when the sighted object does not quack like the duck' do
        it 'returns false' do
          obj = OpenStruct.new(:vegan_fallafal => :yuck)
          sighting = Sighting.new(obj)
          expect(sighting.quacks_like? MyChunkyBaconContract).to be false
        end
      end

    end
  end
end
