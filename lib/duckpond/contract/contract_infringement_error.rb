module DuckPond
  class Contract
    class ContractInfringementError < TypeError
      def initialize(contract, subject)
        @contract = contract
        @subject  = subject
      end
      
      def message
        "One or more clauses from #{@contract} were not fulfilled by #{@subject}"
      end
    end
  end
end
