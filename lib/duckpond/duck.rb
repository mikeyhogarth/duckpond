# 
# DuckPond::Duck
#
# Ducks are essentially "contracts" or "interfaces". They are not intended
# to ever be instantiated, and are completely configured at the class level.
#
module DuckPond
  class Duck
    class << self

      def quacks
        @quacks ||= []
      end
      
      #
      # quacks_like
      #
      # Use this to specify that this duck quacks with
      # a certain method.
      #
      def quacks_like(method)
        quacks << method
      end

      #
      # looks_like
      #
      # Use this to specify that this duck looks like
      # another duck.
      #
      def looks_like(other_duck)
        other_duck.quacks.each do |other_ducks_quacking|
          quacks_like other_ducks_quacking
        end
      end

      def quacks_like?(method)
        quacks.include?(method)
      end

    end
  end
end
