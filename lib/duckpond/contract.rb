# 
# DuckPond::Contract
#
# Contracts are essentially lists of properties that a class could have. 
# They are not intended to ever be instantiated, and are completely 
# configured at the class level.
#
module DuckPond
  class Contract
    class ContractInfringementError < TypeError;end

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
      # has_method
      #
      # Adds a method expectation to the contract
      #
      def has_method(method_name)
        clauses << method_name
      end

      #
      # include_clauses_from
      #
      # Facilitates composition of multiple contracts
      #
      def include_clauses_from(other_contract)
        other_contract.each_clause do |other_clause|
          has_method other_clause
        end
      end

      #
      # fulfills?
      #
      # Returns true if this contract fulfills the passed-in object,
      # otherwise false.
      #
      def fulfills?(obj)
        inspection = DuckPond::Inspection.new(obj)
        return false unless inspection.fulfilled_by? self
        true
      end

      #
      # fulfills!
      #
      # Raises a ContractInfringementError unless this contract fulfills
      # the passed in object, otherwise returns true.
      #
      def fulfills!(obj)
        raise ContractInfringementError unless fulfills?(obj)
        true
      end
    end
  end
end
