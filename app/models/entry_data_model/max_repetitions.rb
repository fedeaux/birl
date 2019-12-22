module EntryDataModel
  class MaxRepetitions < Base
    DEFAULT_DIMENSIONS = [
      { name: :reps, options: {} },
      { name: :load, options: {} },
      { name: :rest, options: {} }
    ]
  end
end
