#
# MethodClause
#
# Satisfied if the subject responds to the method represented
# by this clause.
#
# Available Options:
#
# :method_name    => The name of the method to check for / call
# :given_args     => Arguments to pass into the method
# :responds_with  => What you would expect the method to respond with
#
#
module DuckPond
  class MethodClause < Clause

    #
    # legal_assesment
    #
    def legal_assesment(subject)
      Lawyer.new do |lawyer|
        lawyer.unsatisfied! unless subject.respond_to? method

        if @block || expected_response
          response_when_called(subject, method, args).tap do |response_when_called|
            if @block
              lawyer.unsatisfied! unless @block.call(response_when_called)
            end
            if expected_response
              lawyer.unsatisfied! unless response_when_called == expected_response
            end
          end
        end
      end
    end

    private 
    def response_when_called(subject, method, args = [])
      subject.send(method, *args)
    end

    def method
      @options[:method_name]
    end

    def expected_response
      @options[:responds_with]
    end

    def args
      @options[:given_args]
    end

  end
end
