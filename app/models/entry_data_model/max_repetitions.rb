module EntryDataModel
  class MaxRepetitions < Base
    DEFAULT_DIMENSIONS = [
      { name: :reps, options: {} },
      { name: :load, options: {} },
      { name: :rest, options: {} }
    ].freeze
  end
end
