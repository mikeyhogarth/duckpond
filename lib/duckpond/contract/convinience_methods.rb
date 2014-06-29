#
# Contract::ConvinienceMethods
#
# A set of methods used to make adding clauses easier for the user.
#
module DuckPond
  class Contract
    module ConvinienceMethods
      #
      # has_method
      #
      # Adds a method clause to the contract
      #
      def has_method(method_name, opts = {})
        if block_given?
          has_clause(MethodClause, opts.merge(:method_name => method_name), &Proc.new)
        else
          has_clause(MethodClause, opts.merge(:method_name => method_name))
        end
      end

    end
  end
end
