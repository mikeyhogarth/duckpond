class SpecificLengthBehaviourContract < DuckPond::Contract

  has_method :length do |method_result|
    method_result == 5
  end

end
