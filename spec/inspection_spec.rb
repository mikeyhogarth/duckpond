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
      context 'when the sighted object quacks like the duck' do
        it 'returns true' do
          obj = OpenStruct.new(:length => 2)
          inspection = Inspection.new(obj)
          expect(inspection.fulfilled_by? LengthContract).to be true
        end
      end

      context 'when the sighted object does not quack like the duck' do
        it 'returns false' do
          obj = OpenStruct.new(:size => 2)
          inspection = Inspection.new(obj)
          expect(inspection.fulfilled_by? LengthContract).to be false
        end
      end

    end
  end
end
