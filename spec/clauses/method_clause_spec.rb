require 'spec_helper'

module DuckPond
  describe MethodClause do
    describe 'Class' do
      it 'inherits from Clause' do
        expect(described_class.ancestors).to include Clause
      end
    end

    describe 'Constructor' do
      context 'when passed a method name' do
        it 'constructs a clause with that method name' do
          expect(MethodClause.new(:foo).method_name).to eq :foo
        end
      end
      context 'when passed a method name and some options' do
        it 'constructs a clause with that method name and those options' do
          clause = MethodClause.new(:foo, :my => :options)
          expect(clause.method_name).to eq :foo
          expect(clause.options[:my]).to eq :options
        end
      end
    end

    describe 'Instance Methods' do
      
      describe '#method_name' do
        it 'returns the method name the clause was constructed with' do
          expect(MethodClause.new(:foo).method_name).to eq :foo
        end
      end

      describe '#satisfied_by?' do
        let(:clause) { MethodClause.new(:length) }

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
