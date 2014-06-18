#
# DuckPond::Inspection
#
# The duckpond analysis class is essentially just a wrapper for the inspected
# object, used here to avoid un-nessecary monkey patching.
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
      contract.clauses.each do |clause|
        return false unless @subject.respond_to? clause
      end
      true
    end
  end
end
