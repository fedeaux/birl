module EntryDataModel
  class MaxRepetitions < Base
    DEFAULT_DIMENSIONS = [
      { name: :mult, options: {} },
      { name: :reps, options: {} },
      { name: :weight, options: {} },
      { name: :rest, options: {} }
    ]
  end
end
