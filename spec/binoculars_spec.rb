require 'spec_helper'

module DuckPond
  describe Binoculars do
  
    let(:obj) { Object.new }

    describe '#identify' do
      it 'returns any ruby object, in "sighting" form' do
        bins = Binoculars.new
        sighting = bins.identify(obj)
        expect(sighting).to be_a Sighting
        expect(sighting.sighted_object). to be obj
      end
    end

    describe ".identify" do
      it 'returns any ruby object, in "sighting" form' do
        sighting = Binoculars.identify(obj)
        expect(sighting).to be_a Sighting
        expect(sighting.sighted_object). to be obj
      end
    end

    describe '.confirm' do

      class StringDuck < Duck
        quacks_like :to_s
        quacks_like :length
      end

      context 'when given a ruby object and a duck class that it quacks like' do
        it 'returns true' do
          expect(DuckPond::Binoculars.confirm("Hello World", StringDuck)).to be true
        end
      end

      context 'when given a ruby object and a duck class that it doesnt quacks like' do
        it 'returns false' do
          expect(DuckPond::Binoculars.confirm(Object.new, StringDuck)).to be false
        end
      end
    end

    describe '.confirm!' do
      it 'behaves like the un-banged version, but raises an error if it doesnt quack right' do
        expect {DuckPond::Binoculars.confirm!(Object.new, StringDuck)}.to raise_error
      end
    end

  end
end