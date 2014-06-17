# 
# DuckPond::Contract
#
# Contracts are essentially lists of properties that a class could have. 
# They are not intended to ever be instantiated, and are completely 
# configured at the class level.
#
module DuckPond
  class Contract
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
      # quacks_like?
      #
      # The main quack checking method for a duck
      #
      def quacks_like?(method)
        clauses.include?(method)
      end

    end
  end
end
