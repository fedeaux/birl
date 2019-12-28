module EntryDataModel
  class Technique < Base
    DEFAULT_DIMENSIONS = [
      { name: :execution, options: {} },
      { name: :mult, options: {} },
      { name: :reps, options: {} },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ].freeze
  end
end
