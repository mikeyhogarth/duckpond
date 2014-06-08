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
      # a certain method, or quacks like another duck.
      #
      def quacks_like(item)
        if item.is_a? Symbol
          quacks << item
        elsif item.ancestors.include? DuckPond::Duck
          add_quacks_from item
        else
          raise TypeError
        end
      end
      alias :looks_like :quacks_like

      #
      # quacks_like?
      #
      # The main quack checking method for a duck
      #
      def quacks_like?(method)
        quacks.include?(method)
      end
      alias :looks_like? :quacks_like

      private
      #
      # add_quacks_from
      #
      # add the quacks from another duck
      #
      def add_quacks_from(other_duck)
        other_duck.quacks.each do |other_ducks_quacking|
          quacks_like other_ducks_quacking
        end
      end

    end
  end
end
