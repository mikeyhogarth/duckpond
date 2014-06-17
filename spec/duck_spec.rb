require 'spec_helper'

module DuckPond

  describe Contract do
    describe 'attributes' do
      context '.clauses' do
        it 'responds to and memoizes the result' do
          expect(Contract).to respond_to :clauses
          expect(Contract.clauses).to be_an Array
          expect(Contract.clauses).to be_empty
        end
      end
    end
  end

  class MyContract < Contract
    has_method :foo
    has_method :bar
  end

  describe MyContract do
    context '.clauses' do
      it 'quacks like foo and bar' do
        clauses = MyContract.clauses
        expect(clauses.length).to eq 2
        expect(clauses).to include :foo
        expect(clauses).to include :bar
      end
    end

    describe '.quacks_like?' do
      it 'returns true if the argument is in the quackings' do
        expect(MyContract.quacks_like? :foo).to be true
        expect(MyContract.quacks_like? :chunky_bacon).to be false
      end
    end
  end

  class MySimilarContract < Contract
    include_clauses_from MyContract
    has_method :chunky_bacon
  end

  describe MySimilarContract do
    it 'retains its parents quackings' do
      expect(MySimilarContract.quacks_like? :chunky_bacon).to be true
      expect(MySimilarContract.quacks_like? :foo).to be true
      expect(MySimilarContract.quacks_like? :bar).to be true
    end
  end

end
