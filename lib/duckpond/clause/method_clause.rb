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

      # Unless a block was given, or a response is required, we're done!
      return true unless @options[:block] || @options[:responds_with]

      # If we get this far, we need to tap into the result of the method
      # call, as the user is interrogating it somehow.
      response_when_called(subject, method_name, @options[:given_args])
        .tap do |response_when_called|
        if @options[:block]
          return false unless @options[:block].call(response_when_called)
        end
        if @options[:responds_with]
          return false unless response_when_called == @options[:responds_with]
        end
      end
      true
    end

    private 
    def response_when_called(subject, method, args = [])
      subject.send(method_name, *args)
    end

  end
end
