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
    describe 'fulfills?' do
      context 'when the object is fulfilled by the contract' do
        it 'returns true' do
          expect(LengthContract.fulfills?("Hello")).to eq true
        end
      end
      context 'when the object is not fulfilled by the contract' do
        it 'returns false' do
          expect(LengthContract.fulfills?(2)).to eq false
        end
      end
    end

    describe 'fulfills!' do
      context 'when the object is fulfilled by the contract' do
        it 'returns true' do
          expect{LengthContract.fulfills!("Hello")}.to_not raise_error
        end
      end
      context 'when the object is not fulfilled by the contract' do
        it 'returns false' do
          expect{LengthContract.fulfills!(2)}.to raise_error
        end
      end
    end

    describe '.clauses' do
      it 'returns the clauses for this contract' do
        clauses = LengthContract.clauses
        expect(clauses.length).to eq 1
        expect(clauses.map(&:method_name)).to include :length
      end
    end
  end

  #
  # see spec/classes/specific_length_contract.rb
  #
  describe SpecificLengthContract do
    it 'checks a methods response is correct' do
      expect(SpecificLengthContract.fulfills?("Hello")).to eq true
      expect(SpecificLengthContract.fulfills?("Yello")).to eq false
      expect(SpecificLengthContract.fulfills?("Goodbye")).to eq false
    end
  end

  describe SpecificLengthBehaviourContract do
    it 'checks the given block against the subjects method repsonse' do
      expect(SpecificLengthBehaviourContract.fulfills?('Hello')).to eq true
      expect(SpecificLengthBehaviourContract.fulfills?('Goodbye')).to eq false
    end
  end

  describe SpecificIncludeBehaviourContract do
    it 'checks the given block against the subjects method response' do
      expect(SpecificIncludeBehaviourContract.fulfills?('Hello')).to eq true
      expect(SpecificLengthBehaviourContract.fulfills?('Goodbye')).to eq false  
    end
  end

  #
  # See spec/classes/composite_contract.rb
  #
  describe CompositeContract do
    it 'retains its parents quackings' do
      clauses = CompositeContract.clauses
      expect(clauses.length).to eq 2 
      expect(clauses.map(&:method_name)).to include :length
      expect(clauses.map(&:method_name)).to include :chunky_bacon
    end
  end
end
