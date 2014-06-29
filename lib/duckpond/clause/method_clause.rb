#
# MethodClause
#
# Satisfied if the subject responds to the method represented
# by this clause.
#
# Available Options:
#
# :method_name  => The name of the method to check for / call
# :given_args   => Arguments to pass into the method
# :responds_with => What you would expect the method to respond with
#
#
module DuckPond
  class MethodClause < Clause

    #
    # satisfied_by?
    #
    # A subject satisfies a method clause if it responds to that method.
    #
    def satisfied_by?(subject)

      # Check the method actually exists.
      return false unless subject.respond_to? @options[:method_name]

      # Unless a block was given, or a response is required, we're done!
      return true unless @block || @options[:responds_with]

      # If we get this far, we need to tap into the result of the method
      # call, as the user is interrogating it somehow.
      response_when_called(subject, @options[:method_name], @options[:given_args])
        .tap do |response_when_called|
        if @block
          return false unless @block.call(response_when_called)
        end
        if @options[:responds_with]
          return false unless response_when_called == @options[:responds_with]
        end
      end
      true
    end

    private 
    def response_when_called(subject, method_name, args = [])
      subject.send(method_name, *args)
    end

  end
end
