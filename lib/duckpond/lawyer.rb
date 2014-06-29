#
# DuckPond::Lawyer
#
# The lawyer class is responsible for maintaining the sate of satisfaction
# between a subject and its contract. Typically these are used in clauses.
#
module DuckPond
  class Lawyer

    def initialize
      @satisfied = true
      @messages = []
      yield self if block_given?
    end

    def satisfied?
      @satisfied
    end

    def unsatisfied!(msg = nil)
      @satisfied = false
      @messages << msg if msg
    end
  end

end
