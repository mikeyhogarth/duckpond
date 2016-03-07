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

    #
    # see spec/classes/length_contract.rb
    #
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
         expect{LengthContract.fulfilled_by!(2)}.to raise_error DuckPond::Contract::ContractInfringementError
        end
      end
    end

    describe '.clauses' do
      it 'returns the clauses for this contract' do
        clauses = LengthContract.clauses
        expect(clauses.length).to eq 1
        expect(clauses.first.options[:method_name]).to eq :length
      end
    end
  end

  #
  # See spec/classes/composite_contract.rb
  #
  describe CompositeContract do
    it 'retains its parents quackings' do
      clauses = CompositeContract.clauses
      expect(clauses.length).to eq 2
      clauses.map {|c|c.options[:method_name]}.tap do |method_names|
        expect(method_names).to include :length
        expect(method_names).to include :chunky_bacon
      end
    end
  end

end
