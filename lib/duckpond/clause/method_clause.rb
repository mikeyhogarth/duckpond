#
# MethodClause
#
# Satisfied if the subject responds to the method represented
# by this clause.
#
module DuckPond
  class MethodClause < Clause

    attr_reader :method_name

    #
    # initialize
    #
    # Initialize method clauses with the method name as a symbol.
    #
    def initialize(method_name, opts = {})
      @method_name = method_name
      @options = opts
    end

    #
    # satisfied_by?
    #
    # A subject satisfies a method clause if it responds to that method.
    #
    def satisfied_by?(subject)
      subject.respond_to? @method_name
    end

  end
end
