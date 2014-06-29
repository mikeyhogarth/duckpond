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

  end
end
