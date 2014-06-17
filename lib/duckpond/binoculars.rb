#
# DuckPond::Binoculars
#
# Binoculars are the users interface to the ducks themselves and 
# are responsible for building "sightings" out of objects. There
# are also a couple of convinience methods on here to perform 
# common duck-spotting tasks.
#
module DuckPond
  class Binoculars
    class ContractInfringementError < TypeError;end

    # The sighted object
    attr_reader :sighting

    #
    # identify (class and instance level version)
    #
    # receives any ruby object, returns a "sighting" of that object
    #
    def identify(obj)
      @sighting = DuckPond::Sighting.new(obj)
    end

    def self.identify(obj)
      DuckPond::Sighting.new(obj)
    end

    #
    # confirm
    #
    # receives any ruby object and a duck class
    # returns true if the object quacks like the duck, 
    # otherwise false.
    #
    def self.confirm(obj, duck)
      binoculars = DuckPond::Binoculars.new
      sighting = binoculars.identify(obj)
      return false unless sighting.quacks_like?(duck)
      true
    end

    #
    # confirm!
    #
    # does exactly the same as the standard confirm
    # method, but raises an exception if the object
    # does not quack like the duck.
    #
    def self.confirm!(obj, duck)
      raise ContractInfringementError unless confirm(obj, duck)
    end

  end
end


