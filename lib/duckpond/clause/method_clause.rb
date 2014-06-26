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

      # Check the method actually exists.
      return false unless subject.respond_to? method_name

      # If required, check the response from the method was what the user expected.
      return false unless _responds_with?(subject, method_name, @options[:responds_with], @options[:given_args])

      true
    end

    private 
    #
    # _responds_with?
    #
    # if a method response expectation was passed in, this just calls the method (with the arguments
    # if given) and does an == compare with the subject.
    #
    def _responds_with?(subject, method, expected_result, args = [])
      return expected_result ? subject.send(method_name, *args) == expected_result : true
    end

  end
end
