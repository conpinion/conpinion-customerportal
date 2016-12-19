module FunctionalRefinements
  refine Object do
    def as
      yield self
    end
  end
end
