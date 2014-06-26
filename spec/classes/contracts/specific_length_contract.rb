class SpecificLengthContract < DuckPond::Contract

  has_method :length, responds_with: 5

  has_method :include?, responds_with: true, given_args: "Hell"

end
