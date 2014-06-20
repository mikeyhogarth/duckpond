module DuckPond
  class CompositeContract < Contract
    include_clauses_from LengthContract
    has_method :chunky_bacon
  end
end
