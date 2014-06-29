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
