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

    class LengthContract < DuckPond::Contract
      has_method :length
    end
 
    describe 'fulfilled_by?' do
      context 'when the object is fulfilled by the contract' do
        it 'returns true' do
          expect(LengthContract.fulfilled_by?("Hello")).to eq true
        end
      end
      context 'when the object is not fulfilled by the contract' do
        it 'returns false' do
          expect(LengthContract.fulfilled_by?(2)).to eq false
        end
      end
    end

    describe 'fulfilled_by!' do
      context 'when the object is fulfilled by the contract' do
        it 'returns true' do
          expect{LengthContract.fulfilled_by!("Hello")}.to_not raise_error
        end
      end
      context 'when the object is not fulfilled by the contract' do
        it 'returns false' do
          expect{LengthContract.fulfilled_by!(2)}.to raise_error
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
  end

  class MySimilarContract < Contract
    include_clauses_from MyContract
    has_method :chunky_bacon
  end

  describe MySimilarContract do
    it 'retains its parents quackings' do
      clauses = MySimilarContract.clauses
      expect(clauses.length).to eq 3 
      expect(clauses).to include :foo
      expect(clauses).to include :bar
      expect(clauses).to include :chunky_bacon
    end
  end
end
