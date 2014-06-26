# 
# Clause
#
# This class is intended to be inherited from.
#
module DuckPond
  class Clause

    attr_reader :options

    #
    # initialize
    #
    def initialize(opts={}, block)
      @options = opts
      @options[:block] = block
    end
  end
end
