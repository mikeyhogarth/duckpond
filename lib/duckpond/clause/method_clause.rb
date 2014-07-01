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
        unless subject.respond_to? method
          lawyer.unsatisfied! "Expected subject to respond to method '#{method}'"
        end

        if @block || expected_response
          response_when_called(subject, method, args).tap do |response_when_called|
            if @block
              unless @block.call(response_when_called)
                lawyer.unsatisfied! "Block did not respond with 'true' for method #{method}"
              end
            end
            
            if expected_response
              unless response_when_called == expected_response
                lawyer.unsatisfied! "Expected method #{method} to return #{expected_response} but got #{response_when_called}"  
              end
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
