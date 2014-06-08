#
# DuckPond::Sighting
#
# The duckpond sighting class is essentially just a wrapper for the sighted
# object, used here to avoid un-nessecary monkey patching.
#
module DuckPond
  class Sighting

    # the wrapped object
    attr_reader :sighted_object

    #
    # initialize
    #
    # Construct with any ruby object. 
    #
    def initialize(sighted_object)
      @sighted_object = sighted_object
    end

    # 
    # quacks_like? 
    #
    # receives exactly one duck, and returns true/false if
    # the sighted object responds to the same methods indicated
    # by the duck's quacks.
    #
    def quacks_like?(duck)
      duck.quacks.each do |quack|
        return false unless @sighted_object.respond_to? quack
      end
      true
    end
    alias :looks_like? :quacks_like?
  end
end
