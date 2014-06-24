#
# MethodClause
#
# Satisfied if the subject responds to the method represented
# by this clause.
#
module DuckPond
  class MethodClause < Clause

    def method_name
      @options[:method_name]
    end

    #
    # satisfied_by?
    #
    # A subject satisfies a method clause if it responds to that method.
    #
    def satisfied_by?(subject)
      subject.respond_to? method_name
    end

  end
end
