require 'spec_helper'

module DuckPond
  describe MethodClause do
    describe 'Class' do
      it 'inherits from Clause' do
        expect(described_class.ancestors).to include Clause
      end
    end

    describe 'Constructor' do
      context 'when constructed with a method name option' do
        it 'adds that method name as an attribute' do
          clause = MethodClause.new({:method_name => :foo}, nil)
          expect(clause.options[:method_name]).to eq :foo
        end
      end
    end

    describe 'Instance Methods' do
     
      describe '#satisfied_by?' do
        let(:clause) { MethodClause.new({:method_name => :length}, nil) }

        context 'when the subject responds to the clauses method' do 
          it 'returns true' do
            expect(clause.satisfied_by? 'Hello').to eq true
          end
        end
        context 'when the subject responds to the clauses method' do 
          it 'returns false' do
            expect(clause.satisfied_by? 42).to eq false
          end
        end
      end
    end

  end
end
