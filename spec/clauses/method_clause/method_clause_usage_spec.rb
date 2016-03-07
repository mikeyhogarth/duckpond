require 'spec_helper'

describe 'MethodClause usage' do

  #
  # see spec/classes/specific_length_contract.rb
  #
  describe SpecificLengthContract do
    it 'checks a methods response is correct' do
      expect(SpecificLengthContract.fulfilled_by?("Hello")).to eq true
      expect(SpecificLengthContract.fulfilled_by?("Yello")).to eq false
      expect(SpecificLengthContract.fulfilled_by?("Goodbye")).to eq false
    end
  end

  describe SpecificLengthBehaviourContract do
    it 'checks the given block against the subjects method repsonse' do
      expect(SpecificLengthBehaviourContract.fulfilled_by?('Hello')).to eq true
      expect(SpecificLengthBehaviourContract.fulfilled_by?('Goodbye')).to eq false
    end
  end

  describe SpecificIncludeBehaviourContract do
    it 'checks the given block against the subjects method response' do
      expect(SpecificIncludeBehaviourContract.fulfilled_by?('Hello')).to eq true
      expect(SpecificLengthBehaviourContract.fulfilled_by?('Goodbye')).to eq false
    end
  end

end
