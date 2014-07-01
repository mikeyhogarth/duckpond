module DuckPond
  class Contract
    class ContractInfringementError < TypeError
      def initialize(contract, subject, inspection = nil)
        @contract     = contract
        @subject      = subject
        @messages     = inspection.messages
      end
      
      def message
        %Q{
        One or more clauses from #{@contract} were not fulfilled by #{@subject} (#{@subject.class}) 
        #{@messages.join(', ') if @messages.any?}
        }
      end
    
    end
  end
end
