require 'duckpond/contract/convinience_methods'
require 'duckpond/contract/contract_infringement_error'

# 
# DuckPond::Contract
#
# Contracts are essentially lists of properties that a class could have. 
# They are not intended to ever be instantiated, and are completely 
# configured at the class level.
#
module DuckPond
  class Contract
    extend DuckPond::Contract::ConvinienceMethods

    class << self

      #
      # clauses
      #
      # Gets this contract's list of clauses or returns
      # an empty array if uninitialized.
      #
      def clauses
        @clauses ||= []
      end

      #
      # each_clause
      #
      # Iterator for clauses
      #
      def each_clause
        0.upto(clauses.size-1) do |i|
          yield @clauses[i]
        end
      end

      #
      # has_clause
      #
      # add a clause to the contract's list of clauses
      #
      def has_clause(clause_klass, opts = {}, &block)
        clauses << clause_klass.new(opts, block)
      end

      #
      # include_clauses_from
      #
      # Facilitates composition of multiple contracts
      #
      def include_clauses_from(other_contract)
        other_contract.each_clause do |other_clause|
          has_clause other_clause.class, other_clause.options, &other_clause.block
        end
      end

      #
      # fulfills?
      #
      # Returns true if this contract fulfills the passed-in object,
      # otherwise false.
      #
      def fulfills?(obj)
        DuckPond::Inspection.new(obj).tap do |inspection|
          return inspection.fulfilled_by? self
        end
      end

      #
      # fulfills!
      #
      # Raises a ContractInfringementError unless this contract fulfills
      # the passed in object, otherwise returns true.
      #
      def fulfills!(obj)
        DuckPond::Inspection.new(obj).tap do |inspection|
          unless inspection.fulfilled_by? self
            raise ContractInfringementError.new(self, obj, inspection)
          else
            return true
          end
        end
      end

    end
  end
end
