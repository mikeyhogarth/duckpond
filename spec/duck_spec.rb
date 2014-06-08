require 'spec_helper'

module DuckPond

  describe Duck do
    describe 'attributes' do
      context '.quackings' do
        it 'responds to and memoizes the result' do
          expect(Duck).to respond_to :quacks
          expect(Duck.quacks).to be_an Array
          expect(Duck.quacks).to be_empty
        end
      end
    end
  end

  class MyDuck < Duck
    quacks_like :foo
    quacks_like :bar
  end

  describe MyDuck do
    context '.quackings' do
      it 'quacks like foo and bar' do
        quacks = MyDuck.quacks
        expect(quacks.length).to eq 2
        expect(quacks).to include :foo
        expect(quacks).to include :bar
      end
    end

    describe '.quacks_like?' do
      it 'returns true if the argument is in the quackings' do
        expect(MyDuck.quacks_like? :foo).to be true
        expect(MyDuck.quacks_like? :chunky_bacon).to be false
      end
    end
  end

  class MySimilarDuck < Duck
    looks_like MyDuck
    quacks_like :chunky_bacon
  end

  describe MySimilarDuck do
    it 'retains its parents quackings' do
      expect(MySimilarDuck.quacks_like? :chunky_bacon).to be true
      expect(MySimilarDuck.quacks_like? :foo).to be true
      expect(MySimilarDuck.quacks_like? :bar).to be true
    end
  end

end
