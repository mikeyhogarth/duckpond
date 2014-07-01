#
# DuckPond::Inspection
#
# The duckpond inspection class is essentially just a wrapper for an inspected
# object (the subject).
#
module DuckPond
  class Inspection

    # the wrapped object
    attr_reader :subject, :messages

    #
    # initialize
    #
    # Construct with any ruby object. 
    #
    def initialize(subject)
      @subject    = subject
      @satisfied  = true
      @messages   = []
    end

    # 
    # fulfilled_by? 
    #
    # receives exactly one contract, and returns true/false if
    # the inspected object responds to the same methods indicated
    # by the contract's clauses.
    #
    def fulfilled_by?(contract)
      contract.each_clause do |clause|
        clause.legal_assesment(@subject).tap do |lawyer|
          unless lawyer.satisfied?
            @satisfied = false
            @messages << lawyer.messages
          end
        end
      end
      @satisfied
    end

    def satisfied?
      @satisfied
    end
  end
end
