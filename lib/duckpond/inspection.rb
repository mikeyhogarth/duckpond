#
# DuckPond::Inspection
#
# The duckpond inspection class is essentially just a wrapper for an inspected
# object (the subject).
#
module DuckPond
  class Inspection

    # the wrapped object
    attr_reader :subject

    #
    # initialize
    #
    # Construct with any ruby object. 
    #
    def initialize(subject)
      @subject = subject
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
        return false unless clause.satisfied_by?(@subject)
      end
      true
    end
  end
end
