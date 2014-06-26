class SpecificIncludeBehaviourContract < DuckPond::Contract
  has_method :include?, given_args: "Hell" do |method_result|
    method_result == true
  end
end
