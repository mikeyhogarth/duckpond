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

      def clauses
        @clauses ||= []
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
        other_contract.clauses.each do |other_contracts_quacking|
          has_method other_contracts_quacking
        end
      end

      #
      # fulfilled_by?
      #
      def fulfilled_by?(obj)
        inspection = DuckPond::Inspection.new(obj)
        return false unless inspection.fulfilled_by? self
        true
      end

      #
      # fulfilled_by!
      #
      def fulfilled_by!(obj)
        raise ContractInfringementError unless fulfilled_by?(obj)
      end
    end
  end
end
