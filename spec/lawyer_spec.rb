require 'spec_helper'

module DuckPond
  describe Lawyer do
    describe 'constructor' do
      it 'yields itself if passed a block' do 
        oid_1 = nil
        oid_2 = Lawyer.new do |lawyer|
          oid_1 = lawyer.object_id
        end.object_id
        expect(oid_1).to eq oid_2
      end
    end
    describe 'unsatisified!' do
      it 'sets the lawyers satisfied flag to false' do
        lawyer = Lawyer.new
        expect(lawyer.satisfied?).to be true

        lawyer.unsatisfied!
        expect(lawyer.satisfied?).to be false
      end
    end
  end
end
