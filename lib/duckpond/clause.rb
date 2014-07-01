# 
# Clause
#
# This class is intended to be inherited from.
#
module DuckPond
  class Clause

    attr_reader :options, :block

    #
    # initialize
    #
    def initialize(opts={}, block)
      @options = opts
      @block = block
    end

    def satisfied_by?(subject)
      self.legal_assesment(subject).satisfied?
    end

    def legal_assesment
      # it is the responsibility of clauses to provide a #legal_assesment
      # method - this should return a lawyer who is either satisfied or 
      # not satisfied that the subject fulfills the clause.
      raise NotImplementedError
    end

  end
end
