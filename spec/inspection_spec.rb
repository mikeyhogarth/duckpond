require 'ostruct'

module DuckPond
  describe Inspection do
    describe '#initialize' do
      it 'is constructed using any ruby object' do
        obj = Object.new
        analysis = Inspection.new(obj)
        expect(analysis.subject).to be obj
      end
    end

    describe '#fulfilled_by?' do

      class MyChunkyBaconContract < Contract
        has_method :chunky_bacon
      end

      context 'when the sighted object quacks like the duck' do
        it 'returns true' do
          obj = OpenStruct.new(:chunky_bacon => :mmm)
          inspection = Inspection.new(obj)
          expect(inspection.fulfilled_by? MyChunkyBaconContract).to be true
        end
      end

      context 'when the sighted object does not quack like the duck' do
        it 'returns false' do
          obj = OpenStruct.new(:vegan_fallafal => :yuck)
          inspection = Inspection.new(obj)
          expect(inspection.fulfilled_by? MyChunkyBaconContract).to be false
        end
      end

    end
  end
end
